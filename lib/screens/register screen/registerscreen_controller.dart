import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/flutter_font_style.dart';

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
  final RxList<String> cityList = <String>[].obs;

  // Dummy Staff List
  final List<String> staffList = [
    'Manager',
    'Sales Representative',
    'Technician',
    'Support Staff',
  ];

  // Dummy State List
  final List<String> stateList = [
    'Maharashtra',
    'Delhi',
    'Karnataka',
    'Tamil Nadu',
    'Gujarat',
  ];

  // Dummy State-to-City Mapping
  final Map<String, List<String>> stateToCities = {
    'Maharashtra': ['Mumbai', 'Pune', 'Nagpur', 'Nashik'],
    'Delhi': ['New Delhi', 'South Delhi', 'North Delhi'],
    'Karnataka': ['Bangalore', 'Mysore', 'Hubli'],
    'Tamil Nadu': ['Chennai', 'Coimbatore', 'Madurai'],
    'Gujarat': ['Ahmedabad', 'Surat', 'Vadodara'],
  };

  @override
  void onInit() {
    super.onInit();
    selectedStaff.value = '';
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

  void loadCities(String state) {
    cityList.clear();
    if (stateToCities.containsKey(state)) {
      cityList.addAll(stateToCities[state]!);
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

    // If all validations pass, navigate to DashboardScreen
    isLoading.value = false;
    update();
    Get.off(() => const DashboardScreen());
  }
}