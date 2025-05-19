import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBackWidget.dart';
import 'package:nikitchem/screens/dashboard/beatplan/BeatPlanController.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailScreen.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/flutter_font_style.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../support/app_theme.dart';
import '../../reason to change location screen/reasontochangelocationscreen.dart';

class BeatPlanScreen extends StatelessWidget {
  BeatPlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<DateTime, List> _highlightedDays = {
      DateTime(2025, 4, 15): ['highlighted'],
      DateTime(2025, 4, 19): ['highlighted'],
      DateTime(2025, 4, 24): ['highlighted'],
    };

    return GetBuilder<BeatPlanController>(
      init: BeatPlanController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 20),
              CustomBackWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(20, 30, 20, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.positiveButton),
                ),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "26 April, 2025",
                        style: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Divider(color: Colors.grey.shade300),
                    SizedBox(height: 10),
                    TableCalendar(
                      firstDay: DateTime(2025, 4, 1),
                      lastDay: DateTime(2025, 4, 30),
                      focusedDay: DateTime(2025, 4, 26),
                      calendarFormat: CalendarFormat.month,
                      headerVisible: false,
                      daysOfWeekStyle: DaysOfWeekStyle(
                        weekdayStyle: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        weekendStyle: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 12,
                          color: Colors.black,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                        outsideDaysVisible: false,
                        defaultTextStyle: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 12,
                        ),
                        weekendTextStyle: TextStyle(
                          fontFamily: "Poppins-Medium",
                          fontSize: 12,
                        ),
                        markerDecoration: BoxDecoration(
                          color: AppColor.positiveButton,
                          shape: BoxShape.circle,
                        ),
                        selectedDecoration: BoxDecoration(
                          color: AppColor.positiveButton,
                          shape: BoxShape.circle,
                        ),
                        todayDecoration: BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColor.positiveButton),
                        ),
                      ),
                      selectedDayPredicate: (day) {
                        return isSameDay(day, DateTime(2025, 4, 26));
                      },
                      onDaySelected: (selectedDay, focusedDay) {},
                      eventLoader: (day) {
                        return _highlightedDays[day] ?? [];
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                child: Text(
                  " Today’s Assigned Task",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: "Poppins-Medium",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing "),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(40, 16, 40, 15),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Choose Temporary Beat plan",
                      () {
                    Get.dialog(
                      Dialog(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            children: [
                              Positioned(
                                right: 0,
                                top: 0,
                                child: GestureDetector(
                                  onTap: () => Get.back(),
                                  child: Image.asset(
                                    ImageAssets.cross, // Assumed asset
                                    width: 50,
                                    height: 50,
                                    errorBuilder: (context, error, stackTrace) => Icon(Icons.close, size: 24),
                                  ),
                                ),
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  SizedBox(height: 30), // Space for cross button
                                  Text(
                                    "Is it Important?",
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins-Medium",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  SizedBox(height: 20),
                                  Container(
                                    width: 220,
                                    height: 40, // Adjust as needed
                                    decoration: BoxDecoration(
                                      color: Color(0xFFf4611f).withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: Text('This may drop your performance',style: FTextStyle.custom(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.blackheading
                                      ),),
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: AppColor.positiveButton,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            Get.offAll(
                                                  () => const DashboardScreen(),
                                              arguments: {'selectedIndex': 0, 'refresh': true},
                                            );
                                          },
                                          child: Text(
                                            "Yes",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontFamily: "Poppins-Medium",
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Container(
                                        width: 70,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(color: Colors.black, width: 1),
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: TextButton(
                                          onPressed: () => Get.back(),
                                          child: Text(
                                            "No",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14,
                                              fontFamily: "Poppins-Medium",
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  CustomWidget.elevatedCustomButton(
                                    context,
                                    "Submit",
                                        () {
                                      Get.to(() => ReasonToChangeLocationScreen());
                                    },
                                    width: 220,
                                    height: 45,
                                    fontSize: 14,
                                    textColor: Colors.white,
                                    bgColor: AppColor.positiveButton,
                                    borderRadius: 10,
                                    weight: FontWeight.w500,
                                  ),
                                  SizedBox(height: 10),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  fontSize: 15,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  height: 52,
                  weight: FontWeight.w500,
                  borderRadius: 10,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.positiveButton),
                ),
                width: 410 * 0.9,
                height: 99 * 0.9,
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: AppColor.bgColor20.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Image.asset(
                          ImageAssets.dealericon,
                          width: 12,
                          height: 12,
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Dealer : Sharma Hardware",
                      maxLines: 2,
                      style: TextStyle(fontFamily: "Poppins-Medium", fontSize: 10),
                    ),
                    Spacer(),
                    CustomWidget.elevatedCustomButton(
                      context,
                      "View Details",
                          () {
                        Get.to(ViewDetailScreen());
                      },
                      width: 110,
                      height: 39,
                      fontSize: 12,
                      weight: FontWeight.w500,
                      textColor: Colors.white,
                      borderRadius: 10,
                      padding: Padding(padding: EdgeInsets.all(2)),
                      bgColor: AppColor.positiveButton,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}