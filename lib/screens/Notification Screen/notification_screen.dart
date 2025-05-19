import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../dashboard/DashboardScreen.dart';
import 'notificationscreen_controller.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = CustomWidget.getHeight(context);
    final double screenWidth = CustomWidget.getWidth(context);

    return GetBuilder<NotificationController>(
      init: NotificationController(),
      builder: (controller) {
        final groupedNotifications = controller.getGroupedNotifications();

        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Back button
                  InkWell(
                    onTap: () {
                      Get.offAll(
                            () => const DashboardScreen(),
                        arguments: {'selectedIndex': 0, 'refresh': true},
                      );
                    },
                    child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.fromLTRB(0, screenHeight * 0.05, 0, 0),
                      child: Image.asset(
                        ImageAssets.backbutton,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                  // Notifications title
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: screenHeight * 0.02),
                    child: Text(
                      'Notifications',
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColor.headingtext,
                        fontFamily: 'Poppins-Medium',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  SizedBox(height: screenHeight * 0.03), // ~22px
                  // Notification list
                  ...groupedNotifications.entries.map((entry) {
                    final dateKey = entry.key;
                    final notifications = entry.value;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Date header
                        Text(
                          dateKey,
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Poppins-Medium',
                            fontWeight: FontWeight.w500,
                            color: AppColor.blackheading,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.015), // ~11px
                        // Notifications for this date
                        ...notifications.map((notification) {
                          return Padding(
                            padding: EdgeInsets.only(bottom: screenHeight * 0.015),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Notification image
                                Image.asset(
                                  notification['imagePath'],
                                  width: screenWidth * 0.1, // ~36px
                                  height: screenWidth * 0.1,
                                ),
                                SizedBox(width: screenWidth * 0.03), // ~11px
                                // Message and timestamp
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        notification['message'],
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'Poppins-Medium',
                                          fontWeight: FontWeight.w500,
                                          color: AppColor.blackheading,
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.005), // ~4px
                                      Text(
                                        controller.getRelativeTime(notification['timestamp']),
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontFamily: 'Poppins-Regular',
                                          color: Color(0xffA0A0A0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }).toList(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}