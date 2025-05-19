import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetController.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitCompletedScreen.dart';
import 'package:nikitchem/support/app_theme.dart';

import '../dashboard/visitscreen/Unsuccessfull visit screen/unsuccessfullvisit_screen.dart';
import '../dashboard/visitscreen/VisitNotCompletedScreen.dart';

class CustomBottomsheetScreen extends StatelessWidget {
  CustomBottomsheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<CustomBottomSheetController>(
      init: CustomBottomSheetController(),
      builder: (controller) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: screenHeight * 0.2, // ~146.3px on 731.6px screen
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.075, // ~27.2px on 362.7px screen
                  vertical: screenHeight * 0.005, // ~3.7px on 731.6px screen
                ),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Successful Visit",
                      () {
                    Get.to(VisitCompletedScreen());
                  },
                  fontSize: screenWidth * 0.04, // ~14.5px
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  width: screenWidth * 0.9, // ~326.4px
                  height: screenHeight * 0.07, // ~51.2px
                  borderRadius: 10,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // ~7.3px
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.075,
                  vertical: screenHeight * 0.005,
                ),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Unsuccessful Visit",
                      () {
                    Get.to(VisitNotCompletedScreen());
                  },
                  fontSize: screenWidth * 0.04,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  width: screenWidth * 0.9,
                  height: screenHeight * 0.07,
                  borderRadius: 10,
                  weight: FontWeight.w500,
                ),
              ),
              SizedBox(height: screenHeight * 0.01), // Bottom padding
            ],
          ),
        );
      },
    );
  }
}