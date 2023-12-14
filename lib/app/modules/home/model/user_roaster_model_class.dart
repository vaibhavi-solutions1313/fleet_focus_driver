class UserRoasterModelClass {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  UserRoasterModelClass({this.status, this.success, this.data, this.message});

  UserRoasterModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
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

  Data(
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

  Data.fromJson(Map<String, dynamic> json) {
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
