// To parse this JSON data, do
//
//     final populationModel = populationModelFromJson(jsonString);

import 'dart:convert';

PopulationModel populationModelFromJson(String str) => PopulationModel.fromJson(json.decode(str));

String populationModelToJson(PopulationModel data) => json.encode(data.toJson());

class PopulationModel {
  bool success;
  List<Datum> data;

  PopulationModel({
    required this.success,
    required this.data,
  });

  factory PopulationModel.fromJson(Map<String, dynamic> json) => PopulationModel(
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
  First four;
  First five;
  First six;

  Datum({
    required this.title,
    required this.first,
    required this.second,
    required this.third,
    required this.four,
    required this.five,
    required this.six,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        first: First.fromJson(json["first"]),
        second: First.fromJson(json["second"]),
        third: First.fromJson(json["third"]),
        four: First.fromJson(json["four"]),
        five: First.fromJson(json["five"]),
        six: First.fromJson(json["six"]),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": first.toJson(),
        "second": second.toJson(),
        "third": third.toJson(),
        "four": four.toJson(),
        "five": five.toJson(),
        "six": six.toJson(),
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
