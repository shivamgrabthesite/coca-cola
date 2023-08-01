import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/mobile_model.dart';

class MobileVerifyApi {
  static Future<MobileModel?> setMobile(String mobile, String authorization) async {
    try {
      final url = Uri.parse(apiPath + "signup/add-phone-number");
      Map<String, dynamic> requestBody = {
        "phone_number": mobile,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + authorization,
        },
        body: jsonencode,
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        MobileModel getdata = mobileModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
