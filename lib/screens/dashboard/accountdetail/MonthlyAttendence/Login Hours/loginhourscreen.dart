import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'loginhour_controller.dart';

class LoginhourScreen extends StatelessWidget {
  const LoginhourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.06; // Single padding ~18px on 360px
    final double fontSizeLarge = width * 0.05; // ~18px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    return GetBuilder<LoginHourController>(
      init: LoginHourController(),
      builder: (controller) {
        // Show SnackBar if data is empty on screen load
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (controller.isDataEmpty()) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("No report data available")),
            );
          }
        });

        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.all(padding),
              children: [
                // Back button
                Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      print('Back button tapped');
                      Get.back();
                    },
                    child: Image.asset(
                      ImageAssets.backbutton,
                      width: width * 0.08, // ~30px
                      height: width * 0.08,
                    ),
                  ),
                ),
                // Title
                Center(
                  child: Text(
                    "Monthly Login Hours",
                    style: TextStyle(
                      fontSize: fontSizeLarge,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins-Medium",
                      color: AppColor.headingtext,
                    ),
                  ),
                ),
                SizedBox(height: spacing * 2),
                // Row with column and date container
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Column with texts
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Login Hours Report",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins-Medium",
                              color: AppColor.headingtext,
                            ),
                          ),
                          Text(
                            "Total Working Hours this month",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              fontFamily: "Cabin-Regular",
                              color: Color(0xffA0A0A0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Date container
                    GestureDetector(
                      onTap: () => controller.selectDate(context),
                      child: Container(
                        padding: EdgeInsets.all(padding * 0.5),
                        decoration: BoxDecoration(
                          color: Color(0xffF4611f).withOpacity(0.10),
                          borderRadius: BorderRadius.circular(width * 0.02),
                        ),
                        child: Row(
                          children: [
                            Text(
                              DateFormat('dd MMMM, yyyy')
                                  .format(controller.selectedDate),
                              style: TextStyle(
                                fontSize: fontSizeSmall,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Cabin-Regular",
                                color: AppColor.headingtext,
                              ),
                            ),
                            SizedBox(width: spacing * 0.3),
                            Icon(
                              Icons.arrow_drop_down_outlined,
                              size: width * 0.06, // ~18px
                              color: AppColor.headingtext,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing * 5),
                // Bar graph structure
                Container(
                  height: height * 0.4, // ~144px, enough for bars and text
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      // Vertical baseline
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Container(
                              height: height * 0.02,
                              decoration: BoxDecoration(
                                color: const Color(0xFFf4611f),
                                borderRadius: BorderRadius.horizontal(
                                  left: Radius.circular(20),
                                  right: Radius.circular(20),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              "Login Hours of 23rd April, 2025",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium",
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),

                      // Bar 1: Pending
                      Positioned(
                        bottom: height * 0.05,
                        width: width * 0.2,
                        left: padding, // Respect container padding
                        child: Column(
                          children: [
                            Text(
                              "2 Hours Pending",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium",
                                color: AppColor.headingtext,
                              ),
                            ),
                            SizedBox(height: height * 0.02), // ~7px
                            Container(
                              width: width * 0.35, // ~126px
                              height: height * 0.2, // ~72px
                              decoration: BoxDecoration(
                                color: const Color(0xFFf4611f).withOpacity(0.1),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20), // ~11px
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bar 2: Login
                      Positioned(
                        bottom: height * 0.05,
                        width: width * 0.2,
                        right: width * 0.3, // Respect container padding
                        child: Column(
                          children: [
                            Text(
                              "5 Hours Login",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium",
                                color: AppColor.headingtext,
                              ),
                            ),
                            SizedBox(height: height * 0.02), // ~7px
                            Container(
                              width: width * 0.35, // ~126px
                              height: height * 0.28, // ~108px
                              decoration: BoxDecoration(
                                color: const Color(0xFFf4611f).withOpacity(0.2),
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20), // ~11px
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
