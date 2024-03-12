import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:staffin_softwares/app/app_constants/getstorage_keys.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/auth_page_view.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/register_view.dart';
import 'package:staffin_softwares/main.dart';

import '../../../app_widgets/custom_loader.dart';
import '../../auth_page/views/update_additional_info_view.dart';
import '../../auth_page/views/update_profile_view.dart';
import '../../declaration_page/bindings/declaration_page_binding.dart';
import '../../auth_page/views/daily_login_page_view.dart';
import '../../declaration_page/views/declaration_page_view.dart';
import '../../home/bindings/home_binding.dart';
import '../../home/views/home_view.dart';
import '../../profile/providers/profile_provider.dart';
import '../../profile/views/profile_details_view.dart';

class SplashScreenController extends GetxController {
  //TODO: Implement SplashScreenController

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

  void goToLoginPage() async {
    Get.to(() => AuthPageView(), binding: AuthPageBinding());
  }

  void goToRegisterPage() async {
    Get.to(() => const RegisterView(), binding: AuthPageBinding());
  }

  Future tryAutoLogin() async {
    CustomLoader.showLoader();

    var alreadyLoggedInTime = getStorage.read(GetStorageKeys.lastLoginTime);
    if (alreadyLoggedInTime != null) {
      bool isSameDay = false;
      int days = calculateDifferenceInDays(
          DateTime.now(), DateTime.tryParse(alreadyLoggedInTime)!);
      print('alreadyLoggedInTime :: ${alreadyLoggedInTime}');
      print(
          'Difference :: ${calculateDifferenceInDays(DateTime.now(), DateTime.now())}');
      isSameDay = days == 0 ? true : false;
      print('Same Day :: ${isSameDay}');

      if (isSameDay) {
        if (getStorage.hasData(GetStorageKeys.userLoginToken)) {
          loginToken = getStorage.read(GetStorageKeys.userLoginToken);
          ProfileProvider()
              .fetchUserInfo(loginUserToken: loginToken)
              .then((userInfo) async {
            await ProfileProvider()
                .fetchDriverInfo(loginUserToken: loginToken)
                .then((resultDriverInfo) {
              // CustomLoader.cancelLoader();
              driverInfo = resultDriverInfo;
            });
            if (userInfo.data != null && driverInfo.data != null) {
              CustomLoader.cancelLoader();

              Get.to(() => const HomeView(), binding: HomeBinding());
            } else {
              CustomLoader.cancelLoader();
              AppServices()
                  .showToastMessage(toastMessage: 'Something went wrong');
              goToLoginPage();
            }
          });
        }
      } else {
        CustomLoader.cancelLoader();
        goToLoginPage();
      }
    } else {
      CustomLoader.cancelLoader();
      goToLoginPage();
    }
  }

  /*tryAutoLogin() async {
    CustomLoader.showLoader();
    if (getStorage.hasData(GetStorageKeys.userLoginToken)) {
      loginToken = getStorage.read(GetStorageKeys.userLoginToken);
      ProfileProvider()
          .fetchUserInfo(loginUserToken: loginToken)
          .then((userInfo) async {
        await ProfileProvider()
            .fetchDriverInfo(loginUserToken: loginToken)
            .then((driverInfo) {
          // CustomLoader.cancelLoader();
        });
        if (userInfo.data != null && driverInfo.data != null) {
          bool isSameDay = false;
          var lastStoredTime = getStorage.read(GetStorageKeys.lastLoginTime);
          print('lastStoredTime :: ${lastStoredTime}');
          if (lastStoredTime != null) {
            int days = calculateDifferenceInDays(
                DateTime.now(), DateTime.tryParse(lastStoredTime)!);
            print('lastStoredTime :: ${lastStoredTime}');
            print(
                'Difference :: ${calculateDifferenceInDays(DateTime.now(), DateTime.now())}');
            isSameDay = days == 0 ? true : false;
            print('Same Day :: ${isSameDay}');
          }
          CustomLoader.cancelLoader();
          if (isSameDay) {
            Get.to(() => const HomeView(), binding: HomeBinding());
          } else {
            goToLoginPage();
            // Get.to(() => const ProfileDetailsPageView());
            // Get.to(() => const DeclarationPageView(), binding: DeclarationPageBinding());
            // Get.to(() => const DailyLoginPageView());
          }
        } else {
          CustomLoader.cancelLoader();
          AppServices().showToastMessage(toastMessage: 'Something went wrong');
        }
      });
    } else {
      CustomLoader.cancelLoader();
      AppServices().determinePosition();
      // Get.to(() => const ProfileDetailsPageView());
      // goToLoginPage();
      Get.to(() => const HomeView());
    }
  }*/

  int calculateDifferenceInDays(DateTime startDate, DateTime endDate) {
    // Set the time portion of both dates to midnight
    DateTime startMidnight =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime endMidnight = DateTime(endDate.year, endDate.month, endDate.day);

    Duration difference = endMidnight.difference(startMidnight);
    return difference.inDays.abs();
  }
}
