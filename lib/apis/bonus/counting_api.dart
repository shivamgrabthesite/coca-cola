import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/vinyl_branding_model.dart';
import 'package:http/http.dart' as http;

import '../../model/CounterTopModel.dart';
import '../../model/brand_strip.dart';
import '../../model/counter_brand_model.dart';
import '../../model/price_strip_model.dart';

class CounterApi {
  static Future<CounterTopModel?> getData(String tid) async {
    try {
      final url = Uri.parse(apiPath + "task/counter_top");
      Map<String, dynamic> requestBody = {
        "tid": tid,
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
