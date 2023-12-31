// To parse this JSON data, do
//
//     final priceStripModel = priceStripModelFromJson(jsonString);

import 'dart:convert';

PriceStripModel priceStripModelFromJson(String str) => PriceStripModel.fromJson(json.decode(str));

String priceStripModelToJson(PriceStripModel data) => json.encode(data.toJson());

class PriceStripModel {
  String? tid;
  int? priceStripAvailable;
  String? priceStripAvailableImage;
  int? priceStripNotAvailable;
  String? priceStripNotAvailableImage;
  String? priceStripRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PriceStripModel({
    this.tid,
    this.priceStripAvailable,
    this.priceStripAvailableImage,
    this.priceStripNotAvailable,
    this.priceStripNotAvailableImage,
    this.priceStripRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PriceStripModel.fromJson(Map<String, dynamic> json) => PriceStripModel(
        tid: json["tid"],
        priceStripAvailable: json["price_strip_available"],
        priceStripAvailableImage: json["price_strip_available_image"],
        priceStripNotAvailable: json["price_strip_not_available"],
        priceStripNotAvailableImage: json["price_strip_not_available_image"],
        priceStripRemark: json["price_strip_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "price_strip_available": priceStripAvailable,
        "price_strip_available_image": priceStripAvailableImage,
        "price_strip_not_available": priceStripNotAvailable,
        "price_strip_not_available_image": priceStripNotAvailableImage,
        "price_strip_remark": priceStripRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
