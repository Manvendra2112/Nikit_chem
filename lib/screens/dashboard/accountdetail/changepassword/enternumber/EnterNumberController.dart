import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EnterNumberController extends GetxController {
  TextEditingController mobileNumController = TextEditingController();
  FocusNode mobileFocus = FocusNode();

  String? validatePhoneNumber() {
    String value = mobileNumController.text.trim();
    if (value.isEmpty) {
      return "Please enter a phone number";
    }
    if (value.length != 10) {
      return "Please enter a valid 10-digit phone number";
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return "Phone number must contain only numbers";
    }
    return null;
  }

  @override
  void onClose() {
    mobileNumController.dispose();
    mobileFocus.dispose();
    super.onClose();
  }
}