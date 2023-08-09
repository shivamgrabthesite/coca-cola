// To parse this JSON data, do
//
//     final outletDetailModel = outletDetailModelFromJson(jsonString);

import 'dart:convert';

OutletDetailModel outletDetailModelFromJson(String str) =>
    OutletDetailModel.fromJson(json.decode(str));

String outletDetailModelToJson(OutletDetailModel data) => json.encode(data.toJson());

class OutletDetailModel {
  bool success;
  Data data;

  OutletDetailModel({
    required this.success,
    required this.data,
  });

  factory OutletDetailModel.fromJson(Map<String, dynamic> json) => OutletDetailModel(
        success: json["success"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
      };
}

class Data {
  String id;
  int srNo;
  String customerGccId;
  String priCustomerName;
  String channel;
  String redOutletClass;
  String marketArea;
  String unit;
  String city;
  String collegeName;
  String smName;
  String asmName;
  String stlName;
  String mgrName;
  String distName;
  String week;
  String day;
  String mid;
  String uid;
  String mobileNumber;

  Data({
    required this.id,
    required this.srNo,
    required this.customerGccId,
    required this.priCustomerName,
    required this.channel,
    required this.redOutletClass,
    required this.marketArea,
    required this.unit,
    required this.city,
    required this.collegeName,
    required this.smName,
    required this.asmName,
    required this.stlName,
    required this.mgrName,
    required this.distName,
    required this.week,
    required this.day,
    required this.mid,
    required this.uid,
    required this.mobileNumber,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        srNo: json["Sr. No"],
        customerGccId: json["Customer_GCC_ID"],
        priCustomerName: json["Pri_Customer_Name"],
        channel: json["Channel"],
        redOutletClass: json["Red Outlet Class"],
        marketArea: json["Market Area"],
        unit: json["Unit"],
        city: json["City"],
        collegeName: json["College Name"],
        smName: json["SM Name"],
        asmName: json["ASM Name"],
        stlName: json["STL Name"],
        mgrName: json["MGR Name"],
        distName: json["Dist. Name"],
        week: json["Week"],
        day: json["Day"],
        mid: json["mid"],
        uid: json["uid"],
        mobileNumber: json["mobile_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "Sr. No": srNo,
        "Customer_GCC_ID": customerGccId,
        "Pri_Customer_Name": priCustomerName,
        "Channel": channel,
        "Red Outlet Class": redOutletClass,
        "Market Area": marketArea,
        "Unit": unit,
        "City": city,
        "College Name": collegeName,
        "SM Name": smName,
        "ASM Name": asmName,
        "STL Name": stlName,
        "MGR Name": mgrName,
        "Dist. Name": distName,
        "Week": week,
        "Day": day,
        "mid": mid,
        "uid": uid,
        "mobile_number": mobileNumber,
      };
}
