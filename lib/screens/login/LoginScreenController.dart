import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInController.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInDialog.dart';
import 'package:nikitchem/screens/model/login_model.dart';
import 'package:nikitchem/support/EasyLoadingConfig.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:nikitchem/support/alert_dialog_manager.dart';

class LoginScreenController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;

  final BuildContext context;

  LoginScreenController(this.context);

  FocusNode emailFocus = FocusNode();
  FocusNode passFocus = FocusNode();

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocus.dispose();
    passFocus.dispose();
    super.onClose();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    update();
  }

  bool validateForm(BuildContext context) {
    if (emailController.text.isEmpty) {
      emailFocus.requestFocus();
      AlertDialogManager.getSnackBarMsg("Warning", "Email can't be empty", false, context);
      return false;
    } else if (passwordController.text.isEmpty) {
      passFocus.requestFocus();
      AlertDialogManager.getSnackBarMsg("Warning", "Password can't be empty", false, context);
      return false;
    }
    return true;
  }

  void verifyPhoneNumber() async {
    if (!validateForm(context)) {
      return;
    }

    EasyLoadingConfig.show();

    try {
      var response = await APIConstant.hitAPIWithToken(
        context,
        ConstantString.post,
        ConstantString.login,
        sendInFields: true,
        body: {
          'email': emailController.text,
          'password': passwordController.text,
        },
        headers: {'Accept': 'application/json'},
      );

      EasyLoadingConfig.dismiss();

      var responseBody = response['body'];
      var responseHeaders = response['headers'] as Map<String, String>;
      var error = response['error'];

      if (responseBody != null && error == null) {
        var responseJson = jsonDecode(responseBody);
        if (responseJson['code'] == 200) {
          print("Login API success: $responseBody");

          // Extract and store token from Set-Cookie
          String? token = responseHeaders['set-cookie']?.split(';').first;
          if (token != null) {
            await PreferenceManager.instance.setString(ConstantString.tokenKey, token);
            print("Token stored: $token");
          }

          // Parse and store login response
          LoginModel loginModel = LoginModel.fromJson(responseJson);
          await PreferenceManager.instance.setString(ConstantString.loginKey, responseBody);
          await PreferenceManager.instance.setString(
            ConstantString.userIdKey,
            loginModel.user!.id!.toString(),
          );

          AlertDialogManager().isErrorAndSuccessAlertDialogMessage(
            context,
            'Success',
            responseJson["message"],
            onTapFunction: () {
              Get.back();
              postData(loginModel.user!.id!.toString());
            },
          );
        } else {
          handleError(responseJson['message'] ?? 'Something went wrong');
        }
      } else {
        handleError(error ?? 'Something went wrong');
      }
    } catch (e) {
      EasyLoadingConfig.dismiss();
      print("Error: $e");
      AlertDialogManager.getSnackBarMsg("Error", "Something went wrong", false, context);
      update();
    }
  }

  void handleError(String errorMessage) {
    errorMessage = errorMessage.toLowerCase();
    if (errorMessage.contains('invalid') || errorMessage.contains('password')) {
      AlertDialogManager.getSnackBarMsg("Error", "Wrong credentials", false, context);
    } else if (errorMessage.contains('not found') || errorMessage.contains('register')) {
      AlertDialogManager.getSnackBarMsg("Error", "User not registered", false, context);
    } else {
      AlertDialogManager.getSnackBarMsg("Error", errorMessage, false, context);
    }
    update();
  }

  Future<void> postData(String userId) async {
    try {
      var response = await APIConstant.hitAPIWithToken(
        context,
        ConstantString.post,
        ConstantString.check_punchin,
        body: {'user_id': userId},
        headers: {
          'Content-Type': 'application/json',
          'Cookie': await PreferenceManager.instance.getString(ConstantString.tokenKey),
        },
      );

      var responseBody = response['body'];
      var error = response['error'];

      if (responseBody != null && error == null) {
        var responseJson = jsonDecode(responseBody);
        if (responseJson['code'] == 200) {
          Get.put(PunchInController(context));
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return PunchInDialog();
            },
          );
        } else {
          Get.offAll(() => DashboardScreen(), arguments: {'refresh': true});
        }
      } else {
        Get.offAll(() => DashboardScreen(), arguments: {'refresh': true});
      }
    } catch (e) {
      print('Error in punch-in check: $e');
      Get.offAll(() => DashboardScreen(), arguments: {'refresh': true});
    }
  }
}