// To parse this JSON data, do
//
//     final resModel = resModelFromJson(jsonString);

import 'dart:convert';

ResModel resModelFromJson(String str) => ResModel.fromJson(json.decode(str));

String resModelToJson(ResModel data) => json.encode(data.toJson());

class ResModel {
  bool? success;

  ResModel({
    this.success,
  });

  factory ResModel.fromJson(Map<String, dynamic> json) => ResModel(
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
      };
}
