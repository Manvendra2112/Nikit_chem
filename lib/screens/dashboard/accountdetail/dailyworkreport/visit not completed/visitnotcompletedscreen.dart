import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import 'UnsuccessfullVisit/unsuccessfullvisitscreen.dart';

class VisitNotCompletedScreenNew extends StatelessWidget {
  const VisitNotCompletedScreenNew({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.04; // Single padding ~14px on 360px
    final double fontSizeLarge = width * 0.05; // ~18px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    // Static dummy user list
    final List<Map<String, String>> users = [
      {'name': 'Sharma Hardware'},
      {'name': 'Ahuja Hardware'},
      {'name': 'Gupta Hardware'},
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(padding),
          children: [
            // SizedBox(height: spacing * 2), // Top spacing
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
            //SizedBox(height: spacing),
            // Title
            Center(
              child: Text(
                "Unsuccessful Visit",
                style: TextStyle(
                  fontSize: fontSizeLarge,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins-Medium",
                  color: AppColor.headingtext,
                ),
              ),
            ),
            // Buttons row
            SizedBox(height: spacing * 2),
            // Location container
            Container(
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(
                color: const Color(0xFFf4611f).withOpacity(0.05),
                borderRadius: BorderRadius.circular(width * 0.03),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Visited Location: Ambala, Panjab",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cabin-Regular",
                          color: AppColor.headingtext,
                        ),
                      ),
                      Text(
                        "01 April, 2025",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Cabin-Regular",
                          color: AppColor.headingtext,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.03,),
                  Container(
                    padding: EdgeInsets.all(padding),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Visit Not Completed For :",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Poppins-Medium",
                            color: AppColor.headingtext,
                          ),
                        ),
                        SizedBox(height: spacing),
                        // User list
                        ...users.map((user) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: spacing),
                            child: GestureDetector(
                              onTap: () {
                                print('Tapped ${user['name']}');
                                if (user['name'] == 'Gupta Hardware') {
                                  print('Navigating to SuccessfullVisitCompletedScreen');
                                  Get.to(() => UnSuccessfullVisitScreen());
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(padding * 0.9),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFf4611f).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(width * 0.03),
                                ),
                                child: Row(
                                  children: [
                                    Image.asset(
                                      ImageAssets.nontick,
                                      width: width * 0.04, // ~22px
                                      height: width * 0.04,
                                    ),
                                    SizedBox(width: spacing * 0.5),
                                    Text(
                                      user['name']!,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        fontFamily: "Cabin-Regular",
                                        color: AppColor.headingtext,
                                      ),
                                    ),
                                    //SizedBox(height: height*0.02,)
                                  ],
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),

                  SizedBox(height: height*0.04,),

                ],

              ),
            ),

          ],
        ),
      ),
    );
  }
}