// To parse this JSON data, do
//
//     final groceryRackModel = groceryRackModelFromJson(jsonString);

import 'dart:convert';

GroceryRackModel groceryRackModelFromJson(String str) =>
    GroceryRackModel.fromJson(json.decode(str));

String groceryRackModelToJson(GroceryRackModel data) => json.encode(data.toJson());

class GroceryRackModel {
  String tid;
  int groceryRackAvailable;
  String groceryRackAvailableImage;
  int groceryRackNotAvailable;
  String groceryRackNotAvailableImage;
  String groceryRackRemark;
  List<dynamic> customImage;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  GroceryRackModel({
    required this.tid,
    required this.groceryRackAvailable,
    required this.groceryRackAvailableImage,
    required this.groceryRackNotAvailable,
    required this.groceryRackNotAvailableImage,
    required this.groceryRackRemark,
    required this.customImage,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory GroceryRackModel.fromJson(Map<String, dynamic> json) => GroceryRackModel(
        tid: json["tid"],
        groceryRackAvailable: json["grocery_rack_available"],
        groceryRackAvailableImage: json["grocery_rack_available_image"],
        groceryRackNotAvailable: json["grocery_rack_not_available"],
        groceryRackNotAvailableImage: json["grocery_rack_not_available_image"],
        groceryRackRemark: json["grocery_rack_remark"],
        customImage: List<dynamic>.from(json["custom_image"].map((x) => x)),
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "tid": tid,
        "grocery_rack_available": groceryRackAvailable,
        "grocery_rack_available_image": groceryRackAvailableImage,
        "grocery_rack_not_available": groceryRackNotAvailable,
        "grocery_rack_not_available_image": groceryRackNotAvailableImage,
        "grocery_rack_remark": groceryRackRemark,
        "custom_image": List<dynamic>.from(customImage.map((x) => x)),
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
