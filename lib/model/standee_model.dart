// To parse this JSON data, do
//
//     final standeeModel = standeeModelFromJson(jsonString);

import 'dart:convert';

StandeeModel standeeModelFromJson(String str) => StandeeModel.fromJson(json.decode(str));

String standeeModelToJson(StandeeModel data) => json.encode(data.toJson());

class StandeeModel {
  String tid;
  int standeeAvailable;
  String standeeAvailableImage;
  int standeeNotAvailable;
  String standeeNotAvailableImage;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  StandeeModel({
    required this.tid,
    required this.standeeAvailable,
    required this.standeeAvailableImage,
    required this.standeeNotAvailable,
    required this.standeeNotAvailableImage,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory StandeeModel.fromJson(Map<String, dynamic> json) => StandeeModel(
        tid: json["tid"],
        standeeAvailable: json["standee_available"],
        standeeAvailableImage: json["standee_available_image"],
        standeeNotAvailable: json["standee_not_available"],
        standeeNotAvailableImage: json["standee_not_available_image"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
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
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
