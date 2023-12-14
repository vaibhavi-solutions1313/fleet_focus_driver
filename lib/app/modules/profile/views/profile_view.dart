import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:staffin_softwares/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:staffin_softwares/app/modules/splash_screen/views/splash_screen_view.dart';

import '../../../../main.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/edit_profile_image.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  SingleChildScrollView( 
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomAppBar(title: AppString.updateProfilePageTitle),
                  IconButton(onPressed: (){
                    getStorage.erase();
                    Get.offAll(()=>const SplashScreenView(),binding: SplashScreenBinding());
                  }, icon: Icon(Icons.power_settings_new_rounded,color: Colors.red,))
                ],
              ),

              UserAvatar(userAvatar: userBasicInformation.data?.profilePhotoUrl,onTap: (v) {
                print(v);
              }),

              AppTextField(controller: controller.fullNameTextEditingController, hinText: AppString.profilePageHintTextForFullName),
              AppTextField(controller: controller.mobileNumberTextEditingController, hinText: AppString.profileHintTextForMobile),
              AppTextField(controller: controller.addressTextEditingController, hinText: AppString.profilePageHintTextForAddress),
          SizedBox(
            height:20,),
              Obx(() => InkWell(
                  onTap:(){
                    controller.isUserNeedsToUpdatePassword.value=!controller.isUserNeedsToUpdatePassword.value;
                  },
                  child: Text(controller.isUserNeedsToUpdatePassword.value?'Cancel':'Change Password',style: TextStyle(color: Colors.blue),)),),
              Form(
                child: Column(
                  children: [
                    Obx(() => Visibility(
                        visible: controller.isUserNeedsToUpdatePassword.value,
                        child: Column(
                          children: [
                            AppTextField(controller: controller.oldPasswordTextEditingController,hinText: AppString.profilePageCurrentPassword,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, ),
                            AppTextField(controller: controller.newPasswordTextEditingController,hinText: AppString.profilePageNewPassword,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, ),
                            AppTextField(controller: controller.cnfPasswordTextEditingController,hinText: AppString.profilePageConfirmNewPassword,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,suffixIcon: Icons.remove_red_eye, ),
                          ],
                        ))),
                    SizedBox(
                      height:20,),
                     CustomSolidButton(text: AppString.profilePageUpdateButtonText, onTap: (){
                       controller.getUpdatePassword(oldPassword: controller.oldPasswordTextEditingController.text.trim(), newPassword: controller.newPasswordTextEditingController.text.trim(), cnfPassword: controller.cnfPasswordTextEditingController.text.trim());
                     }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
