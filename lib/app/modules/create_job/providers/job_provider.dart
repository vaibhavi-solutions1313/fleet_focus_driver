import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:staffin_softwares/app/modules/create_job/controllers/create_job_controller.dart';
import 'package:staffin_softwares/main.dart';

class JobProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }

  Future<http.StreamedResponse> requestAddJobInformation({
    required String numberOfDelivery,
    required String deliveryFrom,
    required String deliveryTo,
    required String jobNumber,
    required String pickUpTime,
    required String remarks,
    required String signatureImagePath,
  }) async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/add-job-information'));
    request.fields.addAll({
      'customer_name': numberOfDelivery,
      'delivery_from': deliveryFrom,
      'delivery_to': deliveryTo,
      'job_number': jobNumber,
      'pickup_time': pickUpTime,
      'remarks': remarks
    });
    request.files.add(await http.MultipartFile.fromPath('signature', signatureImagePath));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchCustomerList() async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-client'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> fetchJobNumber() async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.Request('POST', Uri.parse('https://truckapp.store/api/get-driver-jobs'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> closeJob() async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/close-job'));
    Get.find<CreateJobController>().closeJobList.asMap().forEach((index, element) async {
      request.fields.addAll({
        'job_number[$index]': element['job_number'],
        'customer_name[$index]': element['customer_name'],
        'shrub[$index]': element['shrub'],
        'status[$index]': element['status'],
        'remarks[$index]': element['remarks'],
        'latitude': element['latitude'],
        'longitude': element['longitude'],
        'odo_value[$index]': element['odo_value']
      });
      request.files.add(await http.MultipartFile.fromPath('front_image[$index]', element['front_image']));
      request.files.add(await http.MultipartFile.fromPath('back_image[$index]', element['back_image']));
      request.files.add(await http.MultipartFile.fromPath('left_image[$index]', element['left_image']));
      request.files.add(await http.MultipartFile.fromPath('right_image[$index]', element['right_image']));
    });


    request.headers.addAll(headers);
    // print(request.fields);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> newCloseJobApiCall(List<Map<String, dynamic>> closeJobData) async {
    var headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $loginToken'};
    print(closeJobData);
    var request = http.Request('POST', Uri.parse('https://truckapp.store/api/close-job'));
    request.body = json.encode(closeJobData);
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(await response.stream.bytesToString());
      print(response.statusCode);
    }
    return response;
  }

  Future<http.StreamedResponse> closeTimer() async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/close-timer'));
    request.fields.addAll({'close_time': DateTime.now().toString(), 'is_job_closed': '1', 'is_paused': '1'});
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }

  Future<http.StreamedResponse> createJob({
    required String driverNumber,
    required List<String> driverName,
    required String vehicleTypeId,
    required String rego,
    required String odometer,
    required String serviceDue,
    required String truckFrontImage,
    required String truckBackImage,
    required String truckRightImage,
    required String truckLeftImage,
    required String truckLeftTyreImage,
    required String truckRightTyreImage,
    required String truckDamageImagePath1,
    required String truckDamageImagePath2,
    required String fuelCardImage,
    required String startWorkTime,
    // required numberOfJobs
  }) async {
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/add-job'));
    print('----------------------------------driverName----------------------------------------------');
    if (kDebugMode) {
      print(loginToken);
      print(jsonEncode(driverName));
      print(serviceDue.toString());
    }
    request.fields.addAll({
      'driver_number': driverNumber,
      'vehicle_type_id': vehicleTypeId,
      'rego': rego,
      'company_names': jsonEncode(driverName),
      'odo_value': odometer,
      'service_due': serviceDue
    });
    request.files.add(await http.MultipartFile.fromPath('front_photo', truckFrontImage));
    request.files.add(await http.MultipartFile.fromPath('back_photo', truckBackImage));
    request.files.add(await http.MultipartFile.fromPath('right_photo', truckRightImage));
    request.files.add(await http.MultipartFile.fromPath('left_photo', truckLeftImage));
    request.files.add(await http.MultipartFile.fromPath('tyre_right_photo', truckRightTyreImage));
    request.files.add(await http.MultipartFile.fromPath('tyre_left_photo', truckLeftTyreImage));
    request.files.add(await http.MultipartFile.fromPath('fuel_card', fuelCardImage));
    request.files.add(await http.MultipartFile.fromPath('truck_damage_1', truckDamageImagePath1));
    request.files.add(await http.MultipartFile.fromPath('truck_damage_2', truckDamageImagePath2));
    request.headers.addAll(headers);
    print(request.fields);
    http.StreamedResponse response = await request.send();
    return response;
  }
}
