import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../providers/terms_provider.dart';

class TermAndConditionController extends GetxController {
  //TODO: Implement TermAndConditionController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<String> getTermAndCondition() async {
    return await TermsProvider().fetchTermAndCondition().then((value) async {
      if (value.statusCode == 200) {
        print('-----------------200-----------------------');
        // var decodedData = jsonDecode(await value.stream.bytesToString());
        var decodedData =  jsonDecode(await value.stream.bytesToString())['data']['terms_condition'];

        if (decodedData != "") {
          return await TermsProvider().fetchTermsCondition(url: decodedData).then((htmlResponse) async {
            print('-----------------htmlResponse-----------------------');
            var htmlRes = await htmlResponse.stream.bytesToString();
            print('-----------------htmlResponse-2----------------------');
            print(htmlRes);
            return htmlRes;
          });
        } else {
          return 'Not available';
        }
      } else {
        return 'Something went wrong';
      }
    });
  }
}
