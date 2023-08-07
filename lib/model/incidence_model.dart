// To parse this JSON data, do
//
//     final incidenceModel = incidenceModelFromJson(jsonString);

import 'dart:convert';

IncidenceModel incidenceModelFromJson(String str) => IncidenceModel.fromJson(json.decode(str));

String incidenceModelToJson(IncidenceModel data) => json.encode(data.toJson());

class IncidenceModel {
  bool success;
  List<Datum> data;

  IncidenceModel({
    required this.success,
    required this.data,
  });

  factory IncidenceModel.fromJson(Map<String, dynamic> json) => IncidenceModel(
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

  Datum({
    required this.title,
    required this.first,
    required this.second,
    required this.third,
    required this.four,
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
        "first": first.toJson(),
        "second": second.toJson(),
        "third": third.toJson(),
        "four": four.toJson(),
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
