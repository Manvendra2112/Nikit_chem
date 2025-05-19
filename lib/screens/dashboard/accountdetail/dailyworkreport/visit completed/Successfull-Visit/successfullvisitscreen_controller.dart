import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessfullVisitController extends GetxController {
  // Static data
  String shopName = "Sharma Hardware";
  Map<String, String> orderDetails = {
    'selectedOrder': 'American Bond Water Proof',
    'quantity': '55kg',
    'price': '₹ 2000.00',
    'scheme': 'N.A',
    'totalPrice': '₹ 2000.00',
  };

  // TextField controller for remarks
  final TextEditingController remarksController = TextEditingController();

  @override
  void onClose() {
    remarksController.dispose();
    super.onClose();
  }
}