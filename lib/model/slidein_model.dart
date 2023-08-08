// To parse this JSON data, do
//
//     final slideInModel = slideInModelFromJson(jsonString);

import 'dart:convert';

SlideInModel slideInModelFromJson(String str) => SlideInModel.fromJson(json.decode(str));

String slideInModelToJson(SlideInModel data) => json.encode(data.toJson());

class SlideInModel {
  String tid;
  int slideInPosterAvailable;
  String slideInPosterAvailableImage;
  int slideInPosterNotAvailable;
  String slideInPosterNotAvailableImage;
  String slideInPosterRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SlideInModel({
    required this.tid,
    required this.slideInPosterAvailable,
    required this.slideInPosterAvailableImage,
    required this.slideInPosterNotAvailable,
    required this.slideInPosterNotAvailableImage,
    required this.slideInPosterRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SlideInModel.fromJson(Map<String, dynamic> json) => SlideInModel(
        tid: json["tid"],
        slideInPosterAvailable: json["slide_in_poster_available"],
        slideInPosterAvailableImage: json["slide_in_poster_available_image"],
        slideInPosterNotAvailable: json["slide_in_poster_not_available"],
        slideInPosterNotAvailableImage: json["slide_in_poster_not_available_image"],
        slideInPosterRemark: json["slide_in_poster_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "slide_in_poster_available": slideInPosterAvailable,
        "slide_in_poster_available_image": slideInPosterAvailableImage,
        "slide_in_poster_not_available": slideInPosterNotAvailable,
        "slide_in_poster_not_available_image": slideInPosterNotAvailableImage,
        "slide_in_poster_remark": slideInPosterRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
