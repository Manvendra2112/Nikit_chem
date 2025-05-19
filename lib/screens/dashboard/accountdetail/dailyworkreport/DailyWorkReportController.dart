import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DailyWorkReportController extends GetxController {
  // State for selected date
  DateTime _selectedDate = DateTime(2025, 4, 23); // Default date
  DateTime get selectedDate => _selectedDate;

  // Report data (can be empty for testing)
  Map<String, String> reportData = {
    'route': 'Ambala, Panjab',
    'distance': '24km',
    'totalOrder': '25kg',
    'successRate': '33%',
  };
  // For testing empty case, comment out above and use:
  // Map<String, String> reportData = {};

  // Check if report data is empty or invalid
  bool isDataEmpty() {
    return reportData.isEmpty ||
        reportData.values.every((value) => value.isEmpty || value == 'N/A');
  }

  // Update selected date
  Future<void> selectDate(BuildContext context) async {
    print('Opening date picker');
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != _selectedDate) {
      _selectedDate = picked;
      update(); // Notify UI to rebuild
      print('Selected date: ${DateFormat('dd MMMM, yyyy').format(_selectedDate)}');
    }
  }

  // Handle button taps
  void handleSuccessfulVisit(int buttonIndex) {
    print('Successful Visit $buttonIndex tapped');
    // Add logic here (e.g., update report, navigate)
  }

  @override
  void onClose() {
    // Clean up if needed
    super.onClose();
  }
}