import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/login_model.dart';
import '../model/reg2model.dart';

class LoginApi {
  static Future<LoginModel?> setData(String email, String password) async {
    try {
      final url = Uri.parse(apiPath + "login");
      Map<String, dynamic> requestBody = {
        "user_email": email,
        "login_password": password,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        body: jsonencode,
        headers: {'Content-Type': 'application/json'},
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;

      if (response.statusCode == 200) {
        LoginModel getdata = loginModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
