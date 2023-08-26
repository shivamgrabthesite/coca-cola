// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  Token? token;
  UserData? userData;

  LoginModel({
    this.success,
    this.message,
    this.token,
    this.userData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        token: Token.fromJson(json["token"]),
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token!.toJson(),
        "user_data": userData!.toJson(),
      };
}

class Token {
  String? token;

  Token({
    this.token,
  });

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };
}

class UserData {
  List<String>? role;
  bool? verify;
  String? id;
  String? firstName;
  String? lastName;
  String? userEmail;

  UserData({
    this.role,
    this.verify,
    this.id,
    this.firstName,
    this.lastName,
    this.userEmail,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        role: List<String>.from(json["role"].map((x) => x)),
        verify: json["verify"],
        id: json["_id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userEmail: json["user_email"],
      );

  Map<String, dynamic> toJson() => {
        "role": List<dynamic>.from(role!.map((x) => x)),
        "verify": verify,
        "_id": id,
        "first_name": firstName,
        "last_name": lastName,
        "user_email": userEmail,
      };
}
