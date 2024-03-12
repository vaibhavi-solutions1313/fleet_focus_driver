import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:staffin_softwares/app/modules/home/model/user_roaster_model_class.dart';
import 'package:staffin_softwares/main.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = 'YOUR-API-URL';
  }
  Future<http.StreamedResponse> findWages({required String startDate,required String endDate})async{
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/search-wages'));
    request.fields.addAll({
      'endDate': endDate,
      'startDate':startDate
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

    return response;

  }

  Future<http.StreamedResponse> fetchUserRoaster()async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    // var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-roaster'));
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-driver-roaster'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('fetchUSerRoaster:: ${response}');
    return response;
  }

  Future<http.StreamedResponse> fetchRosterHistory()async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-roaster-history'));
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    print('fetchRoasterHistory:: ${response}');
    return response;
  }

  Future<http.StreamedResponse> fetchAcceptRoaster({required String roasterId,required String isAccepted})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    print(roasterId);
    print(loginToken);
    print(isAccepted);
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/set-roaster-status'));
    request.fields.addAll({
      'roaster_id': roasterId,
      'status': isAccepted
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }

  Future<http.StreamedResponse>requestStartWorkingTime({required String resumeTimeAt})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/start-timer'));
    request.fields.addAll({
      'start_time': resumeTimeAt
    });

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   return response;

  }


  Future<http.StreamedResponse>getStartTimer()async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/start-timer'));
    request.fields.addAll({
      'start_time': DateTime.now().toString(),
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
   return response;
  }

  Future<http.StreamedResponse> fetchTimeDuration()async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/fetch-timer'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    return response;

  }


  Future<http.StreamedResponse>getStartWaiting({required String userId,required String waitingTime})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/start-waiting-timer'));
    request.fields.addAll({
      'user_id': userId,
      'start_time': waitingTime
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
   return response;
  }
  Future<http.StreamedResponse>getEndWaiting({required String userId,required String waitingTime})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/close-waiting-timer'));
    request.fields.addAll({
      'user_id': userId,
      'close_time': waitingTime
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
   return response;

  }

  Future<http.StreamedResponse>requestUpdateWorkingStatus({required String resumeTimeAt,required String isJobClosed,required String isJobPaused})async{
    var headers = {
      'Authorization': 'Bearer $loginToken'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://truckapp.store/api/close-timer'));
    request.fields.addAll({
      'close_time': resumeTimeAt,
      'is_job_closed': isJobClosed,
      'is_paused': isJobPaused
    });

    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();

   return response;

  }

}
