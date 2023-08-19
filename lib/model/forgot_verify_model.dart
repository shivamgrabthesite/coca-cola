// To parse this JSON data, do
//
//     final forgotVerifyModel = forgotVerifyModelFromJson(jsonString);

import 'dart:convert';

ForgotVerifyModel forgotVerifyModelFromJson(String str) => ForgotVerifyModel.fromJson(json.decode(str));

String forgotVerifyModelToJson(ForgotVerifyModel data) => json.encode(data.toJson());

class ForgotVerifyModel {
  bool? success;
  String? message;

  ForgotVerifyModel({
    this.success,
    this.message,
  });

  factory ForgotVerifyModel.fromJson(Map<String, dynamic> json) => ForgotVerifyModel(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
