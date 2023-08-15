import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../../constant/api.dart';

class PriceStripNotAvailable {
  static Future setImage(String pid, String remark, File imgPath) async {
    try {
      print("pid in api------" + pid);
      print("image in api------" + imgPath.toString());
      var request = http.MultipartRequest(
        'post',
        Uri.parse(apiPath + "task/price_strip/upload-image/not-available"),
      );

      // request.fields['pid'] = pid.toString();
      var payload = {
        "pid": pid,
        "price_strip_remark": remark,
      };
      var payloadJson = jsonEncode(payload);
      print('JSON Payload: $payloadJson');

      Map<String, String> headers = {"Content-type": "application/json"};

      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imgPath.readAsBytesSync(),
        filename: imgPath.path,
        contentType: MediaType("image", "jpg"),
      ));
      request.fields.addAll(payload);
      request.headers.addAll(headers);

      var res = await request.send();
      var resposeData = await res.stream.toBytes();
      var result = String.fromCharCodes(resposeData);
      print("result------" + result);

      print("image respose------" + res.statusCode.toString());
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
