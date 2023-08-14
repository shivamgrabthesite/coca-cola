// To parse this JSON data, do
//
//     final weekScheduleModel = weekScheduleModelFromJson(jsonString);

import 'dart:convert';

WeekScheduleModel weekScheduleModelFromJson(String str) =>
    WeekScheduleModel.fromJson(json.decode(str));

String weekScheduleModelToJson(WeekScheduleModel data) => json.encode(data.toJson());

class WeekScheduleModel {
  bool? success;
  String? message;

  WeekScheduleModel({
    this.success,
    this.message,
  });

  factory WeekScheduleModel.fromJson(Map<String, dynamic> json) => WeekScheduleModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
