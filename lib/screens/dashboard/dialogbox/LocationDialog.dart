import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/changelocationreason/ChangeLocationScreen.dart';
import 'package:nikitchem/screens/dashboard/HomeScreenController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class LocationDialog extends StatelessWidget {
  final List<String> locations = [
    "Ambala, Haryana",
    "Chandigarh, Punjab",
    "Amritsar, Punjab",
    "Jalandhar, Punjab",
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      // Remove init to use existing controller instance
      builder: (controller) => Dialog(
        backgroundColor: Colors.white,
        alignment: Alignment.center,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            const Text(
              "Select Below Location",
              style: TextStyle(
                fontSize: 16,
                fontFamily: "Poppins-Medium",
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            ...locations.map((location) {
              return ListTile(
                leading: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Image.asset(
                    ImageAssets.locationadd,
                    width: 17,
                    height: 18,
                  ),
                ),
                title: Text(
                  location,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: "Poppins-Medium",
                    fontWeight: FontWeight.w500,
                  ),
                ),
                trailing: Checkbox(
                  value: controller.selectedLocation == location,
                  onChanged: (value) {
                    if (value == true) {
                      controller.updateLocation(location);
                      controller.update();
                    }
                  },
                  activeColor: AppColor.positiveButton,
                ),
                onTap: () {
                  controller.updateLocation(location);
                  controller.update();
                },
              );
            }).toList(),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
              child: CustomWidget.elevatedCustomButton(
                context,
                "Next",
                    () {
                  Get.to(() => ChangeLocationScreen());
                },
                fontSize: 16,
                textColor: Colors.white,
                bgColor: AppColor.positiveButton,
                width: 390 * 0.9,
                height: 50 * 0.9,
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}