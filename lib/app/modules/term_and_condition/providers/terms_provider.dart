import 'package:get/get.dart';
import 'package:http/http.dart'as http;
class TermsProvider extends GetConnect {

  Future<http.StreamedResponse> fetchTermAndCondition()async{
    var request = http.Request('GET', Uri.parse('https://truckapp.store/api/get-terms-deed-urlss'));
    http.StreamedResponse response = await request.send();
   return response;
  }

  Future<http.StreamedResponse> fetchTermsCondition({required String url})async{
    var request = http.Request('GET', Uri.parse(url));
    http.StreamedResponse response = await request.send();
   return response;
  }

}
