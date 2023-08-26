import 'dart:convert';

import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/reg1model.dart';

class Reg1API {
  static Future<Reg1Model?> getData(String f_name, String l_name) async {
    try {
      final url = Uri.parse(apiPath + "signup/");
      Map<String, dynamic> requestBody = {
        "first_name": f_name,
        "last_name": l_name,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonencode,
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 201) {
        Reg1Model getdata = reg1ModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
