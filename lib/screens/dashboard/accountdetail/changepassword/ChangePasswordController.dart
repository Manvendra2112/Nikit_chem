import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'dart:convert';

import 'enternumber/EnterNumberScreen.dart';

class ChangePasswordController extends GetxController {
  TextEditingController currepassContr = TextEditingController();
  TextEditingController newpassContr = TextEditingController();
  TextEditingController confirmpassContr = TextEditingController();

  FocusNode currePassword = FocusNode();
  FocusNode newPassword = FocusNode();
  FocusNode confiPassword = FocusNode();

  var isLoading = false.obs;
  var showCurrentPassword = false.obs; // Visibility for current password
  var showNewPassword = false.obs; // Visibility for new password
  var showConfirmPassword = false.obs; // Visibility for confirm password

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

  Future<void> changePassword(BuildContext context) async {
    var (error, focusNode) = validateAllFields();
    if (error != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
      focusNode?.requestFocus();
      return;
    }

    isLoading.value = true;

    try {
      String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      String? token = await PreferenceManager.instance.getString(ConstantString.tokenKey);

      if (userId == null || userId.isEmpty || token == null || token.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("User ID or token not found. Please log in again.")),
        );
        isLoading.value = false;
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://pob.volvrit.in/api/v1/users/change-password'),
      );

      request.fields.addAll({
        'user_id': userId,
        'current_password': currepassContr.text.trim(),
        'new_password': newpassContr.text.trim(),
        'new_password_confirmation': confirmpassContr.text.trim(),
      });

      request.headers.addAll({
        'Accept': 'application/json',
        'Cookie': token,
      });

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseBody);

      print("Change Password Response: ${response.statusCode} - $responseBody");

      if (response.statusCode == 200 && responseJson['code'] == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseJson['message'] ?? "Password changed successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Get.to(() => EnterNumberScreen());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(responseJson['message'] ?? "Failed to change password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      print("Change Password Exception: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Network error: Unable to change password"),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }

  void toggleCurrentPasswordVisibility() {
    showCurrentPassword.value = !showCurrentPassword.value;
  }

  void toggleNewPasswordVisibility() {
    showNewPassword.value = !showNewPassword.value;
  }

  void toggleConfirmPasswordVisibility() {
    showConfirmPassword.value = !showConfirmPassword.value;
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