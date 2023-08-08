// To parse this JSON data, do
//
//     final dpsModel = dpsModelFromJson(jsonString);

import 'dart:convert';

DpsModel dpsModelFromJson(String str) => DpsModel.fromJson(json.decode(str));

String dpsModelToJson(DpsModel data) => json.encode(data.toJson());

class DpsModel {
  String tid;
  int dpsBoardAvailable;
  String dpsBoardAvailableImage;
  int dpsBoardNotAvailable;
  String dpsBoardNotAvailableImage;
  String dpsRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  DpsModel({
    required this.tid,
    required this.dpsBoardAvailable,
    required this.dpsBoardAvailableImage,
    required this.dpsBoardNotAvailable,
    required this.dpsBoardNotAvailableImage,
    required this.dpsRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory DpsModel.fromJson(Map<String, dynamic> json) => DpsModel(
        tid: json["tid"],
        dpsBoardAvailable: json["dps_board_available"],
        dpsBoardAvailableImage: json["dps_board_available_image"],
        dpsBoardNotAvailable: json["dps_board_not_available"],
        dpsBoardNotAvailableImage: json["dps_board_not_available_image"],
        dpsRemark: json["dps_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "dps_board_available": dpsBoardAvailable,
        "dps_board_available_image": dpsBoardAvailableImage,
        "dps_board_not_available": dpsBoardNotAvailable,
        "dps_board_not_available_image": dpsBoardNotAvailableImage,
        "dps_remark": dpsRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
