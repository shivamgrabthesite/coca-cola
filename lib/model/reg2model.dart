// To parse this JSON data, do
//
//     final reg2Model = reg2ModelFromJson(jsonString);

import 'dart:convert';

Reg2Model reg2ModelFromJson(String str) => Reg2Model.fromJson(json.decode(str));

String reg2ModelToJson(Reg2Model data) => json.encode(data.toJson());

class Reg2Model {
  bool success;
  String message;

  Reg2Model({
    required this.success,
    required this.message,
  });

  factory Reg2Model.fromJson(Map<String, dynamic> json) => Reg2Model(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
