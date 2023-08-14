// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
  bool? success;
  String? message;
  Data? data;
  UserData? userData;

  LoginModel({
    this.success,
    this.message,
    this.data,
    this.userData,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
        userData: UserData.fromJson(json["user_data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data!.toJson(),
        "user_data": userData!.toJson(),
      };
}

class Data {
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        user: User.fromJson(json["user"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "token": token,
      };
}

class User {
  String? week;
  String? collegeName;

  User({
    this.week,
    this.collegeName,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        week: json["week"],
        collegeName: json["college_name"],
      );

  Map<String, dynamic> toJson() => {
        "week": week,
        "college_name": collegeName,
      };
}

class UserData {
  List<String>? role;
  bool? verify;
  String? id;
  String? phoneNumber;
  String? firstName;
  String? lastName;
  String? userEmail;

  UserData({
    this.role,
    this.verify,
    this.id,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.userEmail,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        role: List<String>.from(json["role"].map((x) => x)),
        verify: json["verify"],
        id: json["_id"],
        phoneNumber: json["phone_number"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        userEmail: json["user_email"],
      );

  Map<String, dynamic> toJson() => {
        "role": List<dynamic>.from(role!.map((x) => x)),
        "verify": verify,
        "_id": id,
        "phone_number": phoneNumber,
        "first_name": firstName,
        "last_name": lastName,
        "user_email": userEmail,
      };
}
