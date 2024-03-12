import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:staffin_softwares/app/app_constants/app_url.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/contract_view.dart';

class AuthProvider extends GetConnect {
  Future<http.StreamedResponse> getRequestLogin({
    required String deviceToken,
    required String userName,
    required String password,
  }) async {
    var request = http.MultipartRequest('POST', Uri.parse(AppUrl.baseUrl + AppUrl.loginUrl));
    request.fields.addAll({'email': userName, 'password': password, 'device_token': deviceToken});

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchLicenseType() async {
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-license-types'));
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchLicenseState() async {
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-license-types'));
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchVisaType() async {
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-visa-type'));
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> registerUser(
      {
        required Map data,
      // required String userAvatarPath,
      // required String passportImagePath,
      // required String passportBackImagePath,
      // required String visaImagePath,
      // required String abnImagePath,
      // required String licenseImagePath,
      // required String licenseBackImagePath,
      // required String signatureImagePath
      }) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/register'));
    request.fields.addAll({
      'ref_code': data['ref_code'],
      'full_name': data['full_name'],
      'email': data['email'],
      'password': data['password'],
      'password_confirmation': data['password'],
      /*'address': data['address'],
      'age': data['age'],
      'mobile_number': data['mobile_number'],
      'dob': data['dob'], //"2023-11-18",
      'passport_number': data['passport_number'],
      'passport_country': data['passport_country'],

      'wages_type': data['wages_type'],
      'break_type': data['break_type'],
      'visa_status_id': data['visa_status_id'],
      'hours_allowed_to_work': data['hours_allowed_to_work'],
      'bank_bsb': data['bank_bsb'],
      'abn': data['abn'],
      'bank_account_number': data['bank_account_number'],
      'license_type_id': data['license_type_id'],
      'license_state': data['license_state'],
      'license_number': data['license_number'],
      'employee_category': data['employee_category'],
      'ip_address': data['ip_address'],*/
      'is_condition_check': data['is_condition_check'],
    });

    // request.files.add(await http.MultipartFile.fromPath('photo', userAvatarPath));
    // request.files.add(await http.MultipartFile.fromPath('passport', passportImagePath));
    // // request.files.add(await http.MultipartFile.fromPath('passport_back', passportBackImagePath));
    // request.files.add(await http.MultipartFile.fromPath('visa', visaImagePath));
    // // request.files.add(await http.MultipartFile.fromPath('abn', abnImagePath));
    // request.files.add(await http.MultipartFile.fromPath('license', licenseImagePath));
    // request.files.add(await http.MultipartFile.fromPath('license_back', licenseBackImagePath));
    // request.files.add(await http.MultipartFile.fromPath('signature', signatureImagePath));
    print(request.fields.toString());
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> sendOtpForNewRegistration({required String emailId}) async {

    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/send-forgot-password-otp'));
    request.fields.addAll({
      'email': emailId
    });
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> verifyAccountByOtp({required String emailId, required String otp}) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/verify-otp'));
    request.fields.addAll({'email': emailId, 'otp': otp});

    http.StreamedResponse response = await request.send();
    return response;
  }

  ///Contract
 Future<http.StreamedResponse> fetchUserContract({required String abn,required String name})async{
   var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/get-terms-page'));
   request.fields.addAll({
     'full_name': name,
     'abn': abn
   });
   http.StreamedResponse response = await request.send();
   return response;
 }


  Future<http.StreamedResponse> fetchDeed({required String abn,required String name,required String address,})async{
   var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/get-deed-page'));
   request.fields.addAll({
     'abn': abn,
     'full_name': name,
     'address': address
   });
   http.StreamedResponse response = await request.send();

   return response;


 }
}
