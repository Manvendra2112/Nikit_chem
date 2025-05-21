import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'beatvisit_model.dart';

class ViewDetailController extends GetxController {
  var dealer = Rxn<Dealer>();

  @override
  void onInit() {
    super.onInit();
    final dealerJson = Get.arguments;
    if (dealerJson != null) {
      dealer.value = Dealer.fromJson(dealerJson);
      print('ViewDetailController: Loaded dealer: ${dealer.value?.delearname}');
    } else {
      print('ViewDetailController: No dealer data provided');
      Get.snackbar('Error', 'No dealer data available',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}