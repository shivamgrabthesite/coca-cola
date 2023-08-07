// To parse this JSON data, do
//
//     final counterTopModel = counterTopModelFromJson(jsonString);

import 'dart:convert';

CounterTopModel counterTopModelFromJson(String str) => CounterTopModel.fromJson(json.decode(str));

String counterTopModelToJson(CounterTopModel data) => json.encode(data.toJson());

class CounterTopModel {
  String tid;
  int counterTopAvailable;
  String counterTopAvailableImage;
  int counterTopNotAvailable;
  String counterTopNotAvailableImage;
  String counterTopRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  CounterTopModel({
    required this.tid,
    required this.counterTopAvailable,
    required this.counterTopAvailableImage,
    required this.counterTopNotAvailable,
    required this.counterTopNotAvailableImage,
    required this.counterTopRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory CounterTopModel.fromJson(Map<String, dynamic> json) => CounterTopModel(
        tid: json["tid"],
        counterTopAvailable: json["counter_top_available"],
        counterTopAvailableImage: json["counter_top_available_image"],
        counterTopNotAvailable: json["counter_top_not_available"],
        counterTopNotAvailableImage: json["counter_top_not_available_image"],
        counterTopRemark: json["counter_top_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "counter_top_available": counterTopAvailable,
        "counter_top_available_image": counterTopAvailableImage,
        "counter_top_not_available": counterTopNotAvailable,
        "counter_top_not_available_image": counterTopNotAvailableImage,
        "counter_top_remark": counterTopRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
