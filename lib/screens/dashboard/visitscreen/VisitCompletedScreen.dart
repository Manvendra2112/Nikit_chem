import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                        SizedBox(width: 12),
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
                    decoration: BoxDecoration(
                      color: AppColor.positiveButton.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: controller.isLoading
                        ? Center(child: CircularProgressIndicator())
                        : controller.errorMessage.isNotEmpty
                        ? Center(child: Text(controller.errorMessage))
                        : Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: CustomWidget.stringTypeDropDown(
                              controller.selectedProduct,
                              controller.productOptions, (value) {
                            controller.updateSelectedProduct(value!);
                          }, controller.productFocus,
                              isMandatory: false,
                              hideBorder: false,
                              label: "Select Product",
                              hideLabel: true),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                          child: CustomWidget.stringTypeDropDown(
                              controller.selectedPacking,
                              controller.packingOptions, (value) {
                            controller.updateSelectedPacking(value!);
                          }, controller.packingFocus,
                              isMandatory: false,
                              hideBorder: false,
                              label: "Packing",
                              hideLabel: true),
                        ),
                        CustomWidget.textInputFiled(
                          controller.quantityController,
                          textInputType: TextInputType.number,
                          borderWidth: 1,
                          topPadding: 10,
                          leftPadding: 20,
                          rightPadding: 20,
                          fillColors: AppColor.white,
                          focusNode: controller.quantityFocus,
                          hintText: "Quantity",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          fillColorFiled: true,
                          borderRadius: 10,
                          enableBorder: true,
                          cursorColors: Colors.black,
                          onChanged: (value) {
                            controller.updatePriceAndTotal();
                          },
                        ),
                        CustomWidget.textInputFiled(
                          controller.priceController,
                          readOnlyFiled: true,
                          borderWidth: 1,
                          topPadding: 10,
                          leftPadding: 20,
                          rightPadding: 20,
                          fillColors: AppColor.white,
                          focusNode: controller.priceFocus,
                          hintText: "Price",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          fillColorFiled: true,
                          borderRadius: 10,
                          enableBorder: true,
                          cursorColors: Colors.black,
                          prefixIconWidget: Padding(
                            padding: EdgeInsets.only(left: 10, top: 12),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        CustomWidget.textInputFiled(
                          controller.totalPriceController,
                          readOnlyFiled: true,
                          borderWidth: 1,
                          topPadding: 10,
                          leftPadding: 20,
                          rightPadding: 20,
                          fillColors: AppColor.white,
                          focusNode: controller.totalPriceFocus,
                          hintText: "Total Price",
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                          fillColorFiled: true,
                          enableBorder: true,
                          borderRadius: 10,
                          cursorColors: Colors.black,
                          prefixIconWidget: Padding(
                            padding: EdgeInsets.only(left: 10, top: 12),
                            child: Text(
                              '₹',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 390 * 0.9,
                    height: 59 * 0.9,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColor.positiveButton),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.fromLTRB(20, 0, 20, 5),
                    padding: EdgeInsets.fromLTRB(3, 0, 3, 0),
                    child: Text("+ Add More",
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(35, 10, 0, 0),
                    child: Text("Remarks",
                        maxLines: 2,
                        style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontSize: 16,
                            fontWeight: FontWeight.w500)),
                  ),
                  CustomWidget.textInputFiled(
                    controller.remarksController,
                    borderWidth: 1,
                    topPadding: 10,
                    leftPadding: 20,
                    rightPadding: 20,
                    maxLine: 6,
                    minLine: 5,
                    height: 120 * 0.9,
                    textInputType: TextInputType.multiline,
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
                  SizedBox(height: height * 0.02),
                  Padding(
                    padding: EdgeInsets.fromLTRB(25, 10, 25, 30),
                    child: CustomWidget.elevatedCustomButton(
                      context,
                      "Submit",
                          () {
                        if (controller.validateFields()) {
                          controller.submitOrder();
                        }
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