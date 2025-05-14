import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardController.dart';
import 'package:nikitchem/support/EasyLoadingConfig.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'dart:convert';

class DealerController extends GetxController {
  final BuildContext context;
  final RxList<bool> isExpanded = <bool>[].obs;
  final TextEditingController searchTextCon = TextEditingController();
  final RxBool isFetching = false.obs;

  DealerController(this.context);

  String? userId;
  final RxList<dynamic> dealerData = <dynamic>[].obs;
  final RxList<dynamic> filteredDealerData = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserDetail();
    fetchDealerData();
    // Delay DashboardController access until after initialization
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dashboardController = Get.find<DashboardController>();
      if (dashboardController.selectedIndex == 3 && dashboardController.needRefresh.value) {
        print("Refresh requested for DealerScreen via DashboardController");
        fetchDealerData();
        dashboardController.needRefresh.value = false;
      }
      if (Get.arguments?['refresh'] == true) {
        print("Refresh requested for DealerScreen via Get.arguments");
        fetchDealerData();
      }
    });
  }

  @override
  void onClose() {
    // Avoid disposing searchTextCon due to IndexedStack
    // searchTextCon.dispose();
    super.onClose();
  }

  void toggleExpansionTile(int index) {
    if (filteredDealerData.isNotEmpty && index >= 0 && index < isExpanded.length) {
      isExpanded[index] = !isExpanded[index];
      print("Toggled index $index to ${isExpanded[index]}");
    } else {
      print("Invalid index $index for isExpanded length ${isExpanded.length}");
    }
  }

  void getUserDetail() {
    PreferenceManager.instance.getString(ConstantString.userIdKey).then((id) {
      userId = id;
      print("User ID in DealerScreen: $id");
    });
  }

  void filterDealerData() {
    String query = searchTextCon.text.toLowerCase();
    if (query.isEmpty) {
      filteredDealerData.assignAll(dealerData);
    } else {
      filteredDealerData.assignAll(
        dealerData.where((dealer) {
          return dealer['delearname']?.toLowerCase().contains(query) ?? false;
        }).toList(),
      );
    }
    isExpanded.assignAll(List<bool>.filled(filteredDealerData.length, false));
    print("Filtered dealer data: ${filteredDealerData.length} items");
  }

  void clearSearch() {
    searchTextCon.clear();
    filterDealerData();
  }

  Future<void> fetchDealerData() async {
    if (isFetching.value) {
      print("Already fetching dealer data, skipping...");
      return;
    }

    isFetching.value = true;
    dealerData.clear();
    filteredDealerData.clear();
    isExpanded.clear();
    print("Fetching dealer data...");

    EasyLoadingConfig.show();

    try {
      if (userId == null) {
        userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      }

      if (userId == null || userId!.isEmpty) {
        Get.snackbar("Error", "User ID not found. Please log in again.");
        dealerData.clear();
        filteredDealerData.clear();
        isExpanded.clear();
        print("User ID not found, set dealerData and isExpanded to empty");
        return;
      }

      String token = await PreferenceManager.instance.getString(ConstantString.tokenKey);
      var headers = {
        'Accept': 'application/json',
        'Cookie': token,
      };

      var request = http.MultipartRequest(
        ConstantString.post,
        Uri.parse(ConstantString.myDealer),
      );
      request.fields.addAll({
        'user_id': userId!,
      });
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseBody);
        print("API Success:");
        print("Status Code: 200");
        print("Response Body: $responseBody");

        if (responseJson["code"] == 200) {
          dealerData.assignAll(responseJson["data"]);
          filteredDealerData.assignAll(dealerData);
          isExpanded.assignAll(List<bool>.filled(dealerData.length, false));
          print("Dealer Data fetched: $dealerData");
          print("Initialized isExpanded with length ${isExpanded.length}");
          searchTextCon.clear();
        } else {
          Get.snackbar("Error", responseJson["message"] ?? "Failed to fetch dealer data");
          dealerData.clear();
          filteredDealerData.clear();
          isExpanded.clear();
          print("API error, set dealerData and isExpanded to empty");
        }
      } else {
        String responseBody = await response.stream.bytesToString();
        var responseJson = jsonDecode(responseBody);
        String errorMessage = responseJson["error"] ?? response.reasonPhrase ?? "Something went wrong";
        Get.snackbar("Error", errorMessage);
        dealerData.clear();
        filteredDealerData.clear();
        isExpanded.clear();
        print("HTTP error, set dealerData and isExpanded to empty");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch dealer data: $e");
      dealerData.clear();
      filteredDealerData.clear();
      isExpanded.clear();
      print("Exception caught, set dealerData and isExpanded to empty: $e");
    } finally {
      EasyLoadingConfig.dismiss();
      isFetching.value = false;
      print("fetchDealerData completed, isExpanded length: ${isExpanded.length}");
    }
  }
}