import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../../model/AmbientRackModel.dart';
import '../../model/cooler_model.dart';

class AmbientRack {
  static Future<AmbientRackModel?> getData() async {
    try {
      final url = Uri.parse(apiPath + "task/ambient_rack");
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
        AmbientRackModel getdata = ambientRackModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
