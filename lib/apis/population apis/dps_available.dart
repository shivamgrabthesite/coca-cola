import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../constant/api.dart';

class DPsAvailable {
  static var dio = Dio();
  static Future<String> setImage(String pid, List<int> file) async {
    // try {
    //   print("pid in api------" + pid);
    //   print("image in api------" + imgPath.toString());
    //   var request = http.MultipartRequest(
    //     'post',
    //     Uri.parse(apiPath + "task/dps/upload-image"),
    //   );
    //
    //   // request.fields['pid'] = pid.toString();
    //   var payload = {"pid": pid};
    //   var payloadJson = jsonEncode(payload);
    //   print('JSON Payload: $payloadJson');
    //
    //   Map<String, String> headers = {"Content-type": "application/json"};
    //
    //   request.files.add(http.MultipartFile.fromBytes(
    //     'image',
    //     imgPath.readAsBytesSync(),
    //     filename: imgPath.path,
    //     contentType: MediaType("image", "jpg"),
    //   ));
    //
    //   request.fields.addAll(payload);
    //   request.headers.addAll(headers);
    //
    //   var res = await request.send();
    //   var resposeData = await res.stream.toBytes();
    //   var result = String.fromCharCodes(resposeData);
    //
    //   print("image respose------" + res.statusCode.toString());
    // } catch (e) {
    //   print('Error while making API request: $e');
    // }

    FormData formData = FormData.fromMap({
      "pid": pid,
      "image": MultipartFile.fromBytes(
        file,
        filename: "image.png",
        contentType: MediaType("image", "png"),
      )
    });
    var response = await dio.post(apiPath + "task/dps/upload-image", data: formData);
    return response.data.toString();
  }
}
