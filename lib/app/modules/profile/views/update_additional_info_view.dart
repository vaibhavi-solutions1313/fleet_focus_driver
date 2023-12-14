import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';

import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/edit_profile_image.dart';
import '../controllers/profile_controller.dart';

// class UpdateAdditionalInfoView extends GetView<ProfileController>  {
//   const UpdateAdditionalInfoView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           SafeArea(
//             child: Column(
//               children: [
//                 const CustomAppBar(title: AppString.updateProfilePageTitle,),
//                 const UserAvatar(),
//                 AppTextField(controller: controller.licenseNumberTextEditingController, hinText: AppString.additionalProfileInfoPageLicense),
//                 CustomDropdownButton(data:controller.data,controller:controller.licenseTypeEditingController, hinText: AppString.additionalProfileInfoPageLicenseType,),
//                 CustomImageContainer(controller: controller.licenseImageTextEditingController, hinText: AppString.additionalProfileInfoPageLicenseImage,),
//                 SizedBox(height: 10,),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text15By500(text: AppString.additionalProfileInfoPageRegisteredForGST),
//                    Obx(() =>  Row(
//                      children: [
//                        Row(
//                          mainAxisSize: MainAxisSize.min,
//                          children: [
//                            Radio(
//                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                              value: 'Yes', groupValue: controller.isRegisteredForGst.value, onChanged: (v){
//                              controller.isRegisteredForGst.value=v!;
//                            },
//                            ),
//                            Text15By500(text: 'Yes'),
//                          ],
//                        ),
//                        Row(
//                          mainAxisSize: MainAxisSize.min,
//                          children: [
//                            Radio(
//                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                              value: 'No', groupValue: controller.isRegisteredForGst.value, onChanged: (v){
//                              controller.isRegisteredForGst.value=v!;
//                            },
//                            ),
//                            Text15By500(text: 'No'),
//                          ],
//                        ),
//                      ],
//                    ))
//                   ],
//                 ),
//                 AppTextField(controller: controller.bankNameTextEditingController, hinText: AppString.additionalProfileInfoPageBankName),
//                 AppTextField(controller: controller.bsbTextEditingController, hinText: AppString.additionalProfileInfoPageBSB),
//                 AppTextField(controller: controller.accountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageAccountNumber),
//                 AppTextField(controller: controller.confirmAccountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageCnfAccountNumber),
//                 CustomImageContainer(controller: controller.signatureTextEditingController, hinText: AppString.additionalProfileInfoPageSignature,),
//                 SizedBox(height: 15,),
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       height: 24,
//                       width: 24,
//                       child: Obx(() => Checkbox(
//                         // fillColor: AppColors.whiteColor,
//                         checkColor: AppColors.appPrimaryLightColor,
//                           activeColor: AppColors.creamColor,
//                           side: BorderSide(color: controller.isReadTermsAndCondition.value?AppColors.appPrimaryColor:AppColors.textFillHintTextColor),
//                           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                           splashRadius: 0.0,
//                           value: controller.isReadTermsAndCondition.value, onChanged: (v){
//                             controller.isReadTermsAndCondition.value=v!;
//                       })
//                       ),
//                     ),
//                     Expanded(
//                       child: RichText(
//                           // textAlign: TextAlign.center,
//                           text: TextSpan(
//                               style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
//                               children: [
//                                 const TextSpan(text:'${AppString.additionalProfileInfoReadTerms} '),
//                                 TextSpan(
//                                     recognizer: TapGestureRecognizer()..onTap=(){
//                                       // Get.back();
//                                     },
//                                     text:AppString.additionalProfileInfoTermsAndCondition,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
//                               ]
//                           )),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: 20.0,),
//                 CustomSolidButton(text: AppString.additionalProfileInfoButtonSave, onTap: (){
//                   // Get.to();
//                 })
//               ],
//             ),
//           )
//         ],
//       )
//     );
//   }
// }
