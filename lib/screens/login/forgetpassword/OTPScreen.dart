import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/login/forgetpassword/OTPController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:pinput/pinput.dart';

class OTPScreen extends StatelessWidget {
   OTPScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 60,
      height: 46,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle, // Circular shape
       // border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    // Define the focused state theme
    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        //border: Border.all(color: AppColor.textFildbgcolor50, width: 2),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    // Define the submitted state theme
    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
       // border: Border.all(color: AppColor.positiveButton),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);

    return GetBuilder<OTPController>(
        init:  OTPController(),

        builder: (controller){
          return Scaffold(body: Column(
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

              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing  ",maxLines: 3,
                style: TextStyle(fontSize: 14,color: AppColor.pharagraphtext,
                    fontFamily: "Cabin-Regular",fontWeight: FontWeight.w400),),
            ),


            SizedBox(height: 10,),
            Container(   alignment: Alignment.center,

              child: Text("Enter OTP To Verify",maxLines: 3,
                style: TextStyle(fontSize: 14,color: AppColor.pharagraphtext,
                    fontFamily: "Poppins-SemiBold",fontWeight: FontWeight.w500),),
            ),


            Container(

              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Pinput(
                controller:controller.pinController,
                length: 4, // Number of OTP digits
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                focusNode:controller. pinFocus,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  print('OTP Entered: $pin');
                  // Handle OTP submission (e.g., verify OTP)


                },
                onChanged: (value) {
                  print('OTP Changed: $value');
                },
              ),
            ),



            Padding(

              padding:  EdgeInsets.fromLTRB(25, 20, 25, 5),
              child: CustomWidget.elevatedCustomButton(
                context, "Verify", (){
                Get.to(OTPScreen());

              },fontSize: 20,textColor: Colors.white,
                bgColor: AppColor.positiveButton,

                height: 60,

                weight: FontWeight.w500,
                borderRadius: 10,



              ),
            )

          ],));


        });
  }
}