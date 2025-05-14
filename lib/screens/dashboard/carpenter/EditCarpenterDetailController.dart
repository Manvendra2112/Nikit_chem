import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditCarpenterDetailController extends GetxController{

TextEditingController nameContr =TextEditingController();
TextEditingController phoneContr =TextEditingController();
TextEditingController addressContr =TextEditingController();
TextEditingController remarksContr =TextEditingController();
String selectedDealer="";

FocusNode nameFocus =FocusNode();
FocusNode phoneFocus =FocusNode();
FocusNode addressFocus =FocusNode();
FocusNode remarksFocus =FocusNode();
FocusNode dealerFocus =FocusNode();


final List<String> dealerOptions = [
  "2",
  "3",
  "5",
  "7",
  "9",
  "10"
];
}