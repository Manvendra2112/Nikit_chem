import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/visitscreen/VisitCompletedController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import '../DashboardScreen.dart';

class VisitCompletedScreen extends StatelessWidget {
  VisitCompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);
    return GetBuilder(
        init: VisitCompletedController(),
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
                      margin: EdgeInsets.fromLTRB(25, 0, 25, 0),
                      child: Text(
                        "Successful Visit",
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
                      //margin: EdgeInsets.fromLTRB(20, 20, 20, 5),
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
              // SizedBox(height: 20,),
              // Container(
              //   margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
              //   child: Text("Are they Interested ?",
              //
              //       style: TextStyle(
              //           fontFamily: "Poppins-Medium",
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500)),
              // ),
              //
              //
              // Container(
              //
              //   alignment: Alignment.topLeft,
              //
              //   margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
              //   child: Row(mainAxisAlignment: MainAxisAlignment.start,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       Radio<bool>(
              //         value: true,
              //         groupValue: controller.isUsingProduct,
              //         onChanged: (value) => controller.toggleProductUsage(value!),
              //         activeColor: AppColor.positiveButton,
              //       ),
              //       const Text('Yes'),
              //       Radio<bool>(
              //         value: false,
              //         groupValue: controller.isUsingProduct,
              //         onChanged: (value) => controller.toggleProductUsage(value!),
              //         activeColor: AppColor.positiveButton,
              //       ),
              //       Text('No'),
              //     ],
              //   ),
              // ),

              // // remark section
              // Container(padding: EdgeInsets.fromLTRB(35, 10, 0, 0),
              //   child: Text("Remarks",
              //       maxLines: 2,
              //       style: TextStyle(
              //           fontFamily: "Poppins-Medium",
              //           fontSize: 16,
              //           fontWeight: FontWeight.w500)),
              // ),
              //
              // CustomWidget.textInputFiled(
              //   enabledBox: true,
              //   borderWidth: 1,
              //   topPadding: 10,
              //   leftPadding: 20,
              //   rightPadding: 20,
              //   maxLine: 6,
              //   minLine: 5,
              //   height: 120 * 0.9,
              //   textInputType: TextInputType.multiline,
              //   controller.remarksController,
              //   fillColors: AppColor.positiveButton.withOpacity(0.1),
              //   focusNode: controller.remarksFocus,
              //   hintText: "Write Here....",
              //   fillColorFiled: true,
              //   enableBorder: true,
              //   borderRadius:20.0,
              //
              // ),


              Container(
                margin: EdgeInsets.fromLTRB(35, 30, 20, 5),
                child: Text("Add Order Details",
                    maxLines: 2,
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
                padding: EdgeInsets.fromLTRB(10, 15, 10, 30),
                width: 390 * 0.9,
               // height: 385 * 0.9,
                decoration: BoxDecoration(
                   // color: AppColor.bgColor20.withOpacity(0.2),
                   // color: AppColor.bgColorpr.withOpacity(0.2),
                  color: AppColor.positiveButton.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CustomWidget.stringTypeDropDown(
                          controller.selectedproduct,
                          controller.productOptions, (value) {
                        controller.selectedproduct = value!;
                        controller.update();
                      }, controller.productFocus,
                          isMandatory: false,
                          hideBorder: false,
                          label: "Select Product",
                          hideLabel: true),
                    ),


                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: CustomWidget.stringTypeDropDown(
                          controller.selectedquantity,
                          controller.quantityOptions, (value) {
                        controller.selectedquantity = value!;
                        controller.update();
                      }, controller.quantityFocus,
                          isMandatory: false,
                          hideBorder: false,
                          label: "Quantity",
                          hideLabel: true),
                    ),
                    CustomWidget.textInputFiled(
                      enabledBox: true,
                      borderWidth: 1,
                      topPadding: 10,
                      leftPadding: 20,
                      cursorColors: Colors.black,
                      rightPadding: 20,
                      enableBorder: true,
                      controller.priceController,
                      fillColors: AppColor.white,
                      focusNode: controller.priceFocus,
                      hintText: "Price",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                      fillColorFiled: true,
                      borderRadius: 10,
                    ),
                    CustomWidget.textInputFiled(
                      enabledBox: true,
                      borderWidth: 1,
                      topPadding: 10,
                      leftPadding: 20,
                      rightPadding: 20,
                      controller.discountController,
                      fillColors: AppColor.white,
                      focusNode: controller.discountFocus,
                      hintText: "Discount",
                      hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500
                      ),
                      fillColorFiled: true,
                      borderRadius: 10,
                    ),
                    CustomWidget.textInputFiled(
                      enabledBox: true,
                      borderWidth: 1,
                      topPadding: 10,
                      leftPadding: 20,
                      rightPadding: 20,
                      controller.totalpriceController,
                      fillColors: AppColor.white,
                      focusNode: controller.totalPriceFocus,
                      hintText: "Total Price",
                      hintStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      ),
                      fillColorFiled: true,
                      enableBorder: true,

                      borderRadius: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 390*0.9,
                height: 59*0.9,
                alignment: Alignment.center,
                decoration: BoxDecoration(

                  border: Border.all(color: AppColor.positiveButton),
                    borderRadius: BorderRadius.circular(10),



                ),
                margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                child: Text("+ Add More",
                    maxLines: 2,textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: "Poppins-Medium",
                        fontSize: 16,
                        fontWeight: FontWeight.w500)),
              ),


              // remark section
              Container(padding: EdgeInsets.fromLTRB(35, 10, 0, 0),
                child: Text("Remarks",
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
                    color: AppColor.blackheading
                ),
                fillColorFiled: true,
                enableBorder: true,
                borderRadius:20.0,

              ),
              SizedBox(height: height*0.02,),


              Padding(
                padding: EdgeInsets.fromLTRB(25, 10, 25, 30),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "Submit",
                  () {
                    // Get.to(Submit());
                  },
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
