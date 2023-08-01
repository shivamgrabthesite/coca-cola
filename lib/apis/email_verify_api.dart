import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/email_model.dart';

class EmailVerifyApi {
  static Future<EmailModel?> setEmail(String email, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/add-email/");
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
        EmailModel getdata = emailModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
