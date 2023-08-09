// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  bool success;
  Data data;

  TaskModel({
    required this.success,
    required this.data,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  String mid;
  String uid;
  String status;
  String id;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  Data({
    required this.mid,
    required this.uid,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        mid: json["mid"],
        uid: json["uid"],
        status: json["status"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "mid": mid,
        "uid": uid,
        "status": status,
        "_id": id,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
      };
}
