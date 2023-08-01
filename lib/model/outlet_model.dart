// To parse this JSON data, do
//
//     final outetModel = outetModelFromJson(jsonString);

import 'dart:convert';

OutetModel outetModelFromJson(String str) => OutetModel.fromJson(json.decode(str));

String outetModelToJson(OutetModel data) => json.encode(data.toJson());

class OutetModel {
  bool success;
  List<Datum> data;

  OutetModel({
    required this.success,
    required this.data,
  });

  factory OutetModel.fromJson(Map<String, dynamic> json) => OutetModel(
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
  String imageChannal;
  String customerGccId;
  String priCustomerName;
  String redOutletClass;
  String channel;
  String address;

  Datum({
    required this.id,
    required this.imageChannal,
    required this.customerGccId,
    required this.priCustomerName,
    required this.redOutletClass,
    required this.channel,
    required this.address,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        imageChannal: json["image_channal"],
        customerGccId: json["Customer_GCC_ID"],
        priCustomerName: json["Pri_Customer_Name"],
        redOutletClass: json["Red_Outlet_Class"],
        channel: json["Channel"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image_channal": imageChannal,
        "Customer_GCC_ID": customerGccId,
        "Pri_Customer_Name": priCustomerName,
        "Red_Outlet_Class": redOutletClass,
        "Channel": channel,
        "address": address,
      };
}
