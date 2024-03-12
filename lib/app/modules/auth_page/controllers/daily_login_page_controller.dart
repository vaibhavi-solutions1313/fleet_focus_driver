import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_constants/getstorage_keys.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/daily_login_page_view.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/truck_details.dart';
import 'package:staffin_softwares/app/modules/declaration_page/views/information_needed_before_start_view.dart';
import 'package:staffin_softwares/app/modules/home/bindings/home_binding.dart';
import 'package:staffin_softwares/app/modules/home/views/home_view.dart';
import 'package:staffin_softwares/main.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/custom_bottom_sheet.dart';
import '../../../app_widgets/custom_grid_item.dart';
import '../../../app_widgets/custom_loader.dart';
import '../../create_job/providers/job_provider.dart';
import '../../home/providers/home_provider.dart';
import '../../declaration_page/providers/declaration_provider.dart';
import '../../declaration_page/views/declaration_page_view.dart';
import '../views/terms_conditions_deed_view.dart';
import '../views/truck_images.dart';

class DailyLoginPageController extends GetxController {
  //TODO: Implement DailyLoginPageController
  // DeclarationProvider provider=DeclarationProvider();

  var dailyLoginItems = <GridItem>[
    GridItem(
        image: 'assets/daily_login/declaration_img.png',
        title: '1. Declaration',
        subtitle: 'Incomplete'.obs,
        icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          DeclarationPageView(),
        );
      },
    ),
    GridItem(
        image: 'assets/daily_login/truck_customer_img.png',
        title: '2. Truck Detail',
        subtitle: 'Incomplete'.obs,
        icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          TruckDetailsView(),
        );
      },
    ),
    GridItem(
        image: 'assets/daily_login/truck_customer_img.png',
        title: '3. Customer Detail',
        subtitle: 'Incomplete'.obs,
        icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          InformationNeededBeforeStartView(),
        );
      },
    ),
    GridItem(
        image: 'assets/daily_login/truck_img.png',
        title: '4. Truck Images',
        subtitle: 'Incomplete'.obs,
        icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          TruckImagesPageView(),
        );
      },
    ),
    GridItem(
        image: 'assets/daily_login/truck_img.png',
        title: '5. T & C',
        subtitle: 'Incomplete'.obs,
        icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          TermsConditionsDeedsPageView(),
        );
      },
    ),

  ];

  void updateDailyLoginGrid(int index){
    dailyLoginItems[index].icon.value = 'assets/daily_login/green_tick.png';
    dailyLoginItems[index].subtitle.value = 'Completed';
  }

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
}