import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/update_additional_info_view.dart';
import 'package:staffin_softwares/app/modules/profile/controllers/profile_controller.dart';
import 'dart:io';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown.dart';
import '../controllers/auth_page_controller.dart';

class VisaPassportDetails extends GetView<AuthPageController> {
  const VisaPassportDetails({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(AuthPageController());
    ProfileController profileController = Get.put(ProfileController());
    print(controller.visaTypeDropdownData);
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: Scaffold(
          body: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              SafeArea(
                child: Form(
                  key: controller.updateProfileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // const CustomAppBar(
                      //   title: AppString.updateProfilePageTitle,
                      // ),
                      Container(
                        padding: EdgeInsets.only(left: 10.0, top: 10.0),
                        child: Text('2. Visa & Passport Details', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            letterSpacing: 0.2
                        ),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextField(controller: controller.passportNumberTextEditingController, hinText: AppString.updateProfilePagePassportNumber),
                      SizedBox(
                        height: 12,
                      ),
                      OurListObjectDropDown(dropdownItems:controller.visaTypeDropdownData,
                          onDropdownChanged: (value) {
                            controller.visaTypeTextEditingController.text=value['visa_id'].toString();
                          }, keyName: "visa_type",hintText: AppString.updateProfilePageDropdownSelectVisaType),

                      Row(
                        children: [
                          Expanded(
                              child: AppCalendarTextField(
                                controller: controller.visaStartDateTextEditingController,
                                hinText: AppString.updateProfilePageHintTextForVisaStartDate,
                              )),
                          SizedBox(
                            width: 6.0,
                          ),
                          Expanded(
                              child: AppCalendarTextField(
                                controller: controller.visaEndDateTextEditingController,
                                hinText: AppString.updateProfilePageHintTextForVisaEndDate,
                              )),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomSolidButton(
                          text: AppString.saveButtonText,
                          onTap: () {
                            // controller.getAdditionalInformation();
                            profileController.updateGridItem(1);
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: 'Visa & Passport Details uploaded successfully');
                          })
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}