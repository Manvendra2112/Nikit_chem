import 'package:get/get.dart';

class VisitNotCompletedController extends GetxController{
  bool isUsingProduct = true;
  String quantity = '';
  String selectedPeriod = 'Month';
  DateTime? expectedOrderDate;
  final List<String> periods = ['Month', 'Week', 'Day'];

  void toggleProductUsage(bool value) {
    isUsingProduct = value;
    update();
  }

  void setQuantity(String value) {
    quantity = value;
    update();
  }

  void setPeriod(String value) {
    selectedPeriod = value;
    update();
  }

  void setExpectedOrderDate(DateTime? date) {
    expectedOrderDate = date;
    update();
  }

  void submit() {
    // Handle submit action here
    print('Submitted: Using Product: $isUsingProduct, Quantity: $quantity, Period: $selectedPeriod, Expected Date: $expectedOrderDate');
  }


}