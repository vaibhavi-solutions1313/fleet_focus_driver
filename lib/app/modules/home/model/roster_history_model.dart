// To parse this JSON data, do
//
//     final rosterHistoryModel = rosterHistoryModelFromJson(jsonString);

import 'dart:convert';

RosterHistoryModel rosterHistoryModelFromJson(String str) => RosterHistoryModel.fromJson(json.decode(str));

String rosterHistoryModelToJson(RosterHistoryModel data) => json.encode(data.toJson());

class RosterHistoryModel {
  int? status;
  bool? success;
  List<Datum>? data;
  String? message;

  RosterHistoryModel({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory RosterHistoryModel.fromJson(Map<String, dynamic> json) => RosterHistoryModel(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class Datum {
  int? id;
  String? rego;
  int? driverId;
  int? status;
  int? vendorId;
  String? startTime;
  String? endTime;
  DateTime? date;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.rego,
    this.driverId,
    this.status,
    this.vendorId,
    this.startTime,
    this.endTime,
    this.date,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    rego: json["rego"],
    driverId: json["driver_id"],
    status: json["status"],
    vendorId: json["vendor_id"],
    startTime: json["start_time"],
    endTime: json["end_time"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rego": rego,
    "driver_id": driverId,
    "status": status,
    "vendor_id": vendorId,
    "start_time": startTime,
    "end_time": endTime,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}