import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import '../model/fetch_task_model.dart';
import '../model/outlet_detail_model.dart';

class OutletDetailApi {
  static Future<OutletDetailModel?> getData(String id) async {
    try {
      print("id--------" + id);
      var response = await http.get(
        Uri.parse(
          apiPath + "market/outlets-details/" + id,
        ),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      print("fatch response----" + response.body);
      // return response.body;
      if (response.statusCode == 200) {
        OutletDetailModel getdata = outletDetailModelFromJson(response.body);
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
