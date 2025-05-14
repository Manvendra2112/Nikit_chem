import 'package:get/get.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/support/PreferenceManager.dart';

import '../screens/SelectionScreen/SelectionScreen.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    checkUserLoginStatus();
  }

  Future<void> checkUserLoginStatus() async {
    try {
      await Future.delayed(const Duration(seconds: 3));
      String userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      print("User ID: $userId");
      if (userId.isNotEmpty) {
        Get.offAll(() => DashboardScreen(), arguments: {'refresh': true});
      } else {
        Get.offAll(() => SelectionScreen());
      }
    } catch (e) {
      print("Error checking login status: $e");
      Get.offAll(() => SelectionScreen());
    }
  }
}