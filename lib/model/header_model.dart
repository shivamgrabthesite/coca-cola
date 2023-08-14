// To parse this JSON data, do
//
//     final headerModel = headerModelFromJson(jsonString);

import 'dart:convert';

HeaderModel headerModelFromJson(String str) => HeaderModel.fromJson(json.decode(str));

String headerModelToJson(HeaderModel data) => json.encode(data.toJson());

class HeaderModel {
  bool? success;
  Data? data;

  HeaderModel({
    this.success,
    this.data,
  });

  factory HeaderModel.fromJson(Map<String, dynamic> json) => HeaderModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data!.toJson(),
      };
}

class Data {
  String? wishes;
  String? name;

  Data({
    this.wishes,
    this.name,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wishes: json["wishes"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "wishes": wishes,
        "name": name,
      };
}
