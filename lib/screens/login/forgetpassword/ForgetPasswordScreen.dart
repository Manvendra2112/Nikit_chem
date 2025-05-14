import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/login/forgetpassword/ForgetPasswordController.dart';
import 'package:nikitchem/screens/login/forgetpassword/OTPScreen.dart';
import 'package:nikitchem/support/app_theme.dart';

import '../../../constant/custom_widget.dart';
import '../../../support/imageassets.dart';

class ForgetPasswordScreen extends StatelessWidget {
   ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(

        init: ForgetPasswordController(),
        builder: (controller){

          return Scaffold(body:
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                SizedBox(height: 50,),
              Center(child: Image.asset(ImageAssets.nikitchamlogo,width: 70,height: 60,)),

              Container(


                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                child: Text("Forget Password",maxLines:2,style: TextStyle(
                    fontSize: 22,color: AppColor.headingtext,
                    fontFamily: "Poppins-SemiBold",fontWeight: FontWeight.w600),),
              ),
              SizedBox(height: 5,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing  ",maxLines: 3,
                  style: TextStyle(fontSize: 14,color: AppColor.pharagraphtext,
                      fontFamily: "Cabin-Regular",fontWeight: FontWeight.w400),),
              ),


              SizedBox(height: 10,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Text("Enter Register Phone Number",maxLines: 3,
                  style: TextStyle(fontSize: 14,color: AppColor.pharagraphtext,
                      fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
              ),


              Padding(
                padding:  EdgeInsets.fromLTRB(25, 20, 25, 0),
                child: Text("Enter Phone Number",style: TextStyle(fontSize: 14,
                    fontFamily: "Cabin-Regular"),),
              ),

              Padding(
                padding:  EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: CustomWidget.textInputFiled(
                    borderWidth:1,
                    topPadding: 0,
                    controller.mobileNumberCont,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.mobileFocus,
                    hintText: "Enter Phone Number ",
                    fillColorFiled: true

                ),
              ),
              Padding(

                padding:  EdgeInsets.fromLTRB(15, 10, 15, 5),
                child: CustomWidget.elevatedCustomButton(
                  context, "Get OTP", (){
                  Get.to(OTPScreen());

                },fontSize: 20,textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  width: 390,
                  height: 60,
                  borderRadius: 10,



                ),
              )
            ],)

            );





        })



    ;
  }
}
