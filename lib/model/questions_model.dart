// To parse this JSON data, do
//
//     final questionsModel = questionsModelFromJson(jsonString);

import 'dart:convert';

QuestionsModel questionsModelFromJson(String str) => QuestionsModel.fromJson(json.decode(str));

String questionsModelToJson(QuestionsModel data) => json.encode(data.toJson());

class QuestionsModel {
  bool? success;
  List<Datum>? data;

  QuestionsModel({
    this.success,
    this.data,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
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
  List<First>? first;
  List<First>? second;
  List<Third>? third;

  Datum({
    this.title,
    this.first,
    this.second,
    this.third,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        title: json["title"],
        first: List<First>.from(json["first"].map((x) => First.fromJson(x))),
        second: List<First>.from(json["second"].map((x) => First.fromJson(x))),
        third: List<Third>.from(json["third"].map((x) => Third.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "first": List<dynamic>.from(first!.map((x) => x.toJson())),
        "second": List<dynamic>.from(second!.map((x) => x.toJson())),
        "third": List<dynamic>.from(third!.map((x) => x.toJson())),
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

class Third {
  First? standee;
  First? verticalSignage;
  First? onewayVision;
  First? vinylBranding;

  Third({
    this.standee,
    this.verticalSignage,
    this.onewayVision,
    this.vinylBranding,
  });

  factory Third.fromJson(Map<String, dynamic> json) => Third(
        standee: First.fromJson(json["Standee"]),
        verticalSignage: First.fromJson(json["Vertical Signage"]),
        onewayVision: First.fromJson(json["Oneway Vision"]),
        vinylBranding: First.fromJson(json["Vinyl Branding"]),
      );

  Map<String, dynamic> toJson() => {
        "Standee": standee!.toJson(),
        "Vertical Signage": verticalSignage!.toJson(),
        "Oneway Vision": onewayVision!.toJson(),
        "Vinyl Branding": vinylBranding!.toJson(),
      };
}
