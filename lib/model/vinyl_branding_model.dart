// To parse this JSON data, do
//
//     final vinylBrandingModel = vinylBrandingModelFromJson(jsonString);

import 'dart:convert';

VinylBrandingModel vinylBrandingModelFromJson(String str) =>
    VinylBrandingModel.fromJson(json.decode(str));

String vinylBrandingModelToJson(VinylBrandingModel data) => json.encode(data.toJson());

class VinylBrandingModel {
  String tid;
  int vinylBrandingAvailable;
  String vinylBrandingAvailableImage;
  int vinylBrandingNotAvailable;
  String vinylBrandingNotAvailableImage;
  String vinylBrandingRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  VinylBrandingModel({
    required this.tid,
    required this.vinylBrandingAvailable,
    required this.vinylBrandingAvailableImage,
    required this.vinylBrandingNotAvailable,
    required this.vinylBrandingNotAvailableImage,
    required this.vinylBrandingRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory VinylBrandingModel.fromJson(Map<String, dynamic> json) => VinylBrandingModel(
        tid: json["tid"],
        vinylBrandingAvailable: json["vinyl_branding_available"],
        vinylBrandingAvailableImage: json["vinyl_branding_available_image"],
        vinylBrandingNotAvailable: json["vinyl_branding_not_available"],
        vinylBrandingNotAvailableImage: json["vinyl_branding_not_available_image"],
        vinylBrandingRemark: json["vinyl_branding_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "vinyl_branding_available": vinylBrandingAvailable,
        "vinyl_branding_available_image": vinylBrandingAvailableImage,
        "vinyl_branding_not_available": vinylBrandingNotAvailable,
        "vinyl_branding_not_available_image": vinylBrandingNotAvailableImage,
        "vinyl_branding_remark": vinylBrandingRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
