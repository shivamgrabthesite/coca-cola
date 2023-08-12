// To parse this JSON data, do
//
//     final aerialHangerModel = aerialHangerModelFromJson(jsonString);

import 'dart:convert';

AerialHangerModel aerialHangerModelFromJson(String str) =>
    AerialHangerModel.fromJson(json.decode(str));

String aerialHangerModelToJson(AerialHangerModel data) => json.encode(data.toJson());

class AerialHangerModel {
  String tid;
  int aerialHangerAvailable;
  String aerialHangerAvailableImage;
  int aerialHangerNotAvailable;
  String aerialHangerNotAvailableImage;
  String aerialHangerRemark;
  String customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AerialHangerModel({
    required this.tid,
    required this.aerialHangerAvailable,
    required this.aerialHangerAvailableImage,
    required this.aerialHangerNotAvailable,
    required this.aerialHangerNotAvailableImage,
    required this.aerialHangerRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AerialHangerModel.fromJson(Map<String, dynamic> json) => AerialHangerModel(
        tid: json["tid"],
        aerialHangerAvailable: json["aerial_hanger_available"],
        aerialHangerAvailableImage: json["aerial_hanger_available_image"],
        aerialHangerNotAvailable: json["aerial_hanger_not_available"],
        aerialHangerNotAvailableImage: json["aerial_hanger_not_available_image"],
        aerialHangerRemark: json["aerial_hanger_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "aerial_hanger_available": aerialHangerAvailable,
        "aerial_hanger_available_image": aerialHangerAvailableImage,
        "aerial_hanger_not_available": aerialHangerNotAvailable,
        "aerial_hanger_not_available_image": aerialHangerNotAvailableImage,
        "aerial_hanger_remark": aerialHangerRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
