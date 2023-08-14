import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/vinyl_branding_model.dart';
import 'package:http/http.dart' as http;

import '../../model/brand_strip.dart';
import '../../model/pack_cutout_model.dart';
import '../../model/price_strip_model.dart';

class PackCutoutApi {
  static Future<PackCutoutModel?> getData(String tid) async {
    print("tid in api----" + tid);
    try {
      final url = Uri.parse(apiPath + "task/pack_cutout");
      Map<String, dynamic> requestBody = {
        "tid": tid,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        body: jsonencode,
        headers: {'Content-Type': 'application/json'},
      );
      print("map pack-------" + jsonencode);
      print("status code pack----" + response.body.toString());
      // return response.body;

      if (response.statusCode == 201) {
        PackCutoutModel getdata = packCutoutModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
