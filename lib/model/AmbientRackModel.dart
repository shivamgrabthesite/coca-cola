// To parse this JSON data, do
//
//     final ambientRackModel = ambientRackModelFromJson(jsonString);

import 'dart:convert';

AmbientRackModel ambientRackModelFromJson(String str) =>
    AmbientRackModel.fromJson(json.decode(str));

String ambientRackModelToJson(AmbientRackModel data) => json.encode(data.toJson());

class AmbientRackModel {
  String tid;
  int ambientRackAvailable;
  String ambientRackAvailableImage;
  int ambientRackNotAvailable;
  String ambientRackNotAvailableImage;
  String ambientRackRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  AmbientRackModel({
    required this.tid,
    required this.ambientRackAvailable,
    required this.ambientRackAvailableImage,
    required this.ambientRackNotAvailable,
    required this.ambientRackNotAvailableImage,
    required this.ambientRackRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory AmbientRackModel.fromJson(Map<String, dynamic> json) => AmbientRackModel(
        tid: json["tid"],
        ambientRackAvailable: json["ambient_rack_available"],
        ambientRackAvailableImage: json["ambient_rack_available_image"],
        ambientRackNotAvailable: json["ambient_rack_not_available"],
        ambientRackNotAvailableImage: json["ambient_rack_not_available_image"],
        ambientRackRemark: json["ambient_rack_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
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
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
