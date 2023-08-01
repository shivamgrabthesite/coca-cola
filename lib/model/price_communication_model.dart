// To parse this JSON data, do
//
//     final priceCommunicationModel = priceCommunicationModelFromJson(jsonString);

import 'dart:convert';

PriceCommunicationModel priceCommunicationModelFromJson(String str) =>
    PriceCommunicationModel.fromJson(json.decode(str));

String priceCommunicationModelToJson(PriceCommunicationModel data) => json.encode(data.toJson());

class PriceCommunicationModel {
  bool success;
  List<Datum> data;

  PriceCommunicationModel({
    required this.success,
    required this.data,
  });

  factory PriceCommunicationModel.fromJson(Map<String, dynamic> json) => PriceCommunicationModel(
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
  List<First> first;
  List<First> second;
  List<First> third;

  Datum({
    required this.title,
    required this.first,
    required this.second,
    required this.third,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        first: List<First>.from(json["first"].map((x) => First.fromJson(x))),
        second: List<First>.from(json["second"].map((x) => First.fromJson(x))),
        third: List<First>.from(json["third"].map((x) => First.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": List<dynamic>.from(first.map((x) => x.toJson())),
        "second": List<dynamic>.from(second.map((x) => x.toJson())),
        "third": List<dynamic>.from(third.map((x) => x.toJson())),
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
