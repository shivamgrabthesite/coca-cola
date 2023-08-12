// To parse this JSON data, do
//
//     final onewayVisionModel = onewayVisionModelFromJson(jsonString);

import 'dart:convert';

OnewayVisionModel onewayVisionModelFromJson(String str) =>
    OnewayVisionModel.fromJson(json.decode(str));

String onewayVisionModelToJson(OnewayVisionModel data) => json.encode(data.toJson());

class OnewayVisionModel {
  String tid;
  int onewayVisionAvailable;
  String onewayVisionAvailableImage;
  int onewayVisionNotAvailable;
  String onewayVisionNotAvailableImage;
  String onewayVisionRemark;
  String customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  OnewayVisionModel({
    required this.tid,
    required this.onewayVisionAvailable,
    required this.onewayVisionAvailableImage,
    required this.onewayVisionNotAvailable,
    required this.onewayVisionNotAvailableImage,
    required this.onewayVisionRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory OnewayVisionModel.fromJson(Map<String, dynamic> json) => OnewayVisionModel(
        tid: json["tid"],
        onewayVisionAvailable: json["oneway_vision_available"],
        onewayVisionAvailableImage: json["oneway_vision_available_image"],
        onewayVisionNotAvailable: json["oneway_vision_not_available"],
        onewayVisionNotAvailableImage: json["oneway_vision_not_available_image"],
        onewayVisionRemark: json["oneway_vision_remark"],
        customImage: json["custom_image"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "oneway_vision_available": onewayVisionAvailable,
        "oneway_vision_available_image": onewayVisionAvailableImage,
        "oneway_vision_not_available": onewayVisionNotAvailable,
        "oneway_vision_not_available_image": onewayVisionNotAvailableImage,
        "oneway_vision_remark": onewayVisionRemark,
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
