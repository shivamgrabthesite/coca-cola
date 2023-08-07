// To parse this JSON data, do
//
//     final coolerModel = coolerModelFromJson(jsonString);

import 'dart:convert';

CoolerModel coolerModelFromJson(String str) => CoolerModel.fromJson(json.decode(str));

String coolerModelToJson(CoolerModel data) => json.encode(data.toJson());

class CoolerModel {
  String tid;
  int coolerAvailable;
  String coolerAvailableImage;
  int coolerNotAvailable;
  String coolerNotAvailableImage;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CoolerModel({
    required this.tid,
    required this.coolerAvailable,
    required this.coolerAvailableImage,
    required this.coolerNotAvailable,
    required this.coolerNotAvailableImage,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CoolerModel.fromJson(Map<String, dynamic> json) => CoolerModel(
        tid: json["tid"],
        coolerAvailable: json["cooler_available"],
        coolerAvailableImage: json["cooler_available_image"],
        coolerNotAvailable: json["cooler_not_available"],
        coolerNotAvailableImage: json["cooler_not_available_image"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
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
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
