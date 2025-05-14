import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBackWidget.dart';
import 'package:nikitchem/screens/dashboard/beatplan/BeatPlanController.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailScreen.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../../support/app_theme.dart';

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
      builder: (controller){

    return    Scaffold(
        backgroundColor: Colors.white,
        body:
          ListView(
            shrinkWrap: true,
            children: [
              SizedBox(height: 20,),
              CustomBackWidget(),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppColor.positiveButton),
                ),
                child: Column(
                  children: [
                    // Header for the date
                    Text(
                      "26 April, 2025",
                      style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Divider(color: Colors.grey.shade300),
                    // Calendar Widget
                    TableCalendar(
                      firstDay: DateTime(2025, 4, 1),
                      lastDay: DateTime(2025, 4, 30),
                      focusedDay: DateTime(2025, 4, 26),
                      calendarFormat: CalendarFormat.month,
                      headerVisible: false, // Hide default header
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
                      onDaySelected: (selectedDay, focusedDay) {
                        // Handle day selection if needed
                      },
                      eventLoader: (day) {
                        return _highlightedDays[day] ?? [];
                      },
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Text(
                  " Today’s Assigned Task",
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      fontFamily: "Poppins-Medium"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 5),
                child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing "),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(20, 10, 20, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.bgColor20.withOpacity(0.2),
                ),
                width: 390 * 0.9,
                //90%of the screen
                height: 60 * 0.9,

                child: Row(
                  children: [
                    Image.asset(
                      ImageAssets.locationadd,
                      width: 18,
                      height: 20,
                    ),
                    SizedBox(width: 5,),
                    Text("Ambala, Punjab",maxLines:2,style:
                    TextStyle(fontFamily:"Poppins-Medium",fontSize: 12 ),),

                    Spacer(),
                    CustomWidget.elevatedCustomButton(
                      context,
                      "Change Route",
                          () {



                      },
                      width: 110 * 0.9,
                      height: 39 * 0.9,
                      padding: Padding(padding: EdgeInsets.all(1)),
                      bgColor: AppColor.positiveButton,
                      textColor: AppColor.white,
                      weight: FontWeight.w500,
                      fontSize: 10,

                      borderRadius: 10,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColor.positiveButton)),
                width: 410*0.9,
                //90%of the screen
                height: 99*0.9,
                //15% of screen

                child:

                Row(
                  children: [
                    Container(
                      width: 26,
                      height: 26,
                      decoration: BoxDecoration(
                          color: AppColor.bgColor20.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Image.asset(
                          ImageAssets.dealericon,
                          width: 11,
                          height: 10,
                        ),
                      ),
                    ),

                    Spacer(),
                    Text("Dealer : Sharma Hardware",maxLines:2,style:
                    TextStyle(fontFamily:"Poppins-Medium",fontSize: 10 ),),

                    SizedBox(width: 5,),
                    CustomWidget.elevatedCustomButton(

                      context,"View Details", (){
                        Get.to(ViewDetailScreen());

                      /*controller.toggleExpansionTile();
                      controller. update();
                      openContainerExpand(context);*/

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

           /*   Visibility(
                visible: controller.isExpand,
                child: openContainerExpand(context),
              ),*/
            ],
          ),
        );
  });
  }




}
