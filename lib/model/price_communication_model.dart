// To parse this JSON data, do
//
//     final priceCommunicationModel = priceCommunicationModelFromJson(jsonString);

import 'dart:convert';

PriceCommunicationModel priceCommunicationModelFromJson(String str) =>
    PriceCommunicationModel.fromJson(json.decode(str));

String priceCommunicationModelToJson(PriceCommunicationModel data) => json.encode(data.toJson());

class PriceCommunicationModel {
  bool? success;
  List<Datum>? data;

  PriceCommunicationModel({
    this.success,
    this.data,
  });

  factory PriceCommunicationModel.fromJson(Map<String, dynamic> json) => PriceCommunicationModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  String? title;
  First? first;
  First? second;
  First? third;
  First? four;

  Datum({
    this.title,
    this.first,
    this.second,
    this.third,
    this.four,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        first: First.fromJson(json["first"]),
        second: First.fromJson(json["second"]),
        third: First.fromJson(json["third"]),
        four: First.fromJson(json["four"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": first!.toJson(),
        "second": second!.toJson(),
        "third": third!.toJson(),
        "four": four!.toJson(),
      };
}

class First {
  String? title;
  String? imageLink;

  First({
    this.title,
    this.imageLink,
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
