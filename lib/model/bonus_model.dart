// To parse this JSON data, do
//
//     final bonusModel = bonusModelFromJson(jsonString);

import 'dart:convert';

BonusModel bonusModelFromJson(String str) => BonusModel.fromJson(json.decode(str));

String bonusModelToJson(BonusModel data) => json.encode(data.toJson());

class BonusModel {
  bool success;
  List<Datum> data;

  BonusModel({
    required this.success,
    required this.data,
  });

  factory BonusModel.fromJson(Map<String, dynamic> json) => BonusModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String title;
  First first;
  First second;
  First third;

  Datum({
    required this.title,
    required this.first,
    required this.second,
    required this.third,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        first: First.fromJson(json["first"]),
        second: First.fromJson(json["second"]),
        third: First.fromJson(json["third"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": first.toJson(),
        "second": second.toJson(),
        "third": third.toJson(),
      };
}

class First {
  String title;
  String imageLink;

  First({
    required this.title,
    required this.imageLink,
  });

  factory First.fromJson(Map<String, dynamic> json) => First(
        title: json["title"],
        imageLink: json["image_link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image_link": imageLink,
      };
}
