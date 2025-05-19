import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import 'package:nikitchem/constant/constant_string.dart';
import 'package:nikitchem/screens/dashboard/DashboardScreen.dart';
import 'package:nikitchem/screens/dashboard/dialogbox/PunchInCompleteDialog.dart';
import 'package:nikitchem/screens/login/LoginScreenController.dart';
import 'package:nikitchem/screens/skippunchout/AssignedTaskSkipScreen.dart';
import 'package:nikitchem/support/EasyLoadingConfig.dart';
import 'package:nikitchem/support/alert_dialog_manager.dart';
import '../../../constant/SharedPrefsHelper.dart';
import '../../../support/PreferenceManager.dart';
import '../../model/login_model.dart';

class PunchInController extends GetxController {
  final BuildContext context;

  PunchInController(this.context);

  var isPunchedIn = false;
  var punchId = 0;

  final now = DateTime.now();
  final currentTime = DateTime.now();
  final currentDate = DateTime.now();
  String location = "";

  LoginModel? loginModel;

  final timeFormat = DateFormat('h:mm a');
  final dateFormat = DateFormat('dd MMMM yyyy');

  getUserDetail() {
    PreferenceManager.instance.getUserDetails().then((onValue) {
      loginModel = onValue;
      update();
    });
  }

  var punchInTime = '';
  var punchOutTime = '';
  var formattedTime = '';
  var formattedDate = '';

  bool togglePunchState = false;

  Map<String, dynamic> getPunchDetails() {
    return {
      'isPunchedIn': isPunchedIn,
      'punchInTime': punchInTime,
      'punchOutTime': punchOutTime,
      'punchId': punchId,
    };
  }

  void updateTimeAndDate() {
    final now = DateTime.now();
    formattedTime = timeFormat.format(now);
    formattedDate = dateFormat.format(now);
    update();
  }

  void toggleFeatureff(bool value) {
    togglePunchState = value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    loadPunchDetails();
    getUserDetail();
    updateTimeAndDate();
  }

  Future<void> loadPunchDetails() async {
    final details = await SharedPrefsHelper.loadPunchDetails();
    isPunchedIn = details['isPunchedIn'];
    punchId = details['punchId'];
    punchInTime = details['punchInTime'];
    punchOutTime = details['punchOutTime'];
    formattedDate = dateFormat.format(now);
  }

  void skipPunching() {
    Get.off(AssignedTaskSkipScreen());
  }

  void toggleFeature(bool value) {
    LoginScreenController logincontroller = Get.put(LoginScreenController(context));
    isPunchedIn = value;
    print("$isPunchedIn");
    if (value) {
      punchInTime = timeFormat.format(DateTime.now());
      formattedDate = dateFormat.format(DateTime.now());
      punchOutTime = '';

      Get.snackbar("Punch In", "User is punched in at $punchInTime",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3));


      logincontroller.postData(loginModel?.user?.id as String);


    }
    else
    {
      punchOutTime = timeFormat.format(DateTime.now());
      punchInTime = '';

      Get.snackbar("Punch Out", "User is punched out at $punchOutTime",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          margin: EdgeInsets.all(10),
          duration: Duration(seconds: 3));





    }

