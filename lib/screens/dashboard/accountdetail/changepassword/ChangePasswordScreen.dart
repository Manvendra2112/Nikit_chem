import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/changepassword/enternumber/EnterNumberScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../../../../constant/custom_widget.dart';
import 'ChangePasswordController.dart';

class ChangePasswordScreen extends StatelessWidget {
  ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return GetBuilder<ChangePasswordController>(
      init: ChangePasswordController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListView(
            shrinkWrap: true,
            children: [
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
              SizedBox(height: 30),
              Padding(
                padding: EdgeInsets.fromLTRB(37, 0, 25, 0),
                child: Text(
                  "Enter Current Password",
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
                child: Obx(
                      () => CustomWidget.textInputFiled(
                    controller.currepassContr,
                    enableBorder: false,
                    borderColor: Colors.transparent,
                    borderWidth: 1,
                    bottomPadding: 0,
                    topPadding: 0,
                    fillColorFiled: true,
                    blurRadius: 10,
                    textInputType: TextInputType.text,
                    passwordHide: !controller.showCurrentPassword.value,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    suffixIconWidget: GestureDetector(
                      onTap: controller.toggleCurrentPasswordVisibility,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          controller.showCurrentPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                          color: AppColor.textFildtextcolor,
                        ),
                      ),
                    ),
                    focusNode: controller.currePassword,
                    hintText: "Edit Password",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textFildtextcolor,
                      fontSize: 14,
                      fontFamily: "Poppins-Medium",
                    ),
                    validator: (value) => controller.validateCurrentPassword(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(37, 0, 25, 0),
                child: Text(
                  "Enter New Password",
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
                child: Obx(
                      () => CustomWidget.textInputFiled(
                    controller.newpassContr,
                    enableBorder: false,
                    borderColor: Colors.transparent,
                    borderWidth: 1,
                    bottomPadding: 0,
                    topPadding: 0,
                    fillColorFiled: true,
                    blurRadius: 10,
                    textInputType: TextInputType.text,
                    passwordHide: !controller.showNewPassword.value,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    suffixIconWidget: GestureDetector(
                      onTap: controller.toggleNewPasswordVisibility,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          controller.showNewPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                          color: AppColor.textFildtextcolor,
                        ),
                      ),
                    ),
                    focusNode: controller.newPassword,
                    hintText: "Edit Password",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textFildtextcolor,
                      fontSize: 14,
                      fontFamily: "Poppins-Medium",
                    ),
                    validator: (value) => controller.validateNewPassword(),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.fromLTRB(37, 0, 25, 0),
                child: Text(
                  "Confirm Password",
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
                child: Obx(
                      () => CustomWidget.textInputFiled(
                    controller.confirmpassContr,
                    enableBorder: false,
                    borderColor: Colors.transparent,
                    borderWidth: 1,
                    bottomPadding: 0,
                    topPadding: 0,
                    fillColorFiled: true,
                    blurRadius: 10,
                    textInputType: TextInputType.text,
                    passwordHide: !controller.showConfirmPassword.value,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    suffixIconWidget: GestureDetector(
                      onTap: controller.toggleConfirmPasswordVisibility,
                      child: Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Icon(
                          controller.showConfirmPassword.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                          size: 16,
                          color: AppColor.textFildtextcolor,
                        ),
                      ),
                    ),
                    focusNode: controller.confiPassword,
                    hintText: "Enter Password",
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: AppColor.textFildtextcolor,
                      fontSize: 14,
                      fontFamily: "Poppins-Medium",
                    ),
                    validator: (value) => controller.validateConfirmPassword(),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(15, 20, 10, MediaQuery.of(context).padding.bottom + 15),
                child: Obx(
                      () => CustomWidget.elevatedCustomButton(
                    context,
                    controller.isLoading.value ? "Processing..." : "Continue",
                        () {
                      if (!controller.isLoading.value) {
                        controller.changePassword(context);
                      }
                    },
                    fontSize: 20,
                    textColor: Colors.white,
                    bgColor: AppColor.positiveButton,
                    height: height * 0.07,
                    weight: FontWeight.w500,
                    borderRadius: 10,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}