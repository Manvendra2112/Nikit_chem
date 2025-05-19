import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/EnterNumberController.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/otpscreen/VerifyOTPScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../../../../constant/custom_widget.dart';

class EnterNumberScreen extends StatelessWidget {
  EnterNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<EnterNumberController>(
      init: EnterNumberController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            shrinkWrap: true,
            children: [
             // SizedBox(height: height * 0.02),
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.fromLTRB(25, MediaQuery.of(context).padding.top + 10, 25, 0),
                  child: Image.asset(
                    ImageAssets.backbutton,
                    width: width * 0.08,
                    height: width * 0.08,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                child: Text(
                  "Change Password",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.headingtext,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.fromLTRB(25, 0, 25, 20),
                child: Text(
                  "Enter Phone Number",
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColor.headingtext,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.fromLTRB(37, 0, 25, 0),
                child: Text(
                  "Enter Phone Number",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin-Regular",
                    color: AppColor.headingtext,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 8, 20, 0),
                child: CustomWidget.textInputFiled(
                  controller.mobileNumController,
                  focusNode: controller.mobileFocus,
                  hintText: "91+ Phone Number ",
                  fillColorFiled: true,
                  fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  borderWidth: 1,
                  textInputType: TextInputType.phone,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  topPadding: 8,
                  validator: (value) => controller.validatePhoneNumber(),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(17, 0, 17, MediaQuery.of(context).padding.bottom + 15),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Get OTP",
                      () {
                    String? error = controller.validatePhoneNumber();
                    if (error == null) {
                      print('Navigating to VerifyOTPScreen');
                      Get.to(() => VerifyOTPScreen());
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error)),
                      );
                      controller.mobileFocus.requestFocus();
                    }
                  },
                  fontSize: 18,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  height: height * 0.07,
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