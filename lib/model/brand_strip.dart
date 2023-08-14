// To parse this JSON data, do
//
//     final brandStripModel = brandStripModelFromJson(jsonString);

import 'dart:convert';

BrandStripModel brandStripModelFromJson(String str) => BrandStripModel.fromJson(json.decode(str));

String brandStripModelToJson(BrandStripModel data) => json.encode(data.toJson());

class BrandStripModel {
  String? tid;
  int? brandStripAvailable;
  String? brandStripAvailableImage;
  int? brandStripNotAvailable;
  String? brandStripNotAvailableImage;
  String? brandStripRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  BrandStripModel({
    this.tid,
    this.brandStripAvailable,
    this.brandStripAvailableImage,
    this.brandStripNotAvailable,
    this.brandStripNotAvailableImage,
    this.brandStripRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory BrandStripModel.fromJson(Map<String, dynamic> json) => BrandStripModel(
        tid: json["tid"],
        brandStripAvailable: json["brand_strip_available"],
        brandStripAvailableImage: json["brand_strip_available_image"],
        brandStripNotAvailable: json["brand_strip_not_available"],
        brandStripNotAvailableImage: json["brand_strip_not_available_image"],
        brandStripRemark: json["brand_strip_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "brand_strip_available": brandStripAvailable,
        "brand_strip_available_image": brandStripAvailableImage,
        "brand_strip_not_available": brandStripNotAvailable,
        "brand_strip_not_available_image": brandStripNotAvailableImage,
        "brand_strip_remark": brandStripRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