    savePunchDetails();
    update();
  }

  Future<void> savePunchDetails() async {
    await SharedPrefsHelper.savePunchDetails(
      isPunchedIn: isPunchedIn,
      punchId: punchId,
      punchInTime: punchInTime,
      punchOutTime: punchOutTime,
    );
  }

  void punchInfromHome() async {
    String dynamicLatitude = "0.0";
    String dynamicLongitude = "0.0";
    String dynamicAddress = "Unknown location";

    if (location.isNotEmpty) {
      try {
        List mainParts = location.split(",");
        if (mainParts.length >= 2) {
          dynamicLatitude = mainParts[0].trim();
          List longAndAddress = mainParts[1].split("--|");
          if (longAndAddress.length >= 2) {
            dynamicLongitude = longAndAddress[0].trim();
            dynamicAddress = longAndAddress[1].trim();
          }
        }
      } catch (e) {
        print("Error parsing location: $e. Using defaults.");
      }
    } else {
      try {
        LocationPermission permission = await Geolocator.checkPermission();
        if (permission == LocationPermission.denied) {
          permission = await Geolocator.requestPermission();
          if (permission == LocationPermission.denied) {
            Get.snackbar("Permission Denied",
                "Location permission is required for Punch In.",
                backgroundColor: Colors.red,
                colorText: Colors.white);
            return;
          }
        }

        if (permission == LocationPermission.deniedForever) {
          Get.snackbar("Permission Denied",
              "Location permission is permanently denied. Please enable it in settings.",
              backgroundColor: Colors.red,
              colorText: Colors.white);
          return;
        }

        Position position = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        dynamicLatitude = position.latitude.toString();
        dynamicLongitude = position.longitude.toString();

        List<Placemark> placemarks = await placemarkFromCoordinates(
            position.latitude, position.longitude);
        if (placemarks.isNotEmpty) {
          final place = placemarks.first;
          dynamicAddress =
          "${place.street}, ${place.locality}, ${place.postalCode}";
        }

        print("Fetched location from GPS:");
        print("Lat: $dynamicLatitude, Long: $dynamicLongitude");
      } catch (e) {
        print("Failed to get location: $e");
        Get.snackbar("Error", "Failed to get location: $e",
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
    }

    final userId = loginModel?.user?.id?.toString();
    if (userId == null || userId.isEmpty) {
      EasyLoadingConfig.dismiss();
      AlertDialogManager.getSnackBarMsg(
        "Login Error",
        "User ID not found. Please login again.",
        false,
        context,
      );
      return;
    }

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    final body = jsonEncode({
      'user_id': userId,
      'latitude': dynamicLatitude,
      'longitude': dynamicLongitude,
      'address': dynamicAddress,
    });

    EasyLoadingConfig.show();

    try {
      final response = await http.post(
        Uri.parse(ConstantString.punchin),
        headers: headers,
        body: body,
      );

      EasyLoadingConfig.dismiss();

      if (response.statusCode == 200) {
        final responseJson = jsonDecode(response.body);

        if (responseJson["code"] == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              punchInTime = formattedTime;
              punchId = now.millisecondsSinceEpoch;
              SharedPrefsHelper.savePunchDetails(
                isPunchedIn: true,
                punchId: punchId,
                punchInTime: formattedTime,
              );
              return PunchInCompleteDialog(formattedTime);
            },
          );
        } else {
          final error = responseJson["message"] ?? "Punch in failed";
          AlertDialogManager.getSnackBarMsg("Error", error, false, context);
        }
      } else {
        final responseJson = jsonDecode(response.body);
        final error = responseJson["error"] ?? "Already punched in today.";
        AlertDialogManager.getSnackBarMsg("Error", error, false, context);
      }
    } catch (e) {
      EasyLoadingConfig.dismiss();
      AlertDialogManager.getSnackBarMsg(
        "Network Error",
        "Unable to complete request. Please check your connection.",
        false,
        context,
      );
      print("Exception: $e");
    }
  }

  Future<void> punchOut() async {
    String dynamicLatitude = "0.0";
    String dynamicLongitude = "0.0";
    String dynamicAddress = "Unknown location";

    try {
      Position position = await _getLocation();
      dynamicLatitude = position.latitude.toString();
      dynamicLongitude = position.longitude.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        dynamicAddress =
        "${place.street}, ${place.locality}, ${place.postalCode}";
      }
    } catch (e) {
      print("Error getting location: $e");
      return;
    }

    final userId = loginModel?.user?.id?.toString();
    if (userId == null || userId.isEmpty) {
      AlertDialogManager.getSnackBarMsg("Login Error",
          "User ID not found. Please login again.", false, context);
      return;
    }

    final body = jsonEncode({
      'user_id': userId,
      'latitude': dynamicLatitude,
      'longitude': dynamicLongitude,
      'address': dynamicAddress,
    });

    EasyLoadingConfig.show();

    try {
      final response = await http.post(
        Uri.parse(ConstantString.punchout),
        headers: {'Content-Type': 'application/json'},
        body: body,
      );

      EasyLoadingConfig.dismiss();

      if (response.statusCode == 200) {
        punchOutTime = timeFormat.format(DateTime.now());
        isPunchedIn = false;
        punchInTime = '';
        punchId = 0;

        await SharedPrefsHelper.savePunchDetails(
          isPunchedIn: false,
          punchId: 0,
          punchInTime: '',
          punchOutTime: punchOutTime,
        );

        Get.snackbar("Punch Out", "Successfully punched out at $punchOutTime",
            backgroundColor: Colors.green, colorText: Colors.white);
        update();
      } else {
        final responseJson = jsonDecode(response.body);
        final error = responseJson['message'] ?? "Punch out failed";
        Get.snackbar("Error", error, backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      EasyLoadingConfig.dismiss();
      Get.snackbar("Error", "Network error during punch out: $e",
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  Future<Position> _getLocation() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied.");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception("Location permission permanently denied.");
    }

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }
}