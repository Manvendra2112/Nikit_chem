import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

class CarpenterController extends GetxController {
  bool isBottomSheetOpen = false;
  bool isExpand = false;

  // Single dealer data
  final RxList<Map<String, dynamic>> dealers = <Map<String, dynamic>>[
    {
      'name': 'Sharma Hardware',
      'address': 'Dealer, Kamrudin nagar',
      'imagePath': ImageAssets.profilenew,
    },
  ].obs;

  void toggleExpansionTile() {
    isExpand = !isExpand;
    update();
  }

  void showDealerListDialog(BuildContext context) {
    final double screenWidth = CustomWidget.getWidth(context);
    final double screenHeight = CustomWidget.getHeight(context);
    final dealer = dealers[0]; // Single dealer

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          width: screenWidth * 0.8,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Title
              Text(
                "Carpenter’s Dealer List",
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Poppins-Medium",
                  fontWeight: FontWeight.w500,
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: 20),
              // Dealer Row
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Dealer Image
                    Image.asset(
                      dealer['imagePath'],
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 12),
                    // Dealer Details
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dealer['name'],
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins-Medium",
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackheading,
                            ),
                          ),
                          Text(
                            dealer['address'],
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "Poppins-Regular",
                              color: Color(0xffA0A0A0),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // View Details Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "View Details",
                      () => Get.to(() => ViewDetailScreen()),
                  width: screenWidth * 0.8 - 40,
                  height: 40,
                  fontSize: 12,
                  textColor: Colors.white,
                  bgColor: AppColor.positiveButton,
                  borderRadius: 10,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}