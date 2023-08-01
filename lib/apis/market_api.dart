import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../model/market_model.dart';

class MarketApi {
  static Future<MarketModel?> getData(String authorization) async {
    try {
      final url = Uri.parse(apiPath + "market/");
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + authorization,
        },
      );
      print('Token : ${authorization}');
      print("status code----" + response.statusCode.toString());
      if (response.statusCode == 200) {
        MarketModel getdata = marketModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
