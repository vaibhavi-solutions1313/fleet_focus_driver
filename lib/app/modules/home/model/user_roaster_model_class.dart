/*
class UserRoasterModelClass {
  int? status;
  bool? success;
  List<UserRoasterData>? data;
  String? message;

  UserRoasterModelClass({this.status, this.success, this.data, this.message});

  UserRoasterModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <UserRoasterData>[];
      json['data'].forEach((v) {
        data!.add(new UserRoasterData.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class UserRoasterData {
  int? id;
  String? rego;
  int? driverId;
  int? status;
  int? vendorId;
  dynamic startTime;
  dynamic endTime;
  dynamic date;
  String? createdAt;
  String? updatedAt;

  UserRoasterData(
      {this.id,
        this.rego,
        this.driverId,
        this.status,
        this.vendorId,
        this.startTime,
        this.endTime,
        this.date,
        this.createdAt,
        this.updatedAt});

  UserRoasterData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rego = json['rego'];
    driverId = json['driver_id'];
    status = json['status'];
    vendorId = json['vendor_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    date = json['date'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rego'] = this.rego;
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    data['vendor_id'] = this.vendorId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['date'] = this.date;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
*/
import 'dart:convert';

UserRoasterModelClass userRoasterModelClassFromJson(String str) => UserRoasterModelClass.fromJson(json.decode(str));

String userRoasterModelClassToJson(UserRoasterModelClass data) => json.encode(data.toJson());

class UserRoasterModelClass {
  int? status;
  bool? success;
  List<UserRoasterData>? data;
  String? message;

  UserRoasterModelClass({
    this.status,
    this.success,
    this.data,
    this.message,
  });

  factory UserRoasterModelClass.fromJson(Map<String, dynamic> json) => UserRoasterModelClass(
    status: json["status"],
    success: json["success"],
    data: json["data"] == null ? [] : List<UserRoasterData>.from(json["data"]!.map((x) => UserRoasterData.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "success": success,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "message": message,
  };
}

class UserRoasterData {
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
  String? username;

  UserRoasterData({
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
    this.username,
  });

  factory UserRoasterData.fromJson(Map<String, dynamic> json) => UserRoasterData(
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
    username: json["username"],
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
    "username": username,
  };
}
