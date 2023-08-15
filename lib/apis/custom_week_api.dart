import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:coca_cola/model/CustomWeekModel.dart';
import 'package:http/http.dart' as http;
import '../model/questions_model.dart';

class CustomWeekApi {
  static Future<CustomWeekModel?> getData(String weekNo,String auth) async {
    try {
      final url = Uri.parse(apiPath + "week-schedule/custome-week");
      Map<String, dynamic> requestBody = {
        "customeWeek":weekNo
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json',
        'Authorization':'Bearer '+auth
        },
        body: jsonencode,
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        CustomWeekModel getdata = customWeekModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
