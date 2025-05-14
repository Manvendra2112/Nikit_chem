import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/skippunchout/AssignedTaskSkipController.dart';

import '../../constant/custom_widget.dart';
import '../../support/app_theme.dart';
import '../../support/imageassets.dart';
import '../dashboard/HomeScreenController.dart';

class AssignedTaskSkipScreen extends StatelessWidget {
   AssignedTaskSkipScreen({super.key});

   @override
   Widget build(BuildContext context) {
     double width = CustomWidget.getWidth(context);
     double height = CustomWidget.getHeight(context);
     return GetBuilder<HomeScreenController>(
         init: HomeScreenController(context),
         builder: (controller) {
           return Scaffold(
             backgroundColor: Colors.white,
             body: ListView(
               shrinkWrap: true,
               children: [
                 SizedBox(height: 30),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Row(
                     children: [
                       Image.asset(
                         ImageAssets.profile,
                         height: height * 0.07,
                         width: width * 0.15,
                       ),
                       SizedBox(width: width * 0.02),
                       Expanded(
                         child: Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Text("Hi , Natasha Mishra",
                                 style: TextStyle(
                                     fontSize: 16,
                                     fontWeight: FontWeight.w600,
                                     fontFamily: "Poppins-SemiBold")),
                             Text("Welcome to Nikit Chem",
                                 style: TextStyle(
                                     fontSize: 10,
                                     fontWeight: FontWeight.w400,
                                     fontFamily: "Poppins-SemiBold")),
                           ],
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.all(15.0),
                         child: Image.asset(
                           ImageAssets.location,
                           width: 35,
                           height: 35,
                         ),
                       ),
                       Container(
                           width: width * 0.1,
                           height: height * 0.05,
                           decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(20),
                               color: AppColor.positiveButton),
                           child: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Image.asset(
                               ImageAssets.notification,
                               width: 15,
                               height: 15,
                             ),
                           ))
                     ],
                   ),
                 ),
                 buildSearchField(),

                 Container(
                   margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(10),
                     color: AppColor.bgColor20.withOpacity(0.2),
                   ),
                   width: 390 * 0.9,
                   height: 118 * 0.8,
                   child: Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(10),
                       color: Colors.white,
                     ),
                     margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                     padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                     width: 356 * 0.9,
                     height: 74 * 0.4,
                     child: Row(
                       children: [
                         Text(
                           "Login ( 9:00AM, 26 April,2025)",
                           style: TextStyle(
                               fontSize: 14, fontWeight: FontWeight.w500),
                         ),
                         Spacer(),
                         Image.asset(
                           ImageAssets.location,
                           width: 15,
                           height: 15,
                         )
                       ],
                     ),
                   ),
                 ),

                 Padding(
                   padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                   child: Text(
                     "Punch In Last Location",
                     style: TextStyle(
                         fontFamily: "Poppins-SemiBold",
                         fontSize: 14,
                         fontWeight: FontWeight.w500),
                   ),
                 ),
               ],
             ),
           );
         });
   }

   Widget buildSearchField() {
     return Container(
       margin: EdgeInsets.fromLTRB(15, 10, 15, 2),
       decoration: BoxDecoration(
         color: AppColor.textFildbgcolor50.withOpacity(0.1),
         borderRadius: BorderRadius.circular(10),
       ),
       child: TextField(
         decoration: InputDecoration(
           hintText: "Search By Shop Name",
           hintStyle: TextStyle(
             fontSize: 14,
             fontWeight: FontWeight.w400,
             color: AppColor.blackheading,
           ),
           prefixIcon: Padding(
             padding: EdgeInsets.fromLTRB(20, 12, 12, 12),
             child: Image.asset(
               ImageAssets.search,
               width: 17,
               height: 17,
             ),
           ),
           border: InputBorder.none,
           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
         ),
       ),
     );
   }
}
