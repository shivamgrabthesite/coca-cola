// To parse this JSON data, do
//
//     final forgotEmailModel1 = forgotEmailModel1FromJson(jsonString);

import 'dart:convert';

ForgotEmailModel1 forgotEmailModel1FromJson(String str) => ForgotEmailModel1.fromJson(json.decode(str));

String forgotEmailModel1ToJson(ForgotEmailModel1 data) => json.encode(data.toJson());

class ForgotEmailModel1 {
  bool? success;
  String? message;
  String? data;

  ForgotEmailModel1({
    this.success,
    this.message,
    this.data,
  });

  factory ForgotEmailModel1.fromJson(Map<String, dynamic> json) => ForgotEmailModel1(
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
