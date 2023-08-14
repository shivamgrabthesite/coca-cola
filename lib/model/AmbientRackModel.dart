// To parse this JSON data, do
//
//     final ambientRackModel = ambientRackModelFromJson(jsonString);

import 'dart:convert';

AmbientRackModel ambientRackModelFromJson(String str) =>
    AmbientRackModel.fromJson(json.decode(str));

String ambientRackModelToJson(AmbientRackModel data) => json.encode(data.toJson());

class AmbientRackModel {
  String? tid;
  int? ambientRackAvailable;
  String? ambientRackAvailableImage;
  int? ambientRackNotAvailable;
  String? ambientRackNotAvailableImage;
  String? ambientRackRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  AmbientRackModel({
    this.tid,
    this.ambientRackAvailable,
    this.ambientRackAvailableImage,
    this.ambientRackNotAvailable,
    this.ambientRackNotAvailableImage,
    this.ambientRackRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AmbientRackModel.fromJson(Map<String, dynamic> json) => AmbientRackModel(
        tid: json["tid"],
        ambientRackAvailable: json["ambient_rack_available"],
        ambientRackAvailableImage: json["ambient_rack_available_image"],
        ambientRackNotAvailable: json["ambient_rack_not_available"],
        ambientRackNotAvailableImage: json["ambient_rack_not_available_image"],
        ambientRackRemark: json["ambient_rack_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "ambient_rack_available": ambientRackAvailable,
        "ambient_rack_available_image": ambientRackAvailableImage,
        "ambient_rack_not_available": ambientRackNotAvailable,
        "ambient_rack_not_available_image": ambientRackNotAvailableImage,
        "ambient_rack_remark": ambientRackRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
