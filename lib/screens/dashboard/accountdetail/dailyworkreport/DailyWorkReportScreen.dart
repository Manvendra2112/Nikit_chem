import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../visitscreen/VisitNotCompletedScreen.dart';
import 'DailyWorkReportController.dart';
import 'visit completed/visitcompleted_screen.dart';
import 'visit not completed/visitnotcompletedscreen.dart';

class DailyWorkReport extends StatelessWidget {
  const DailyWorkReport({super.key});

  // Reusable function for info rows (Route, Distance, etc.)
  Widget buildInfoRow(
      String leftText, String rightText, double fontSize, double spacing) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin-Regular",
                color: AppColor.headingtext,
              ),
            ),
            Text(
              rightText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin-Regular",
                color: AppColor.headingtext,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        buildDottedDivider(),
        SizedBox(height: spacing),
      ],
    );
  }

  //Reusable function for single dashed line divider
  Widget buildDottedDivider() {
    return DottedBorder(
      color: const Color(0xFFA0A0A0),
      strokeWidth: 1,
      dashPattern: const [4, 4],
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.05; // Single padding
    final double fontSizeLarge = width * 0.05; // ~18px on 360px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    return GetBuilder<DailyWorkReportController>(
      init: DailyWorkReportController(),
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
                SizedBox(
                  height: height * 0.01,
                ),
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
                    "Daily Work Report",
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
                            "Daily Work Report",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins-Medium",
                              color: AppColor.headingtext,
                            ),
                          ),
                          Text(
                            "Check your daily work report",
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
                          color: Colors.white,
                          border: Border.all(
                            color: const Color(0xFFf4611f).withOpacity(0.2),
                            width: 1,
                          ),
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
                            SizedBox(width: spacing * 0.5),
                            Icon(
                              Icons.calendar_today,
                              size: width * 0.05, // ~18px
                              color: AppColor.headingtext,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: spacing * 3),
                // Main container
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: const Color(0xFFf4611f).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(width * 0.07),
                  ),
                  child: Column(
                    children: [
                      buildInfoRow(
                        "Route :",
                        controller.reportData['route'] ?? "N/A",
                        15,
                        spacing,
                      ),
                      buildInfoRow(
                        "Distance :",
                        controller.reportData['distance'] ?? "N/A",
                        15,
                        spacing,
                      ),
                      buildInfoRow(
                        "Total Order :",
                        controller.reportData['totalOrder'] ?? "N/A",
                        15,
                        spacing,
                      ),
                      buildInfoRow(
                        "Success Rate :",
                        controller.reportData['successRate'] ?? "N/A",
                        15,
                        spacing,
                      ),
                      SizedBox(height: spacing),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.handleSuccessfulVisit(1);
                                if (controller.isDataEmpty()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("No report data available"),
                                    ),
                                  );
                                } else {
                                  Get.to(() => VisitCompletedScreenNew());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.positiveButton,
                                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width * 0.03),
                                ),
                              ),
                              child: Text(
                                "Successful Visit",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: spacing),
                          Expanded(
                            child: ElevatedButton(
                              onPressed: () {
                                controller.handleSuccessfulVisit(2);
                                if (controller.isDataEmpty()) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text("No report data available"),
                                    ),
                                  );
                                }else {
                                  Get.to(() => VisitNotCompletedScreenNew());
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.positiveButton,
                                padding: EdgeInsets.symmetric(vertical: height * 0.015),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(width * 0.03),
                                ),
                              ),
                              child: Text(
                                "Unsuccessful visit",
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: spacing),
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
