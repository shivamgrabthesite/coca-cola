import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/reg2model.dart';

class SetClgName {
  static Future setData(String clgName, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "week-schedule");
      Map<String, dynamic> requestBody = {
        "college_name": clgName,
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
