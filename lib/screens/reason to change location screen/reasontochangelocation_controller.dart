import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class ReasonToChangeLocationController extends GetxController {
  final reasonController = TextEditingController();

  @override
  void onClose() {
    reasonController.dispose();
    super.onClose();
  }

  void submitReason(BuildContext context) {
    // Dismiss the keyboard
    FocusScope.of(context).unfocus();

    if (reasonController.text.trim().isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter a reason",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    final screenWidth = MediaQuery.of(context).size.width;
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(screenWidth * 0.05),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                ImageAssets.success,
                width: screenWidth * 0.2,
                height: screenWidth * 0.2,
                errorBuilder: (context, error, stackTrace) => Icon(
                  Icons.check_circle,
                  size: screenWidth * 0.2,
                  color: AppColor.positiveButton ?? Color(0xFFf4611f),
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
              Text(
                "Request has been send to Admin Wait for the Approval",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.w500,
                  color: AppColor.blackheading,
                ),
              ),
              SizedBox(height: screenWidth * 0.04),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );

    Future.delayed(Duration(seconds: 3), () {
      Get.back(); // Close popup
      Get.offAll(
            () => const DashboardScreen(),
        arguments: {'selectedIndex': 0, 'refresh': true},
      );
    });
  }
}