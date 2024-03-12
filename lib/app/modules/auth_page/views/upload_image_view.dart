import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/update_additional_info_view.dart';
import 'package:staffin_softwares/app/modules/profile/controllers/profile_controller.dart';
import 'dart:io';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown.dart';
import '../controllers/auth_page_controller.dart';

class UploadImagesView extends GetView<AuthPageController> {
  const UploadImagesView({Key? key}) : super(key: key);
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
                        child: Text('5. Upload Images', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            letterSpacing: 0.2
                        ),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CustomImageContainer(
                        controller: controller.passportImageTextEditingController,
                        hinText: AppString.updateProfilePagePassportSizeImage,
                      ),
                      CustomImageContainer(
                        controller: controller.visaImageTextEditingController,
                        hinText: AppString.updateProfilePageVisaImage,
                      ),
                      Obx(() => Offstage(
                          offstage: controller.dropdownSpouseTextEditingController.value.text.isEmpty ? true : false,
                          child: CustomImageContainer(
                            controller: controller.marriageCertificateImageTextEditingController,
                            hinText: AppString.updateProfilePageMarriageCertificateImage,
                            isValidatorRequired: controller.dropdownSpouseTextEditingController.value.text.isEmpty ? false : true,
                          ))),
                      CustomImageContainer(
                        controller: controller.cOEImageTextEditingController,
                        hinText: AppString.updateProfilePageCOEImage,
                      ),
                      CustomImageContainer(controller: controller.licenseImageTextEditingController, hinText: AppString.additionalProfileInfoPageLicenseImage,),
                      const SizedBox(height: 10,),
                      const Text15By500(text: 'Draw your signature'),
                      const SizedBox(
                        height: 6,
                      ),
                      Container(
                          padding: EdgeInsets.all(1.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: Signature(
                                height: 120, backgroundColor: AppColors.lightBlackishTextColor.withOpacity(0.2), controller: controller.signatureController),
                          )),
                      const SizedBox(height: 15,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Obx(() => Checkbox(
                              // fillColor: AppColors.whiteColor,
                                checkColor: AppColors.appPrimaryLightColor,
                                activeColor: AppColors.creamColor,
                                side: BorderSide(color: controller.isReadContracts.value?AppColors.appPrimaryColor:AppColors.textFillHintTextColor),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 0.0,
                                value: controller.isReadContracts.value, onChanged: (v){
                              controller.isReadContracts.value=v!;
                              if(v==true){
                                controller.userContract(abn: controller.abnTextEditingController.text, name: controller.fullNameTextEditingController.text);
                              }
                            })
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              // textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
                                    children: [
                                      const TextSpan(text:'${AppString.contract} '),
                                      // TextSpan(
                                      //     recognizer: TapGestureRecognizer()..onTap=(){
                                      //       // Get.back();
                                      //     },
                                      //     text:AppString.additionalProfileInfoTermsAndCondition,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
                                    ]
                                )),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 24,
                            width: 24,
                            child: Obx(() => Checkbox(
                              // fillColor: AppColors.whiteColor,
                                checkColor: AppColors.appPrimaryLightColor,
                                activeColor: AppColors.creamColor,
                                side: BorderSide(color: controller.isReadDeed.value?AppColors.appPrimaryColor:AppColors.textFillHintTextColor),
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                splashRadius: 0.0,
                                value: controller.isReadDeed.value, onChanged: (v){
                              controller.isReadDeed.value=v!;
                              if(v==true){
                                controller.userDeed(abn: controller.abnTextEditingController.text, name: controller.fullNameTextEditingController.text, address: controller.addressTextEditingController.text);
                              }
                            })
                            ),
                          ),
                          Expanded(
                            child: RichText(
                              // textAlign: TextAlign.center,
                                text: TextSpan(
                                    style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
                                    children: [
                                      const TextSpan(text:'${AppString.deed} '),
                                      // TextSpan(
                                      //     recognizer: TapGestureRecognizer()..onTap=(){
                                      //       // Get.back();
                                      //     },
                                      //     text:AppString.additionalProfileInfoTermsAndCondition,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
                                    ]
                                )),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20.0),
                      CustomSolidButton(
                          text: AppString.saveButtonText,
                          onTap: () {
                            // controller.getAdditionalInformation();
                            profileController.updateGridItem(4);
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: 'Images uploaded successfully');
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
