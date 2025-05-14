import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../support/EasyLoadingConfig.dart';
import '../support/alert_dialog_manager.dart';
import 'constant_string.dart';

class APIConstant {
  static Future<dynamic> gethitAPI(
      context,
      String method,
      String url, {
        bool sendInFeilds = false,
        Map<String, dynamic> body = const {},
        Map<String, String> headers = const {'Accept': 'application/json'},
      }) async {
    EasyLoadingConfig.show();
    var responsebody = null;
    try {
      Uri baseUrl = Uri.parse(url);
      var request;
      var response;
      // Set body only for methods that allow it
      if (body != null && (method == "POST" || method == "PUT" || method == "PATCH" || method == "GET")) {
        // request.body = jsonEncode(body);
        if (sendInFeilds) {
          request = await http.MultipartRequest(method, baseUrl);
          request.headers.addAll(headers);
          request.fields.addAll(body);
          var streamedResponse = await http.Client().send(request);
          response = await http.Response.fromStream(streamedResponse);
        } else {
          print(method);
          print(baseUrl);
          request = await http.Request(method, baseUrl);
          request.body = jsonEncode(body ?? {});
          print(request.body);
          var streamedResponse = await http.Client().send(request);
          print(">>>>>>>>>>>>>>>>>>>>>>");
          response = await http.Response.fromStream(streamedResponse);
          print(response);
        }
      }
      print(url);

      EasyLoadingConfig.dismiss();
      if (response != null) {
        if (response.statusCode == 200 || response.statusCode == 201) {
          print('Response: ${response.body}');
          responsebody = response.body;
          var new_responce = jsonDecode(responsebody);
          if (new_responce["status"] != "error") {
            return responsebody;
          } else {
            if (!url.contains(ConstantString.register)) {
              var responce = jsonDecode(response.body);
              AlertDialogManager().sendMessageAlert(context, 'Error', responce["message"]);
            }
          }
        } else if (response.statusCode < 500) {
          print('Error: ${response.statusCode} - ${response.reasonPhrase}');
          responsebody = null;
          var responce = jsonDecode(response.body);
          AlertDialogManager().sendMessageAlert(context, 'Error', responce["message"]);
        } else {
          print('Error: ${response.statusCode} - ${response.reasonPhrase}');
          responsebody = null;
          var responce = jsonDecode(response.body);
          AlertDialogManager().sendMessageAlert(context, 'Error', responce["message"]);
        }
      }
    } catch (e) {
      EasyLoadingConfig.dismiss();
      AlertDialogManager().isErrorAndSuccessAlertDialogMessage(
        context,
        "Exception",
        e.toString(),
        onTapFunction: () {
          Get.back();
        },
      );
    }
    if (responsebody != null) {
      return Future.value(responsebody);
    } else {
      return Future.error(responsebody ?? "");
    }
  }

  static Future<Map<String, dynamic>> hitAPIWithToken(
      context,
      String method,
      String url, {
        bool sendInFields = false,
        Map<String, dynamic> body = const {},
        Map<String, String> headers = const {'Accept': 'application/json'},
      }) async {
    EasyLoadingConfig.show();
    try {
      Uri baseUrl = Uri.parse(url);
      http.Response response;

      if (sendInFields) {
        var request = http.MultipartRequest(method, baseUrl);
        request.headers.addAll(headers);
        request.fields.addAll(body.map((key, value) => MapEntry(key, value.toString())));
        var streamedResponse = await http.Client().send(request);
        response = await http.Response.fromStream(streamedResponse);
      } else {
        var request = http.Request(method, baseUrl);
        request.headers.addAll(headers);
        request.body = jsonEncode(body);
        var streamedResponse = await http.Client().send(request);
        response = await http.Response.fromStream(streamedResponse);
      }

      print('Request URL: $url');
      print('Request Body: ${body}');

      EasyLoadingConfig.dismiss();

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Response: ${response.body}');
        return {
          'body': response.body,
          'headers': response.headers,
        };
      } else {
        var responseJson = jsonDecode(response.body);
        print('Error: ${response.statusCode} - ${response.reasonPhrase}');
        return {
          'body': response.body,
          'headers': response.headers,
          'error': responseJson['message'] ?? response.reasonPhrase,
        };
      }
    } catch (e) {
      EasyLoadingConfig.dismiss();
      print('Exception: $e');
      AlertDialogManager().isErrorAndSuccessAlertDialogMessage(
        context,
        "Exception",
        e.toString(),
        onTapFunction: () {
          Get.back();
        },
      );
      return {
        'body': null,
        'headers': {},
        'error': e.toString(),
      };
    }
  }
}