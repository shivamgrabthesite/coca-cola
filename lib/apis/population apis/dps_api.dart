import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/dps_model.dart';
import 'package:http/http.dart' as http;

import '../../model/AerialHangerModel.dart';
import '../../model/AmbientRackModel.dart';
import '../../model/cooler_model.dart';

class DpsApi {
  static Future<DpsModel?> getData(String tid) async {
    try {
      final url = Uri.parse(apiPath + "task/dps");
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
      print("task code----" + response.body.toString());
      // return response.body;

      if (response.statusCode == 201) {
        DpsModel getdata = dpsModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
