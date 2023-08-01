import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/outlet_model.dart';

class OutletApi {
  static Future<OutetModel?> getData(String marketName) async {
    try {
      final url = Uri.parse(apiPath + "market/outlets");
      print("market area name-----" + marketName);
      Map<String, dynamic> requestBody = {
        "Market_Area": "Market Area 7",
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        body: jsonencode,
        headers: {'Content-Type': 'application/json'},
      );
      print("status code----" + response.statusCode.toString());
      if (response.statusCode == 200) {
        OutetModel getdata = outetModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
