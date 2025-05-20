import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:nikitchem/constant/custom_widget.dart';
import 'package:nikitchem/screens/dashboard/beatplan/ViewDetailScreen.dart';
import 'package:nikitchem/support/app_theme.dart';
import 'package:nikitchem/support/imageassets.dart';
import 'package:nikitchem/support/PreferenceManager.dart';
import 'package:nikitchem/constant/constant_string.dart';
import 'dart:convert';

import 'carpanterscreen_model.dart';

class CarpenterController extends GetxController {
  bool isBottomSheetOpen = false;
  var isExpand = <int, bool>{}.obs; // Track expansion state per carpenter
  var carpenters = <CarpenterModel>[].obs; // All carpenters from API
  var filteredCarpenters = <CarpenterModel>[].obs; // Filtered carpenters for search
  var isLoading = false.obs;
  final searchController = TextEditingController();
  var isScreenActive = false.obs; // Track if CarpanterScreen is visible

  @override
  void onInit() {
    super.onInit();
    searchController.addListener(_filterCarpenters);
  }

  void onScreenOpened() {
    isScreenActive.value = true;
    if (carpenters.isEmpty) {
      fetchCarpenters();
    }
  }

  void onScreenClosed() {
    isScreenActive.value = false;
  }

  void toggleExpansionTile(int carpenterId) {
    isExpand[carpenterId] = !(isExpand[carpenterId] ?? false);
    update();
  }

  Future<void> fetchCarpenters() async {
    isLoading.value = true;
    try {
      String? userId = await PreferenceManager.instance.getString(ConstantString.userIdKey);
      String? token = await PreferenceManager.instance.getString(ConstantString.tokenKey);

      if (userId == null || userId.isEmpty || token == null || token.isEmpty) {
        if (isScreenActive.value && !Get.isSnackbarOpen) {
          Get.snackbar('Error', 'User ID or token not found. Please log in again.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
        return;
      }

      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://pob.volvrit.in/api/v1/users/my-carpenters'),
      );

      request.fields.addAll({
        'user_id': userId,
      });

      request.headers.addAll({
        'Accept': 'application/json',
        'Cookie': token,
      });

      http.StreamedResponse response = await request.send();
      String responseBody = await response.stream.bytesToString();
      var responseJson = jsonDecode(responseBody);

      print("Carpenter List Response: ${response.statusCode} - $responseBody");

      if (response.statusCode == 200 && responseJson['code'] == 200) {
        carpenters.value = carpenterListFromJson(responseBody);
        filteredCarpenters.value = carpenters;
        if (isScreenActive.value && !Get.isSnackbarOpen) {
         // Get.snackbar('Success', responseJson['message'],
             // backgroundColor: Colors.green, colorText: Colors.white);
        }
      } else {
        if (isScreenActive.value && !Get.isSnackbarOpen) {
          Get.snackbar('Error', responseJson['message'] ?? 'Failed to fetch carpenters',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } catch (e) {
      print("Carpenter Fetch Exception: $e");
      if (isScreenActive.value && !Get.isSnackbarOpen) {
        Get.snackbar('Error', 'Network error: Unable to fetch carpenters',
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } finally {
      isLoading.value = false;
    }
  }

  void _filterCarpenters() {
    String query = searchController.text.trim().toLowerCase();
    if (query.isEmpty) {
      filteredCarpenters.value = carpenters;
    } else {
      filteredCarpenters.value = carpenters
          .where((carpenter) =>
          carpenter.carpenterName.toLowerCase().contains(query))
          .toList();
    }
  }

  void showDealerListDialog(BuildContext context, DealerModel dealer) {
    final double screenWidth = CustomWidget.getWidth(context);
    final double screenHeight = CustomWidget.getHeight(context);

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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      ImageAssets.profilenew,
                      width: 40,
                      height: 40,
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dealer.name,
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "Poppins-Medium",
                              fontWeight: FontWeight.w500,
                              color: AppColor.blackheading,
                            ),
                          ),
                          Text(
                            dealer.address,
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
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: CustomWidget.elevatedCustomButton(
                  context,
                  "View Details",
                      () => Get.to(() => ViewDetailScreen(
                    // dealerName: dealer.name,
                    // dealerAddress: dealer.address,
                  )),
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

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}