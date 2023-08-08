import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../model/fetch_task_model.dart';

class FetchTaskApi {
  static Future<FetchTaskModel?> getData() async {
    try {
      Dio dio = Dio();
      var url = apiPath + "fetch-task/:uid";

      final response = await dio.get(
        url,
        options: Options(
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        ),
        queryParameters: {
          "uid": "64cd32324c73d9f927836919",
        },
      );
      // String encodedUrl = Uri.parse(
      //   apiPath + "fetch-task/:uid",
      // ).replace(queryParameters: {"uid": "64cd32324c73d9f927836919"}).toString();
      // final Map<String, String> params = {"uid": "64cd32324c73d9f927836919"};
      // var response = await http.get(
      //     Uri.parse(
      //       apiPath + "fetch-task/:uid",
      //     ),
      //     headers: {"uid": "64cd32324c73d9f927836919"});
      // print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        FetchTaskModel getdata = fetchTaskModelFromJson(jsonDecode(response.data));
        print("fetch data=====" + getdata.data.toString());
        print("fatch response----" + response.data);
        // return response.data;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
