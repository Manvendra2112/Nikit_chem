import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:nikitchem/support/alert_dialog_manager.dart';
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
  final RxString selectedState = ''.obs;
  final RxString selectedCity = ''.obs;
  final RxList<String> stateList = <String>[].obs;
  final RxList<String> cityList = <String>[].obs;

  final BuildContext context;

  AddDealerController(this.context);

  @override
  void onInit() {
    super.onInit();
    fetchStates();
  }

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

  Future<void> fetchStates() async {
    isLoading.value = true;
    update();

    try {
      var response = await APIConstant.gethitAPI(
        context,
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
            context,
          );
        }
      }
    } catch (e) {
      print('Error fetching states: $e');
      AlertDialogManager.getSnackBarMsg(
        "Error",
        "Failed to fetch states",
        false,
        context,
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
        context,
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
            context,
          );
        }
      }
    } catch (e) {
      print('Error fetching cities: $e');
      AlertDialogManager.getSnackBarMsg(
        "Error",
        "Failed to fetch cities",
        false,
        context,
      );
    } finally {
      isLoading.value = false;
      update();
    }
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

    String? stateError = validateState(selectedState.value);
    if (stateError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(stateError)));
      stateFocus.requestFocus();
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

    String? landmarkError = validateOptionalField(landmarkContr.text);
    if (landmarkError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(landmarkError)));
      landmarkFocus.requestFocus();
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
        Uri.parse('https://pob.volvrit.in/api/v1/users/create-dealer'),
      );

      // Add headers
      request.headers['Accept'] = 'application/json';
      request.headers['Authorization'] = 'Bearer $token';

      // Add form fields
      request.fields['name'] = nameContr.text.trim();
      request.fields['phone'] = phoneContr.text.trim();
      request.fields['email'] = emailContr.text.trim();
      request.fields['user_id'] = userId;
      request.fields['state'] = selectedState.value;
      request.fields['city'] = selectedCity.value;
      request.fields['address'] = addressContr.text.trim();
      request.fields['floor'] = floorContr.text.trim();
      request.fields['near_by_land'] = nearbyLandmarkContr.text.trim();

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
        print("Dealer API success: $responseBody");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Dealer created successfully")),
        );
        await Future.delayed(const Duration(seconds: 1));
        Get.offAll(
              () => const DashboardScreen(),
          arguments: {'selectedIndex': 3, 'refresh': true},
        );
      } else {
        var responseJson = jsonDecode(responseBody);
        String errorMessage = responseJson['message'] ?? 'Failed to create dealer';
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
        "Failed to create dealer: $e",
        false,
        context,
      );
    }
  }
}