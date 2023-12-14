import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import '../../../../main.dart';

class DeclarationProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<http.StreamedResponse> fetchCustomerList()async{
    var headers = {'Authorization': 'Bearer $loginToken'};
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-client'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
   return response;

  }

  Future<http.StreamedResponse> fetchRego()async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    if (kDebugMode) {
      print(loginToken);
    }
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-rego'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    return response;
  }


  Future<http.StreamedResponse> fetchTruckDetailByRego({required String regoId})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };

    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/fetch-truck'));
    request.fields.addAll({
      'rego': regoId
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    return response;
  }
}
