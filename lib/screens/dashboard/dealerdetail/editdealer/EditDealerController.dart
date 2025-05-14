import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditDealerController extends GetxController{
  TextEditingController nameContr =TextEditingController();
  TextEditingController phoneContr =TextEditingController();
  TextEditingController addressContr =TextEditingController();
  TextEditingController landmarkContr =TextEditingController();


  FocusNode nameFocus =FocusNode();
  FocusNode phoneFocus =FocusNode();
  FocusNode addressFocus =FocusNode();
  FocusNode landmarkFocus =FocusNode();

}