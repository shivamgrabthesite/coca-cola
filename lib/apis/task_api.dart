import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/task_model.dart';

class TaskApi {
  static Future<TaskModel?> getData(String uid, String mid, String oid) async {
    try {
      print("oid in api--------" + oid);
      final url = Uri.parse(apiPath + "task");
      Map<String, dynamic> requestBody = {"uid": uid, "mid": mid, "oid": oid};
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        body: jsonencode,
        headers: {'Content-Type': 'application/json'},
      );
      print("map-------" + jsonencode);
      print("task code----" + response.statusCode.toString());
      if (response.statusCode == 201) {
        TaskModel getdata = taskModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
