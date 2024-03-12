import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/daily_login_page_controller.dart';
import 'package:staffin_softwares/app/modules/term_and_condition/bindings/term_and_condition_binding.dart';
import 'package:staffin_softwares/app/modules/term_and_condition/views/term_and_condition_view.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../declaration_page/controllers/declaration_page_controller.dart';

class TermsConditionsDeedsPageView extends GetView<DeclarationPageController> {
  const TermsConditionsDeedsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DailyLoginPageController dailyLoginPageController = Get.put(DailyLoginPageController());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20.0),
                  child: Text('Terms & Conditions', style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat',
                      fontSize: 20,
                      letterSpacing: 0.2
                  ),),
                ),
                SizedBox(
                  height: 10,
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
                          side: BorderSide(color: controller.isReadTermsAndCondition.value ? AppColors.appPrimaryColor : AppColors.textFillHintTextColor),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          splashRadius: 0.0,
                          value: controller.isReadTermsAndCondition.value,
                          onChanged: (v) {
                            controller.isReadTermsAndCondition.value = v!;
                          })),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkBlackishTextColor), children: [
                            const TextSpan(text: '${AppString.additionalProfileInfoReadTerms} '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(()=>const TermAndConditionView(),binding: TermAndConditionBinding());
                                  },
                                text: AppString.additionalProfileInfoTermsAndCondition,
                                style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.appPrimaryLightColor)),
                          ])),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
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
                          side: BorderSide(color: controller.isReadTermsAndCondition.value ? AppColors.appPrimaryColor : AppColors.textFillHintTextColor),
                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          splashRadius: 0.0,
                          value: controller.isReadTermsAndCondition.value,
                          onChanged: (v) {
                            controller.isReadTermsAndCondition.value = v!;
                          })),
                    ),
                    Expanded(
                      child: RichText(
                          text: TextSpan(style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.darkBlackishTextColor), children: [
                            const TextSpan(text: '${AppString.additionalProfileInfoReadDeed} '),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Get.to(()=>const TermAndConditionView(),binding: TermAndConditionBinding());
                                  },
                                text: AppString.additionalProfileInfoDeed,
                                style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.appPrimaryLightColor)),
                          ])),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 20.0,
                ),
                CustomSolidButton(
                    text: AppString.declarationPageButtonText,
                    onTap: () {
                      if(controller.saveDeclaration()){
                        dailyLoginPageController.updateDailyLoginGrid(4);
                        Navigator.pop(context);
                        Fluttertoast.showToast(msg: 'Terms and Conditions accepted successfully');
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
