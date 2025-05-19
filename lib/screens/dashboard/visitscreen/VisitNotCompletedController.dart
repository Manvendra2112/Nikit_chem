import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../DashboardScreen.dart';

class VisitNotCompletedController extends GetxController {
  TextEditingController remarksController = TextEditingController();
  final TextEditingController competitorbrandname = TextEditingController();
  final TextEditingController otherdealer = TextEditingController();
  final TextEditingController brandproduct = TextEditingController();

  FocusNode remarksFocus = FocusNode();
  final FocusNode competitorbrandnameFocus = FocusNode();
  final FocusNode otherdealerFocus = FocusNode();
  final FocusNode brandproductFocus = FocusNode();

  bool isUsingProduct = true;
  String quantity = '';
  String selectedPeriod = 'Month';
  DateTime? expectedOrderDate;
  final List<String> periods = ['Month', 'Week', 'Day'];

  void toggleProductUsage(bool value) {
    isUsingProduct = value;
    update();
  }

  void setQuantity(String value) {
    quantity = value;
    update();
  }

  void setPeriod(String value) {
    selectedPeriod = value;
    update();
  }

  void setExpectedOrderDate(DateTime? date) {
    expectedOrderDate = date;
    update();
  }

  void submit() {
    if (remarksController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the reason for the unsuccessful visit',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 3),
      );
      return;
    }

    if (!isUsingProduct) {
      if (competitorbrandname.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter the competitor brand name',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 3),
        );
        return;
      }
      if (otherdealer.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter the dealer supplying competitor products',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(20),
          duration: Duration(seconds: 3),
        );
        return;
      }
    }

    if (brandproduct.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter the recommended brand products',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 3),
      );
      return;
    }

    // All validations passed
    Get.offAll(
          () => const DashboardScreen(),
      arguments: {'selectedIndex': 0, 'refresh': true},
    );
  }
}