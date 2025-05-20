import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerScreen.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/adddelaer/AddDealerController.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/editdealer/EditDealerController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/flutter_font_style.dart';
import 'package:nikitchem/support/imageassets.dart';

class EditDealerScreen extends StatelessWidget {
  const EditDealerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = CustomWidget.getWidth(context);
    final double screenHeight = CustomWidget.getHeight(context);

    return GetBuilder<EditDealerController>(
      init: EditDealerController(context),
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
                    "Edit Dealers",
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
                    "Edit Name*",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Phone Number*",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Email Number*",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit State*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedState.value.isEmpty ? null : controller.selectedState.value,
                    decoration: InputDecoration(
                      hintText: controller.isLoading.value ? "Loading States..." : "Select State",
                      filled: true,
                      fillColor: AppColor.textFildtextcolor.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.textFildtextcolor,
                        size: 20,
                      ),
                    ),
                    icon: const SizedBox.shrink(),
                    items: controller.stateList.map((state) {
                      return DropdownMenuItem<String>(
                        value: state,
                        child: Text(
                          state,
                          style: FTextStyle.custom(
                            fontSize: screenWidth * 0.04,
                            color: AppColor.blackheading,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: controller.isLoading.value
                        ? null
                        : (value) {
                      if (value != null) {
                        controller.selectedState.value = value;
                        controller.stateContr.text = value;
                        controller.loadCities(value);
                        controller.selectedCity.value = '';
                        controller.cityContr.text = '';
                        controller.update();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit City*",
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Cabin-Regular",
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedCity.value.isEmpty ? null : controller.selectedCity.value,
                    decoration: InputDecoration(
                      hintText: controller.isLoading.value ? "Loading Cities..." : "Select City",
                      filled: true,
                      fillColor: AppColor.textFildtextcolor.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
                      suffixIcon: const Icon(
                        Icons.arrow_drop_down,
                        color: AppColor.textFildtextcolor,
                        size: 20,
                      ),
                    ),
                    icon: const SizedBox.shrink(),
                    items: controller.cityList.map((city) {
                      return DropdownMenuItem<String>(
                        value: city,
                        child: Text(
                          city,
                          style: FTextStyle.custom(
                            fontSize: screenWidth * 0.04,
                            color: AppColor.blackheading,
                          ),
                        ),
                      );
                    }).toList(),
                    onChanged: (controller.isLoading.value || controller.selectedState.value.isEmpty)
                        ? null
                        : (value) {
                      if (value != null) {
                        controller.selectedCity.value = value;
                        controller.cityContr.text = value;
                        controller.update();
                      }
                    },
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Shop Address*",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Floor",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Area or Landmark",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                const SizedBox(height: 10),
                const Padding(
                  padding: EdgeInsets.fromLTRB(25, 5, 25, 5),
                  child: Text(
                    "Edit Nearby Landmark",
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
                    borderRadius: 10,
                    height: screenHeight * 0.06,
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
                    height: screenHeight * 0.07,
                    borderRadius: 10,
                    width: screenWidth * 0.9,
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