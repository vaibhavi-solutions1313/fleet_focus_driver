import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/auth_page_controller.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/daily_login_page_controller.dart';

import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown_strings.dart';

class TruckDetailsView extends GetView<AuthPageController> {
  const TruckDetailsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var statusDropDown = ['Delivered', 'Pending', 'Returned'];
    var selectedStatus;
    AuthPageController controller = Get.put(AuthPageController());
    DailyLoginPageController dailyLoginPageController = Get.put(DailyLoginPageController());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: Scaffold(
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, top: 10),
                  child: const Text20By700(text: AppString.dailyLoginTruckDetails)),
              SizedBox(height: 15,),
              Form(
                // key: controller.signUpFormKey,
                key: controller.truckDetailsFormKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AppTextField(controller: controller.truckNumberTextEditingController,hinText: AppString.driverNumberTruckDetails ),
                    SizedBox(height: 12,),
                    OurListStringDropDown(
                        onDropdownChanged: (value) {
                          // controller.closeJobList[widget.index]['status'] = value;
                        },
                        dropdownItems: statusDropDown,
                        hintText: AppString.regoTruckDetails,
                        selectedDropdownItem: selectedStatus),
                    AppTextField(controller: controller.odometerValueTextEditingController, hinText: AppString.odometerValueTruckDetails),
                    SizedBox(height: 50,),
                    CustomSolidButton(text: AppString.saveButtonText,
                        onTap: (){
                      controller.getTruckDetails(
                          driverNumber: controller.truckNumberTextEditingController.text,
                          rego: '',
                          odometerValue: controller.odometerValueTextEditingController.text
                      );

                        print('Truck Details Saved successfully------------');
                    }),
                  ],
                ),
              ),
              // SizedBox(height: 15,),
              // RichText(
              //     textAlign: TextAlign.center,
              //     text: TextSpan(
              //         style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
              //         children: [
              //           const TextSpan(text:AppString.signUpPageStringHaveAlreadyAccount),
              //           TextSpan(
              //               recognizer: TapGestureRecognizer()..onTap=(){
              //                 Get.back();
              //               },
              //               text:AppString.signUpPageStringForLoginNow,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
              //         ]
              //     ))
            ],
          ),
        ),
      ),
    );
  }
}
