class TruckDetailByRegoModelClass {
  int? status;
  bool? success;
  Data? data;
  String? message;

  TruckDetailByRegoModelClass(
      {this.status, this.success, this.data, this.message});

  TruckDetailByRegoModelClass.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int? id;
  int? truckNumber;
  int? vendorId;
  String? rego;
  int? odometerValue;
  int? serviceDue;
  int? vehicleTypeId;
  String? frontPhotoUrl;
  String? backPhotoUrl;
  String? rightPhotoUrl;
  String? leftPhotoUrl;
  String? fuelCardUrl;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
        this.truckNumber,
        this.vendorId,
        this.rego,
        this.odometerValue,
        this.serviceDue,
        this.vehicleTypeId,
        this.frontPhotoUrl,
        this.backPhotoUrl,
        this.rightPhotoUrl,
        this.leftPhotoUrl,
        this.fuelCardUrl,
        this.createdAt,
        this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    truckNumber = json['truck_number'];
    vendorId = json['vendor_id'];
    rego = json['rego'];
    odometerValue = json['odometer_value'];
    serviceDue = json['service_due'];
    vehicleTypeId = json['vehicle_type_id'];
    frontPhotoUrl = json['front_photo_url'];
    backPhotoUrl = json['back_photo_url'];
    rightPhotoUrl = json['right_photo_url'];
    leftPhotoUrl = json['left_photo_url'];
    fuelCardUrl = json['fuel_card_url'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['truck_number'] = this.truckNumber;
    data['vendor_id'] = this.vendorId;
    data['rego'] = this.rego;
    data['odometer_value'] = this.odometerValue;
    data['service_due'] = this.serviceDue;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['front_photo_url'] = this.frontPhotoUrl;
    data['back_photo_url'] = this.backPhotoUrl;
    data['right_photo_url'] = this.rightPhotoUrl;
    data['left_photo_url'] = this.leftPhotoUrl;
    data['fuel_card_url'] = this.fuelCardUrl;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
