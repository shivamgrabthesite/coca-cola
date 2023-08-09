import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/vertical_signage_model.dart';
import 'package:http/http.dart' as http;

import '../../model/cooler_model.dart';

class VerticalSignageApi {
  static Future<VerticalSignageModel?> getData(String tid) async {
    try {
      final url = Uri.parse(apiPath + "task/vertical_signage");
      Map<String, dynamic> requestBody = {
        "tid":tid,
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

      if (response.statusCode == 201) {
        VerticalSignageModel getdata = verticalSignageModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
