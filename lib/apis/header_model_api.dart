import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/header_model.dart';

class HeaderModelApi {
  static Future<HeaderModel?> getData(String token) async {
    try {
      final url = Uri.parse(apiPath + "user/header/");
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
      print("status code----" + response.statusCode.toString());
      if (response.statusCode == 200) {
        HeaderModel getdata = headerModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
