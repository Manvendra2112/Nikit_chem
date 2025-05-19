import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class VisitCompletedController extends GetxController{

TextEditingController remarksController =TextEditingController();
TextEditingController productContro =TextEditingController();
TextEditingController priceController =TextEditingController();
TextEditingController discountController =TextEditingController();
TextEditingController totalpriceController =TextEditingController();
String selectedquantity = "";
String selectedproduct = "";
bool isUsingProduct = true;
FocusNode remarksFocus =FocusNode();
FocusNode productFocus =FocusNode();
FocusNode priceFocus =FocusNode();
FocusNode discountFocus =FocusNode();
FocusNode totalPriceFocus =FocusNode();
FocusNode quantityFocus =FocusNode();

final List<String> quantityOptions = [
  "2",
  "3",
  "5",
  "7",
  "9",
  "10"
];
final List<String> productOptions = [
  "paint 1",
  "paint 2",
  "paint 3",
  "paint 4",
  "paint 5",
  "paint 6"
];

//radio button
void toggleProductUsage(bool value) {
  isUsingProduct = value;
  update();
}


@override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    selectedquantity = quantityOptions[0];
    selectedproduct=productOptions[0];
  }

void updateSelectedSkill(String newSkill) {
selectedquantity=newSkill;
selectedproduct=newSkill;
// selectedLanguage = newSkill;
  update();
// Optional: Add logic for when skill changes (e.g., save to backend)
  print('Selected skill: $selectedquantity');
}

String? getIndustrySkill() {
  return selectedquantity;
}

  String? getProductSkill() {
    return selectedproduct;
  }
}