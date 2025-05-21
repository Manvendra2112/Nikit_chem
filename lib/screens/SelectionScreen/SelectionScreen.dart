import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../support/app_theme.dart';
import 'SelectionScreenControlller.dart';

class SelectionScreen extends StatelessWidget {
  const SelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SelectionScreenController());
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double fontScale = screenWidth / 360; // Scale based on 360px reference
    final double horizontalPadding = screenWidth * 0.05; // 5% padding per side

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: true,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.01, // 1% of screen height
                ),
                child: Image.asset(
                  ImageAssets.nikitchamimage,
                  width: screenWidth * 0.85, // 85% of screen width
                  fit: BoxFit.contain,
                ),
              ),
              Image.asset(
                ImageAssets.nikitchamlogo,
                width: screenWidth * 0.18, // ~65px on 360px screen
                height: screenWidth * 0.15, // ~54px
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.005, // 0.5% of screen height
                ),
                child: Text(
                  "Welcome to Nikit Chem Adhesives Limited",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18 * fontScale,
                    color: AppColor.headingtext,
                    fontFamily: "Poppins-SemiBold",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04, // 4% for text
                ),
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                      "sed do eiusmod tempor incididunt ut labore.",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12 * fontScale,
                    color: AppColor.pharagraphtext,
                    fontFamily: "Cabin-Regular",
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.015), // 1.5% of screen height
              CustomWidget.elevatedCustomButton(
                context,
                "Register",
                    () => Get.find<SelectionScreenController>().navigateToRegister(),
                fontSize: 16 * fontScale,
                textColor: Colors.white,
                bgColor: AppColor.positiveButton,
                height: screenHeight * 0.06, // 6% of screen height
                width: screenWidth - (2 * horizontalPadding), // Full width minus padding
                borderRadius: 10,
              ),
              SizedBox(height: screenHeight * 0.015), // 1.5% of screen height
              CustomWidget.elevatedCustomButton(
                context,
                "Login",
                    () => Get.find<SelectionScreenController>().navigateToLogin(),
                fontSize: 16 * fontScale,
                textColor: Colors.white,
                bgColor: AppColor.positiveButton,
                height: screenHeight * 0.06, // 6% of screen height
                width: screenWidth - (2 * horizontalPadding), // Full width minus padding
                borderRadius: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}