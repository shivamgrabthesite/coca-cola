import 'dart:convert';
import 'package:coca_cola/constant/api.dart';
import 'package:http/http.dart' as http;
import '../model/questions_model.dart';

class OptionsApi {
  static Future<QuestionsModel?> getData(String imgId, String step) async {
    try {
      final url = Uri.parse(apiPath + "market/send-questions");
      Map<String, dynamic> requestBody = {
        "image_id": imgId,
        "step": step,
      };
      var jsonencode = jsonEncode(requestBody);
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonencode,
      );
      print("map-------" + jsonencode);
      print("status code----" + response.statusCode.toString());
      // return response.body;
      if (response.statusCode == 200) {
        QuestionsModel getdata = questionsModelFromJson(response.body);
        return getdata;
      } else {
        print("-------------no data found---------");
      }
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
