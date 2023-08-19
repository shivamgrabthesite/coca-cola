// To parse this JSON data, do
//
//     final forgotLastModel = forgotLastModelFromJson(jsonString);

import 'dart:convert';

ForgotLastModel forgotLastModelFromJson(String str) => ForgotLastModel.fromJson(json.decode(str));

String forgotLastModelToJson(ForgotLastModel data) => json.encode(data.toJson());

class ForgotLastModel {
  bool? success;
  String? message;

  ForgotLastModel({
    this.success,
    this.message,
  });

  factory ForgotLastModel.fromJson(Map<String, dynamic> json) => ForgotLastModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
