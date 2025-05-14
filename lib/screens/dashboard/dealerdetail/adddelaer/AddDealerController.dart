import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart'; // Updated import
import 'package:nikitchem/support/PreferenceManager.dart';
import 'dart:convert';

class AddDealerController extends GetxController {
  final TextEditingController nameContr = TextEditingController();
  final TextEditingController phoneContr = TextEditingController();
  final TextEditingController emailContr = TextEditingController();
  final TextEditingController stateContr = TextEditingController();
  final TextEditingController cityContr = TextEditingController();
  final TextEditingController addressContr = TextEditingController();
  final TextEditingController floorContr = TextEditingController();
  final TextEditingController landmarkContr = TextEditingController();
  final TextEditingController nearbyLandmarkContr = TextEditingController();

  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode stateFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode floorFocus = FocusNode();
  final FocusNode landmarkFocus = FocusNode();
  final FocusNode nearbyLandmarkFocus = FocusNode();

  final RxBool isLoading = false.obs;

  final BuildContext context;

  AddDealerController(this.context);

  @override
  void onClose() {
    nameContr.dispose();
    phoneContr.dispose();
    emailContr.dispose();
    stateContr.dispose();
    cityContr.dispose();
    addressContr.dispose();
    floorContr.dispose();
    landmarkContr.dispose();
    nearbyLandmarkContr.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    stateFocus.dispose();
    cityFocus.dispose();
    addressFocus.dispose();
    floorFocus.dispose();
    landmarkFocus.dispose();
    nearbyLandmarkFocus.dispose();
    super.onClose();
  }

  String? validateName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Dealer Name";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Dealer Name should contain only letters and spaces";
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
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value)) {
      return "Please enter a valid Email";
    }
    return null;
  }

  String? validateState(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter State";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "State should contain only letters and spaces";
    }
    return null;
  }

  String? validateCity(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter City";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "City should contain only letters and spaces";
    }
    return null;
  }

  String? validateAddress(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Shop Address";
    }
    if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
      return "Shop Address should contain letters, numbers, spaces, commas, or periods";
    }
    return null;
  }

  String? validateOptionalField(String value) {
    value = value.trim();
    if (value.isNotEmpty && !RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
      return "Field should contain letters, numbers, spaces, commas, or periods";
    }
    return null;
  }

  Future<void> createDealer(BuildContext context) async {
    // Validate all fields
    String? nameError = validateName(nameContr.text);
    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nameError)));
      nameFocus.requestFocus();
      return;
    }

    String? phoneError = validatePhone(phoneContr.text);
    if (phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(phoneError)));
      phoneFocus.requestFocus();
      return;
    }

    String? emailError = validateEmail(emailContr.text);
    if (emailError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(emailError)));
      emailFocus.requestFocus();
      return;
    }

    String? stateError = validateState(stateContr.text);
    if (stateError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(stateError)));
      stateFocus.requestFocus();
      return;
    }

    String? cityError = validateCity(cityContr.text);
    if (cityError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cityError)));
      cityFocus.requestFocus();
      return;
    }

    String? addressError = validateAddress(addressContr.text);
    if (addressError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(addressError)));
      addressFocus.requestFocus();
      return;
    }

    String? floorError = validateOptionalField(floorContr.text);
    if (floorError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(floorError)));
      floorFocus.requestFocus();
      return;
    }

    String? landmarkError = validateOptionalField(landmarkContr.text);
    if (landmarkError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(landmarkError)));
      landmarkFocus.requestFocus();
      return;
    }

    String? nearbyLandmarkError = validateOptionalField(nearbyLandmarkContr.text);
    if (nearbyLandmarkError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nearbyLandmarkError)));
      nearbyLandmarkFocus.requestFocus();
      return;
    }

    // Get user_id and token from PreferenceManager
    String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
    if (userId == null || userId.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User ID not found. Please log in again.")),
      );
      return;
    }

    String? token = await PreferenceManager.instance.getString(ConstantString.tokenKey);
    if (token == null || token.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Token not found. Please log in again.")),
      );
      return;
    }

    isLoading.value = true;

    // Prepare request body
    Map<String, String> requestBody = {
      'name': nameContr.text.trim(),
      'phone': phoneContr.text.trim(),
      'email': emailContr.text.trim(),
      'user_id': userId,
      'address': addressContr.text.trim(),
      'state': stateContr.text.trim(),
      'city': cityContr.text.trim(),
      'floor': floorContr.text.trim(),
      'near_by_land': nearbyLandmarkContr.text.trim(),
    };

    // Headers with dynamic token
    Map<String, String> headers = {
      'Accept': 'application/json',
      'Cookie': token,
    };

    try {
      // Make API request
      var response = await APIConstant.gethitAPI(
        context,
        ConstantString.post,
        'https://pob.volvrit.in/api/v1/users/create-dealer',
        sendInFeilds: true,
        body: requestBody,
        headers: headers,
      );

      // Parse response
      var responseJson = jsonDecode(response);
      print('API Success:');
      print('Status Code: ${responseJson["code"] ?? 200}');
      print('Response Body: $response');

      if (responseJson["code"] == 200 || responseJson["code"] == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Dealer created successfully")),
        );
        await Future.delayed(const Duration(seconds: 1)); // Brief delay for feedback
        Get.offAll(
              () => const DashboardScreen(),
          arguments: {'selectedIndex': 3, 'refresh': true},
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(responseJson["message"] ?? "Failed to create dealer")),
        );
      }
    } catch (e) {
      print('API Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to create dealer: $e")),
      );
    } finally {
      isLoading.value = false;
    }
  }
}