// To parse this JSON data, do
//
//     final ambientDisplayModel = ambientDisplayModelFromJson(jsonString);

import 'dart:convert';

AmbientDisplayModel ambientDisplayModelFromJson(String str) =>
    AmbientDisplayModel.fromJson(json.decode(str));

String ambientDisplayModelToJson(AmbientDisplayModel data) => json.encode(data.toJson());

class AmbientDisplayModel {
  String tid;
  int ambientDisplayAvailable;
  String ambientDisplayAvailableImage;
  int ambientDisplayNotAvailable;
  String ambientDisplayNotAvailableImage;
  String ambientDisplayRemark;
  String customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AmbientDisplayModel({
    required this.tid,
    required this.ambientDisplayAvailable,
    required this.ambientDisplayAvailableImage,
    required this.ambientDisplayNotAvailable,
    required this.ambientDisplayNotAvailableImage,
    required this.ambientDisplayRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AmbientDisplayModel.fromJson(Map<String, dynamic> json) => AmbientDisplayModel(
        tid: json["tid"],
        ambientDisplayAvailable: json["ambient_display_available"],
        ambientDisplayAvailableImage: json["ambient_display_available_image"],
        ambientDisplayNotAvailable: json["ambient_display_not_available"],
        ambientDisplayNotAvailableImage: json["ambient_display_not_available_image"],
        ambientDisplayRemark: json["ambient_display_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "ambient_display_available": ambientDisplayAvailable,
        "ambient_display_available_image": ambientDisplayAvailableImage,
        "ambient_display_not_available": ambientDisplayNotAvailable,
        "ambient_display_not_available_image": ambientDisplayNotAvailableImage,
        "ambient_display_remark": ambientDisplayRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
