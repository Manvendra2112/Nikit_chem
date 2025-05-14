import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/ChangePasswordController.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/EnterNumberScreen.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInDialog.dart';
import 'package:nikitchem/screens/login/LoginScreenController.dart';
import 'package:nikitchem/screens/login/forgetpassword/ForgetPasswordScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';



class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width=CustomWidget.getWidth(context);
    double height=CustomWidget.getHeight(context);
    return GetBuilder<ChangePasswordController>(
        init: ChangePasswordController(),

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







                  SizedBox(height: 30,),

                  Padding(
                    padding:  EdgeInsets.fromLTRB(37, 0, 25, 0),
                    child: Text("Enter Current Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,
                        fontFamily: "Cabin-Regular",color: AppColor.headingtext),


                    ),
                  ),



                  Padding(
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
                        /* inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],*/
                        fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                        controller.currepassContr,

                        suffixIconWidget: Padding(
                          padding:  EdgeInsets.all(15.0),
                          child: Image.asset(ImageAssets.eye,width: width/50-4,height: 4,),
                        ),
                        focusNode: controller.currePassword,
                        hintText: "Edit Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500,color:AppColor.textFildtextcolor,
                            fontSize: 14,fontFamily: "Poppins-Medium")

                    ),
                  ),

                  SizedBox(height: 20,),

                  Padding(
                    padding:  EdgeInsets.fromLTRB(37, 0, 25, 0),
                    child: Text("Enter New Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,
                        fontFamily: "Cabin-Regular",color: AppColor.headingtext),


                    ),
                  ),



                  Padding(
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
                        /* inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],*/
                        fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                        controller.newpassContr,

                        suffixIconWidget: Padding(
                          padding:  EdgeInsets.all(15.0),
                          child: Image.asset(ImageAssets.eye,width: width/50-4,height: 4,),
                        ),
                        focusNode: controller.newPassword,
                        hintText: "Edit Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500,color:AppColor.textFildtextcolor,
                            fontSize: 14,fontFamily: "Poppins-Medium")

                    ),
                  ),

                  SizedBox(height: 20,),
                  Padding(
                    padding:  EdgeInsets.fromLTRB(37, 0, 25, 0),
                    child: Text("Confirm Password",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w400,
                        fontFamily: "Cabin-Regular",color: AppColor.headingtext),


                    ),
                  ),



                  Padding(
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
                        /* inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],*/
                        fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                        controller.confirmpassContr,

                        suffixIconWidget: Padding(
                          padding:  EdgeInsets.all(15.0),
                          child: Image.asset(ImageAssets.eye,width: width/50-4,height: 4,),
                        ),
                        focusNode: controller.confiPassword,
                        hintText: "Enter Password",
                        hintStyle: TextStyle(fontWeight: FontWeight.w500,color:AppColor.textFildtextcolor,
                            fontSize: 14,fontFamily: "Poppins-Medium")

                    ),
                  ),




                  Padding(

                    padding:  EdgeInsets.fromLTRB(15, 20, 10, 15),
                    child: CustomWidget.elevatedCustomButton(
                      context, "Continue", (){
                      //  Get.to(DashboardScreen());

                          Get.to(EnterNumberScreen());


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
