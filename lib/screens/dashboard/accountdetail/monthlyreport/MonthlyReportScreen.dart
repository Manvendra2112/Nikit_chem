import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'MonthlyReportController.dart';

class MonthlyAttendanceReportScreen extends StatelessWidget {
  const MonthlyAttendanceReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.04; // Single padding ~14px on 360px
    final double fontSizeLarge = width * 0.05; // ~18px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    // Initialize controller as singleton
    Get.put(MonthlyAttendanceReportController());

    return GetBuilder<MonthlyAttendanceReportController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                        "Monthly Report",
                        style: TextStyle(
                          fontSize: fontSizeLarge,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Poppins-Medium",
                          color: AppColor.headingtext,
                        ),
                      ),
                    ),
                    SizedBox(height: spacing * 3),
                    // Buttons column
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            print('Successful Visit Report button tapped');
                            controller.showReportPopup(context, isSuccessful: true);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFf4611f).withOpacity(0.2),
                            padding: EdgeInsets.symmetric(vertical: height * 0.025),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Successful Visit Report",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium",
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(height: spacing),
                        ElevatedButton(
                          onPressed: () {
                            print('Unsuccessful Visit Report button tapped');
                            controller.showReportPopup(context, isSuccessful: false);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFf4611f).withOpacity(0.2),
                            padding: EdgeInsets.symmetric(vertical: height * 0.025),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(width * 0.03),
                            ),
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            child: Text(
                              "Unsuccessful Visit Report",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                fontFamily: "Poppins-Medium",
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
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