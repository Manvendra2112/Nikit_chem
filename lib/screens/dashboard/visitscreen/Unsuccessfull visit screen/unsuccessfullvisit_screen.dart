import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/Unsuccessfull%20visit%20screen/unsuccessfullvisit_controller.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../../DashboardScreen.dart';

class UnsuccessfullvisitScreen extends StatelessWidget {
  UnsuccessfullvisitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);
    return GetBuilder(
        init: UnsuccessfullvisitController(),
        builder: (controller) {
          return Scaffold(
              backgroundColor: Colors.white,
              body: ListView(
                shrinkWrap: true,
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
                        margin: EdgeInsets.fromLTRB(28, 25, 25, 0),
                        child: Image.asset(
                          ImageAssets.backbutton,
                          width: 20,
                          height: 20,
                        ),
                      )),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(25, 0, 25, 15),
                    child: Text(
                      "Unsuccessful Visit",
                      maxLines: 2,
                      style: TextStyle(
                          fontSize: 22,
                          color: AppColor.headingtext,
                          fontFamily: "Poppins-SemiBold",
                          fontWeight: FontWeight.w600),
                    ),
                  ),
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
                    padding: EdgeInsets.fromLTRB(35, 30, 0, 0),
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
                    fillColorFiled: true,
                    enableBorder: true,
                    borderRadius: 20.0,
                  ),
                  SizedBox(height: height * 0.46),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 30),
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
              ));
        });
  }
}