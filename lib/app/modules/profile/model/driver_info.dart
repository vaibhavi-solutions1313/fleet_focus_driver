class DriverInfo {
  int? status;
  bool? success;
  Data? data;
  String? message;

  DriverInfo({this.status, this.success, this.data, this.message});

  DriverInfo.fromJson(Map<String, dynamic> json) {
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
  int? driverNumber;
  String? address;
  int? age;
  String? dob;
  String? mobileNumber;
  String? passportNumber;
  int? visaStatusId;
  dynamic visaStartDate;
  dynamic visaEndDate;
  int? hoursAllowedToWork;
  String? wagesType;
  int? wages;
  dynamic breakType;
  String? bankBsb;
  String? bankAccountNumber;
  String? abnumber;
  int? isRegisteredForGst;
  int? licenseTypeId;
  String? licenseState;
  String? licenseNumber;
  String? ipAddress;
  dynamic userAgent;
  String? photoUrl;
  String? passportUrl;
  String? passportBackUrl;
  String? visaUrl;
  String? abnUrl;
  dynamic licenseUrl;
  String? signatureUrl;
  dynamic coeUrl;
  dynamic mcUrl;
  dynamic salary;
  String? employeeCategory;
  int? isPermanent;
  int? isActive;
  dynamic startDate;
  dynamic endDate;
  int? isAvailable;
  int? userId;
  String? licenseBackUrl;
  dynamic passportCountry;
  String? refCode;
  String? createdAt;
  String? updatedAt;
  String? driverName;
  String? username;
  String? email;

  Data(
      {this.id,
        this.driverNumber,
        this.address,
        this.age,
        this.dob,
        this.mobileNumber,
        this.passportNumber,
        this.visaStatusId,
        this.visaStartDate,
        this.visaEndDate,
        this.hoursAllowedToWork,
        this.wagesType,
        this.wages,
        this.breakType,
        this.bankBsb,
        this.bankAccountNumber,
        this.abnumber,
        this.isRegisteredForGst,
        this.licenseTypeId,
        this.licenseState,
        this.licenseNumber,
        this.ipAddress,
        this.userAgent,
        this.photoUrl,
        this.passportUrl,
        this.passportBackUrl,
        this.visaUrl,
        this.abnUrl,
        this.licenseUrl,
        this.signatureUrl,
        this.coeUrl,
        this.mcUrl,
        this.salary,
        this.employeeCategory,
        this.isPermanent,
        this.isActive,
        this.startDate,
        this.endDate,
        this.isAvailable,
        this.userId,
        this.licenseBackUrl,
        this.passportCountry,
        this.refCode,
        this.createdAt,
        this.updatedAt,
        this.driverName,
        this.username,
        this.email});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    driverNumber = json['driver_number'];
    address = json['address'];
    age = json['age'];
    dob = json['dob'];
    mobileNumber = json['mobile_number'];
    passportNumber = json['passport_number'];
    visaStatusId = json['visa_status_id'];
    visaStartDate = json['visa_start_date'];
    visaEndDate = json['visa_end_date'];
    hoursAllowedToWork = json['hours_allowed_to_work'];
    wagesType = json['wages_type'];
    wages = json['wages'];
    breakType = json['break_type'];
    bankBsb = json['bank_bsb'];
    bankAccountNumber = json['bank_account_number'];
    abnumber = json['abnumber'];
    isRegisteredForGst = json['is_registered_for_gst'];
    licenseTypeId = json['license_type_id'];
    licenseState = json['license_state'];
    licenseNumber = json['license_number'];
    ipAddress = json['ip_address'];
    userAgent = json['user_agent'];
    photoUrl = json['photo_url'];
    passportUrl = json['passport_url'];
    passportBackUrl = json['passport_back_url'];
    visaUrl = json['visa_url'];
    abnUrl = json['abn_url'];
    licenseUrl = json['license_url'];
    signatureUrl = json['signature_url'];
    coeUrl = json['coe_url'];
    mcUrl = json['mc_url'];
    salary = json['salary'];
    employeeCategory = json['employee_category'];
    isPermanent = json['is_permanent'];
    isActive = json['is_active'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    isAvailable = json['is_available'];
    userId = json['user_id'];
    licenseBackUrl = json['license_back_url'];
    passportCountry = json['passport_country'];
    refCode = json['ref_code'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driverName = json['driver_name'];
    username = json['username'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['driver_number'] = this.driverNumber;
    data['address'] = this.address;
    data['age'] = this.age;
    data['dob'] = this.dob;
    data['mobile_number'] = this.mobileNumber;
    data['passport_number'] = this.passportNumber;
    data['visa_status_id'] = this.visaStatusId;
    data['visa_start_date'] = this.visaStartDate;
    data['visa_end_date'] = this.visaEndDate;
    data['hours_allowed_to_work'] = this.hoursAllowedToWork;
    data['wages_type'] = this.wagesType;
    data['wages'] = this.wages;
    data['break_type'] = this.breakType;
    data['bank_bsb'] = this.bankBsb;
    data['bank_account_number'] = this.bankAccountNumber;
    data['abnumber'] = this.abnumber;
    data['is_registered_for_gst'] = this.isRegisteredForGst;
    data['license_type_id'] = this.licenseTypeId;
    data['license_state'] = this.licenseState;
    data['license_number'] = this.licenseNumber;
    data['ip_address'] = this.ipAddress;
    data['user_agent'] = this.userAgent;
    data['photo_url'] = this.photoUrl;
    data['passport_url'] = this.passportUrl;
    data['passport_back_url'] = this.passportBackUrl;
    data['visa_url'] = this.visaUrl;
    data['abn_url'] = this.abnUrl;
    data['license_url'] = this.licenseUrl;
    data['signature_url'] = this.signatureUrl;
    data['coe_url'] = this.coeUrl;
    data['mc_url'] = this.mcUrl;
    data['salary'] = this.salary;
    data['employee_category'] = this.employeeCategory;
    data['is_permanent'] = this.isPermanent;
    data['is_active'] = this.isActive;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['is_available'] = this.isAvailable;
    data['user_id'] = this.userId;
    data['license_back_url'] = this.licenseBackUrl;
    data['passport_country'] = this.passportCountry;
    data['ref_code'] = this.refCode;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['driver_name'] = this.driverName;
    data['username'] = this.username;
    data['email'] = this.email;
    return data;
  }
}
