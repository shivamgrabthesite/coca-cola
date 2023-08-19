// To parse this JSON data, do
//
//     final emailOtpModel = emailOtpModelFromJson(jsonString);

import 'dart:convert';

EmailOtpModel emailOtpModelFromJson(String str) => EmailOtpModel.fromJson(json.decode(str));

String emailOtpModelToJson(EmailOtpModel data) => json.encode(data.toJson());

class EmailOtpModel {
  bool? success;
  String? message;

  EmailOtpModel({
    this.success,
    this.message,
  });

  factory EmailOtpModel.fromJson(Map<String, dynamic> json) => EmailOtpModel(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
