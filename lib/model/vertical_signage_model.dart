// To parse this JSON data, do
//
//     final verticalSignageModel = verticalSignageModelFromJson(jsonString);

import 'dart:convert';

VerticalSignageModel verticalSignageModelFromJson(String str) =>
    VerticalSignageModel.fromJson(json.decode(str));

String verticalSignageModelToJson(VerticalSignageModel data) => json.encode(data.toJson());

class VerticalSignageModel {
  String tid;
  int verticalSignageAvailable;
  String verticalSignageAvailableImage;
  int verticalSignageNotAvailable;
  String verticalSignageNotAvailableImage;
  String verticalSignageRemark;
  String customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  VerticalSignageModel({
    required this.tid,
    required this.verticalSignageAvailable,
    required this.verticalSignageAvailableImage,
    required this.verticalSignageNotAvailable,
    required this.verticalSignageNotAvailableImage,
    required this.verticalSignageRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VerticalSignageModel.fromJson(Map<String, dynamic> json) => VerticalSignageModel(
        tid: json["tid"],
        verticalSignageAvailable: json["vertical_signage_available"],
        verticalSignageAvailableImage: json["vertical_signage_available_image"],
        verticalSignageNotAvailable: json["vertical_signage_not_available"],
        verticalSignageNotAvailableImage: json["vertical_signage_not_available_image"],
        verticalSignageRemark: json["vertical_signage_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "vertical_signage_available": verticalSignageAvailable,
        "vertical_signage_available_image": verticalSignageAvailableImage,
        "vertical_signage_not_available": verticalSignageNotAvailable,
        "vertical_signage_not_available_image": verticalSignageNotAvailableImage,
        "vertical_signage_remark": verticalSignageRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
