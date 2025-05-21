import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  final DateFormat dateFormat = DateFormat('d MMMM, yyyy');

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BeatPlanController>(
      init: BeatPlanController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Obx(
                () => controller.isLoading.value
                ? Center(child: CircularProgressIndicator(color: AppColor.positiveButton))
                : ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height: 20),
                CustomBackWidget(),
                if (controller.errorMessage.isNotEmpty)
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: Text(
                      'Error: ${controller.errorMessage.value} (Using mock data)',
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
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
                          dateFormat.format(controller.selectedDate.value),
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
                        firstDay: DateTime(2025, 1, 1),
                        lastDay: DateTime(2025, 12, 31),
                        focusedDay: controller.focusedDay.value,
                        calendarFormat: CalendarFormat.month,
                        headerStyle: HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                          titleTextStyle: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
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
                            color: Colors.black,
                          ),
                          weekendTextStyle: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: 12,
                            color: Colors.black,
                          ),
                          markerDecoration: BoxDecoration(
                            color: Color(0xFFf4611f).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: Color(0xFFf4611f),
                            shape: BoxShape.circle,
                          ),
                          todayDecoration: BoxDecoration(
                            color: Color(0xFFf4611f),
                            shape: BoxShape.circle,
                          ),
                          defaultDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          weekendDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                        ),
                        selectedDayPredicate: (day) {
                          return isSameDay(day, controller.selectedDate.value);
                        },
                        onDaySelected: (selectedDay, focusedDay) {
                          controller.onDaySelected(selectedDay, focusedDay);
                        },
                        eventLoader: (day) {
                          return controller.highlightedDays[DateTime(day.year, day.month, day.day)] ?? [];
                        },
                        calendarBuilders: CalendarBuilders(
                          markerBuilder: (context, date, events) {
                            if (events.isNotEmpty) {
                              return Container(
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: isSameDay(date, DateTime.now())
                                      ? Color(0xFFf4611f)
                                      : Color(0xFFf4611f).withOpacity(0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    '${date.day}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins-Medium",
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              );
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
                  child: Text(
                    "Assigned Tasks for ${dateFormat.format(controller.selectedDate.value)}",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Poppins-Medium",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 5),
                  child: Text(
                    "${controller.filteredDealers.length} dealer(s) scheduled for visits",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColor.positiveButton,
                    ),
                  ),
                ),
                controller.filteredDealers.isEmpty
                    ? Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    "No dealers scheduled for ${dateFormat.format(controller.selectedDate.value)}",
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                )
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: controller.filteredDealers.length,
                  itemBuilder: (context, index) {
                    final dealer = controller.filteredDealers[index];
                    return Container(
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColor.positiveButton),
                      ),
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
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(Icons.person, size: 12),
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dealer: ${dealer.delearname}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "City: ${dealer.city}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                                Text(
                                  "Visit Date: ${dealer.visitDate}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 10,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          CustomWidget.elevatedCustomButton(
                            context,
                            "View Details",
                                () {
                              Get.to(() => ViewDetailScreen(),
                                  arguments: dealer.toJson());
                              print('BeatPlanScreen: Navigating to ViewDetailScreen for dealer: ${dealer.delearname}');
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
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(40, 16, 40, 15),
                  child: CustomWidget.elevatedCustomButton(
                    context,
                    "Choose Temporary Beat Plan",
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
                                      ImageAssets.cross,
                                      width: 50,
                                      height: 50,
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.close, size: 24),
                                    ),
                                  ),
                                ),
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 30),
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
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFf4611f).withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'This may drop your performance',
                                          style: FTextStyle.custom(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColor.blackheading,
                                          ),
                                        ),
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
                                                arguments: {
                                                  'selectedIndex': 0,
                                                  'refresh': true
                                                },
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
                                            border: Border.all(
                                                color: Colors.black, width: 1),
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
              ],
            ),
          ),
        );
      },
    );
  }
}