import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:staffin_softwares/app/app_services/services.dart';

import '../../../../main.dart';
import '../../../app_constants/app_strings.dart';
import '../model/driver_info.dart';
import '../model/user_basic_information.dart';

class ProfileProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<UserBasicInformation> fetchUserInfo({required String loginUserToken}) async {
    var headers = {'Authorization': 'Bearer $loginUserToken'};
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-user'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if(response.statusCode==200){
      return userBasicInformation=UserBasicInformation.fromJson(jsonDecode(await response.stream.bytesToString()));
    }else{
      return userBasicInformation;
    }

  }
  ///////////////////////////////////////////////////////////////////////////////////////////////////////
  Future<DriverInfo> fetchDriverInfo({required String loginUserToken}) async {
    var headers = {'Authorization': 'Bearer $loginUserToken'};
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-driver'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();


    // UserBasicInformation userBasicInformation=UserBasicInformation();
    if(response.statusCode==200){
      if (kDebugMode) {
        print('-----------------------success---fetchDriverInfo-------------------------------------');
      }
      return driverInfo=DriverInfo.fromJson(jsonDecode(await response.stream.bytesToString()));
    }else{
      return driverInfo;
    }

  }
  /////////////////////////////////////////////////////////////////////////////////
Future <void> updatePassword({required String oldPassword,required String newPassword,required String cnfPassword,})async {
  var headers = {'Authorization': 'Bearer $loginToken'};
  var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/change-password'));
  request.fields.addAll({
    'current_password':oldPassword,
    'new_password': newPassword,
    'confirm_password':cnfPassword
  });

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    AppServices().showToastMessage(toastMessage: AppString.profilePagePasswordUpdatedSuccessfulMessage);
  }
  else {
    print(response.reasonPhrase);
  }

}
}
