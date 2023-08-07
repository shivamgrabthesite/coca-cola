// To parse this JSON data, do
//
//     final marketModel = marketModelFromJson(jsonString);

import 'dart:convert';

MarketModel marketModelFromJson(String str) => MarketModel.fromJson(json.decode(str));

String marketModelToJson(MarketModel data) => json.encode(data.toJson());

class MarketModel {
  bool success;
  List<dynamic> data;

  MarketModel({
    required this.success,
    required this.data,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        success: json["success"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}

class DatumClass {
  String area;
  DateTime date;
  String id;

  DatumClass({
    required this.area,
    required this.date,
    required this.id,
  });

  factory DatumClass.fromJson(Map<String, dynamic> json) => DatumClass(
        area: json["area"],
        date: DateTime.parse(json["date"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "id": id,
      };
}
