import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitNotCompletedController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:intl/intl.dart';

import '../../../support/flutter_font_style.dart';
import '../DashboardScreen.dart';

class VisitNotCompletedScreen extends StatelessWidget {
  VisitNotCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = CustomWidget.getHeight(context);
    final double screenWidth = CustomWidget.getWidth(context);

    return GetBuilder<VisitNotCompletedController>(
        init: VisitNotCompletedController(),
        builder: (controller) {
          return Scaffold(
              resizeToAvoidBottomInset: true, // Adjust for keyboard
              backgroundColor: Colors.white,
              body: SafeArea(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 20), // Ensure bottom content is accessible
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: () {
                            Get.offAll(
                                  () => const DashboardScreen(),
                              arguments: {'selectedIndex': 0, 'refresh': true},
                            );
                          },
                          child: Container(
                            alignment: Alignment.topLeft,
                            margin: EdgeInsets.fromLTRB(25, 50, 25, 0),
                            child: Image.asset(
                              ImageAssets.backbutton,
                              width: 20,
                              height: 20,
                            ),
                          )),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                        child: Text(
                          "Unsuccessful Visit",
                          maxLines: 2,
                          style: TextStyle(
                              fontSize: 18,
                              color: AppColor.headingtext,
                              fontFamily: "Poppins-Medium",
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 40, 20, 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                  color: AppColor.bgColor20.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Padding(
                                padding: EdgeInsets.all(7.0),
                                child: Image.asset(
                                  ImageAssets.dealericon,
                                  width: 24,
                                  height: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Text("Shop Name :",
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                            Text("Sharma Flowers",
                                maxLines: 2,
                                style: TextStyle(
                                    fontFamily: "Poppins-Medium",
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(35, 20, 0, 0),
                        child: Text("Why the visit is unsuccessful ?",
                            maxLines: 2,
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      CustomWidget.textInputFiled(
                        enabledBox: true,
                        borderWidth: 1,
                        topPadding: 10,
                        leftPadding: 20,
                        rightPadding: 20,
                        maxLine: 6,
                        minLine: 5,
                        height: 120 * 0.9,
                        textInputType: TextInputType.multiline,
                        controller.remarksController,
                        fillColors: AppColor.positiveButton.withOpacity(0.1),
                        focusNode: controller.remarksFocus,
                        hintText: "Write Here....",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 15,
                            color: AppColor.blackheading),
                        fillColorFiled: true,
                        enableBorder: true,
                        borderRadius: 20.0,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text("Are They Using Our Products ?",
                            style: TextStyle(
                                fontFamily: "Poppins-Medium",
                                fontSize: 16,
                                fontWeight: FontWeight.w500)),
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Radio<bool>(
                              value: true,
                              groupValue: controller.isUsingProduct,
                              onChanged: (value) => controller.toggleProductUsage(value!),
                              activeColor: AppColor.positiveButton,
                            ),
                            const Text('Yes'),
                            Radio<bool>(
                              value: false,
                              groupValue: controller.isUsingProduct,
                              onChanged: (value) => controller.toggleProductUsage(value!),
                              activeColor: AppColor.positiveButton,
                            ),
                            Text('No'),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                          child: Text(
                            "Competitor Brand Name",
                            style: FTextStyle.custom(
                              fontSize: screenWidth * 0.045,
                              fontFamily: "Cabin-Regular",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: CustomWidget.textInputFiled(
                          controller.competitorbrandname,
                          borderWidth: 1,
                          topPadding: 0,
                          fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                          focusNode: controller.competitorbrandnameFocus,
                          hintText: "Enter Competitor Brand Name",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffA0A0A0)),
                          fillColorFiled: true,
                          borderRadius: 10,
                          height: screenHeight * 0.06,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                          child: Text(
                            "Through which dealer are they getting this ?",
                            style: FTextStyle.custom(
                              fontSize: screenWidth * 0.045,
                              fontFamily: "Cabin-Regular",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: CustomWidget.textInputFiled(
                          controller.otherdealer,
                          borderWidth: 1,
                          topPadding: 0,
                          fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                          focusNode: controller.otherdealerFocus,
                          fillColorFiled: true,
                          borderRadius: 10,
                          height: screenHeight * 0.06,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                          child: Text(
                            "Our brand products recommended by you",
                            style: FTextStyle.custom(
                              fontSize: screenWidth * 0.045,
                              fontFamily: "Cabin-Regular",
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                        child: CustomWidget.textInputFiled(
                          controller.brandproduct,
                          borderWidth: 1,
                          topPadding: 0,
                          fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                          focusNode: controller.brandproductFocus,
                          hintText: "Enter our product you recommended",
                          hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Color(0xffA0A0A0)),
                          fillColorFiled: true,
                          borderRadius: 10,
                          height: screenHeight * 0.06,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      SizedBox(height: screenHeight * 0.05), // Replace Spacer
                      Padding(
                        padding: EdgeInsets.fromLTRB(25, 10, 25, 20),
                        child: CustomWidget.elevatedCustomButton(
                          context,
                          "Submit",
                          controller.submit,
                          fontSize: 20,
                          textColor: Colors.white,
                          bgColor: AppColor.positiveButton,
                          width: 390 * 0.9,
                          height: 55 * 0.9,
                          borderRadius: 10,
                        ),
                      )
                    ],
                  ),
                ),
              ));
        });
  }
}