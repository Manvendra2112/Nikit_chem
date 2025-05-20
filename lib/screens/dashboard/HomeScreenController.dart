import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'dialogbox/LocationDialog.dart';

class HomeScreenController extends GetxController {
  final BuildContext context;
  HomeScreenController(this.context);

  TextEditingController searchTextCon = TextEditingController();
  final RxList<bool> isExpanded = <bool>[].obs;
  final RxList<dynamic> visitData = <dynamic>[].obs;
  final RxList<dynamic> filteredVisitData = <dynamic>[].obs;
  final RxBool isFetching = false.obs;
  dynamic loginModel; // Map from API response

  String? selectedLocation; // For LocationDialog

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    fetchVisitData();
  }

  @override
  void onClose() {
    // Avoid disposing searchTextCon due to IndexedStack
    // searchTextCon.dispose();
    super.onClose();
  }

  void getUserDetail() async {
    try {
      String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "User ID not found. Please log in again.");
        loginModel = {'user': {'name': 'User'}}; // Fallback
        update();
        return;
      }

      String token = await PreferenceManager.instance.getString(ConstantString.tokenKey);
      var headers = {
        'Accept': 'application/json',
        'Cookie': token,
      };

      var response = await http.get(
        Uri.parse('https://pob.volvrit.in/api/v1/user/$userId'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        print("getUserDetails: $responseJson");
        if (responseJson['code'] == 200) {
          loginModel = responseJson; // Store full response
          update();
        } else {
          // Get.snackbar("Error", responseJson['message'] ?? "Failed to fetch user details");
          loginModel = {'user': {'name': 'User'}}; // Fallback
          update();
        }
      } else {
        // Get.snackbar("Error", "Failed to fetch user details");
        loginModel = {'user': {'name': 'User'}}; // Fallback
        update();
      }
    } catch (e) {
      //Get.snackbar("Error", "Failed to fetch user details: $e");
      loginModel = {'user': {'name': 'User'}}; // Fallback
      update();
    }
  }

  void updateLocation(String location) {
    selectedLocation = location;
    print("Selected location: $location");
    update();
  }

  void filterVisitData() {
    String query = searchTextCon.text.toLowerCase();
    if (query.isEmpty) {
      filteredVisitData.assignAll(visitData);
    } else {
      filteredVisitData.assignAll(
        visitData.where((dealer) {
          return dealer['delearname']?.toLowerCase().contains(query) ?? false;
        }).toList(),
      );
    }
    isExpanded.assignAll(List<bool>.filled(filteredVisitData.length, false));
    print("Filtered visit data: ${filteredVisitData.length} items");
  }

  void clearSearch() {
    searchTextCon.clear();
    filterVisitData();
  }

  void toggleExpansionTile(int index) {
    if (filteredVisitData.isNotEmpty && index >= 0 && index < isExpanded.length) {
      isExpanded[index] = !isExpanded[index];
      print("Toggled index $index to ${isExpanded[index]}");
    }
  }

  void openLocationDialog() {
    Get.dialog( LocationDialog());
  }

  Future<void> fetchVisitData() async {
    if (isFetching.value) {
      print("Already fetching visit data, skipping...");
      return;
    }

    isFetching.value = true;
    visitData.clear();
    filteredVisitData.clear();
    isExpanded.clear();
    print("Fetching visit data...");

    try {
      String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      if (userId == null || userId.isEmpty) {
        Get.snackbar("Error", "User ID not found. Please log in again.");
        isFetching.value = false;
        return;
      }

      String token = await PreferenceManager.instance.getString(ConstantString.tokenKey);
      var headers = {
        'Accept': 'application/json',
        'Cookie': token, // Assumes token includes XSRF-TOKEN and laravel_session
      };

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://pob.volvrit.in/api/v1/users/get-today-visit'),
      );
      request.fields.addAll({'user_id': userId});
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();

      print("fetchVisitData Status Code: ${response.statusCode}");
      print("fetchVisitData Response Body: $responseBody");

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(responseBody);
        if (responseJson["code"] == 200) {
          List<dynamic> fetchedData = responseJson["data"] ?? [];
          print("fetchVisitData API Success: $fetchedData");
          if (fetchedData.isEmpty) {
            print("fetchVisitData Warning: No visits returned from API");
            Get.snackbar("Info", "No visits available for today");
          }
          visitData.assignAll(fetchedData);
          filteredVisitData.assignAll(visitData);
          isExpanded.assignAll(List<bool>.filled(visitData.length, false));
          print("Visit Data fetched: $visitData");
        } else {
         // Get.snackbar("Error", responseJson["message"] ?? "Failed to fetch visit data");
          print("fetchVisitData API Error: ${responseJson["message"]}");
        }
      } else {
        //Get.snackbar("Error", "Failed to fetch visit data: ${response.statusCode}");
        print("fetchVisitData HTTP Error: ${response.statusCode}");
      }
    } catch (e) {
      //Get.snackbar("Error", "Failed to fetch visit data: $e");
      print("fetchVisitData Exception: $e");
    } finally {
      isFetching.value = false;
    }
  }
}