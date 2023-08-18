import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/api.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import '../../constant/api.dart';

class CoolerCustom {
  static var dio = Dio();
  static Future setImage(String pid, String remark, List<int> file) async {
    // try {
    //   print("pid in api------" + pid);
    //   // print("image in api------" + imgPath.toString());
    //   var request = http.MultipartRequest(
    //     'post',
    //     Uri.parse(apiPath + "task/cooler/custom-image"),
    //   );

    //   var payload = {
    //     "pid": pid,
    //     "cooler_remark": remark,
    //   };
    //   var payloadJson = jsonEncode(payload);
    //   print('JSON Payload: $payloadJson');

    //   Map<String, String> headers = {"Content-type": "application/json"};
    //   // for (int i = 0; i < _pickedImages.length; i++) {
    //   //   var file = await http.MultipartFile.fromPath('image', _pickedImages[i].path);
    //   //   request.files.add(file);
    //   // }
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

    //   print("image respose------" + res.statusCode.toString());
    //   print("result------" + result);
    // } catch (e) {
    //   print('Error while making API request: $e');
    // }
    FormData formData = FormData.fromMap({
      "pid": pid,
      "cooler_remark": remark,
      "image": MultipartFile.fromBytes(
        file,
        filename: "image.png",
        contentType: MediaType("image", "png"),
      )
    });
    var response = await dio.post(apiPath + "task/cooler/custom-image", data: formData);
    return response.data.toString();
  }
}
