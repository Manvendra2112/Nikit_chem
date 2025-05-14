import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OTPController extends GetxController{


  final pinController = TextEditingController();
  FocusNode pinFocus =FocusNode();

  bool validateOtp() {
    String otp = pinController.text.trim();
    if (otp.isEmpty) {
      return false;
    }
    // Validate OTP is exactly 6 digits
    if (otp.length != 4 || !RegExp(r'^\d+$').hasMatch(otp)) {
      return false;
    }
    return true;
  }


  @override
  void onClose() {
    pinController.dispose();
    super.onClose();
  }

}