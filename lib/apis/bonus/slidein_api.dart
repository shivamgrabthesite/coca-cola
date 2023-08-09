import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/vinyl_branding_model.dart';
import 'package:http/http.dart' as http;

import '../../model/ambient_display_model.dart';
import '../../model/brand_strip.dart';
import '../../model/counter_brand_model.dart';
import '../../model/price_strip_model.dart';
import '../../model/slidein_model.dart';

class SplideinApi {
  static Future<SlideInModel?> getData(String tid) async {
    try {
      final url = Uri.parse(apiPath + "task/slide_in");
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
        SlideInModel getdata = slideInModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
