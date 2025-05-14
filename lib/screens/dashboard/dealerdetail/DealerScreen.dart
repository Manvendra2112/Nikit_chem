import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerController.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../constant/custom_widget.dart';
import '../../../support/alert_dialog_manager.dart';
import '../carpenter/AddCarpanterScreen.dart';
import 'adddelaer/AddDealerScreen.dart';

class DealerScreen extends StatelessWidget {
  const DealerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DealerController controller = Get.find<DealerController>();
    double width = CustomWidget.getWidth(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: RefreshIndicator(
        onRefresh: () async {
          await controller.fetchDealerData();
        },
        color: AppColor.positiveButton,
        child: Obx(
              () => ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 20),
              buildSearchField(controller),
              GestureDetector(
                onTap: () {
                  print("Navigating to AddDealerScreen");
                  Get.to(() => AddDealerScreen());
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                  child: Image.asset(
                    ImageAssets.dottedbutton,
                    width: 80,
                    height: 70,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              controller.filteredDealerData.isEmpty
                  ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  "No dealers available",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                  ),
                ),
              )
                  : controller.isExpanded.length != controller.filteredDealerData.length
                  ? const Padding(
                padding: EdgeInsets.all(20.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.positiveButton,
                  ),
                ),
              )
                  : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredDealerData.length,
                itemBuilder: (context, index) {
                  var dealer = controller.filteredDealerData[index];
                  return Column(
                    children: [
                      Container(
                        margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: AppColor.positiveButton),
                        ),
                        width: width * 0.9,
                        height: 99 * 0.9,
                        child: Row(
                          children: [
                            Container(
                              width: 26,
                              height: 26,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                color: AppColor.bgColor20.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Image.asset(
                                ImageAssets.dealericon,
                                width: 11,
                                height: 10,
                              ),
                            ),
                            const SizedBox(width: 3),
                            Expanded(
                              child: Text(
                                "Dealer: ${dealer['delearname']}",
                                maxLines: 2,
                                style: const TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 5),
                            CustomWidget.elevatedCustomButton(
                              context,
                              controller.isExpanded[index] ? "Hide Details" : "View Details",
                                  () {
                                controller.toggleExpansionTile(index);
                              },
                              width: 110,
                              height: 39,
                              fontSize: 12,
                              weight: FontWeight.w500,
                              textColor: Colors.white,
                              borderRadius: 10,
                              padding: const Padding(padding: EdgeInsets.all(2)),
                              bgColor: AppColor.positiveButton,
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: controller.isExpanded[index],
                        child: openContainerExpand(context, controller, dealer, index),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSearchField(DealerController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 2),
      decoration: BoxDecoration(
        color: AppColor.textFildbgcolor50.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller.searchTextCon,
        onChanged: (value) => controller.filterDealerData(),
        decoration: InputDecoration(
          hintText: "Search By Shop Name",
          hintStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColor.blackheading,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 12, 12),
            child: Image.asset(
              ImageAssets.search,
              width: 17,
              height: 17,
            ),
          ),
          suffixIcon: controller.searchTextCon.text.isNotEmpty
              ? IconButton(
            icon: const Icon(Icons.clear, size: 20),
            onPressed: () => controller.clearSearch(),
          )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        ),
      ),
    );
  }

  Widget openContainerExpand(
      BuildContext context, DealerController controller, dynamic dealer, int index) {
    final double popupWidth = MediaQuery.of(context).size.width * 0.8;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColor.positiveButton),
      ),
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Column(
        children: [
          buildTextView(ImageAssets.dealericon, "Dealer:", dealer['delearname']),
          const SizedBox(height: 5),
          buildTextView(ImageAssets.dealericon, "Address:", dealer['address'] ?? ""),
          const SizedBox(height: 5),
          buildTextView(
            ImageAssets.dealericon,
            "Client’s Shop Location",
            dealer['map_link'] ?? "",
            isLink: true,
          ),
          const SizedBox(height: 5),
          buildTextView(ImageAssets.dealericon, dealer['phone'], ""),
          const SizedBox(height: 5),
          buildTextView(
            ImageAssets.dealericon,
            "Total Visits:",
            dealer['totalVisits'].toString(),
          ),
          const SizedBox(height: 5),
          buildTextView(ImageAssets.dealericon, "Total Order:", dealer['total_orders']),
          const SizedBox(height: 5),
          buildTextView(ImageAssets.dealericon, "Success rate:", dealer['success_rate']),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.fromLTRB(10, 5, 5, 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColor.bgColor20.withOpacity(0.2),
            ),
            width: 390 * 0.9,
            height: 60 * 0.9,
            child: Row(
              children: [
                Image.asset(
                  ImageAssets.circleimage,
                  width: 18,
                  height: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "No. Of Carpenter - ${dealer['totalCarpenters']}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Poppins-Medium",
                  ),
                ),
                const Spacer(),
                CustomWidget.elevatedCustomButton(
                  context,
                  "View Details",
                      () {
                    if (dealer['carpenderList'].isNotEmpty) {
                      Get.dialog(
                        Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Container(
                            width: popupWidth,
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
                                     // dealerName: dealer['delearname'] ?? '',
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
                    } else {
                      AlertDialogManager.getSnackBarMsg(
                        "Info",
                        "No carpenters available",
                        false,
                        context,
                      );
                    }
                  },
                  width: 110 * 0.9,
                  height: 33 * 0.9,
                  borderColor: Colors.transparent,
                  bgColor: AppColor.white,
                  textColor: AppColor.blackheading,
                  fontSize: 10,
                  padding: const Padding(padding: EdgeInsets.all(3)),
                  borderRadius: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          CustomWidget.elevatedCustomButton(
            context,
            "I have Arrived at the location",
                () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 0),
                  child: const SizedBox(), // Replace with CustomBottomsheetScreen if available
                ),
              );
            },
            fontSize: 12,
            textColor: Colors.white,
            bgColor: AppColor.positiveButton,
            width: 390 * 0.9,
            height: 50 * 0.9,
            borderRadius: 10,
          ),
        ],
      ),
    );
  }

  Widget buildTextView(String asset, String label, String value, {bool isLink = false}) {
    return Row(
      children: [
        Container(
          width: 26,
          height: 26,
          decoration: BoxDecoration(
            color: AppColor.bgColor20.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              asset,
              width: 11,
              height: 10,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Container(
          width: 110,
          child: isLink && value.isNotEmpty
              ? GestureDetector(
            onTap: () async {
              final url = Uri.parse(value);
              if (await canLaunchUrl(url)) {
                await launchUrl(url, mode: LaunchMode.externalApplication);
              } else {
                Get.snackbar("Error", "Could not open the map link");
              }
            },
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          )
              : Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isLink ? Colors.blue : AppColor.blackheading,
            ),
          ),
        ),
        Expanded(
          child: Text(
            isLink ? "" : value,
            maxLines: 2,
            style: const TextStyle(
              fontFamily: "Poppins-Medium",
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: AppColor.blackheading,
            ),
          ),
        ),
      ],
    );
  }
}