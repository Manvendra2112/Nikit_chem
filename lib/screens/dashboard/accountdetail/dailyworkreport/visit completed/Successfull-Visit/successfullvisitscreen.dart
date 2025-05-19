import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import 'successfullvisitscreen_controller.dart';

class SuccessfullVisitScreen extends StatelessWidget {
  const SuccessfullVisitScreen({super.key});

  // Reusable function for order details rows
  Widget buildOrderRow(String leftText, String rightText, double fontSize, double spacing) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              leftText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin-Regular",
                color: AppColor.headingtext,
              ),
            ),
            Text(
              rightText,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w400,
                fontFamily: "Cabin-Regular",
                color: AppColor.headingtext,
              ),
            ),
          ],
        ),
        SizedBox(height: spacing),
        buildDivider(),
        SizedBox(height: spacing),
      ],
    );
  }

  // Reusable function for divider
  Widget buildDivider() {
    return Divider(
      color: AppColor.headingtext.withOpacity(0.5),
      height: 1,
      thickness: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    final double padding = width * 0.07; // Single padding ~14px on 360px
    final double fontSizeLarge = width * 0.05; // ~18px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = height * 0.02; // ~14px on 720px

    return GetBuilder<SuccessfullVisitController>(
        init: SuccessfullVisitController(),
    builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.all(padding),
            children: [
             // SizedBox(height: spacing * 2), // Top spacing
              // Back button
              Align(
                alignment: Alignment.topLeft,
                child: InkWell(
                  onTap: () {
                    print('Back button tapped');
                    Get.back();
                  },
                  child: Image.asset(
                    ImageAssets.backbutton,
                    width: width * 0.08, // ~30px
                    height: width * 0.08,
                  ),
                ),
              ),
             // SizedBox(height: spacing),
              // Title
              Center(
                child: Text(
                  "Successful Visit",
                  style: TextStyle(
                    fontSize: fontSizeLarge,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                    color: AppColor.headingtext,
                  ),
                ),
              ),
              SizedBox(height: spacing * 2),
              // Shop row
              Row(
                children: [
                  Container(
                    width: width * 0.08, // ~43px
                    height: width * 0.08,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFf4611f).withOpacity(0.2),
                    ),
                    child: Center(
                      child: Image.asset(
                        ImageAssets.dealericon,
                        width: width * 0.04, // ~22px
                        height: width * 0.04,
                      ),
                    ),
                  ),
                  SizedBox(width: spacing),
                  Text(
                    "Shop Name: ${controller.shopName}",
                    style: TextStyle(
                      fontSize: fontSizeMedium,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Cabin-Regular",
                      color: AppColor.headingtext,
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing * 2),
              // Interested container
              Container(
                padding: EdgeInsets.all(padding),
                decoration: BoxDecoration(
                  color:  Color(0xFFf4611f).withOpacity(0.10),
                  borderRadius: BorderRadius.circular(width * 0.03),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageAssets.ticknew,
                      width: width * 0.04, // ~22px
                      height: width * 0.04,
                    ),
                    SizedBox(width: spacing * 0.5),
                    Text(
                      "They are interested in Product",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Poppins-Medium",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: spacing * 2),
              // Order Details
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Order Details",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                    color: AppColor.headingtext,
                  ),
                ),
              ),
              SizedBox(height: height*0.03),
              buildOrderRow(
                "Selected Order:",
                controller.orderDetails['selectedOrder']!,
                14,
                spacing,
              ),
              buildOrderRow(
                "Quantity:",
                controller.orderDetails['quantity']!,
                14,
                spacing,
              ),
              buildOrderRow(
                "Price:",
                controller.orderDetails['price']!,
                14,
                spacing,
              ),
              buildOrderRow(
                "Scheme:",
                controller.orderDetails['scheme']!,
                14,
                spacing,
              ),
              buildOrderRow(
                "Total Price:",
                controller.orderDetails['totalPrice']!,
                14,
                spacing,
              ),
              SizedBox(height: height*0.02,),
              // Remarks
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Remarks",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                    color: AppColor.headingtext,
                  ),
                ),
              ),
              SizedBox(height: spacing),
              TextField(
                controller: controller.remarksController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText:
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  hintStyle: TextStyle(
                    fontSize: fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin-Regular",
                    color: AppColor.headingtext.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.2),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: height*0.05,)
            ],
          ),
        ),
      );
    }
    );

    }
  }