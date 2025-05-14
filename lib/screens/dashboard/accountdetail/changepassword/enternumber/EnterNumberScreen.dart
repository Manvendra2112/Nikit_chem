import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/EnterNumberController.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/otpscreen/VerifyOTPScreen.dart';
import 'package:nikitchem/screens/login/forgetpassword/OTPScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../../../../../constant/custom_widget.dart';

class EnterNumberScreen extends StatelessWidget {
   EnterNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width=CustomWidget.getWidth(context);
    double height=CustomWidget.getHeight(context);
    return GetBuilder<EnterNumberController>(
        init: EnterNumberController(),

        builder: (controller){
          return Scaffold(
              backgroundColor: Colors.white,
              body:
              ListView(
                shrinkWrap: true,
                /*mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,*/
                children: [
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
                    child: Text("Change Password",maxLines:2,style: TextStyle(
                        fontSize: 18,color: AppColor.headingtext,
                        fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
                  ),






                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: Text("Enter Phone Number",maxLines:2,style: TextStyle(
                        fontSize: 18,color: AppColor.headingtext,
                        fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
                  ),
                  SizedBox(height: 30,),

                  Padding(
                    padding:  EdgeInsets.fromLTRB(37, 0, 25, 0),
                    child: Text("Enter Phone Number",
                      style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,
                        fontFamily: "Cabin-Regular",color: AppColor.headingtext),


                    ),
                  ),


                  Padding(
                    padding:  EdgeInsets.fromLTRB(20, 8, 20, 0),
                    child: CustomWidget.textInputFiled(
                        borderWidth:1,
                        topPadding: 0,
                        controller.mobileNumController,
                        fillColors: AppColor.textFildtextcolor.
                        withOpacity(0.2),
                        focusNode: controller.mobileFocus,
                        hintText: "91+ Phone Number ",
                        fillColorFiled: true

                    ),
                  ),


                  SizedBox(height: 20,),





                  Padding(

                    padding:  EdgeInsets.fromLTRB(15, 0, 10, 15),
                    child: CustomWidget.elevatedCustomButton(
                      context, "Get OTP", (){
                        Get.to(VerifyOTPScreen());



                    },fontSize: 20,textColor: Colors.white,
                      bgColor: AppColor.positiveButton,

                      height: 60,
                      weight: FontWeight.w500,
                      borderRadius: 10,



                    ),
                  )

                ],)

          );


        });
  }
}