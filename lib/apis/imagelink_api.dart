import 'dart:convert';

import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/image_model.dart';
import '../model/reg1model.dart';

class ImagelinkApi {
  static Future<ImageModel?> getData(String imageChannel) async {
    try {
      final url = Uri.parse(apiPath + "market/image-link");
      Map<String, dynamic> requestBody = {
        "image_channal": imageChannel,
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
      if (response.statusCode == 200) {
        ImageModel getdata = imageModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
