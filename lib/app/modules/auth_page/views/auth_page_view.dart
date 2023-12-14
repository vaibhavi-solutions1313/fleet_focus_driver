import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_constants/app_strings.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_fields.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/register_view.dart';
import '../../../app_constants/app_Images.dart';
import '../../../app_constants/app_colors.dart';
import '../controllers/auth_page_controller.dart';

class AuthPageView extends GetView<AuthPageController> {
  const AuthPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: [
            const Text20By700(text: AppString.loginPageStringTitle),
            SizedBox(height: 15,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.only(right: 3.0),
                  decoration: BoxDecoration(
                    color: AppColors.lightGreenishColor,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.check,size:12,weight: 100,color: AppColors.whiteColor,),
                ),
                Text14By400(text: AppString.loginPageStringInfo1),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.only(right: 3.0),
                  decoration: const BoxDecoration(
                    color: AppColors.lightGreenishColor,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.check,size:12,weight: 100,color: AppColors.whiteColor,),
                ),
                Text14By400(text: AppString.loginPageStringInfo2),
              ],
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3.0),
                  margin: EdgeInsets.only(right: 3.0),
                  decoration: const BoxDecoration(
                    color: AppColors.lightGreenishColor,
                    shape: BoxShape.circle
                  ),
                  child: Icon(Icons.check,size:12,weight: 100,color: AppColors.whiteColor,),
                ),
                Text14By400(text: AppString.loginPageStringInfo3),
              ],
            ),
             Image.asset(AppImages.loginImage),
             Form(
               key: controller.loginFormKey,
               child: Column(
                 children: [
                   AppTextField(controller: controller.loginUserNameTextEditingController,hinText: AppString.loginPageStringHintTextForUsername, ),
                   AppTextField(controller: controller.loginPasswordTextEditingController,hinText: AppString.loginPageStringHintTextForPassword,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, ),
            const SizedBox(height: 15,),
            CustomSolidButton(text: AppString.loginButtonText, onTap: (){
                    controller.getStartLogin( userName: controller.loginUserNameTextEditingController.text, password:controller.loginPasswordTextEditingController.text);
            }),
                 ],
               ),
             ),
            const SizedBox(height: 10,),
            RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
            style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.darkBlackishTextColor),
              children: [
                const TextSpan(text:AppString.loginPageStringHaveAnAccount),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap=(){
                    Get.to(()=>const RegisterView());
                  },
                    text:AppString.loginPageStringRegisterNow,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: AppColors.appPrimaryLightColor)),
              ]
            ))
          ],
        ),
      ),
    );
  }
}
