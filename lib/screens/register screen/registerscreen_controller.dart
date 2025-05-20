import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/login/LoginScreen.dart';
import 'package:nikitchem/support/alert_dialog_manager.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../../support/app_theme.dart';

class RegesterScreenController extends GetxController {
  // Text Controllers
  final TextEditingController nameContr = TextEditingController();
  final TextEditingController phoneContr = TextEditingController();
  final TextEditingController emailContr = TextEditingController();
  final TextEditingController passwordContr = TextEditingController();
  final TextEditingController confirmPasswordContr = TextEditingController();
  final TextEditingController addressContr = TextEditingController();
  final TextEditingController floorContr = TextEditingController();
  final TextEditingController cityContr = TextEditingController();
  final TextEditingController nearbyLandmarkContr = TextEditingController();

  // Focus Nodes
  final FocusNode nameFocus = FocusNode();
  final FocusNode phoneFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();
  final FocusNode floorFocus = FocusNode();
  final FocusNode cityFocus = FocusNode();
  final FocusNode nearbyLandmarkFocus = FocusNode();

  // Observables
  final RxBool isLoading = false.obs;
  final RxBool isPasswordHidden = true.obs;
  final RxBool isConfirmPasswordHidden = true.obs;
  final RxString selectedStaff = ''.obs;
  final RxString selectedState = ''.obs;
  final RxString selectedCity = ''.obs;
  final RxList<String> stateList = <String>[].obs;
  final RxList<String> cityList = <String>[].obs;

  // Static Staff List
  final List<String> staffList = [
    'Sales Executive',
    'Sales Promotion Executive',
    'Team Head',
    'Carpenter Working Worker',
    'Calling Staff',
    'Accounting Staff',
       'Hr Head'// Added to match Postman
  ];

  @override
  void onInit() {
    super.onInit();
    selectedStaff.value = '';
    fetchStates();
  }

  @override
  void onClose() {
    nameContr.dispose();
    phoneContr.dispose();
    emailContr.dispose();
    passwordContr.dispose();
    confirmPasswordContr.dispose();
    addressContr.dispose();
    floorContr.dispose();
    cityContr.dispose();
    nearbyLandmarkContr.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    addressFocus.dispose();
    floorFocus.dispose();
    cityFocus.dispose();
    nearbyLandmarkFocus.dispose();
    super.onClose();
  }

  Future<void> fetchStates() async {
    isLoading.value = true;
    update();

    try {
      var response = await APIConstant.gethitAPI(
        Get.context!,
        ConstantString.get,
        ConstantString.getStates,
        headers: {'Accept': 'application/json'},
      );

      if (response != null) {
        var responseJson = jsonDecode(response);
        if (responseJson['code'] == 200 && responseJson['states'] != null) {
          stateList.clear();
          stateList.addAll(List<String>.from(responseJson['states']));
          print('States fetched: ${stateList.length}');
        } else {
          AlertDialogManager.getSnackBarMsg(
            "Error",
            responseJson['message'] ?? "Failed to fetch states",
            false,
            Get.context!,
          );
        }
      }
    } catch (e) {
      print('Error fetching states: $e');
      AlertDialogManager.getSnackBarMsg(
        "Error",
        "Failed to fetch states",
        false,
        Get.context!,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  Future<void> loadCities(String state) async {
    isLoading.value = true;
    cityList.clear();
    update();

    try {
      var response = await APIConstant.gethitAPI(
        Get.context!,
        ConstantString.get,
        "${ConstantString.getCities}/$state",
        headers: {'Accept': 'application/json'},
      );

      if (response != null) {
        var responseJson = jsonDecode(response);
        if (responseJson['code'] == 200 && responseJson['cities'] != null) {
          cityList.addAll(List<String>.from(responseJson['cities']));
          print('Cities fetched for $state: ${cityList.length}');
        } else {
          AlertDialogManager.getSnackBarMsg(
            "Error",
            responseJson['message'] ?? "Failed to fetch cities",
            false,
            Get.context!,
          );
        }
      }
    } catch (e) {
      print('Error fetching cities: $e');
      AlertDialogManager.getSnackBarMsg(
        "Error",
        "Failed to fetch cities",
        false,
        Get.context!,
      );
    } finally {
      isLoading.value = false;
      update();
    }
  }

  String? validateName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Full Name";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Full Name should contain only letters and spaces";
    }
    return null;
  }

  String? validateStaff(String value) {
    if (value.isEmpty) {
      return "Please select a Staff Role";
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

  String? validatePassword(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Password";
    }
    if (value.length < 8) {
      return "Password must be at least 8 characters long";
    }
    return null;
  }

  String? validateConfirmPassword(String value, String password) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please confirm Password";
    }
    if (value != password) {
      return "Passwords do not match";
    }
    return null;
  }

