import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class SlideinAvailable {
  static Future setImage(String pid, File imgPath) async {
    try {
      print("pid in api------" + pid);
      print("image in api------" + imgPath.toString());
      var request = http.MultipartRequest(
        'post',
        Uri.parse("http://16.170.252.47:5000/api/task/slide_in/upload-image"),
      );

      // request.fields['pid'] = pid.toString();
      var payload = {"pid": pid};
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
