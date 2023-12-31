// To parse this JSON data, do
//
//     final vinylBrandingModel = vinylBrandingModelFromJson(jsonString);

import 'dart:convert';

VinylBrandingModel vinylBrandingModelFromJson(String str) =>
    VinylBrandingModel.fromJson(json.decode(str));

String vinylBrandingModelToJson(VinylBrandingModel data) => json.encode(data.toJson());

class VinylBrandingModel {
  String? tid;
  int? vinylBrandingAvailable;
  String? vinylBrandingAvailableImage;
  int? vinylBrandingNotAvailable;
  String? vinylBrandingNotAvailableImage;
  String? vinylBrandingRemark;
  String? customImage;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? v;

  VinylBrandingModel({
    this.tid,
    this.vinylBrandingAvailable,
    this.vinylBrandingAvailableImage,
    this.vinylBrandingNotAvailable,
    this.vinylBrandingNotAvailableImage,
    this.vinylBrandingRemark,
    this.customImage,
    this.id,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory VinylBrandingModel.fromJson(Map<String, dynamic> json) => VinylBrandingModel(
        tid: json["tid"],
        vinylBrandingAvailable: json["vinyl_branding_available"],
        vinylBrandingAvailableImage: json["vinyl_branding_available_image"],
        vinylBrandingNotAvailable: json["vinyl_branding_not_available"],
        vinylBrandingNotAvailableImage: json["vinyl_branding_not_available_image"],
        vinylBrandingRemark: json["vinyl_branding_remark"],
        customImage: json["custom_image"],
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
        "custom_image": customImage,
        "_id": id,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
      };
}
