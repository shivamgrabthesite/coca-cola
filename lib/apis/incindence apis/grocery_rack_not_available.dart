import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class GroceryRackNotAvailable {
  static Future setImage(String pid, String remark, File imgPath) async {
    try {
      print("pid in api------" + pid);
      print("image in api------" + imgPath.toString());
      var request = http.MultipartRequest(
        'post',
        Uri.parse("http://16.170.252.47:5000/api/task/grocery_rack/upload-image/not-available"),
      );
      var payload = {
        "pid": pid,
        "grocery_rack_remark": remark,
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

      print("image respose------" + res.statusCode.toString());
      print("result------" + result);
    } catch (e) {
      print('Error while making API request: $e');
    }
  }
}
