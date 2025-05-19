import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../DashboardScreen.dart';

class UnsuccessfullvisitController extends GetxController {
  TextEditingController remarksController = TextEditingController();
  FocusNode remarksFocus = FocusNode();

  void submit() {
    if (remarksController.text.trim().isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter remarks',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        margin: EdgeInsets.all(20),
        duration: Duration(seconds: 3),
      );
    } else {
      Get.offAll(
            () => const DashboardScreen(),
        arguments: {'selectedIndex': 0, 'refresh': true},
      );
    }
  }
}