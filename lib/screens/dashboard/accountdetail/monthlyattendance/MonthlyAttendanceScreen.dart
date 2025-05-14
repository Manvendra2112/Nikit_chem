import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/monthlyattendance/MonthlyAttendanceController.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/monthlyattendance/loginhour/MonthlyLoginHourScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class MonthlyAttendanceScreen extends StatelessWidget {
   MonthlyAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MonthlyAttendanceController>(
        init: MonthlyAttendanceController(),
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
    child: Text("Monthly Attendance",maxLines:2,style: TextStyle(
    fontSize: 18,color: AppColor.headingtext,
    fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
    ),
    Expanded(

      child: ListView.builder(shrinkWrap: true,
      itemCount: 4,
      controller: controller.scrollController,
      itemBuilder: (BuildContext,index){
      return
      
      commonWidget("March, 2025", "Active : 24/30 Days", "Leave : 2 Days", "View Login Hours");
      }),
    )

    ],),
    //),
    // ],
    );
    });


    
  }

   Widget commonWidget(String date,String active, String leave, String btnloginhour,
       ) {
     return Container(
         margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
         padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
             color: AppColor.positiveButton.withOpacity(0.1)),

         child: Column(
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.center,
           children: [



                 SizedBox(width: 10,),
                Container(
                  margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
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

                 Expanded(flex: 3,
                   child: Container(

                     margin: EdgeInsets.fromLTRB(20, 5, 10, 15),
                     padding: EdgeInsets.fromLTRB(7, 7, 7, 7),
                     decoration: BoxDecoration(color: Colors.white,borderRadius:
                     BorderRadius.circular(10)),
                     child: Text(active, style: TextStyle(fontSize: 12,
                         fontWeight: FontWeight.w500,
                         fontFamily: "Poppins-Medium"),),
                   ),
                 ),

                 Expanded(flex: 2,
                   child: Container(
                     margin: EdgeInsets.fromLTRB(0, 5, 20, 15),
                     padding: EdgeInsets.fromLTRB(6, 7, 6, 7),
                     decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                         color: Colors.white),
                     child: Text(leave, style: TextStyle(fontSize: 12,
                         fontWeight: FontWeight.w500,
                         fontFamily: "Poppins-Medium"),),
                   ),
                 ),
               ],),
             
             
             LayoutBuilder(
             builder: (BuildContext context, BoxConstraints constraints) {
               return
                 Container(margin: EdgeInsets.only(left: 15,right: 15,bottom: 20,top: 10),
                   child: ElevatedButton(
                     style: ElevatedButton.styleFrom(
                       //  foregroundColor: AppColor.positiveButton,
                       backgroundColor: AppColor.positiveButton,

                       padding: EdgeInsets.only(left: 20,right: 20),

                       shape: RoundedRectangleBorder(
                         borderRadius: BorderRadius.circular(10),
                       ),

                       minimumSize: Size(constraints.maxWidth, 50), // Make it responsive
                      // padding: EdgeInsets.symmetric(horizontal: 16),

                     ),
                     onPressed: () {
Get.to(MonthlyLoginHourScreen());


                     },
                     child: Text(btnloginhour,textAlign: TextAlign.center,
                       style: TextStyle(fontSize: 12,
                           fontWeight: FontWeight.w500,
                           backgroundColor: AppColor.positiveButton,
                           color: AppColor.white,
                           fontFamily: "Poppins-Medium"),),
                   ),
                 );

             }
             )


           ],));
   }
}
