// To parse this JSON data, do
//
//     final customWeekModel = customWeekModelFromJson(jsonString);

import 'dart:convert';

CustomWeekModel customWeekModelFromJson(String str) => CustomWeekModel.fromJson(json.decode(str));

String customWeekModelToJson(CustomWeekModel data) => json.encode(data.toJson());

class CustomWeekModel {
  bool? success;
  String? message;

  CustomWeekModel({
    this.success,
    this.message,
  });

  factory CustomWeekModel.fromJson(Map<String, dynamic> json) => CustomWeekModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
