import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';

class EditCarpenterDetailController extends GetxController {
  TextEditingController nameContr = TextEditingController();
  TextEditingController phoneContr = TextEditingController();
  TextEditingController addressContr = TextEditingController();
  TextEditingController remarksContr = TextEditingController();
  String selectedDealer = "";

  FocusNode nameFocus = FocusNode();
  FocusNode phoneFocus = FocusNode();
  FocusNode addressFocus = FocusNode();
  FocusNode remarksFocus = FocusNode();
  FocusNode dealerFocus = FocusNode();

  final List<String> dealerOptions = ["2", "3", "5", "7", "9", "10"];

  bool isLoading = false;
  bool isFormValid = false;

  @override
  void onInit() {
    super.onInit();
    validateForm();
  }

  @override
  void onClose() {
    nameContr.dispose();
    phoneContr.dispose();
    addressContr.dispose();
    remarksContr.dispose();
    nameFocus.dispose();
    phoneFocus.dispose();
    addressFocus.dispose();
    remarksFocus.dispose();
    dealerFocus.dispose();
    super.onClose();
  }

  String? validateName(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Carpenter Name";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters";
    }
    if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
      return "Name should contain only letters and spaces";
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

  String? validateAddress(String value) {
    value = value.trim();
    if (value.isEmpty) {
      return "Please enter Shop Address";
    }
    if (value.length < 5) {
      return "Address must be at least 5 characters";
    }
    return null;
  }

  String? validateDealer(String value) {
    if (value.isEmpty) {
      return "Please select a Dealer";
    }
    return null;
  }

  String? validateRemarks(String value) {
    value = value.trim();
    if (value.length > 500) {
      return "Remarks cannot exceed 500 characters";
    }
    return null;
  }

  void updateNameValidity() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void updatePhoneValidity() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void updateAddressValidity() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void updateDealerValidity() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void updateRemarksValidity() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void validateForm() {
    isFormValid = validateName(nameContr.text) == null &&
        validatePhone(phoneContr.text) == null &&
        validateAddress(addressContr.text) == null &&
        validateDealer(selectedDealer) == null &&
        validateRemarks(remarksContr.text) == null;
  }

  void submitDetails(BuildContext context) {
    isLoading = true;
    update();

    String? nameError = validateName(nameContr.text);
    if (nameError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nameError)));
      nameFocus.requestFocus();
      isLoading = false;
      update();
      return;
    }

    String? phoneError = validatePhone(phoneContr.text);
    if (phoneError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(phoneError)));
      phoneFocus.requestFocus();
      isLoading = false;
      update();
      return;
    }

    String? addressError = validateAddress(addressContr.text);
    if (addressError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(addressError)));
      addressFocus.requestFocus();
      isLoading = false;
      update();
      return;
    }

    String? dealerError = validateDealer(selectedDealer);
    if (dealerError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(dealerError)));
      dealerFocus.requestFocus();
      isLoading = false;
      update();
      return;
    }

    String? remarksError = validateRemarks(remarksContr.text);
    if (remarksError != null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(remarksError)));
      remarksFocus.requestFocus();
      isLoading = false;
      update();
      return;
    }

    isLoading = false;
    update();
    Get.offAll(
          () => const DashboardScreen(),
      arguments: {'selectedIndex': 2, 'refresh': true},
    );
  }
}