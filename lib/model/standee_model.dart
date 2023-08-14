// To parse this JSON data, do
//
//     final standeeModel = standeeModelFromJson(jsonString);

import 'dart:convert';

StandeeModel standeeModelFromJson(String str) => StandeeModel.fromJson(json.decode(str));

String standeeModelToJson(StandeeModel data) => json.encode(data.toJson());

class StandeeModel {
  String? tid;
  int? standeeAvailable;
  String? standeeAvailableImage;
  int? standeeNotAvailable;
  String? standeeNotAvailableImage;
  String? standeeRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  StandeeModel({
    this.tid,
    this.standeeAvailable,
    this.standeeAvailableImage,
    this.standeeNotAvailable,
    this.standeeNotAvailableImage,
    this.standeeRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory StandeeModel.fromJson(Map<String, dynamic> json) => StandeeModel(
        tid: json["tid"],
        standeeAvailable: json["standee_available"],
        standeeAvailableImage: json["standee_available_image"],
        standeeNotAvailable: json["standee_not_available"],
        standeeNotAvailableImage: json["standee_not_available_image"],
        standeeRemark: json["standee_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "standee_available": standeeAvailable,
        "standee_available_image": standeeAvailableImage,
        "standee_not_available": standeeNotAvailable,
        "standee_not_available_image": standeeNotAvailableImage,
        "standee_remark": standeeRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
