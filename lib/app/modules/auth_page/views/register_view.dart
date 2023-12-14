import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/auth_page_controller.dart';

import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_solid_button.dart';

class RegisterView extends GetView<AuthPageController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            const Text20By700(text: AppString.signUpPageStringForTitle),
            SizedBox(height: 15,),

            Form(
              key: controller.signUpFormKey,
              child: Column(
                children: [
                  AppTextField(controller: controller.fullNameTextEditingController,hinText: AppString.signUpHintTextForFullName ),
                  AppTextField(controller: controller.signUpEmailTextEditingController,hinText: AppString.signUpHintTextForEmail,textInputType: TextInputType.emailAddress,  ),
                  AppTextField(controller: controller.signUpMobileTextEditingController,hinText: AppString.signUpHintTextForMobile,textInputType: TextInputType.phone,  ),
                  AppTextField(controller: controller.signUpPasswordTextEditingController,hinText: AppString.signUpHintTextForPassword, textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, ),
                  AppTextField(controller: controller.signUpConfirmPasswordTextEditingController,hinText: AppString.signUpHintTextForConfirmPassword,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,suffixIcon: Icons.remove_red_eye,  ),
                  AppTextField(controller: controller.signUpReferralCodeEditingController,hinText: AppString.signUpHintTextForReferralCode ,isValidatorRequired: false,),
                  SizedBox(height: 15,),
                  CustomSolidButton(text: AppString.signUpButtonText, onTap: (){
                    if(GetUtils.isEmail(controller.signUpEmailTextEditingController.text)){
                      if(controller.signUpPasswordTextEditingController.text==controller.signUpConfirmPasswordTextEditingController.text){
                        controller.getStartRegistration();
                      }else{
                        AppServices().showToastMessage(toastMessage: 'Password not matched!');
                        print('Password not matched!');
                      }
                    }else{
                      AppServices().showToastMessage(toastMessage: 'Enter a valid email');
                      print('Enter a valid email');
                    }
                  }),
                ],
              ),
            ),
            SizedBox(height: 15,),
            RichText(
              textAlign: TextAlign.center,
                text: TextSpan(
                style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
                children: [
                  const TextSpan(text:AppString.signUpPageStringHaveAlreadyAccount),
                  TextSpan(
                      recognizer: TapGestureRecognizer()..onTap=(){
                        Get.back();
                      },
                      text:AppString.signUpPageStringForLoginNow,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
                ]
            ))
          ],
        ),
      ),
    );
  }
}
