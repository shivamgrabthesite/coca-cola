// To parse this JSON data, do
//
//     final coolerModel = coolerModelFromJson(jsonString);

import 'dart:convert';

CoolerModel coolerModelFromJson(String str) => CoolerModel.fromJson(json.decode(str));

String coolerModelToJson(CoolerModel data) => json.encode(data.toJson());

class CoolerModel {
  String? tid;
  int? coolerAvailable;
  String? coolerAvailableImage;
  int? coolerNotAvailable;
  String? coolerNotAvailableImage;
  String? coolerRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  CoolerModel({
    this.tid,
    this.coolerAvailable,
    this.coolerAvailableImage,
    this.coolerNotAvailable,
    this.coolerNotAvailableImage,
    this.coolerRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CoolerModel.fromJson(Map<String, dynamic> json) => CoolerModel(
        tid: json["tid"],
        coolerAvailable: json["cooler_available"],
        coolerAvailableImage: json["cooler_available_image"],
        coolerNotAvailable: json["cooler_not_available"],
        coolerNotAvailableImage: json["cooler_not_available_image"],
        coolerRemark: json["cooler_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "cooler_available": coolerAvailable,
        "cooler_available_image": coolerAvailableImage,
        "cooler_not_available": coolerNotAvailable,
        "cooler_not_available_image": coolerNotAvailableImage,
        "cooler_remark": coolerRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
