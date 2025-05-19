import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import 'reasontochangelocation_controller.dart';

class ReasonToChangeLocationScreen extends StatelessWidget {
  const ReasonToChangeLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return GetBuilder<ReasonToChangeLocationController>(
      init: ReasonToChangeLocationController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.05,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Image.asset(
                        ImageAssets.backbutton,
                        width: screenWidth * 0.08,
                        height: screenWidth * 0.08,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.arrow_back,
                          size: screenWidth * 0.08,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Text(
                      "Reason",
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w500,
                        color: AppColor.blackheading,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    Container(
                      width: screenWidth * 0.9,
                      height: screenHeight * 0.2,
                      decoration: BoxDecoration(
                        color: AppColor.textfieldbg ?? Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                      child: TextField(
                        controller: controller.reasonController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          hintText: "Write here",
                          hintStyle: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: screenWidth * 0.04,
                            color: Colors.grey.shade500,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(screenWidth * 0.04),
                        ),
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: screenWidth * 0.04,
                          color: AppColor.blackheading,
                        ),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.52),
                    Center(
                      child: CustomWidget.elevatedCustomButton(
                        context,
                        "Submit",
                            () {
                          controller.submitReason(context);
                        },
                        width: screenWidth * 0.9,
                        height: screenHeight * 0.07,
                        fontSize: screenWidth * 0.04,
                        textColor: Colors.white,
                        bgColor: AppColor.positiveButton ?? Color(0xFFf4611f),
                        borderRadius: 10,
                        weight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.02),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}