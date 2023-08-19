import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/email_model.dart';
import '../model/email_otp_model.dart';

class EmailOtpApi {
  static Future<EmailOtpModel?> setEmail(String otp, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/verifyOTP");
      Map<String, dynamic> requestBody = {
        "otp": otp,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + authorization,
        },
        body: jsonencode,
      );
      print('Token : ${authorization}');
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        EmailOtpModel getdata = emailOtpModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
