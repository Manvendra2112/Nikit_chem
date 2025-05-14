import 'package:get/get.dart';
import 'package:nikitchem/screens/login/LoginScreen.dart';
import 'package:nikitchem/screens/register screen/regester_screen.dart';

class SelectionScreenController extends GetxController {
  void navigateToLogin() {
    Get.to(() => LoginScreen());
  }

  void navigateToRegister() {
    Get.to(() => RegesterScreen());
  }
}