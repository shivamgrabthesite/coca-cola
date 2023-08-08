// To parse this JSON data, do
//
//     final counterBrandModel = counterBrandModelFromJson(jsonString);

import 'dart:convert';

CounterBrandModel counterBrandModelFromJson(String str) =>
    CounterBrandModel.fromJson(json.decode(str));

String counterBrandModelToJson(CounterBrandModel data) => json.encode(data.toJson());

class CounterBrandModel {
  String tid;
  int counterBrandingAvailable;
  String counterBrandingAvailableImage;
  int counterBrandingNotAvailable;
  String counterBrandingNotAvailableImage;
  String counterBrandingRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CounterBrandModel({
    required this.tid,
    required this.counterBrandingAvailable,
    required this.counterBrandingAvailableImage,
    required this.counterBrandingNotAvailable,
    required this.counterBrandingNotAvailableImage,
    required this.counterBrandingRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CounterBrandModel.fromJson(Map<String, dynamic> json) => CounterBrandModel(
        tid: json["tid"],
        counterBrandingAvailable: json["counter_branding_available"],
        counterBrandingAvailableImage: json["counter_branding_available_image"],
        counterBrandingNotAvailable: json["counter_branding_not_available"],
        counterBrandingNotAvailableImage: json["counter_branding_not_available_image"],
        counterBrandingRemark: json["counter_branding_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "counter_branding_available": counterBrandingAvailable,
        "counter_branding_available_image": counterBrandingAvailableImage,
        "counter_branding_not_available": counterBrandingNotAvailable,
        "counter_branding_not_available_image": counterBrandingNotAvailableImage,
        "counter_branding_remark": counterBrandingRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
