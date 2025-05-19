
  import 'package:flutter/cupertino.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_state_manager/get_state_manager.dart';
  import 'package:nikitchem/constant/custom_widget.dart';
  import 'package:nikitchem/screens/dashboard/accountdetail/AccountDetailController.dart';
  import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/ChangePasswordScreen.dart';
  import 'package:nikitchem/screens/dashboard/accountdetail/dailyworkreport/DailyWorkReportScreen.dart';
  import 'package:nikitchem/support/alert_dialog_manager.dart';
  import 'package:nikitchem/support/app_theme.dart';
  import 'package:nikitchem/support/imageassets.dart';

import 'MonthlyAttendence/monthlyattendence_screen.dart';
import 'monthlyreport/MonthlyReportScreen.dart';

  class AccountDetailScreen extends StatelessWidget {
    AccountDetailScreen({super.key});

    @override
    Widget build(BuildContext context) {
      double width = CustomWidget.getWidth(context);
      double height = CustomWidget.getHeight(context);
      return GetBuilder<AccountDetailController>(

          init: AccountDetailController(),
          builder: (controller){

            return Scaffold(
             backgroundColor: Colors.white,
                body: ListView(
              shrinkWrap: true,
              children: [
                SizedBox(height:height*0.02 ,),
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


                  )
              ),



              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                child: Text("My Account",maxLines:2,style: TextStyle(
                    fontSize: 20,color: AppColor.headingtext,
                    fontFamily: "Poppins-Medium",fontWeight: FontWeight.w600),),
              ),

  Image.asset(ImageAssets.profilenew,width: 50,height: 50,),
                SizedBox(height: 10,),
              Center(
                child: Text("Natasha Sharma",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Poppins-Medium",
                  fontSize: 14,),),
              ),
              SizedBox(height: 5,),
              Center(
                child: Text("natasha.sharma@gmail.com",style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Poppins-Medium",
                  fontSize: 10,),),
              ),
              SizedBox(height: 20),



              GestureDetector(
                  onTap: (){
                    Get.to(ChangePasswordScreen());

                  },

                  child: showTextwitharrow("Change Password", ImageAssets.nextgo)),
  GestureDetector(
      onTap: (){
        Get.to(MonthlyAttendenceScreen());

      },

      child: showTextwitharrow("Monthly Attendance",ImageAssets.nextgo)),


  GestureDetector(
      onTap: (){
        Get.to(DailyWorkReport());

      },

      child: showTextwitharrow("Daily Report",ImageAssets.nextgo)),


  GestureDetector(
     onTap: (){
       Get.to(MonthlyAttendanceReportScreen());

     },
      child: showTextwitharrow("Monthly Report",ImageAssets.nextgo)),

SizedBox(height: height*0.13,),
              Padding(

                padding:  EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: CustomWidget.elevatedCustomButton(
                  context, "Logout", (){
                  AlertDialogManager().logoutDialog(context);

                },


                  fontSize: 20,textColor: Colors.black,
                  bgColor: Colors.white,
  borderColor: AppColor.positiveButton,
                  height: 60,
                  borderRadius: 20,



                ),
              )


            ],));
          });
    }


    Widget showTextwitharrow(String label,String asset)
    {
      return   Container(
        margin: EdgeInsets.fromLTRB(15, 5, 15, 5),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),

        height: 70,
        decoration: BoxDecoration(
  borderRadius: BorderRadius.circular(10),
          color: Color(0xffD9D9D9).withOpacity(0.50)
        ),
        child: Row(
        children: [
          Text(label,style: TextStyle(fontWeight: FontWeight.w500,fontFamily: "Poppins-Medium",
            fontSize: 14,),),
          Spacer(),
          Image.asset(asset,width: 10,height: 10,)
        ],
      ),);
    }
  }