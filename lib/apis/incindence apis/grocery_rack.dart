import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;

import '../../model/GroceryRackModel.dart';
import '../../model/cooler_model.dart';

class Grocaryrackpi {
  static Future<GroceryRackModel?> getData(String tid) async {
    try {
      final url = Uri.parse(apiPath + "task/grocery_rack");
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
        GroceryRackModel getdata = groceryRackModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
