import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../model/fetch_task_model.dart';

class FetchTaskApi {
  static Future<FetchTaskModel?> getData(String token) async {
    try {
      var response = await http.get(
        Uri.parse(
          apiPath + "fetch-task",
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer " + token,
        },
      );
      print("fatch response----" + response.body);
      // return response.body;
      if (response.statusCode == 200) {
        FetchTaskModel getdata = fetchTaskModelFromJson(response.body);
        print("fetch data=====" + getdata.data.toString());
        print("fatch response----" + response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
