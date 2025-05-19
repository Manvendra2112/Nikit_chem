import 'package:get/get.dart';

class VisitCompletedNewController extends GetxController {
  // Static data
  String location = "Ambala, Panjab";
  String date = "01 April, 2025";

  // Dummy user list
  List<Map<String, dynamic>> users = [
    {'name': 'Sharma Hardware', 'navigate': false},
    {'name': 'Ahuja Hardware', 'navigate': false},
    {'name': 'Gupta Hardware', 'navigate': true},
  ];
  // For testing empty case, comment out above and use:
  // List<Map<String, dynamic>> users = [];

  // Check if user list is empty
  bool isUsersEmpty() {
    return users.isEmpty;
  }

  // Handle Successful Visit button tap
  void handleSuccessfulVisitButton() {
    print('Successful Visit button tapped');
    // Add logic (e.g., update state, API call)
  }

  // Handle Non - Interested button tap
  void handleNonInterestedButton() {
    print('Non - Interested button tapped');
    // Add logic
  }

  // Handle user container tap
  void handleUserTap(String userName) {
    print('Tapped $userName');
    if (userName == 'Gupta Hardware') {
      print('Navigating to SuccessfullVisitCompletedScreen for $userName');
     // Get.to(() => SuccessfullVisitCompletedScreen());
    }
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}