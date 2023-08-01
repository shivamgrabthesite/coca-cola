// To parse this JSON data, do
//
//     final marketModel = marketModelFromJson(jsonString);

import 'dart:convert';

MarketModel marketModelFromJson(String str) => MarketModel.fromJson(json.decode(str));

String marketModelToJson(MarketModel data) => json.encode(data.toJson());

class MarketModel {
  bool success;
  List<Datum> data;

  MarketModel({
    required this.success,
    required this.data,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String week;
  String marketArea;

  Datum({
    required this.id,
    required this.week,
    required this.marketArea,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        week: json["Week "],
        marketArea: json["Market Area"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Week ": week,
        "Market Area": marketArea,
      };
}