  String? validateAddress(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Flat / House No / Building Name";
    }
    if (!RegExp(r'^[a-zA-Z0-9\s,.-]+$').hasMatch(value)) {
      return "Address should contain letters, numbers, spaces, commas, or periods";
    }
    return null;
  }

  String? validateState(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please select a State";
    }
    return null;
  }

  String? validateCity(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please select a City";
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

  Future<void> showSuccessPopup(BuildContext context) async {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            width: screenWidth * 0.8,
            padding: EdgeInsets.all(screenWidth * 0.05),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  ImageAssets.tickwithstar,
                  width: 100,
                  height: 55,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: screenHeight * 0.02),
                Text(
                  "You have Registered Successful. After approval from admin you can login to system.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2));
    Navigator.of(context).pop();
    Get.off(() => LoginScreen());
  }

  Future<void> createAccount(BuildContext context) async {
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

    String? staffError = validateStaff(selectedStaff.value);
    if (staffError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(staffError)));
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

    String? passwordError = validatePassword(passwordContr.text);
    if (passwordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(passwordError)));
      passwordFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? confirmPasswordError = validateConfirmPassword(confirmPasswordContr.text, passwordContr.text);
    if (confirmPasswordError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(confirmPasswordError)));
      confirmPasswordFocus.requestFocus();
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

    String? floorError = validateOptionalField(floorContr.text);
    if (floorError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(floorError)));
      floorFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? stateError = validateState(selectedState.value);
    if (stateError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(stateError)));
      isLoading.value = false;
      update();
      return;
    }

    String? cityError = validateCity(selectedCity.value);
    if (cityError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cityError)));
      cityFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    String? nearbyLandmarkError = validateOptionalField(nearbyLandmarkContr.text);
    if (nearbyLandmarkError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nearbyLandmarkError)));
      nearbyLandmarkFocus.requestFocus();
      isLoading.value = false;
      update();
      return;
    }

    // Prepare form-data request
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse(ConstantString.createAccount),
      );

      // Add headers
      request.headers['Accept'] = 'application/json';

      // Add form fields
      request.fields['name'] = nameContr.text.trim();
      request.fields['email'] = emailContr.text.trim();
      request.fields['phone'] = phoneContr.text.trim();
      request.fields['role'] = selectedStaff.value;
      request.fields['state'] = selectedState.value;
      request.fields['city'] = selectedCity.value;
      request.fields['near_by_land'] = nearbyLandmarkContr.text.trim();
      request.fields['password'] = passwordContr.text;
      request.fields['password_confirmation'] = confirmPasswordContr.text;
      request.fields['floor'] = floorContr.text.trim();
      request.fields['address'] = addressContr.text.trim();

      print('Request URL: ${ConstantString.createAccount}');
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
        print("Register API success: $responseBody");
        await showSuccessPopup(context);
      } else {
        var responseJson = jsonDecode(responseBody);
        String errorMessage = responseJson['message'] ?? 'Registration failed';
        if (responseJson['errors'] != null) {
          errorMessage += ': ${jsonEncode(responseJson['errors'])}';
        }
        AlertDialogManager.getSnackBarMsg(
          "Error",
          errorMessage,
          false,
          context,
        );
      }
    } catch (e) {
      isLoading.value = false;
      update();
      print("Error: $e");
      AlertDialogManager.getSnackBarMsg(
        "Error",
        "Something went wrong: $e",
        false,
        context,
      );
    }
  }
}