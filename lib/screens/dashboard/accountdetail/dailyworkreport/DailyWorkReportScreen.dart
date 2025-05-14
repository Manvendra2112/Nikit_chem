import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/dailyworkreport/DailyWorkReportController.dart';
import 'package:nikitchem/support/app_theme.dart';

import '../../../../support/imageassets.dart';

class DailyWorkReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GetBuilder<DailyWorkReportController>

      (

        init: DailyWorkReportController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,

              body: ListView(shrinkWrap: true, children: [
            InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(

                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                  child: Image.asset(
                    ImageAssets.backbutton,
                    width: 20,
                    height: 20,
                  ),
                )),



            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
              child: Text("Daily Work Report",maxLines:2,style: TextStyle(
                  fontSize: 18,color: AppColor.headingtext,
                  fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
            ),

SizedBox(height: 20),
            ListView.builder(
              shrinkWrap: true,
                itemCount: 4,
                itemBuilder: (BuildContext,index){
              return   commonWidget("Visited Location : Ambala, Punjab", "01 April, 2025",
                  "Visited Dealers  : 03", "Completed Leads : 02");

            })


          ],));
        });
  }

  Widget commonWidget(String location, String date, String delaercount,
      String leades) {
    return Container(
        margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),
            color: AppColor.positiveButton.withOpacity(0.1)),
        
        child: Column(
mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height:45,),
          Expanded(
            child: Text(location, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins-Medium"),),
          ),

SizedBox(width: 10,),
          Expanded(
            child: Text(date, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins-Medium"),),
          )

        ],)
,Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

        Expanded(
          child: Container(
          
            margin: EdgeInsets.fromLTRB(0, 10, 10, 15),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(10)),
            child: Text(delaercount, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins-Medium"),),
          ),
        ),

        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(0, 10, 10, 15),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            decoration: BoxDecoration(borderRadius:BorderRadius.circular(10),
                color: Colors.white),
            child: Text(leades, style: TextStyle(fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: "Poppins-Medium"),),
          ),
        ),
      ],)

    ],));
  }
}