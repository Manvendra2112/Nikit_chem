import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../DashboardScreen.dart';

class VisitCompletedController extends GetxController {
  TextEditingController remarksController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController totalPriceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  String selectedProduct = "";
  String selectedPacking = "";
  bool isUsingProduct = true;
  FocusNode remarksFocus = FocusNode();
  FocusNode productFocus = FocusNode();
  FocusNode priceFocus = FocusNode();
  FocusNode packingFocus = FocusNode();
  FocusNode totalPriceFocus = FocusNode();
  FocusNode quantityFocus = FocusNode();

  List<String> productOptions = ["Select"];
  List<String> packingOptions = ["Select"];
  List<dynamic> products = [];
  List<dynamic> currentItems = [];
  bool isLoading = true;
  String errorMessage = "";

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('https://pob.volvrit.in/api/v1/users/products'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['code'] == 200) {
          products = data['data'];
          productOptions = ["Select"] +
              products
                  .map((product) => "${product['group']} - ${product['subcategory_name']}")
                  .toList();
          updatePackingOptions(selectedProduct);
          updatePriceAndTotal();
        } else {
          errorMessage = data['message'] ?? 'Failed to load products';
        }
      } else {
        errorMessage = 'Failed to connect to the server';
      }
    } catch (e) {
      errorMessage = 'Error: $e';
    }
    isLoading = false;
    update();
  }

  void updateSelectedProduct(String newProduct) {
    selectedProduct = newProduct;
    updatePackingOptions(newProduct);
    updatePriceAndTotal();
    update();
  }

  void updateSelectedPacking(String newPacking) {
    selectedPacking = newPacking;
    updatePriceAndTotal();
    update();
  }

  void updatePackingOptions(String productName) {
    if (productName == "Select" || productName.isEmpty) {
      currentItems = [];
      packingOptions = ["Select"];
      selectedPacking = "Select";
    } else {
      final product = products.firstWhere(
            (p) => "${p['group']} - ${p['subcategory_name']}" == productName,
        orElse: () => null,
      );
      if (product != null) {
        currentItems = product['items'];
        packingOptions = ["Select"] + currentItems.map((item) => item['packing'].toString()).toList();
        selectedPacking = "Select";
      } else {
        currentItems = [];
        packingOptions = ["Select"];
        selectedPacking = "Select";
      }
    }
    update();
  }

  void updatePriceAndTotal() {
    if (selectedProduct == "Select" ||
        selectedPacking == "Select" ||
        selectedProduct.isEmpty ||
        selectedPacking.isEmpty ||
        quantityController.text.isEmpty) {
      priceController.text = "Price: 0.00";
      totalPriceController.text = "Total Price: 0.00";
    } else if (currentItems.isNotEmpty && selectedPacking.isNotEmpty) {
      final item = currentItems.firstWhere(
            (i) => i['packing'] == selectedPacking,
        orElse: () => null,
      );
      if (item != null) {
        final price = double.tryParse(item['list_price']) ?? 0.0;
        priceController.text = "Price: ${price.toStringAsFixed(2)}";
        final quantity = int.tryParse(quantityController.text) ?? 1;
        final totalPrice = price * quantity;
        totalPriceController.text = "Total Price: ${totalPrice.toStringAsFixed(2)}";
      } else {
        priceController.text = "Price: 0.00";
        totalPriceController.text = "Total Price: 0.00";
      }
    } else {
      priceController.text = "Price: 0.00";
      totalPriceController.text = "Total Price: 0.00";
    }
  }

  bool validateFields() {
    if (selectedProduct == "Select" || selectedProduct.isEmpty) {
      Get.snackbar("Error", "Please select a product",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (selectedPacking == "Select" || selectedPacking.isEmpty) {
      Get.snackbar("Error", "Please select a packing",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (quantityController.text.isEmpty) {
      Get.snackbar("Error", "Please enter a quantity",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    final quantity = int.tryParse(quantityController.text);
    if (quantity == null || quantity <= 0) {
      Get.snackbar("Error", "Please enter a valid quantity greater than 0",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    if (remarksController.text.isEmpty) {
      Get.snackbar("Error", "Please enter remarks",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return false;
    }
    return true;
  }

  void submitOrder() {
    if (validateFields()) {
      Get.offAll(
            () => const DashboardScreen(),
        arguments: {'selectedIndex': 0, 'refresh': true},
      );
    }
  }

  void toggleProductUsage(bool value) {
    isUsingProduct = value;
    update();
  }
}