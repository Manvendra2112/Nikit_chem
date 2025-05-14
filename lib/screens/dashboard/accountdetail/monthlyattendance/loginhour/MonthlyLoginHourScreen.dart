import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/monthlyattendance/loginhour/MonthlyLoginHourController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class MonthlyLoginHourScreen extends StatelessWidget {
   MonthlyLoginHourScreen({super.key});

   @override
   Widget build(BuildContext context) {
     return GetBuilder<MonthlyLoginHourController>(
         init: MonthlyLoginHourController(),
         builder: (controller){
           return Scaffold(

             backgroundColor: Colors.white,
             body:
             Column(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [
                 /*      Expanded(

              child: ListView(
                controller: controller.scrollController,
            shrinkWrap: true,
              children: [*/
                 SizedBox(height: 40,),
                 InkWell(
                     onTap: () {
                       Get.back();
                     },
                     child: Container(

                       alignment: Alignment.topLeft,
                       margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                       child: Image.asset(
                         ImageAssets.backbutton,
                         width: 30,
                         height: 30,
                       ),
                     )),


                 Container(
                   alignment: Alignment.center,
                   margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                   child: Text("Monthly Login Hours",maxLines:2,style: TextStyle(
                       fontSize: 18,color: AppColor.headingtext,
                       fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
                 ),
                 Expanded(

                   child: ListView.builder(shrinkWrap: true,
                       itemCount: 4,
                       controller: controller.scrollController,
                       itemBuilder: (BuildContext,index){
                         return

                           commonWidget("01 April, 2025", "Login Hours : 7/8 Hours", "Full Day Completed");
                       }),
                 )

               ],),
             //),
             // ],
           );
         });



   }

   Widget commonWidget(String date,String active, String leave
       ) {
     return Container(
         margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
         padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
             color: AppColor.positiveButton.withOpacity(0.1)),

         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [




             Container(
              // margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
               alignment: Alignment.topLeft,
               child: Text(date,
                 textAlign: TextAlign.start,

                 style: TextStyle(fontSize: 14,
                     fontWeight: FontWeight.w500,
                     fontFamily: "Poppins-Medium"),),
             ),



             Row(
               mainAxisAlignment: MainAxisAlignment.start,
               crossAxisAlignment: CrossAxisAlignment.center,
               children: [

                 Expanded(flex: 7,
                   child: Container(
alignment: Alignment.center,
                     margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(color: Colors.white,borderRadius:
                     BorderRadius.circular(10)),
                     child: Text(active,

                       maxLines: 1,textAlign: TextAlign.center,
                      // overflow: TextOverflow.ellipsis,
                       style: TextStyle(fontSize: 10,
                         fontWeight: FontWeight.w500,
                         fontFamily: "Poppins-Medium"),),
                   ),
                 ),
                 SizedBox(width: 8),

                 Expanded(flex: 8,
                   child: Container(
                     margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                     padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                         color: Colors.white),
                     child: Row(

                       children: [
                         Image.asset(ImageAssets.correct,width: 14,height: 14,),
                         SizedBox(width: 3,),
                         Expanded(

                           child: Text(textAlign: TextAlign.center,
                             //overflow: TextOverflow.ellipsis,
                             leave, style: TextStyle(fontSize: 10,
                               fontWeight: FontWeight.w500,
                               fontFamily: "Poppins-Medium"),),
                         ),
                       ],
                     ),
                   ),
                 ),
               ],),





           ],));
   }
}
