import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';

class PunchInCompleteController extends GetxController{
  BuildContext context;



  TimeOfDay currentTime;
  DateTime currentDate;

  PunchInCompleteController(this.context)
      : currentTime = TimeOfDay.now(),
        currentDate = DateTime.now();


  @override
  void onInit() {
    super.onInit();
    // Start a 30-second timer to close the dialog and navigate


    Future.delayed(Duration(seconds: 2), () {
      Get.back(); // Close the dialog
      Get.off(() => DashboardScreen()); // Navigate to DashboardScreen
    });
  }





}