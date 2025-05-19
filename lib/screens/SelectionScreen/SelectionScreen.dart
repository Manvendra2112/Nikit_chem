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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Image.asset(
              ImageAssets.nikitchamimage,
            ),
          ),
          Image.asset(
            ImageAssets.nikitchamlogo,
            width: 70,
            height: 60,
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(45, 10, 45, 5),
            child: const Text(
              "Welcome to Nikit Chem Adhesives Limited",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                color: AppColor.headingtext,
                fontFamily: "Poppins-SemiBold",
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.fromLTRB(35, 0, 35, 0),
            child: const Text(
              textAlign: TextAlign.center,
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
              maxLines: 3,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.pharagraphtext,
                fontFamily: "Cabin-Regular",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          const SizedBox(height: 10),
          CustomWidget.elevatedCustomButton(
            context,
            "Register",
                () => Get.find<SelectionScreenController>().navigateToRegister(),
            fontSize: 20,
            textColor: Colors.white,
            bgColor: AppColor.positiveButton,
            height: 60 * 0.9,
            borderRadius: 10,
          ),
          const SizedBox(height: 10),
          CustomWidget.elevatedCustomButton(
            context,
            "Login",
                () => Get.find<SelectionScreenController>().navigateToLogin(),
            fontSize: 20,
            textColor: Colors.white,
            bgColor: AppColor.positiveButton,
            height: 60 * 0.9,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }
}