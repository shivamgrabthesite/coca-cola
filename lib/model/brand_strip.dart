// To parse this JSON data, do
//
//     final brandStripModel = brandStripModelFromJson(jsonString);

import 'dart:convert';

BrandStripModel brandStripModelFromJson(String str) => BrandStripModel.fromJson(json.decode(str));

String brandStripModelToJson(BrandStripModel data) => json.encode(data.toJson());

class BrandStripModel {
  String tid;
  int brandStripAvailable;
  String brandStripAvailableImage;
  int brandStripNotAvailable;
  String brandStripNotAvailableImage;
  String brandStripRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  BrandStripModel({
    required this.tid,
    required this.brandStripAvailable,
    required this.brandStripAvailableImage,
    required this.brandStripNotAvailable,
    required this.brandStripNotAvailableImage,
    required this.brandStripRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory BrandStripModel.fromJson(Map<String, dynamic> json) => BrandStripModel(
        tid: json["tid"],
        brandStripAvailable: json["brand_strip_available"],
        brandStripAvailableImage: json["brand_strip_available_image"],
        brandStripNotAvailable: json["brand_strip_not_available"],
        brandStripNotAvailableImage: json["brand_strip_not_available_image"],
        brandStripRemark: json["brand_strip_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
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
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
