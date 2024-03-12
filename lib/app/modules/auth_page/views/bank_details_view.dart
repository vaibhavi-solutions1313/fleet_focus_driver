import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:staffin_softwares/app/modules/profile/controllers/profile_controller.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../controllers/auth_page_controller.dart';

class BankDetailsView extends GetView<AuthPageController> {
  const BankDetailsView({Key? key}) : super(key: key);
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
                        child: Text('4. Bank Details', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            letterSpacing: 0.2
                        ),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      AppTextField(controller: controller.bankNameTextEditingController, hinText: AppString.additionalProfileInfoPageBankName),
                      AppTextField(controller: controller.bsbTextEditingController, hinText: AppString.additionalProfileInfoPageBSB),
                      AppTextField(controller: controller.abnTextEditingController, hinText: AppString.additionalProfileInfoPageAbn),
                      AppTextField(controller: controller.accountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,isSecureText: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageAccountNumber),
                      AppTextField(controller: controller.confirmAccountNumberTextEditingController,textInputType: TextInputType.visiblePassword,isSuffixIcon: true,suffixIcon: Icons.remove_red_eye, hinText: AppString.additionalProfileInfoPageCnfAccountNumber),

                      const SizedBox(height: 20.0),
                      CustomSolidButton(
                          text: AppString.saveButtonText,
                          onTap: () {
                            // controller.getAdditionalInformation();
                            profileController.updateGridItem(3);
                            Navigator.pop(context);
                            Fluttertoast.showToast(msg: 'Bank Details uploaded successfully');
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