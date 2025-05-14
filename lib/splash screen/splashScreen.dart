import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../support/app_theme.dart';
import 'SplashScreenController.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashScreenController());
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20,10 ),

            child: Image.asset(
              ImageAssets.nikitchamimage,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          Image.asset(
            ImageAssets.nikitchamlogo,
            width: 100,
            height: 70,
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 45),
            child: Text(
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
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 35),
            child: Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                  "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
              maxLines: 3,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColor.pharagraphtext,
                fontFamily: "Cabin-Regular",
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}