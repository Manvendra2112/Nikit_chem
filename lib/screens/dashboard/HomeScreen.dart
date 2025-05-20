import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/screens/customUI/CustomBottomSheetScreen.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/HomeScreenController.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInController.dart';
import 'package:nikitchem/support/flutter_font_style.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../constant/custom_widget.dart';
import '../../support/alert_dialog_manager.dart';
import '../../support/app_theme.dart';
import '../Notification Screen/notification_screen.dart';
import 'carpenter/AddCarpanterScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final PunchInController controllerpunchin = Get.find<PunchInController>();
    final HomeScreenController controller = Get.find<HomeScreenController>();

    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);

    return ScaffoldMessenger(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: RefreshIndicator(
          onRefresh: () async {
            await controller.fetchVisitData();
          },
          color: AppColor.positiveButton,
          child: Obx(
                () => ListView(
              shrinkWrap: true,
              children: [
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          ImageAssets.profilenew,
                          height: height * 0.06,
                          width: width * 0.15,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: width * 0.02),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hi, ${controller.loginModel != null ? controller.loginModel['user']['name'] ?? 'User' : 'User'}",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                fontFamily: "Poppins-SemiBold",
                              ),
                            ),
                            const Text(
                              "Welcome to Nikit Chem",
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w400,
                                fontFamily: "Poppins-SemiBold",
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          ImageAssets.location,
                          width: 41,
                          height: 41,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => const NotificationScreen()),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColor.positiveButton,
                          ),
                          child: Center(
                            child: Image.asset(
                              ImageAssets.notification,
                              width: 20,
                              height: 20,
                            ),
                          ),
                        ),
                      ),                    ],
                  ),
                ),
                buildSearchField(controller),
                SizedBox(height: height*0.015,),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  padding: EdgeInsets.all(35),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.bgColor20.withOpacity(0.2),
                  ),
                  width: 390 * 0.9,
                  height: 110 * 0.8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        controllerpunchin.isPunchedIn
                            ? "Punch - In ${controllerpunchin.punchInTime.isNotEmpty ? controllerpunchin.punchInTime : controllerpunchin.formattedTime}, ${controllerpunchin.formattedDate}"
                            : "Punch - Out ${controllerpunchin.punchOutTime}",
                        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 30,
                        height: 20,
                        child: Switch(
                          value: controllerpunchin.isPunchedIn,
                          onChanged: (value) async {
                            controllerpunchin.toggleFeature(value);
                            if (!value) {
                              await controllerpunchin.punchOut();
                            }
                          },
                          activeColor: AppColor.positiveButton,
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.01,),
                Padding(
                  padding: EdgeInsets.only(left: width*0.06,right:width*0.06 ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Track your Location',style: FTextStyle.custom(fontSize: 16,fontWeight: FontWeight.w500,color: AppColor.blackheading),),
                      SizedBox(height: height*0.02,),
                      Image.asset(ImageAssets.maps)
                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),

                Container(
                  margin: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColor.bgColor20.withOpacity(0.2),
                  ),
                  width: 390 * 0.9,
                  height: 70 * 0.9,
                  child: Row(
                    children: [
                      // Image.asset(
                      //   ImageAssets.locationadd,
                      //   width: 17,
                      //   height: 19,
                      // ),
                      const SizedBox(width: 5),
                      Text(
                        controller.selectedLocation ?? "Today’s Beat Plan",
                        maxLines: 2,
                        style: const TextStyle(fontFamily: "Poppins-Medium", fontSize: 12),
                      ),
                      const Spacer(),
                      CustomWidget.elevatedCustomButton(
                        context,
                        "View Plan",
                            () {
                          //controller.openLocationDialog();
                              Get.offAll(
                                    () => const DashboardScreen(),
                                arguments: {'selectedIndex': 1, 'refresh': true},
                              );
                        },
                        width: 125 * 0.9,
                        height: 39 * 0.9,
                        padding: const Padding(padding: EdgeInsets.all(1)),
                        bgColor: Colors.white,
                        textColor: Colors.black,
                        weight: FontWeight.w500,
                        fontSize: 10,
                        borderRadius: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height*0.02,),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Text(
                    "Today’s Assigned Task",
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                      fontFamily: "Poppins-Medium",
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 5),
                  child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing ",style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                    fontFamily: "Poppins-Medium",
                  ),),
                ),
                controller.filteredVisitData.isEmpty
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
                    : controller.isExpanded.length != controller.filteredVisitData.length
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
                  itemCount: controller.filteredVisitData.length,
                  itemBuilder: (context, index) {
                    var dealer = controller.filteredVisitData[index];
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColor.positiveButton),
                          ),
                          width: 410 * 0.9,
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
      ),
    );
  }

  Widget buildSearchField(HomeScreenController controller) {
    return Container(
      margin: const EdgeInsets.fromLTRB(15, 10, 15, 2),
      decoration: BoxDecoration(
        color: AppColor.textFildbgcolor50.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller.searchTextCon,
        onChanged: (value) => controller.filterVisitData(),
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
      BuildContext context, HomeScreenController controller, dynamic dealer, int index) {
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
                                    Get.to(() => AddCarpanterScreen(
                                      dealerId: dealer['id']?.toString() ?? '',
                                      //dealerName: dealer['delearname'] ?? '',
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
              // showModalBottomSheet(
              //   context: context,
              //   isScrollControlled: true,
              //   builder: (context) => Container(
              //     height: MediaQuery.of(context).size.height * 0.2,
              //     decoration: const BoxDecoration(
              //       color: AppColor.white,
              //       borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(40),
              //         topRight: Radius.circular(40),
              //       ),
              //     ),
              //     padding: const EdgeInsets.only(top: 10, right: 15, left: 15, bottom: 0),
              //     child: CustomBottomsheetScreen(),
              //   ),
              // );
            },
            fontSize: 12,
            textColor: Colors.white,
            bgColor: AppColor.positiveButton,
            width: 390 * 0.9,
            height: 50 * 0.9,
            borderRadius: 10,
            weight: FontWeight.w500,

          ),
          const SizedBox(height: 15),

          CustomWidget.elevatedCustomButton(
            context,
            "Visit Completed",
                () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => Container(
                  height: MediaQuery.of(context).size.height * 0.2, // ~146.3px
                  decoration: const BoxDecoration(
                    color: AppColor.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  child: CustomBottomsheetScreen(),
                ),
              );
            },
            fontSize: 12,
            textColor: Colors.white,
            bgColor: AppColor.positiveButton,
            width: 390 * 0.9,
            height: 50 * 0.9,
            borderRadius: 10,
            weight: FontWeight.w500,
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