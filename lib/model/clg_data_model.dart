// To parse this JSON data, do
//
//     final clgDataModel = clgDataModelFromJson(jsonString);

import 'dart:convert';

ClgDataModel clgDataModelFromJson(String str) => ClgDataModel.fromJson(json.decode(str));

String clgDataModelToJson(ClgDataModel data) => json.encode(data.toJson());

class ClgDataModel {
  bool success;
  List<Datum> data;

  ClgDataModel({
    required this.success,
    required this.data,
  });

  factory ClgDataModel.fromJson(Map<String, dynamic> json) => ClgDataModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String institutePermanentId;
  String instituteName;
  String state;
  String district;
  String city;

  Datum({
    required this.id,
    required this.institutePermanentId,
    required this.instituteName,
    required this.state,
    required this.district,
    required this.city,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        institutePermanentId: json["Institute Permanent ID"],
        instituteName: json["Institute Name"],
        state: json["State"],
        district: json["District"],
        city: json["City"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Institute Permanent ID": institutePermanentId,
        "Institute Name": instituteName,
        "State": state,
        "District": district,
        "City": city,
      };
}
