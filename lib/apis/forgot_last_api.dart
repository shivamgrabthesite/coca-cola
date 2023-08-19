import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/forgot_last_model.dart';
import 'package:http/http.dart' as http;

import '../model/email_model.dart';
import '../model/email_otp_model.dart';
import '../model/forgot_verify_model.dart';

class ForgotLastApi {
  static Future<ForgotLastModel?> setEmail(String pass,String confirm_pass,String id, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/forget");
      Map<String, dynamic> requestBody = {
        "password": pass,
        "compare_password":confirm_pass,
        "id":id
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
        ForgotLastModel getdata = forgotLastModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
