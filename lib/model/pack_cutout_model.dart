// To parse this JSON data, do
//
//     final packCutoutModel = packCutoutModelFromJson(jsonString);

import 'dart:convert';

PackCutoutModel packCutoutModelFromJson(String str) => PackCutoutModel.fromJson(json.decode(str));

String packCutoutModelToJson(PackCutoutModel data) => json.encode(data.toJson());

class PackCutoutModel {
  String? tid;
  int? packCutoutAvailable;
  String? packCutoutAvailableImage;
  int? packCutoutNotAvailable;
  String? packCutoutNotAvailableImage;
  String? packCutoutRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  PackCutoutModel({
    this.tid,
    this.packCutoutAvailable,
    this.packCutoutAvailableImage,
    this.packCutoutNotAvailable,
    this.packCutoutNotAvailableImage,
    this.packCutoutRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory PackCutoutModel.fromJson(Map<String, dynamic> json) => PackCutoutModel(
        tid: json["tid"],
        packCutoutAvailable: json["pack_cutout_available"],
        packCutoutAvailableImage: json["pack_cutout_available_image"],
        packCutoutNotAvailable: json["pack_cutout_not_available"],
        packCutoutNotAvailableImage: json["pack_cutout_not_available_image"],
        packCutoutRemark: json["pack_cutout_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "pack_cutout_available": packCutoutAvailable,
        "pack_cutout_available_image": packCutoutAvailableImage,
        "pack_cutout_not_available": packCutoutNotAvailable,
        "pack_cutout_not_available_image": packCutoutNotAvailableImage,
        "pack_cutout_remark": packCutoutRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
