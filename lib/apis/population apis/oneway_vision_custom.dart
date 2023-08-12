import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';

class OnewayVisionCustom {
  static Future setImage(String pid, String remark, File imgPath) async {
    try {
      print("pid in api------" + pid);
      // print("image in api------" + imgPath.toString());
      var request = http.MultipartRequest(
        'post',
        Uri.parse("http://16.170.252.47:5000/api/task/oneway_vision/custom-image"),
      );

      var payload = {
        "pid": pid,
        "oneway_vision_remark": remark,
      };
      var payloadJson = jsonEncode(payload);
      print('JSON Payload: $payloadJson');

      Map<String, String> headers = {"Content-type": "application/json"};
      // for (int i = 0; i < _pickedImages.length; i++) {
      //   var file = await http.MultipartFile.fromPath('image', _pickedImages[i].path);
      //   request.files.add(file);
      // }
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
