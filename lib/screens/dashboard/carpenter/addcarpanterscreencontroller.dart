import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:nikitchem/support/alert_dialog_manager.dart';
import 'dart:convert';

class AddCarpenterScreenController extends GetxController {
  final TextEditingController nameContr = TextEditingController();
  final TextEditingController phoneContr = TextEditingController();
  final TextEditingController emailContr = TextEditingController();
  final TextEditingController addressContr = TextEditingController();
  final TextEditingController remarksContr = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode remarksFocus = FocusNode();
  final FocusNode dealerFocus = FocusNode();

  final RxBool isLoading = false.obs;
  final String dealerId;
  String selectedDealer = '';
  final RxList<Map<String, String>> dealerOptions = <Map<String, String>>[].obs;

  AddCarpenterScreenController({required this.dealerId}) {
    print("AddCarpenterScreenController created with dealerId: $dealerId");
  }

  @override
  void onInit() {
    super.onInit();
    fetchDealers();
  }

  @override
  void onClose() {
    nameContr.dispose();
    phoneContr.dispose();
    emailContr.dispose();
    addressContr.dispose();
    remarksContr.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    addressFocus.dispose();
    remarksFocus.dispose();
    dealerFocus.dispose();
    super.onClose();
  }

  Future<void> fetchDealers() async {
    try {
      String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      String? token = await PreferenceManager.instance.getString(ConstantString.tokenKey);
      if (userId == null || token == null) {
        print("fetchDealers: Missing userId or token");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          const SnackBar(content: Text("Authentication error. Please log in again.")),
        );
        return;
      }

      var headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      };

      var body = {
        'user_id': userId,
      };

      print("fetchDealers: Fetching dealers with userId: $userId");
      var response = await APIConstant.gethitAPI(
        Get.context!,
        ConstantString.post,
        'https://pob.volvrit.in/api/v1/users/my-dealer',
        sendInFeilds: true,
        body: body,
        headers: headers,
      );

      var responseJson = jsonDecode(response);
      print("fetchDealers Response: $responseJson");

      if (responseJson["code"] == 200) {
        List<dynamic> dealers = responseJson["data"] ?? [];
        dealerOptions.assignAll(dealers.map((dealer) => {
          'id': dealer['id'].toString(),
          'name': dealer['delearname'].toString(),
        }).toList());
        // Set selectedDealer based on dealerId
        final matchingDealer = dealerOptions.firstWhereOrNull((option) => option['id'] == dealerId);
        selectedDealer = matchingDealer != null
            ? matchingDealer['id']!
            : (dealerOptions.isNotEmpty ? dealerOptions[0]['id']! : '');
        print("fetchDealers: Set selectedDealer to $selectedDealer, options: $dealerOptions");
        update();
      } else {
        print("fetchDealers: Failed with code ${responseJson["code"]}, message: ${responseJson["message"]}");
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text(responseJson["message"] ?? "Failed to fetch dealers")),
        );
      }
    } catch (e) {
      print("fetchDealers Error: $e");
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(content: Text("Failed to fetch dealers: $e")),
      );
    }
  }

  String? validateName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Carpenter Name";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Carpenter Name should contain only letters and spaces";
    }
    return null;
  }

  String? validatePhone(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Phone Number";
    }
    if (!RegExp(r'^[6-9][0-9]{9}$').hasMatch(value)) {
      return "Phone Number must be 10 digits and start with 6-9";
    }
    return null;
  }

  String? validateEmail(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Email";
    }
    if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return "Please enter a valid Email";
    }
    return null;
  }

  String? validateAddress(String value) {
    value = value.trim();
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
      return "Address should contain letters, numbers, spaces, commas, or periods";
    }
    return null;
  }

  String? validateRemarks(String value) {
    value = value.trim();
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
      return "Remarks should contain letters, numbers, spaces, commas, or periods";
    }
    return null;
  }

  String? validateDealer(String value) {
    if (value.isEmpty) {
      return "Please select a Dealer";
    }
    return null;
  }

  Future<void> createCarpenter(BuildContext context) async {
    isLoading.value = true;
    update();

    // Validate all fields
    String? nameError = validateName(nameContr.text);
    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nameError)));
      nameFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? phoneError = validatePhone(phoneContr.text);
    if (phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(phoneError)));
      phoneFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? emailError = validateEmail(emailContr.text);
    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(emailError)));
      emailFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? addressError = validateAddress(addressContr.text);
    if (addressError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(addressError)));
      addressFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? remarksError = validateRemarks(remarksContr.text);
    if (remarksError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(remarksError)));
      remarksFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? dealerError = validateDealer(selectedDealer);
    if (dealerError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(dealerError)));
      dealerFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    // Get user_id and token from PreferenceManager
    String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
    String? token = await PreferenceManager.instance.getString(ConstantString.tokenKey);

    print('User ID: $userId');
    print('Token: $token');

    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found. Please log in again.")),
      );
      isLoading.value = false;
      update();
      return;
    }

    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found. Please log in again.")),
      );
      isLoading.value = false;
      update();
      return;
    }

    // Prepare form-data request
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://pob.volvrit.in/api/v1/users/create-carpenter'),
      );

      // Add headers
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      request.fields['name'] = nameContr.text.trim();
      request.fields['phone'] = phoneContr.text.trim();
      request.fields['email'] = emailContr.text.trim();
      request.fields['address'] = addressContr.text.trim();
      request.fields['remarks'] = remarksContr.text.trim();
      request.fields['dealer_id'] = selectedDealer;
      request.fields['user_id'] = userId;

      print('Request URL: ${request.url}');
      print('Request Headers: ${request.headers}');
      print('Request Fields: ${request.fields}');

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      print('Response Status: ${response.statusCode}');
      print('Response Body: $responseBody');

      isLoading.value = false;
      update();

      if (response.statusCode == 200 || response.statusCode == 201) {
        var responseJson = jsonDecode(responseBody);
        print("createCarpenter API Success: $responseBody");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Carpenter created successfully")),
        );
        await Future.delayed(const Duration(seconds: 1));
        print('Navigating to DashboardScreen with selectedIndex: 2, refresh: true');
        Get.offAll(
              () => const DashboardScreen(),
          arguments: {'selectedIndex': 2, 'refresh': true},
        );
      } else {
        var responseJson = jsonDecode(responseBody);
        String errorMessage = responseJson['message'] ?? 'Failed to create carpenter';
        if (responseJson['errors'] != null) {
          errorMessage += ': ${jsonEncode(responseJson['errors'])}';
        }
        print("createCarpenter: Failed with code ${response.statusCode}, message: $errorMessage");
        // AlertDialogManager.getSnackBarMsg(
        //   "Error",
        //   errorMessage,
        //   false,
        //   context,
        // );
      }
    } catch (e) {
      isLoading.value = false;
      update();
      print("createCarpenter Error: $e");
      // AlertDialogManager.getSnackBarMsg(
      //   "Error",
      //   "Failed to create carpenter: $e",
      //   false,
      //   context,
      // );
    }
  }
}