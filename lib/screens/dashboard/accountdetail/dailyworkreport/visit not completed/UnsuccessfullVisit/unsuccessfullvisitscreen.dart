import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';

import 'unsuccessfullvisit_controller.dart';

class UnSuccessfullVisitScreen extends StatelessWidget {
  const UnSuccessfullVisitScreen({super.key});

  // Reusable function for order details rows
  Widget buildOrderRow(String leftText, String rightText, double fontSize, double spacing) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                leftText,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Flexible(
              child: Text(
                rightText,
                style: TextStyle(
                  fontSize: fontSize,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
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

    return GetBuilder<UnSuccessfullVisitController>(
      init: UnSuccessfullVisitController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    // Title
                    Center(
                      child: Text(
                        "Unsuccessful Visit",
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
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: spacing * 2),
                    // Not interested container
                    Container(
                      padding: EdgeInsets.all(padding),
                      decoration: BoxDecoration(
                        color: const Color(0xFFf4611f).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(width * 0.03),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            ImageAssets.nontick,
                            width: width * 0.04, // ~22px
                            height: width * 0.04,
                          ),
                          SizedBox(width: spacing * 0.5),
                          Text(
                            "They are not interested",
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
                    buildOrderRow(
                      "They are using our products",
                      controller.orderDetails['usingProducts']!,
                      14,
                      spacing,
                    ),
                    buildOrderRow(
                      "How much they are using",
                      controller.orderDetails['usageQuantity']!,
                      14,
                      spacing,
                    ),
                    buildOrderRow(
                      "Last Order Details",
                      controller.orderDetails['lastOrder']!,
                      14,
                      spacing,
                    ),
                    buildOrderRow(
                      "Next Expected Order Date",
                      controller.orderDetails['nextOrderDate']!,
                      14,
                      spacing,
                    ),

                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}