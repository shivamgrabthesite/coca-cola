import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/reg2model.dart';

class Reg2Api {
  static Future<Reg2Model?> setData(String clgName, String password, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/step-2");
      Map<String, dynamic> requestBody = {
        "college_name": clgName,
        "password": password,
        "confirm_password": password
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + authorization,
        },
        body: jsonencode,
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 201) {
        Reg2Model getdata = reg2ModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
