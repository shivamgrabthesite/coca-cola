// To parse this JSON data, do
//
//     final packCutoutModel = packCutoutModelFromJson(jsonString);

import 'dart:convert';

PackCutoutModel packCutoutModelFromJson(String str) => PackCutoutModel.fromJson(json.decode(str));

String packCutoutModelToJson(PackCutoutModel data) => json.encode(data.toJson());

class PackCutoutModel {
  String tid;
  int packCutoutAvailable;
  String packCutoutAvailableImage;
  int packCutoutNotAvailable;
  String packCutoutNotAvailableImage;
  String packCutoutRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PackCutoutModel({
    required this.tid,
    required this.packCutoutAvailable,
    required this.packCutoutAvailableImage,
    required this.packCutoutNotAvailable,
    required this.packCutoutNotAvailableImage,
    required this.packCutoutRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory PackCutoutModel.fromJson(Map<String, dynamic> json) => PackCutoutModel(
        tid: json["tid"],
        packCutoutAvailable: json["pack_cutout_available"],
        packCutoutAvailableImage: json["pack_cutout_available_image"],
        packCutoutNotAvailable: json["pack_cutout_not_available"],
        packCutoutNotAvailableImage: json["pack_cutout_not_available_image"],
        packCutoutRemark: json["pack_cutout_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
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
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
