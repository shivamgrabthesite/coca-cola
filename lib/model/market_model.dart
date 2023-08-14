// To parse this JSON data, do
//
//     final marketModel = marketModelFromJson(jsonString);

import 'dart:convert';

MarketModel marketModelFromJson(String str) => MarketModel.fromJson(json.decode(str));

String marketModelToJson(MarketModel data) => json.encode(data.toJson());

class MarketModel {
  bool? success;
  List<Datum>? data;

  MarketModel({
    this.success,
    this.data,
  });

  factory MarketModel.fromJson(Map<String, dynamic> json) => MarketModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  List<Day>? monday;
  int? count;
  List<Day>? tuesday;
  int? tuesdayCount;
  List<Day>? wednesday;
  int? wednesdayCount;
  List<Day>? thursday;
  int? thursdayCount;
  List<Day>? friday;
  int? fridayCount;
  List<Day>? saturday;
  int? saturdayCount;

  Datum({
    this.monday,
    this.count,
    this.tuesday,
    this.tuesdayCount,
    this.wednesday,
    this.wednesdayCount,
    this.thursday,
    this.thursdayCount,
    this.friday,
    this.fridayCount,
    this.saturday,
    this.saturdayCount,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        monday: json["Monday"] == null
            ? []
            : List<Day>.from(json["Monday"]!.map((x) => Day.fromJson(x))),
        count: json["count"],
        tuesday: json["Tuesday"] == null
            ? []
            : List<Day>.from(json["Tuesday"]!.map((x) => Day.fromJson(x))),
        tuesdayCount: json["tuesdayCount"],
        wednesday: json["Wednesday"] == null
            ? []
            : List<Day>.from(json["Wednesday"]!.map((x) => Day.fromJson(x))),
        wednesdayCount: json["WednesdayCount"],
        thursday: json["Thursday"] == null
            ? []
            : List<Day>.from(json["Thursday"]!.map((x) => Day.fromJson(x))),
        thursdayCount: json["ThursdayCount"],
        friday: json["Friday"] == null
            ? []
            : List<Day>.from(json["Friday"]!.map((x) => Day.fromJson(x))),
        fridayCount: json["FridayCount"],
        saturday: json["saturday"] == null
            ? []
            : List<Day>.from(json["saturday"]!.map((x) => Day.fromJson(x))),
        saturdayCount: json["saturdayCount"],
      );

  Map<String, dynamic> toJson() => {
        "Monday": monday == null ? [] : List<dynamic>.from(monday!.map((x) => x.toJson())),
        "count": count,
        "Tuesday": tuesday == null ? [] : List<dynamic>.from(tuesday!.map((x) => x.toJson())),
        "tuesdayCount": tuesdayCount,
        "Wednesday": wednesday == null ? [] : List<dynamic>.from(wednesday!.map((x) => x.toJson())),
        "WednesdayCount": wednesdayCount,
        "Thursday": thursday == null ? [] : List<dynamic>.from(thursday!.map((x) => x.toJson())),
        "ThursdayCount": thursdayCount,
        "Friday": friday == null ? [] : List<dynamic>.from(friday!.map((x) => x.toJson())),
        "FridayCount": fridayCount,
        "saturday": saturday == null ? [] : List<dynamic>.from(saturday!.map((x) => x.toJson())),
        "saturdayCount": saturdayCount,
      };
}

class Day {
  String? area;
  String? id;

  Day({
    this.area,
    this.id,
  });

  factory Day.fromJson(Map<String, dynamic> json) => Day(
        area: json["area"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "area": area,
        "id": id,
      };
}
