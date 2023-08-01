// To parse this JSON data, do
//
//     final reg1Model = reg1ModelFromJson(jsonString);

import 'dart:convert';

Reg1Model reg1ModelFromJson(String str) => Reg1Model.fromJson(json.decode(str));

String reg1ModelToJson(Reg1Model data) => json.encode(data.toJson());

class Reg1Model {
  bool success;
  String message;
  String data;

  Reg1Model({
    required this.success,
    required this.message,
    required this.data,
  });

  factory Reg1Model.fromJson(Map<String, dynamic> json) => Reg1Model(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
