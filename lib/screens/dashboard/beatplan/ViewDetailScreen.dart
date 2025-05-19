import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetScreen.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailController.dart';
import 'package:nikitchem/screens/dashboard/carpenter/AddCarpanterScreen.dart';

import '../../../support/app_theme.dart';
import '../../../support/imageassets.dart';

class ViewDetailScreen extends StatelessWidget {
  ViewDetailScreen({super.key});

  // Static dummy dealer data
  final Map<String, dynamic> dealer = {
    'id': 58,
    'delearname': 'Sharma Hardware',
    'carpenderList': [
      {'name': 'Amit Sharma', 'role': 'Head Carpenter', 'city': 'New Delhi'},
      {'name': 'Rahul Verma', 'role': 'Assistant Carpenter', 'city': 'Gurgaon'},
      {'name': 'Suresh Kumar', 'role': 'Carpenter', 'city': 'Noida'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewDetailController>(
      init: ViewDetailController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(25, 60, 25, 15),
                child: textImage(ImageAssets.backbutton, "Sharma Hardware"),
              ),
              openContainerExpand(context),
            ],
          ),
        );
      },
    );
  }

  Widget buildTextView(String asset, String label, String value) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 26,
              height: 26,
              decoration: BoxDecoration(
                color: AppColor.bgColor20.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Image.asset(
                  asset,
                  width: 11,
                  height: 10,
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: 110,
              child: Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                label,
                style: TextStyle(
                  fontFamily: "Metropolis-Regular",
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              value,
              maxLines: 2,
              style: TextStyle(
                fontFamily: "Metropolis-Regular",
                fontSize: 10,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget openContainerExpand(BuildContext context) {
    return Container(
      width: 390 * 0.9,
      padding: EdgeInsets.fromLTRB(25, 30, 25, 0),
      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.positiveButton),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          buildTextView(ImageAssets.dealericon, "Dealer:", "Sushil Kumar"),
          SizedBox(height: 5),
          buildTextView(ImageAssets.address, "Address:", "K-2 Achim Vihar, New Delhi"),
          SizedBox(height: 5),
          buildTextView(ImageAssets.locationnew, "Client’s Shop Location", ""),
          SizedBox(height: 5),
          buildTextView(ImageAssets.phone, "91+ 9764464646", ""),
          SizedBox(height: 5),
          buildTextView(ImageAssets.totalvisit, "Total Visits:", "23"),
          SizedBox(height: 5),
          buildTextView(ImageAssets.totalorder, "Total Order:", "24kg"),
          SizedBox(height: 5),
          buildTextView(ImageAssets.successrate, "Success rate:", "80%"),
          SizedBox(height: 5),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.fromLTRB(15, 8, 8, 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.bgColor20.withOpacity(0.2),
            ),
            width: 390 * 0.9,
            height: 60 * 0.9,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.circleimage,
                  width: 20,
                  height: 22,
                ),
                SizedBox(width: 10),
                Text(
                  "No. Of Carpenter :- 05",
                  style: TextStyle(
                    fontFamily: "",
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(right: 5),
                  child: CustomWidget.elevatedCustomButton(
                    context,
                    "View Details",
                        () {
                      // Show the carpenter list dialog
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: 300, // Adjust popupWidth as needed
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Dealer’s Carpenter List",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: "Poppins-SemiBold",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                ...dealer['carpenderList'].map<Widget>((carpenter) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 5),
                                    child: Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 20,
                                          backgroundImage: AssetImage(ImageAssets.profilenew),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              carpenter['name'],
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "Poppins-Medium",
                                              ),
                                            ),
                                            Text(
                                              "${carpenter['role']}, ${carpenter['city'] ?? 'Unknown'}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Poppins-Medium",
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }).toList(),
                                const SizedBox(height: 20),
                                GestureDetector(
                                  onTap: () {
                                    Get.back();
                                    print("Navigating to AddCarpanterScreen with dealerId: ${dealer['id']}");
                                    Get.to(() => AddCarpanterScreen(
                                      dealerId: dealer['id']?.toString() ?? '',
                                    ));
                                  },
                                  child: Image.asset(
                                    ImageAssets.dottedbutton,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    width: 120 * 0.9,
                    height: 35 * 0.9,
                    borderColor: Colors.transparent,
                    bgColor: AppColor.white,
                    weight: FontWeight.w500,
                    textColor: AppColor.blackheading,
                    fontSize: 10,
                    borderRadius: 10,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
            child: CustomWidget.elevatedCustomButton(
              context,
              "I have arrived at location",
                  () {
                // showModalBottomSheet(
                //   context: context,
                //   isScrollControlled: true,
                //   builder: (context) => Container(
                //     height: MediaQuery.of(context).size.height * 0.25, // ~182.9px
                //     decoration: BoxDecoration(
                //       color: AppColor.white,
                //       borderRadius: BorderRadius.only(
                //         topLeft: Radius.circular(40),
                //         topRight: Radius.circular(40),
                //       ),
                //     ),
                //     padding: EdgeInsets.symmetric(
                //       vertical: 10, // Reduced from 15 for tighter fit
                //       horizontal: 15,
                //     ),
                //     child: CustomBottomsheetScreen(),
                //   ),
                // );
              },
              fontSize: 12,
              textColor: Colors.white,
              bgColor: AppColor.positiveButton,
              width: 340 * 0.9,
              height: 49 * 0.9,
              borderRadius: 10,
              weight: FontWeight.w500,
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 15, 0, 30),
            child: CustomWidget.elevatedCustomButton(
              context,
              "Visit Completed",
                  () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.25, // ~182.9px
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10, // Reduced from 15 for tighter fit
                      horizontal: 15,
                    ),
                    child: CustomBottomsheetScreen(),
                  ),
                );
              },
              fontSize: 12,
              textColor: Colors.white,
              bgColor: AppColor.positiveButton,
              width: 340 * 0.9,
              height: 49 * 0.9,
              borderRadius: 10,
              weight: FontWeight.w500,
            ),
          ),

        ],
      ),
    );
  }

  Widget textImage(String asset, String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
            Get.back();
          },
          child: Image.asset(asset, width: 20, height: 20),
        ),
        Expanded(
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 20.0,
                fontFamily: "Poppins-SemiBold",
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ),
      ],
    );
  }
}