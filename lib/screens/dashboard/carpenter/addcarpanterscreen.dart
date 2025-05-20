import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/carpenter/addcarpanterscreencontroller.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class AddCarpanterScreen extends StatelessWidget {
  final String dealerId;
  const AddCarpanterScreen({super.key, required this.dealerId});

  @override
  Widget build(BuildContext context) {
    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);
    print('the dealer id is $dealerId');
    return GetBuilder<AddCarpenterScreenController>(
      init: AddCarpenterScreenController(dealerId: dealerId),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 72,
                        alignment: Alignment.center,
                        margin: EdgeInsets.fromLTRB(25, 0, 15, 0),
                        child: Image.asset(
                          ImageAssets.backbutton,
                          width: 20,
                          height: 20,
                        ),
                      ),
                    ),
                    Container(
                      height: 72,
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: Text(
                        "Add Carpenters",
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 22,
                          color: AppColor.headingtext,
                          fontFamily: "Poppins-SemiBold",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    "Carpenter Name*",
                    style: TextStyle(fontSize: 14, fontFamily: "Cabin-Regular"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.nameContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.nameFocus,
                    hintText: "Enter Carpenter Name",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                    borderRadius: 10,
                    height: height * 0.06,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    "Phone Number*",
                    style: TextStyle(fontSize: 14, fontFamily: "Cabin-Regular"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.phoneContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.phoneFocus,
                    hintText: "91+ Phone Number",
                    fillColorFiled: true,
                    textInputType: TextInputType.phone,
                    enabledBox: !controller.isLoading.value,
                    borderRadius: 10,
                    height: height * 0.06,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    "Email*",
                    style: TextStyle(fontSize: 14, fontFamily: "Cabin-Regular"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.emailContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.emailFocus,
                    hintText: "Enter Email",
                    fillColorFiled: true,
                    textInputType: TextInputType.emailAddress,
                    enabledBox: !controller.isLoading.value,
                    borderRadius: 10,
                    height: height * 0.06,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    "Add Address",
                    style: TextStyle(fontSize: 14, fontFamily: "Cabin-Regular"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.addressContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.addressFocus,
                    hintText: "Enter Address",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                    borderRadius: 10,
                    height: height * 0.06,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 0),
                  child: Text(
                    "Assign to Dealer*",
                    style: TextStyle(fontSize: 14, fontFamily: "Cabin-Regular"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.stringTypeDropDown(
                    controller.dealerOptions.any((option) => option['id'] == controller.selectedDealer)
                        ? controller.dealerOptions
                        .firstWhere((option) => option['id'] == controller.selectedDealer)['name']!
                        : '',
                    controller.dealerOptions.map((option) => option['name']!).toList(),
                        (value) {
                      final selectedOption = controller.dealerOptions
                          .firstWhere((option) => option['name'] == value);
                      controller.selectedDealer = selectedOption['id']!;
                      print("Selected dealer ID: ${controller.selectedDealer}");
                      controller.update();
                    },
                    controller.dealerFocus,
                    colorDropDown: AppColor.textFildtextcolor.withOpacity(0.2),
                    label: "Select the Dealer",
                    isMandatory: true,
                    hideBorder: false,
                    hideLabel: true,
                    enabledBox: !controller.isLoading.value,
                   // borderRadius: 10,
                    height: height * 0.06,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                  child: Text(
                    "Remarks",
                    maxLines: 2,
                    style: TextStyle(
                      fontFamily: "Poppins-Medium",
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                CustomWidget.textInputFiled(
                  controller.remarksContr,
                  enabledBox: !controller.isLoading.value,
                  borderWidth: 1,
                  topPadding: 5,
                  leftPadding: 20,
                  rightPadding: 20,
                  maxLine: 6,
                  minLine: 5,
                  height: height * 0.12,
                  textInputType: TextInputType.multiline,
                  fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                  focusNode: controller.remarksFocus,
                  hintText: "Enter Remarks",
                  fillColorFiled: true,
                  borderRadius: 20,
                ),
                SizedBox(height: height * 0.06),
                Padding(
                  padding: EdgeInsets.fromLTRB(25, 10, 25, 5),
                  child: CustomWidget.elevatedCustomButton(
                    context,
                    controller.isLoading.value ? "Submitting..." : "Submit",
                    controller.isLoading.value ? () {} : () => controller.createCarpenter(context),
                    fontSize: 20,
                    textColor: Colors.white,
                    bgColor: AppColor.positiveButton,
                    width: width * 0.9,
                    height: height * 0.07,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}