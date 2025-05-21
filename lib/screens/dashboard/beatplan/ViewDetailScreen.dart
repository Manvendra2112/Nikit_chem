import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetScreen.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailController.dart';
import 'package:nikitchem/screens/dashboard/carpenter/AddCarpanterScreen.dart';
import '../../../support/app_theme.dart';
import '../../../support/imageassets.dart';
import 'beatvisit_model.dart';

class ViewDetailScreen extends StatelessWidget {
  ViewDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewDetailController>(
      init: ViewDetailController(),
      builder: (controller) {
        return Obx(
              () => Scaffold(
            backgroundColor: Colors.white,
            body: controller.dealer.value == null
                ? Center(
              child: Text(
                "No dealer data available",
                style: TextStyle(
                  fontFamily: "Poppins-Medium",
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
            )
                : Column(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(25, 60, 25, 15),
                  child: textImage(
                      ImageAssets.backbutton, controller.dealer.value!.delearname),
                ),
                openContainerExpand(context, controller.dealer.value!),
              ],
            ),
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
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.info, size: 10),
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
            Expanded(
              child: Text(
                value,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontFamily: "Metropolis-Regular",
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget openContainerExpand(BuildContext context, Dealer dealer) {
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
          buildTextView(ImageAssets.dealericon, "Dealer:", dealer.delearname),
          SizedBox(height: 5),
          buildTextView(ImageAssets.address, "Address:", dealer.address),
          SizedBox(height: 5),
          buildTextView(ImageAssets.locationnew, "City:", dealer.city),
          SizedBox(height: 5),
          buildTextView(ImageAssets.phone, "Phone:", dealer.phone),
          SizedBox(height: 5),
          buildTextView(ImageAssets.totalvisit, "Total Visits:", dealer.totalVisits.toString()),
          SizedBox(height: 5),
          buildTextView(ImageAssets.totalorder, "Total Orders:", dealer.totalOrders),
          SizedBox(height: 5),
          buildTextView(ImageAssets.successrate, "Success Rate:", dealer.successRate),
          SizedBox(height: 5),
          SizedBox(height: 15),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02,
              vertical: MediaQuery.of(context).size.height * 0.015,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.bgColor20.withOpacity(0.2),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImageAssets.circleimage,
                  width: MediaQuery.of(context).size.width * 0.055,
                  height: MediaQuery.of(context).size.width * 0.06,
                  errorBuilder: (context, error, stackTrace) => Icon(Icons.group, size: 20),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                Text(
                  "No. Of Carpenters: ${dealer.carpenderList.length}",
                  style: TextStyle(
                    fontFamily: "Poppins-Medium",
                    fontSize: 11 * (MediaQuery.of(context).size.width / 360),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.32,
                    ),
                    child: CustomWidget.elevatedCustomButton(
                      context,
                      "View Details",
                          () {
                        Get.dialog(
                          Dialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              constraints: BoxConstraints(
                                minWidth: 280,
                                maxWidth: 400,
                              ),
                              padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Dealer’s Carpenter List",
                                    style: TextStyle(
                                      fontSize: 16 * (MediaQuery.of(context).size.width / 360),
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Poppins-SemiBold",
                                    ),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                                  dealer.carpenderList.isEmpty
                                      ? Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: MediaQuery.of(context).size.height * 0.02),
                                    child: Text(
                                      "No carpenters available",
                                      style: TextStyle(
                                        fontSize: 14 * (MediaQuery.of(context).size.width / 360),
                                        fontFamily: "Poppins-Medium",
                                        color: Colors.grey,
                                      ),
                                    ),
                                  )
                                      : Column(
                                    children: dealer.carpenderList.map<Widget>((carpenter) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: MediaQuery.of(context).size.height * 0.01),
                                        child: Row(
                                          children: [
                                            CircleAvatar(
                                              radius: MediaQuery.of(context).size.width * 0.055,
                                              backgroundImage: AssetImage(ImageAssets.profilenew),
                                            ),
                                            SizedBox(width: MediaQuery.of(context).size.width * 0.025),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    carpenter.name,
                                                    style: TextStyle(
                                                      fontSize:
                                                      14 * (MediaQuery.of(context).size.width / 360),
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "Poppins-Medium",
                                                    ),
                                                  ),
                                                  Text(
                                                    "${carpenter.role}, ${carpenter.city ?? 'Unknown'}",
                                                    style: TextStyle(
                                                      fontSize:
                                                      12 * (MediaQuery.of(context).size.width / 360),
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: "Poppins-Medium",
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                  SizedBox(height: MediaQuery.of(context).size.height * 0.025),
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                      print("Navigating to AddCarpanterScreen with dealerId: ${dealer.id}");
                                      Get.to(() => AddCarpanterScreen(
                                        dealerId: dealer.id.toString(),
                                      ));
                                    },
                                    child: Image.asset(
                                      ImageAssets.dottedbutton,
                                      width: MediaQuery.of(context).size.width * 0.9,
                                      height: MediaQuery.of(context).size.height * 0.06,
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.05,
                      borderColor: Colors.transparent,
                      bgColor: AppColor.white,
                      weight: FontWeight.w500,
                      textColor: AppColor.blackheading,
                      fontSize: 9 * (MediaQuery.of(context).size.width / 360),
                      borderRadius: 10,
                    ),
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
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => Container(
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
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
                    height: MediaQuery.of(context).size.height * 0.25,
                    decoration: BoxDecoration(
                      color: AppColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
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
          child: Image.asset(
            asset,
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) => Icon(Icons.arrow_back, size: 20),
          ),
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