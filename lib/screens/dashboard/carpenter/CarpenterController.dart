import 'package:get/get.dart';

class CarpenterController extends GetxController{

  bool isBottomSheetOpen = false;
  bool isExpand = false;
  void toggleExpansionTile() {
    isExpand = !isExpand;
    update();

  }


}