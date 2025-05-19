import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/register%20screen/registerscreen_controller.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/flutter_font_style.dart';
import 'package:nikitchem/support/imageassets.dart';

class RegesterScreen extends StatelessWidget {
  const RegesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = CustomWidget.getHeight(context);
    final double screenWidth = CustomWidget.getWidth(context);

    return GetBuilder<RegesterScreenController>(
      init: RegesterScreenController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.05),
                // Logo
                Image.asset(
                  ImageAssets.nikitchamlogo,
                  height: screenHeight * 0.15,
                  width: screenWidth * 0.4,
                  fit: BoxFit.contain,
                ),
                // Title
                Text(
                  "Register to Nik Chem",
                  style: FTextStyle.custom(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: AppColor.blackheading,
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Description
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing",
                    style: FTextStyle.custom(
                      fontSize: screenWidth * 0.035,
                      color: AppColor.pharagraphtext,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: screenHeight * 0.03),
                // Full Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Full Name*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomWidget.textInputFiled(
                    controller.nameContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.nameFocus,
                    hintText: "Enter Full Name",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Staff Selection
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Staff Selection*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomWidget.stringTypeDropDown(
                    controller.selectedStaff.value,
                    controller.staffList,
                        colorDropDown:AppColor.textFildtextcolor.withOpacity(0.2) ,
                        (value) {
                      if (value != null) {
                        controller.selectedStaff.value = value;
                        controller.update();
                      }
                    },
                    null,
                    height: screenHeight * 0.06,
                    enabledBox: !controller.isLoading.value,
                    isMandatory: true,
                  ),
                ),

                SizedBox(height: screenHeight * 0.02),
                // Phone Number
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Phone Number*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                SizedBox(height: screenHeight * 0.02),
                // Email
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Email",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                SizedBox(height: screenHeight * 0.02),
                // Create Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Create Password*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomWidget.textInputFiled(
                    controller.passwordContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.passwordFocus,
                    hintText: "Enter Password",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                    passwordHide: controller.isPasswordHidden.value,
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                    suffixIconWidget: IconButton(
                      icon: Icon(
                        controller.isPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.textFildtextcolor,
                        size: screenHeight * 0.03,
                      ),
                      onPressed: () {
                        controller.isPasswordHidden.value = !controller.isPasswordHidden.value;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Confirm Password
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Confirm Password*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: CustomWidget.textInputFiled(
                    controller.confirmPasswordContr,
                    borderWidth: 1,
                    topPadding: 0,
                    fillColors: AppColor.textFildtextcolor.withOpacity(0.2),
                    focusNode: controller.confirmPasswordFocus,
                    hintText: "Confirm Password",
                    fillColorFiled: true,
                    enabledBox: !controller.isLoading.value,
                    passwordHide: controller.isConfirmPasswordHidden.value,
                    borderRadius: 10,
                    height: screenHeight * 0.06,
                    suffixIconWidget: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordHidden.value ? Icons.visibility_off : Icons.visibility,
                        color: AppColor.textFildtextcolor,
                        size: screenHeight * 0.03,
                      ),
                      onPressed: () {
                        controller.isConfirmPasswordHidden.value = !controller.isConfirmPasswordHidden.value;
                        controller.update();
                      },
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Flat / House No / Building Name
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Flat / House No / Building Name*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                    height: screenHeight * 0.06,
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // Floor
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Floor (Floor)",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                SizedBox(height: screenHeight * 0.02),
                // State
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "State*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedState.value.isEmpty ? null : controller.selectedState.value,
                    decoration: InputDecoration(
                      hintText: "Select State",
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
                    icon: const SizedBox.shrink(), // Hide default dropdown arrow
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
                        controller.loadCities(value);
                        controller.selectedCity.value = '';
                        controller.cityContr.text = '';
                        controller.update();
                      }
                    },
                  ),
                ),
                SizedBox(height: screenHeight * 0.02),
                // City
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "City*",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05,),
                  child: DropdownButtonFormField<String>(
                    value: controller.selectedCity.value.isEmpty ? null : controller.selectedCity.value,
                    decoration: InputDecoration(
                      hintText: "Select City",
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
                    icon: const SizedBox.shrink(), // Hide default dropdown arrow
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
                SizedBox(height: screenHeight * 0.02),
                // Nearby Landmark
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0, 0, screenHeight * 0.01),
                    child: Text(
                      "Nearby Landmark",
                      style: FTextStyle.custom(
                        fontSize: screenWidth * 0.035,
                        fontFamily: "Cabin-Regular",
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
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
                SizedBox(height: screenHeight * 0.03),
                // Submit Button
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05, vertical: screenHeight * 0.02),
                  child: CustomWidget.elevatedCustomButton(
                    context,
                    controller.isLoading.value ? "Submitting..." : "Submit",
                    controller.isLoading.value ? () {} : () => controller.createAccount(context),
                    fontSize: screenWidth * 0.045,
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