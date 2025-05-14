import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nikitchem/constant/api_constant.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInController.dart';
import 'package:nikitchem/screens/login/LoginScreen.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import '../../support/app_theme.dart';

class DashboardController extends GetxController {
  final BuildContext context;
  DashboardController(this.context);

  final RxInt selectedIndex = 0.obs;
  final RxBool needRefresh = false.obs;
  TextEditingController searchTextCon = TextEditingController();
  FocusNode searchFocus = FocusNode();
  ScrollController scrollHomeController = ScrollController();
  var selectedDateIndex = 0;
  List<Map<String, String>> dateList = [];

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      // Validate and set selectedIndex
      final index = Get.arguments['selectedIndex'];
      if (index is int && index >= 0 && index <= 4) {
        selectedIndex.value = index;
        print("Set selectedIndex to $index from arguments");
      } else {
        selectedIndex.value = 0;
        print("Invalid or missing selectedIndex, defaulting to 0");
      }
      // Handle refresh argument
      if (Get.arguments['refresh'] == true) {
        Get.put(PunchInController(context));
        if (selectedIndex.value == 3) {
          needRefresh.value = true;
          print("Set needRefresh to true for DealerScreen");
        }
      }
    }
  }

  @override
  void onClose() {
    // Avoid disposing searchTextCon since IndexedStack keeps screens alive
    // searchTextCon.dispose();
    searchFocus.dispose();
    scrollHomeController.dispose();
    super.onClose();
  }

  void changeTab(int index, {bool refresh = false}) {
    if (index >= 0 && index <= 4) {
      selectedIndex.value = index;
      print("Changed tab to index: $index");
      if (index == 3 && refresh) {
        needRefresh.value = true;
        print("Set needRefresh to true for DealerScreen");
      } else {
        needRefresh.value = false;
      }
      update();
    } else {
      print("Invalid tab index: $index");
    }
  }

  void selectDate(int index) {
    selectedDateIndex = index;
    update();
  }

  void logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await PreferenceManager.instance.logout();
                searchTextCon.dispose();
                Get.offAll(() => LoginScreen());
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}