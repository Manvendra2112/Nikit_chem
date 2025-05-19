import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:pinput/pinput.dart';

import '../../../../../../constant/custom_widget.dart';
import '../../../../../../support/app_theme.dart';
import '../../../../../login/forgetpassword/OTPController.dart';
import '../../../../DashboardScreen.dart';

class VerifyOTPScreen extends StatelessWidget {
  VerifyOTPScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width * 0.16,
      height: MediaQuery.of(context).size.height * 0.064,
      textStyle: TextStyle(
        fontSize: MediaQuery.of(context).size.width * 0.053,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: AppColor.textFildtextcolor.withOpacity(0.2),
      ),
    );

    return GetBuilder<OTPController>(
      init: OTPController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(25, MediaQuery.of(context).padding.top + 10, 25, 0),
                  child: Image.asset(
                    ImageAssets.backbutton,
                    width: MediaQuery.of(context).size.width * 0.08,
                    height: MediaQuery.of(context).size.width * 0.08,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                child: Text(
                  "Enter OTP",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColor.headingtext,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Text(
                  "Enter OTP To Verify",
                  maxLines: 3,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColor.pharagraphtext,
                    fontFamily: "Poppins-SemiBold",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Pinput(
                  controller: controller.pinController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  focusNode: controller.pinFocus,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    print('OTP Entered: $pin');
                  },
                  onChanged: (value) {
                    print('OTP Changed: $value');
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25, 20, 25, MediaQuery.of(context).padding.bottom + 20),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Verify",
                      () {
                    if (controller.pinController.text.length == 4) {
                      print('Navigating to DashboardScreen');
                      Get.offAll(
                            () => const DashboardScreen(),
                        arguments: {'selectedIndex': 4, 'refresh': true},
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Please enter a 4-digit OTP")),
                      );
                      controller.pinFocus.requestFocus();
                    }
                  },
                  fontSize: 20,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  height: MediaQuery.of(context).size.height * 0.07,
                  weight: FontWeight.w500,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}