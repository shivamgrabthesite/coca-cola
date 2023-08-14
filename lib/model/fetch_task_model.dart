// To parse this JSON data, do
//
//     final fetchTaskModel = fetchTaskModelFromJson(jsonString);

import 'dart:convert';

FetchTaskModel fetchTaskModelFromJson(String str) => FetchTaskModel.fromJson(json.decode(str));

String fetchTaskModelToJson(FetchTaskModel data) => json.encode(data.toJson());

class FetchTaskModel {
  bool? success;
  List<Datum>? data;

  FetchTaskModel({
    this.success,
    this.data,
  });

  factory FetchTaskModel.fromJson(Map<String, dynamic> json) => FetchTaskModel(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Market? market;
  String? status;

  Datum({
    this.market,
    this.status,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        market: Market.fromJson(json["market"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "market": market!.toJson(),
        "status": status,
      };
}

class Market {
  String? id;
  String? studentName;
  String? studentEmail;
  String? studentPhone;
  String? scheduleWeek;
  String? day;
  String? collegeName;
  String? ringOfMagicArea;
  String? town;
  String? gccCode;
  String? outletName;
  String? fullOutletAddress;
  String? outletMobileNumber;
  String? mgrPresellerName;
  String? mgrContectNo;
  String? moeName;
  String? moeContact;
  String? channelManager;
  String? stlName;
  String? asmName;
  String? distributor;
  String? channel;
  String? redOlClass;
  String? cooler;
  String? uid;
  DateTime? updatedAt;

  Market({
    this.id,
    this.studentName,
    this.studentEmail,
    this.studentPhone,
    this.scheduleWeek,
    this.day,
    this.collegeName,
    this.ringOfMagicArea,
    this.town,
    this.gccCode,
    this.outletName,
    this.fullOutletAddress,
    this.outletMobileNumber,
    this.mgrPresellerName,
    this.mgrContectNo,
    this.moeName,
    this.moeContact,
    this.channelManager,
    this.stlName,
    this.asmName,
    this.distributor,
    this.channel,
    this.redOlClass,
    this.cooler,
    this.uid,
    this.updatedAt,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        id: json["_id"],
        studentName: json["student_name"],
        studentEmail: json["student_email"],
        studentPhone: json["student_phone"],
        scheduleWeek: json["schedule_week"],
        day: json["day"],
        collegeName: json["college_name"],
        ringOfMagicArea: json["ring_of_magic_area"],
        town: json["town"],
        gccCode: json["gcc_code"],
        outletName: json["outlet_name"],
        fullOutletAddress: json["full_outlet_address"],
        outletMobileNumber: json["outlet_mobile_number"],
        mgrPresellerName: json["mgr_preseller_name"],
        mgrContectNo: json["mgr_contect_no"],
        moeName: json["moe_name"],
        moeContact: json["moe_contact"],
        channelManager: json["channel_manager"],
        stlName: json["stl_name"],
        asmName: json["asm_name"],
        distributor: json["distributor"],
        channel: json["channel"],
        redOlClass: json["red_ol_class"],
        cooler: json["cooler"],
        uid: json["uid"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "student_name": studentName,
        "student_email": studentEmail,
        "student_phone": studentPhone,
        "schedule_week": scheduleWeek,
        "day": day,
        "college_name": collegeName,
        "ring_of_magic_area": ringOfMagicArea,
        "town": town,
        "gcc_code": gccCode,
        "outlet_name": outletName,
        "full_outlet_address": fullOutletAddress,
        "outlet_mobile_number": outletMobileNumber,
        "mgr_preseller_name": mgrPresellerName,
        "mgr_contect_no": mgrContectNo,
        "moe_name": moeName,
        "moe_contact": moeContact,
        "channel_manager": channelManager,
        "stl_name": stlName,
        "asm_name": asmName,
        "distributor": distributor,
        "channel": channel,
        "red_ol_class": redOlClass,
        "cooler": cooler,
        "uid": uid,
        "updatedAt": updatedAt!.toIso8601String(),
      };
}
