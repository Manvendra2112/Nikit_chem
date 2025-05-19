import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currepassContr = TextEditingController();
  TextEditingController newpassContr = TextEditingController();
  TextEditingController confirmpassContr = TextEditingController();

  FocusNode currePassword = FocusNode();
  FocusNode newPassword = FocusNode();
  FocusNode confiPassword = FocusNode();

  String? validateCurrentPassword() {
    String value = currepassContr.text.trim();
    if (value.isEmpty) {
      return "Please enter your current password";
    }
    if (value.length < 6) {
      return "Current password must be at least 6 characters";
    }
    return null;
  }

  String? validateNewPassword() {
    String value = newpassContr.text.trim();
    if (value.isEmpty) {
      return "Please enter a new password";
    }
    if (value.length < 8) {
      return "New password must be at least 8 characters";
    }
    if (!RegExp(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@#$%^&*()_+!])[A-Za-z\d@#$%^&*()_+!]+$')
        .hasMatch(value)) {
      return "New password must contain uppercase, lowercase, digit, and special character";
    }
    return null;
  }

  String? validateConfirmPassword() {
    String value = confirmpassContr.text.trim();
    if (value.isEmpty) {
      return "Please confirm your new password";
    }
    if (value != newpassContr.text.trim()) {
      return "Confirm password does not match";
    }
    return null;
  }

  (String?, FocusNode?) validateAllFields() {
    String? error = validateCurrentPassword();
    if (error != null) {
      return (error, currePassword);
    }
    error = validateNewPassword();
    if (error != null) {
      return (error, newPassword);
    }
    error = validateConfirmPassword();
    if (error != null) {
      return (error, confiPassword);
    }
    return (null, null);
  }

  @override
  void onClose() {
    currepassContr.dispose();
    newpassContr.dispose();
    confirmpassContr.dispose();
    currePassword.dispose();
    newPassword.dispose();
    confiPassword.dispose();
    super.onClose();
  }
}