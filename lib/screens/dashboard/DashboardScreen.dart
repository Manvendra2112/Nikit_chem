import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/DashboardController.dart';
import 'package:nikitchem/screens/dashboard/HomeScreen.dart';
import 'package:nikitchem/screens/dashboard/HomeScreenController.dart';
import 'package:nikitchem/screens/dashboard/accountdetail/AccountDetailScreen.dart';
import 'package:nikitchem/screens/dashboard/beatplan/BeatPlanScreen.dart';
import 'package:nikitchem/screens/dashboard/carpenter/CarpanterScreen.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerScreen.dart';
import 'package:nikitchem/screens/dashboard/dealerdetail/DealerController.dart';
import 'package:nikitchem/support/imageassets.dart';
import '../../support/app_theme.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double width = CustomWidget.getWidth(context);
    double height = CustomWidget.getHeight(context);

    // Initialize controllers once
    Get.put(DashboardController(context));
    Get.put(HomeScreenController(context));
    Get.put(DealerController(context));

    return GetBuilder<DashboardController>(
      builder: (controller) {
        print("Building DashboardScreen with selectedIndex: ${controller.selectedIndex.value}");
        return SafeArea(
          child: Scaffold(
            resizeToAvoidBottomInset: true, // Ensure scaffold resizes for keyboard
            backgroundColor: Colors.grey.shade200,
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Column(
                  children: [
                    SizedBox(
                      height: height - 65 - MediaQuery.of(context).padding.top, // Adjust for nav bar and status bar
                      child: IndexedStack(
                        index: controller.selectedIndex.value,
                        children: [
                          const HomeScreen(),
                          BeatPlanScreen(),
                          CarpanterScreen(),
                          const DealerScreen(),
                          AccountDetailScreen(),
                        ],
                      ),
                    ),
                    getCustomBottomNavigation(context, controller),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget getCustomBottomNavigation(BuildContext context, DashboardController controller) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        color: AppColor.white,
        boxShadow: [
          BoxShadow(color: Colors.grey.shade200, spreadRadius: 4, blurRadius: 4),
        ],
      ),
      child: Row(
        children: [
          buildNavItem(
            context: context,
            controller: controller,
            index: 0,
            activeIcon: ImageAssets.homecolored,
            inactiveIcon: ImageAssets.homeblacknew,
            label: "Home",
          ),
          buildNavItem(
            context: context,
            controller: controller,
            index: 1,
            activeIcon: ImageAssets.calandercolor,
            inactiveIcon: ImageAssets.calanderblack,
            label: "Beat Plan",
          ),
          buildNavItem(
            context: context,
            controller: controller,
            index: 2,
            activeIcon: ImageAssets.carpaintercolored,
            inactiveIcon: ImageAssets.calanderblack,
            label: "Carpenter",
          ),
          buildNavItem(
            context: context,
            controller: controller,
            index: 3,
            activeIcon: ImageAssets.dealercolored,
            inactiveIcon: ImageAssets.dealericon,
            label: "Dealers",
          ),
          buildNavItem(
            context: context,
            controller: controller,
            index: 4,
            activeIcon: ImageAssets.settingscolored,
            inactiveIcon: ImageAssets.settingblackicon,
            label: "Account",
          ),
        ],
      ),
    );
  }

  Widget buildNavItem({
    required BuildContext context,
    required DashboardController controller,
    required int index,
    required String activeIcon,
    required String inactiveIcon,
    required String label,
  }) {
    return InkWell(
      hoverColor: Colors.white,
      highlightColor: Colors.transparent,
      onTap: () => controller.changeTab(index),
      child: Container(
        width: Get.width / 5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              controller.selectedIndex.value == index ? activeIcon : inactiveIcon,
              height: 22,
              width: 22,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error, color: Colors.red);
              },
            ),
            Text(
              label,
              style: TextStyle(
                color: controller.selectedIndex.value == index ? AppColor.positiveButton : AppColor.blackheading,
              ),
            ),
          ],
        ),
      ),
    );
  }
}