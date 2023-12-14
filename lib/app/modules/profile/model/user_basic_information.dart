class UserBasicInformation {
  int? status;
  bool? success;
  Data? data;
  String? message;

  UserBasicInformation({this.status, this.success, this.data, this.message});

  UserBasicInformation.fromJson(Map<String, dynamic> json) {
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
  String? name;
  String? username;
  String? email;
  dynamic emailVerifiedAt;
  dynamic companyName;
  String? address;
  String? refCode;
  int? vendorId;
  int? roleId;
  dynamic twoFactorConfirmedAt;
  String? deviceToken;
  dynamic latitude;
  dynamic longitute;
  dynamic currentTeamId;
  dynamic profilePhotoPath;
  int? planId;
  int? isOtpVerified;
  String? createdAt;
  String? updatedAt;
  String? profilePhotoUrl;

  Data(
      {this.id,
        this.name,
        this.username,
        this.email,
        this.emailVerifiedAt,
        this.companyName,
        this.address,
        this.refCode,
        this.vendorId,
        this.roleId,
        this.twoFactorConfirmedAt,
        this.deviceToken,
        this.latitude,
        this.longitute,
        this.currentTeamId,
        this.profilePhotoPath,
        this.planId,
        this.isOtpVerified,
        this.createdAt,
        this.updatedAt,
        this.profilePhotoUrl});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    companyName = json['company_name'];
    address = json['address'];
    refCode = json['ref_code'];
    vendorId = json['vendor_id'];
    roleId = json['role_id'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    deviceToken = json['device_token'];
    latitude = json['latitude'];
    longitute = json['longitute'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    planId = json['plan_id'];
    isOtpVerified = json['is_otp_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['company_name'] = this.companyName;
    data['address'] = this.address;
    data['ref_code'] = this.refCode;
    data['vendor_id'] = this.vendorId;
    data['role_id'] = this.roleId;
    data['two_factor_confirmed_at'] = this.twoFactorConfirmedAt;
    data['device_token'] = this.deviceToken;
    data['latitude'] = this.latitude;
    data['longitute'] = this.longitute;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['plan_id'] = this.planId;
    data['is_otp_verified'] = this.isOtpVerified;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
