// To parse this JSON data, do
//
//     final mobileModel = mobileModelFromJson(jsonString);

import 'dart:convert';

MobileModel mobileModelFromJson(String str) => MobileModel.fromJson(json.decode(str));

String mobileModelToJson(MobileModel data) => json.encode(data.toJson());

class MobileModel {
  bool? success;
  String? message;

  MobileModel({
    this.success,
    this.message,
  });

  factory MobileModel.fromJson(Map<String, dynamic> json) => MobileModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
