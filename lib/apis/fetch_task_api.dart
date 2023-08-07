import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/fetch_task_model.dart';

class FetchTaskApi {
  static Future<FetchTaskModel?> getData() async {
    try {
      // String encodedUrl = Uri.parse(
      //   apiPath + "fetch-task/:uid",
      // ).replace(queryParameters: {"uid": "64cd32324c73d9f927836919"}).toString();
      final Map<String, String> params = {"uid": "64cd32324c73d9f927836919"};
      var response = await http.get(
          Uri.parse(
            apiPath + "fetch-task/uid/",
          ),
          headers: params);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        FetchTaskModel getdata = fetchTaskModelFromJson(response.body);
        print("fetch data=====" + getdata.toString());
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
