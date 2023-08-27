import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/api.dart';
import 'package:http_parser/http_parser.dart';

import '../../constant/api.dart';
import 'package:dio/dio.dart';

class AerialHangerNotAvailable {
  static var dio = Dio();
  static Future setImage(String pid, String remark, List<int> file) async {
    // try {
    //   print("pid in api------" + pid);
    //   print("image in api------" + imgPath.toString());
    //   var request = http.MultipartRequest(
    //     'post',
    //     Uri.parse(apiPath + "task/aerial_hanger/upload-image/not-available"),
    //   );

    //   // request.fields['pid'] = pid.toString();
    //   var payload = {
    //     "pid": pid,
    //     "aerial_hanger_remark": remark,
    //   };
    //   var payloadJson = jsonEncode(payload);
    //   print('JSON Payload: $payloadJson');

    //   Map<String, String> headers = {"Content-type": "application/json"};

    //   request.files.add(http.MultipartFile.fromBytes(
    //     'image',
    //     imgPath.readAsBytesSync(),
    //     filename: imgPath.path,
    //     contentType: MediaType("image", "jpg"),
    //   ));
    //   request.fields.addAll(payload);
    //   request.headers.addAll(headers);

    //   var res = await request.send();
    //   var resposeData = await res.stream.toBytes();
    //   var result = String.fromCharCodes(resposeData);
    //   print("result------" + result);

    //   print("image respose------" + res.statusCode.toString());
    // } catch (e) {
    //   print('Error while making API request: $e');
    // }
    var prefs = await SharedPreferences.getInstance();
    FormData formData = FormData.fromMap({
      "pid": pid,
      "aerial_hanger_remark": remark,
      "image": MultipartFile.fromBytes(
        file,
        filename: "image.png",
        contentType: MediaType("image", "png"),
      )
    });
    var response =
        await dio.post(apiPath + "task/aerial_hanger/upload-image/not-available", data: formData);
    print("aerial_hanger res-----" + response.data['success'].toString());
    prefs.setBool("aerialNotAvailable", response.data['success']);
    return response.data;
  }
}
