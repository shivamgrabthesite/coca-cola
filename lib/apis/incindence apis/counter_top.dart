import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../../model/CounterTopModel.dart';
import '../../model/cooler_model.dart';

class CounterTop {
  static Future<CounterTopModel?> getData() async {
    try {
      final url = Uri.parse(apiPath + "task/counter_top");
      Map<String, dynamic> requestBody = {
        "tid": "64c91c2beb0916e300de203a",
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
        CounterTopModel getdata = counterTopModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
