import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';

import '../../../support/PreferenceManager.dart';
import 'beatvisit_model.dart';

class BeatPlanController extends GetxController {
  var dealers = <Dealer>[].obs;
  var filteredDealers = <Dealer>[].obs;
  var selectedDate = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;
  var highlightedDays = <DateTime, List>{}.obs;
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void onInit() {
    super.onInit();
    fetchVisitData();
  }

  Future<void> fetchVisitData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // Get user_id and token from PreferenceManager
      final userDetails = await PreferenceManager.instance.getUserDetails();
      final userId = userDetails.user?.id?.toString() ?? '40';
      final token = userDetails.token ?? ''; // Adjust based on LoginModel structure

      print('BeatPlanController: Fetching data for user_id: $userId, token: $token');

      // Try POST request
      final response = await http.post(
        Uri.parse('https://pob.volvrit.in/api/v1/users/get-all-visit'),
        headers: {
          'Content-Type': 'application/json',
          if (token.isNotEmpty) 'Authorization': 'Bearer $token',
        },
        body: jsonEncode({'user_id': userId}),
      );

      print('BeatPlanController: API response status: ${response.statusCode}');
      print('BeatPlanController: API response body: ${response.body}');

      if (response.statusCode == 200) {
        final visitModel = VisitModel.fromJson(jsonDecode(response.body));
        dealers.assignAll(visitModel.data);
        updateHighlightedDays();
        filterDealersByDate(selectedDate.value);
      } else {
        errorMessage.value = 'Failed to fetch visit data: ${response.statusCode}';
        Get.snackbar('Error', errorMessage.value,
            backgroundColor: Colors.red, colorText: Colors.white);
        loadMockData();
      }
    } catch (e) {
      print('BeatPlanController: Error fetching visit data: $e');
      errorMessage.value = 'Network error: $e';
      Get.snackbar('Error', errorMessage.value,
          backgroundColor: Colors.red, colorText: Colors.white);
      loadMockData();
    } finally {
      isLoading.value = false;
    }
  }

  void loadMockData() {
    final mockData = [
      Dealer(
        delearname: 'ddfcc',
        visitDate: '2025-05-21',
        id: 89,
        phone: '9536524585',
        city: 'Adilabad',
        state: 'Andhra Pradesh',
        address: 'xffvvv',
        mapLink: '',
        totalVisits: 0,
        totalCarpenters: 0,
        carpenderList: [],
        successRate: '0%',
        totalOrders: '0',
      ),
      Dealer(
        delearname: 'Amit Raj',
        visitDate: '2025-05-15',
        id: 90,
        phone: '9876543210',
        city: 'Mumbai',
        state: 'Maharashtra',
        address: '123 Street',
        mapLink: '',
        totalVisits: 5,
        totalCarpenters: 2,
        carpenderList: [],
        successRate: '80%',
        totalOrders: '10',
      ),
      Dealer(
        delearname: 'ffhvv',
        visitDate: '2025-05-30',
        id: 91,
        phone: '9123456789',
        city: 'Delhi',
        state: 'Delhi',
        address: '456 Road',
        mapLink: '',
        totalVisits: 3,
        totalCarpenters: 1,
        carpenderList: [],
        successRate: '60%',
        totalOrders: '5',
      ),
    ];
    dealers.assignAll(mockData);
    updateHighlightedDays();
    filterDealersByDate(selectedDate.value);
    print('BeatPlanController: Loaded mock data with ${mockData.length} dealers');
  }

  void updateHighlightedDays() {
    highlightedDays.clear();
    for (var dealer in dealers) {
      try {
        final date = dateFormat.parse(dealer.visitDate);
        final dateKey = DateTime(date.year, date.month, date.day);
        highlightedDays[dateKey] = ['highlighted'];
        print('BeatPlanController: Highlighted date: ${dealer.visitDate} for dealer: ${dealer.delearname}');
      } catch (e) {
        print('BeatPlanController: Invalid visit_date format for ${dealer.delearname}: ${dealer.visitDate}');
      }
    }
    highlightedDays.refresh();
    print('BeatPlanController: Total highlighted dates: ${highlightedDays.length}');
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = selectedDay;
    this.focusedDay.value = focusedDay;
    filterDealersByDate(selectedDay);
    print('BeatPlanController: Selected date: ${dateFormat.format(selectedDay)}');
  }

  void filterDealersByDate(DateTime date) {
    final formattedDate = dateFormat.format(date);
    filteredDealers.assignAll(
      dealers.where((dealer) => dealer.visitDate == formattedDate).toList(),
    );
    print('BeatPlanController: Filtered dealers for $formattedDate: ${filteredDealers.length} found');
    for (var dealer in filteredDealers) {
      print('BeatPlanController: Dealer on $formattedDate: ${dealer.delearname}');
    }
  }
}