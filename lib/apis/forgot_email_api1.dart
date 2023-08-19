import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/email_model.dart';
import '../model/email_otp_model.dart';
import '../model/forgot_email_model1.dart';

class ForgotEmailApi1 {
  static Future<ForgotEmailModel1?> setEmail(String email, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/forget/email");
      Map<String, dynamic> requestBody = {
        "user_email": email,
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
        ForgotEmailModel1 getdata = forgotEmailModel1FromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
