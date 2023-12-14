class WagesModel {
  int? status;
  bool? success;
  List<Data>? data;
  String? message;

  WagesModel({this.status, this.success, this.data, this.message});

  WagesModel.fromJson(Map<String, dynamic> json) {
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
  int? userId;
  int? jobId;
  String? startTime;
  String? closedTime;
  int? amount;
  int? workingHours;
  int? breakHours;
  int? isJobClosed;
  int? isPaused;
  String? createdAt;
  String? updatedAt;
  int? driverNumber;
  String? rego;
  int? vehicleTypeId;
  String? company;
  int? odometerValue;
  int? serviceDue;
  String? frontPhotoUrl;
  String? backPhotoUrl;
  String? rightPhotoUrl;
  String? leftPhotoUrl;
  String? tyreRightPhotoUrl;
  String? tyreLeftPhotoUrl;
  String? fuelCardUrl;
  String? truckDamage1Url;
  String? truckDamage2Url;
  int? vendorId;
  String? name;
  dynamic username;
  String? email;
  dynamic emailVerifiedAt;
  String? password;
  String? companyName;
  String? address;
  String? refCode;
  int? roleId;
  dynamic twoFactorSecret;
  dynamic twoFactorRecoveryCodes;
  dynamic twoFactorConfirmedAt;
  String? rememberToken;
  String? deviceToken;
  dynamic latitude;
  dynamic longitute;
  dynamic currentTeamId;
  String? profilePhotoPath;
  int? planId;
  int? isOtpVerified;
  dynamic permissions;

  Data(
      {this.id,
        this.userId,
        this.jobId,
        this.startTime,
        this.closedTime,
        this.amount,
        this.workingHours,
        this.breakHours,
        this.isJobClosed,
        this.isPaused,
        this.createdAt,
        this.updatedAt,
        this.driverNumber,
        this.rego,
        this.vehicleTypeId,
        this.company,
        this.odometerValue,
        this.serviceDue,
        this.frontPhotoUrl,
        this.backPhotoUrl,
        this.rightPhotoUrl,
        this.leftPhotoUrl,
        this.tyreRightPhotoUrl,
        this.tyreLeftPhotoUrl,
        this.fuelCardUrl,
        this.truckDamage1Url,
        this.truckDamage2Url,
        this.vendorId,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.password,
        this.companyName,
        this.address,
        this.refCode,
        this.roleId,
        this.twoFactorSecret,
        this.twoFactorRecoveryCodes,
        this.twoFactorConfirmedAt,
        this.rememberToken,
        this.deviceToken,
        this.latitude,
        this.longitute,
        this.currentTeamId,
        this.profilePhotoPath,
        this.planId,
        this.isOtpVerified,
        this.permissions});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    jobId = json['job_id'];
    startTime = json['start_time'];
    closedTime = json['closed_time'];
    amount = json['amount'];
    workingHours = json['working_hours'];
    breakHours = json['break_hours'];
    isJobClosed = json['is_job_closed'];
    isPaused = json['is_paused'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driverNumber = json['driver_number'];
    rego = json['rego'];
    vehicleTypeId = json['vehicle_type_id'];
    company = json['company'];
    odometerValue = json['odometer_value'];
    serviceDue = json['service_due'];
    frontPhotoUrl = json['front_photo_url'];
    backPhotoUrl = json['back_photo_url'];
    rightPhotoUrl = json['right_photo_url'];
    leftPhotoUrl = json['left_photo_url'];
    tyreRightPhotoUrl = json['tyre_right_photo_url'];
    tyreLeftPhotoUrl = json['tyre_left_photo_url'];
    fuelCardUrl = json['fuel_card_url'];
    truckDamage1Url = json['truck_damage_1_url'];
    truckDamage2Url = json['truck_damage_2_url'];
    vendorId = json['vendor_id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    password = json['password'];
    companyName = json['company_name'];
    address = json['address'];
    refCode = json['ref_code'];
    roleId = json['role_id'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    rememberToken = json['remember_token'];
    deviceToken = json['device_token'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    planId = json['plan_id'];
    isOtpVerified = json['is_otp_verified'];
    permissions = json['permissions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['job_id'] = this.jobId;
    data['start_time'] = this.startTime;
    data['closed_time'] = this.closedTime;
    data['amount'] = this.amount;
    data['working_hours'] = this.workingHours;
    data['break_hours'] = this.breakHours;
    data['is_job_closed'] = this.isJobClosed;
    data['is_paused'] = this.isPaused;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['driver_number'] = this.driverNumber;
    data['rego'] = this.rego;
    data['vehicle_type_id'] = this.vehicleTypeId;
    data['company'] = this.company;
    data['odometer_value'] = this.odometerValue;
    data['service_due'] = this.serviceDue;
    data['front_photo_url'] = this.frontPhotoUrl;
    data['back_photo_url'] = this.backPhotoUrl;
    data['right_photo_url'] = this.rightPhotoUrl;
    data['left_photo_url'] = this.leftPhotoUrl;
    data['tyre_right_photo_url'] = this.tyreRightPhotoUrl;
    data['tyre_left_photo_url'] = this.tyreLeftPhotoUrl;
    data['fuel_card_url'] = this.fuelCardUrl;
    data['truck_damage_1_url'] = this.truckDamage1Url;
    data['truck_damage_2_url'] = this.truckDamage2Url;
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['password'] = this.password;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['ref_code'] = this.refCode;
    data['role_id'] = this.roleId;
    data['two_factor_secret'] = this.twoFactorSecret;
    data['two_factor_recovery_codes'] = this.twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['remember_token'] = this.rememberToken;
    data['device_token'] = this.deviceToken;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['plan_id'] = this.planId;
    data['is_otp_verified'] = this.isOtpVerified;
    data['permissions'] = this.permissions;
    return data;
  }
}
