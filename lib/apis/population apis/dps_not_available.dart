import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../constant/api.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../constant/api.dart';

class DpsNotAvailable {
  static var dio = Dio();
  static Future setImage(String pid, String remark, List<int> file) async {
    // try {
    //   print("pid in api------" + pid);
    //   print("image in api------" + imgPath.toString());
    //   var request = http.MultipartRequest(
    //     'post',
    //     Uri.parse(apiPath + "task/dps/upload-image/not-available"),
    //   );

    //   // request.fields['pid'] = pid.toString();
    //   var payload = {
    //     "pid": pid,
    //     "dps_remark": remark,
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
    FormData formData = FormData.fromMap({
      "pid": pid,
      "dps_remark": remark,
      "image": MultipartFile.fromBytes(
        file,
        filename: "image.png",
        contentType: MediaType("image", "png"),
      )
    });
    print("dps map----"+formData.toString());
    var response = await dio.post(apiPath + "task/dps/upload-image/not-available", data: formData);
    return response.data.toString();
  }
}
