import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';

import 'package:nikitchem/screens/customUI/PasswordField.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInDialog.dart';
import 'package:nikitchem/screens/login/LoginScreenController.dart';
import 'package:nikitchem/screens/login/forgetpassword/ForgetPasswordScreen.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../../support/app_theme.dart';
import '../dashboard/HomeScreen.dart';

class LoginScreen extends StatelessWidget {
   LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width=CustomWidget.getWidth(context);
    double height=CustomWidget.getHeight(context);
    return GetBuilder<LoginScreenController>(
        init: LoginScreenController(context),

        builder: (controller){
          return Scaffold(
            backgroundColor: Colors.white,

              body:
            ListView(
shrinkWrap: true,
              /*mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,*/
              children: [


                SizedBox(height: 50,),
              Container(alignment: Alignment.center,

                  child: Image.asset(ImageAssets.nikitchamlogo,width: 100,height: 55,)),


Container(alignment: Alignment.center,
  child: Text("Login to your Account",style: TextStyle(fontSize: 24,
      fontWeight: FontWeight.w600,fontFamily: "Poppins-SemiBold"),),
),
                SizedBox(height: 40,),
              Padding(
                padding:  EdgeInsets.fromLTRB(37, 5, 25, 0),
                child: Text("Email Address / Phone Number",style: TextStyle(fontSize: 16,
                    fontFamily: "Cabin-Regular",fontWeight: FontWeight.w400),),
              ),

              Padding(
                padding:  EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: CustomWidget.textInputFiled(
                    borderWidth:1,
                    topPadding: 0,
                    controller.emailController,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  focusNode: controller.emailFocus,
                   hintText: "Enter Email",
fillColorFiled: true

                ),
              ),

                SizedBox(height: 20,),

                Padding(
                  padding:  EdgeInsets.fromLTRB(37, 0, 25, 0),
                  child: Text("Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,
                      fontFamily: "Cabin-Regular",color: AppColor.headingtext),


                  ),
                ),


                PasswordField(
                  controller: controller.passwordController,
                  focusNode: controller.passFocus,
                  isPasswordVisible: controller.isPasswordVisible,
                  togglePasswordVisibility: controller.togglePasswordVisibility,
                  width: width,
                ),
             /*   Padding(
                  padding:  EdgeInsets.fromLTRB(20, 8, 20, 0),
                  child: CustomWidget.textInputFiled(

                    enableBorder: false,
                    borderColor: Colors.transparent,
                    borderWidth: 1,
                    bottomPadding: 0,
                    topPadding: 0,
                    fillColorFiled: true,
                      blurRadius: 10,

                      textInputType: TextInputType.text,
                     *//* inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],*//*

                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    controller.passwordController,

suffixIconWidget: InkWell(
  onTap: (){

  },
  child: Padding(
    padding:  EdgeInsets.all(15.0),
    child: Image.asset(ImageAssets.eye,width: width/50-4,height: 4,),
  ),
),
                    focusNode: controller.passFocus,
                    hintText: "Enter Password",

                    hintStyle: TextStyle(fontWeight: FontWeight.w500,color:AppColor.textFildtextcolor,
                        fontSize: 14,fontFamily: "Poppins-Medium")

                  ),
                ),*/
                Padding(
                  padding:  EdgeInsets.fromLTRB(40, 16, 25, 0),
                  child: InkWell(

                    onTap: (){

                      Get.to(ForgetPasswordScreen());
                    },
                    child: Text("Forget Password?",style: TextStyle(fontSize: 16,
                        fontWeight: FontWeight.w600,
                       // decoration: TextDecoration.underline, // Underline style
                       // decorationColor: Colors.blue,
                        fontFamily: "Cabin-Regular"),),
                  ),
                ),

                Padding(

                  padding:  EdgeInsets.fromLTRB(15, 16, 10, 15),
                  child: CustomWidget.elevatedCustomButton(
                    context, "Login", (){
                  //  Get.to(DashboardScreen());
controller.verifyPhoneNumber();
                  /*  showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return PunchInDialog();
                        });
*/

                  },fontSize: 18,textColor: Colors.white,
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
