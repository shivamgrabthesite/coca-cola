// To parse this JSON data, do
//
//     final counterBrandingModel = counterBrandingModelFromJson(jsonString);

import 'dart:convert';

CounterBrandingModel counterBrandingModelFromJson(String str) =>
    CounterBrandingModel.fromJson(json.decode(str));

String counterBrandingModelToJson(CounterBrandingModel data) => json.encode(data.toJson());

class CounterBrandingModel {
  String tid;
  int counterBrandingAvailable;
  String counterBrandingAvailableImage;
  int counterBrandingNotAvailable;
  String counterBrandingNotAvailableImage;
  String counterBrandingRemark;
  String customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CounterBrandingModel({
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

  factory CounterBrandingModel.fromJson(Map<String, dynamic> json) => CounterBrandingModel(
        tid: json["tid"],
        counterBrandingAvailable: json["counter_branding_available"],
        counterBrandingAvailableImage: json["counter_branding_available_image"],
        counterBrandingNotAvailable: json["counter_branding_not_available"],
        counterBrandingNotAvailableImage: json["counter_branding_not_available_image"],
        counterBrandingRemark: json["counter_branding_remark"],
        customImage: json["custom_image"],
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
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
