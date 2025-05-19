import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../support/app_theme.dart';
import '../dailyworkreport/visit completed/visitcompleted_screen.dart';
import '../dailyworkreport/visit not completed/visitnotcompletedscreen.dart';

class MonthlyAttendanceReportController extends GetxController {
  // TextField controllers
  final TextEditingController yearController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  // Show popup with text fields and submit button
  void showReportPopup(BuildContext context, {required bool isSuccessful}) {
    final double width = MediaQuery.of(context).size.width;
    final double padding = width * 0.07; // Single padding ~14px on 360px
    final double fontSizeMedium = width * 0.045; // ~16px
    final double fontSizeSmall = width * 0.04; // ~14px
    final double spacing = MediaQuery.of(context).size.height * 0.02; // ~14px on 720px
    final double height = MediaQuery.of(context).size.height; // ~14px on 720px

    // Clear previous inputs
    yearController.clear();
    monthController.clear();
    dateController.clear();

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(width * 0.03),
          ),
          contentPadding: EdgeInsets.all(padding),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select Month, Date & Day",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Poppins-Medium",
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: height*0.03),
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Year",
                  hintStyle: TextStyle(
                    fontSize: fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin-Regular",
                    color: AppColor.headingtext.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: spacing),
              TextField(
                controller: monthController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Month",
                  hintStyle: TextStyle(
                    fontSize: fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin-Regular",
                    color: AppColor.headingtext.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: spacing),
              TextField(
                controller: dateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Enter Date",
                  hintStyle: TextStyle(
                    fontSize: fontSizeSmall,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Cabin-Regular",
                    color: AppColor.headingtext.withOpacity(0.5),
                  ),
                  filled: true,
                  fillColor: const Color(0xFFD9D9D9).withOpacity(0.5),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(width * 0.03),
                    borderSide: BorderSide.none,
                  ),
                ),
                style: TextStyle(
                  fontSize: fontSizeSmall,
                  fontWeight: FontWeight.w400,
                  fontFamily: "Cabin-Regular",
                  color: AppColor.headingtext,
                ),
              ),
              SizedBox(height: spacing * 2),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (validateInputs(context)) {
                      // Close the dialog
                      Navigator.of(dialogContext).pop();
                      if (isSuccessful) {
                        print('Navigating to VisitCompletedScreenNew');
                        Get.to(() => VisitCompletedScreenNew());
                      } else {
                        print('Navigating to VisitNotCompletedScreenNew');
                        Get.to(() => VisitNotCompletedScreenNew());
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFf4611f),
                    padding: EdgeInsets.symmetric(vertical: height * 0.015),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(width * 0.03),
                    ),
                  ),
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Poppins-Medium",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // Validate text field inputs
  bool validateInputs(BuildContext context) {
    final year = yearController.text.trim();
    final month = monthController.text.trim();
    final date = dateController.text.trim();

    // Check if fields are empty
    if (year.isEmpty || month.isEmpty || date.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields correctly")),
      );
      return false;
    }

    // Validate year (4 digits)
    if (!RegExp(r'^\d{4}$').hasMatch(year)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid 4-digit year")),
      );
      return false;
    }

    // Validate month (1-12)
    final monthNum = int.tryParse(month);
    if (monthNum == null || monthNum < 1 || monthNum > 12) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid month (1-12)")),
      );
      return false;
    }

    // Validate date (1-31)
    final dateNum = int.tryParse(date);
    if (dateNum == null || dateNum < 1 || dateNum > 31) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid date (1-31)")),
      );
      return false;
    }

    return true;
  }

  @override
  void onClose() {
    yearController.dispose();
    monthController.dispose();
    dateController.dispose();
    super.onClose();
  }
}