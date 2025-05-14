// To parse this JSON data, do
//
//     final homeModel = homeModelFromJson(jsonString);

import 'dart:convert';

HomeModel homeModelFromJson(String str) => HomeModel.fromJson(json.decode(str));

String homeModelToJson(HomeModel data) => json.encode(data.toJson());

class HomeModel {
  int? code;
  String? message;
  Data? data;
  String? formattedPunchInTime;

  HomeModel({
    this.code,
    this.message,
    this.data,
    this.formattedPunchInTime,
  });

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(
    code: json["code"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    formattedPunchInTime: json["formatted_punch_in_time"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "data": data?.toJson(),
    "formatted_punch_in_time": formattedPunchInTime,
  };
}

class Data {
  String? userId;
  DateTime? punchInTime;
  String? punchInLatitude;
  String? punchInLongitude;
  String? punchInAddress;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.punchInTime,
    this.punchInLatitude,
    this.punchInLongitude,
    this.punchInAddress,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    punchInTime: json["punch_in_time"] == null ? null : DateTime.parse(json["punch_in_time"]),
    punchInLatitude: json["punch_in_latitude"],
    punchInLongitude: json["punch_in_longitude"],
    punchInAddress: json["punch_in_address"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "punch_in_time": punchInTime?.toIso8601String(),
    "punch_in_latitude": punchInLatitude,
    "punch_in_longitude": punchInLongitude,
    "punch_in_address": punchInAddress,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
