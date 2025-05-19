import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UnSuccessfullVisitController extends GetxController {
  // Static data
  String shopName = "Sharma Hardware";
  Map<String, String> orderDetails = {
    'usingProducts': 'Yes',
    'usageQuantity': '55kg, Monthly',
    'lastOrder': '20kg, 22 April, 2025',
    'nextOrderDate': '23 May, 2025',
  };

  // TextField controller for remarks
  final TextEditingController remarksController = TextEditingController();

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}