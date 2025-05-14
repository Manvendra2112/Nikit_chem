import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../constant/custom_widget.dart';
import '../../../../../../support/app_theme.dart';
import '../../../../../login/forgetpassword/OTPController.dart';

class VerifyOTPScreen extends StatelessWidget {
   VerifyOTPScreen({super.key});

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
                 child: Text("Enter OTP",maxLines:2,style: TextStyle(
                     fontSize: 18,color: AppColor.headingtext,
                     fontFamily: "Poppins-Medium",fontWeight: FontWeight.w500),),
               ),



               SizedBox(height: 10,),
               Container(   alignment: Alignment.center,

                 child: Text("Enter OTP To Verify",maxLines: 3,
                   style: TextStyle(fontSize: 14,color: AppColor.pharagraphtext,
                       fontFamily: "Poppins-SemiBold",fontWeight: FontWeight.w500),),
               ),


               Container(

                 alignment: Alignment.center,
                 margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
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
                  // Get.to(OTPScreen());

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
