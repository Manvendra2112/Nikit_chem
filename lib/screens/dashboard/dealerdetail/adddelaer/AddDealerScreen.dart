import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerScreen.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/adddelaer/AddDealerController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class AddDealerScreen extends StatelessWidget {
  const AddDealerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AddDealerController>(
      init: AddDealerController(context),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 35),
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    alignment: Alignment.topLeft,
                    margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                    child: Image.asset(
                      ImageAssets.backbutton,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.fromLTRB(25, 0, 25, 5),
                  child: const Text(
                    "Add Dealers",
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColor.headingtext,
                      fontFamily: "Poppins-Medium",
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Dealer Name*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.nameContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.nameFocus,
                    hintText: "Enter Dealer Name",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Phone Number*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Email",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "State*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.stateContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.stateFocus,
                    hintText: "Enter State",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "City*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.cityContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.cityFocus,
                    hintText: "Enter City",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Shop Address*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.addressContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.addressFocus,
                    hintText: "Enter Shop Address",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Floor",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.floorContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.floorFocus,
                    hintText: "Enter Floor (e.g., Ground, 1st)",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Area or Landmark",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.landmarkContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.landmarkFocus,
                    hintText: "Enter Area or Landmark",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Nearby Landmark",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
                  child: CustomWidget.textInputFiled(
                    controller.nearbyLandmarkContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.nearbyLandmarkFocus,
                    hintText: "Enter Nearby Landmark",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
                  child: CustomWidget.elevatedCustomButton(
                    context,
                    controller.isLoading.value ? "Submitting..." : "Submit",
                    controller.isLoading.value ? () {} : () => controller.createDealer(context),
                    fontSize: 18,
                    textColor: Colors.white,
                    bgColor: AppColor.positiveButton,
                    height: 60 * 0.9,
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