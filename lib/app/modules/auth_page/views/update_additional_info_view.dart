import 'package:flutter/gestures.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown.dart';
import '../controllers/auth_page_controller.dart';

class UpdateAdditionalInfoView extends GetView<AuthPageController> {
  const UpdateAdditionalInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // CustomLoader.cancelLoader();
    return Scaffold(
      body:ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SafeArea(
            child: Form(
              key: controller.updateAdditionalProfileFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomAppBar(title: AppString.updateProfilePageTitle,),
                  Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            backgroundColor: AppColors.appPrimaryLightColor,
                            radius: 35,
                            child: Obx(() => CircleAvatar(
                              radius: 33,
                              backgroundImage: controller.userAvatarImagePath.value != '' ? FileImage(File(controller.userAvatarImagePath.value)) : null,
                            )),
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: -5.0,
                            child: InkWell(
                              onTap: () async {
                                var imageFile = await AppServices().selectImageFromGallery();
                                {
                                  if (imageFile!.path.isNotEmpty) {
                                    controller.userAvatarImagePath.value = imageFile.path;
                                  }
                                }
                              },
                              child: const Card(
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: Icon(Icons.edit, size: 16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Profile picture',
                        style: GoogleFonts.lato(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppColors.lightBlackishTextColor69,
                        ),
                      ),
                    ],
                  ),
                  AppTextField(controller: controller.licenseNumberTextEditingController, hinText: AppString.additionalProfileInfoPageLicense),
                  const SizedBox(height: 10,),
                  OurListObjectDropDown(dropdownItems:controller.licenseTypeDropdownData,
                      onDropdownChanged: (value) {
                        controller.licenseTypeEditingController.text=value['id'].toString();
                      }, keyName: "type",hintText: AppString.additionalProfileInfoPageLicenseType),
                  // CustomDropdownButton(data:controller.licenseTypeDropdownData,controller:controller.licenseTypeEditingController, hinText: AppString.additionalProfileInfoPageLicenseType,),
                  CustomImageContainer(controller: controller.licenseImageTextEditingController, hinText: AppString.additionalProfileInfoPageLicenseImage,),
                  const SizedBox(height: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text15By500(text: AppString.additionalProfileInfoPageRegisteredForGST),
                      Obx(() =>  Row(
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: 'Yes', groupValue: controller.isRegisteredForGst.value, onChanged: (v){
                                controller.isRegisteredForGst.value=v!;
                              },
                              ),
                              Text15By500(text: 'Yes'),
                            ],
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio(
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                value: 'No', groupValue: controller.isRegisteredForGst.value, onChanged: (v){
                                controller.isRegisteredForGst.value=v!;
                              },
                              ),
                              Text15By500(text: 'No'),
                            ],
                          ),
                        ],
                      ))
                    ],
                  ),
                  AppTextField(controller: controller.bankNameTextEditingController, hinText: AppString.additionalProfileInfoPageBankName),
                  AppTextField(controller: controller.bsbTextEditingController, hinText: AppString.additionalProfileInfoPageBSB),
                  AppTextField(controller: controller.abnTextEditingController, hinText: AppString.additionalProfileInfoPageAbn),
                  AppTextField(controller: controller.accountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageAccountNumber),
                AppTextField(controller: controller.confirmAccountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageCnfAccountNumber),
                  //CustomImageContainer(controller: controller.signatureImageTextEditingController, hinText: AppString.additionalProfileInfoPageSignature,),
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
                            side: BorderSide(color: controller.isReadTermsAndCondition.value?AppColors.appPrimaryColor:AppColors.textFillHintTextColor),
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            splashRadius: 0.0,
                            value: controller.isReadTermsAndCondition.value, onChanged: (v){
                          controller.isReadTermsAndCondition.value=v!;
                        })
                        ),
                      ),
                      Expanded(
                        child: RichText(
                          // textAlign: TextAlign.center,
                            text: TextSpan(
                                style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
                                children: [
                                  const TextSpan(text:'${AppString.additionalProfileInfoReadTerms} '),
                                  TextSpan(
                                      recognizer: TapGestureRecognizer()..onTap=(){
                                        // Get.back();
                                      },
                                      text:AppString.additionalProfileInfoTermsAndCondition,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
                                ]
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0,),
                  CustomSolidButton(text: AppString.additionalProfileInfoButtonSave, onTap: (){
                    controller.getRegisterUser();
                    // Get.to();
                  })
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}
