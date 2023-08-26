import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/outlet_model.dart';

class OutletApi {
  static Future<OutletModel?> getData(String areaName, String token) async {
    try {
      final url = Uri.parse(apiPath + "market/outlets");
      // print("market area name-----" + mid);
      Map<String, dynamic> requestBody = {
        "ring_of_magic_area": areaName,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        body: jsonencode,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
      print("status code----" + response.statusCode.toString());
      if (response.statusCode == 200) {
        OutletModel getdata = outletModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
