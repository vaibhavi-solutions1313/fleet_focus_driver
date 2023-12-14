
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import '../app_constants/app_colors.dart';

class CustomLoader {
  static showLoader(){
    Get.dialog(
        WillPopScope(
            child: const Center(child:SpinKitCircle(
              color: AppColors.appPrimaryLightColor,
              size: 80.0,
              // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
            )),
            onWillPop: ()=>Future.value(false)),
        barrierDismissible: false,
        barrierColor: Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
        useSafeArea: true
    );
  }
  static void cancelLoader(){
    Get.back();
  }
}