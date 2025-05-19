import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'Login Hours/loginhourscreen.dart';
import 'monthlyattendence_controller.dart';

class MonthlyAttendenceScreen extends StatelessWidget {
  const MonthlyAttendenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.05; // Single padding ~18px on 360px
    final double fontSizeLarge = width * 0.05; // ~18px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    return GetBuilder<MonthlyAttendenceController>(
      init: MonthlyAttendenceController(),
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
                SizedBox(height: height * 0.01),
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
                    "Monthly Attendance",
                    style: TextStyle(
                      fontSize: fontSizeLarge,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins-Medium",
                      color: AppColor.headingtext,
                    ),
                  ),
                ),
                SizedBox(height: spacing * 3),
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
                            "Leave & Attendance",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Poppins-Medium",
                              color: AppColor.headingtext,
                            ),
                          ),
                          Text(
                            "Monthly leave & Attandence",
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
                            color: const Color(0xFF1E1E1E),
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
                SizedBox(height: spacing * 2),
                // Main container
                Container(
                  padding: EdgeInsets.all(padding),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: const Color(0xFFf4611f),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(width * 0.03),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // My Attendance
                      Text(
                        "My Attendance",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins-Medium",
                          color: AppColor.headingtext,
                        ),
                      ),
                      // Date range
                      Text(
                        "1st April to 30th April",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cabin-Regular",
                          color: Color(0xffA0A0A0),
                        ),
                      ),
                      SizedBox(height: spacing * 3),
                      // Circle structure
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            // Largest circle
                            Container(
                              width: width * 0.47, // ~144px
                              height: width * 0.47,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFf4611f).withOpacity(0.2),
                              ),
                            ),
                            // Middle circle
                            Container(
                              width: width * 0.34, // ~115px
                              height: width * 0.34,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white,
                              ),
                            ),
                            // Smallest circle with text
                            Container(
                              width: width * 0.23, // ~86px
                              height: width * 0.23,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFf4611f).withOpacity(0.1),
                              ),
                              child: Center(
                                child: Text(
                                  "63%",
                                  style: TextStyle(
                                    fontSize: fontSizeMedium,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "Poppins-Medium",
                                    color: AppColor.headingtext,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: spacing * 3),
                      // Row 1: Present and Half Days
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 6,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf4611f),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Present",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                              Text(
                                "24 Days",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 6,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf4611f),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Half Days",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                              Text(
                                "5",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Cabin-Regular",
                                  color: AppColor.headingtext,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spacing * 2),
                      // Row 2: Absent and On Leave
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: 6,
                            height: 40 ,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf4611f),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Absent",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                              Text(
                                "5 Days",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            width: 6,
                            height: 40,
                            decoration: BoxDecoration(
                              color: const Color(0xFFf4611f),
                              borderRadius: BorderRadius.circular(3),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "On Leave",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Poppins-Medium",
                                  color: AppColor.headingtext,
                                ),
                              ),
                              Text(
                                "5 Days",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Cabin-Regular",
                                  color: AppColor.headingtext,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: spacing * 3),
                      // View Working Hours button
                      ElevatedButton(
                        onPressed: () {
                          print('View Working Hours button tapped');
                          Get.to(() => LoginhourScreen());

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFf4611f),
                          padding: EdgeInsets.symmetric(vertical: height * 0.02,horizontal: width*0.185),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(width * 0.03),
                          ),
                        ),
                        child: Text(
                          "View Working Hours",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins-Medium",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.05,)
              ],
            ),
          ),
        );
      },
    );
  }
}