import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:nikitchem/constant/SharedPrefsHelper.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInCompleteDialog.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInController.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../../../support/app_theme.dart';

class PunchInDialog extends StatelessWidget {
  PunchInDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PunchInController>(
      init: PunchInController(context),
      builder: (controller) {
        // Format the time to 12-hour format with AM/PM
        final now = DateTime.now();
        final timeFormat = DateFormat('h:mm a'); // Updated to show only time
        final formattedTime = timeFormat.format(now);
        controller.isPunchedIn = true;



        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text(
                    "PLEASE PUNCH -In to See Today's Beat Plan",
                    maxLines: 1,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontFamily: "Cabin-Regular",
                        fontSize: 12,
                        color: AppColor.blackheading),
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  "Attendance Punch - In",
                  style: TextStyle(
                      color: AppColor.blackheading,
                      fontSize: 18,
                      fontFamily: "Cabin-Regular",
                      fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            ImageAssets.clock,
                            width: 15,
                            height: 14,
                          ),
                          SizedBox(width: 8),
                          Text(
                           formattedTime,
                            style:  TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      Container(
                        width: 1,
                        height: 24,
                        color: Colors.orange,
                      ),
                      Row(
                        children: [
                          Image.asset(
                            ImageAssets.datecalander,
                            width: 15,
                            height: 14,
                          ),
                          SizedBox(width: 8),
                          Text(
                            "${controller.currentDate.day}th ${controller.currentDate.month == 4 ? 'April' : _getMonthName(controller.currentDate.month)}, ${controller.currentDate.year}",
                            style:  TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.orange),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {

                      controller.punchInfromHome();



                    },
                    child: Text(
                      "Punch In",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
                 SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColor.positiveButton.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: controller.skipPunching,
                    child: Text(
                      "Skip Punching",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }
}