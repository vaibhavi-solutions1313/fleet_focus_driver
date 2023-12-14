import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/term_and_condition/bindings/term_and_condition_binding.dart';
import 'package:staffin_softwares/app/modules/term_and_condition/views/term_and_condition_view.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../controllers/declaration_page_controller.dart';

class DeclarationPageView extends GetView<DeclarationPageController> {
  const DeclarationPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'Declaration'),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: controller.declaration.length,
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: const [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(child: Text14By400(text: controller.declaration[index]['title'].toString())),
                         Obx(() =>  Switch(
                             value: controller.declaration[index]['value'] as bool,
                             onChanged: (value) {
                               controller.declaration[index]['value']=value;
                               controller.declaration.refresh();
                             }))
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10.0,
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 15,
              ),
          
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Signature'),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12.0),
                    child: Signature(
                        height: 120, backgroundColor: AppColors.lightBlackishTextColor.withOpacity(0.2), controller: controller.signatureController),
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
                height: 20.0,
              ),
              CustomSolidButton(
                  text: AppString.declarationPageButtonText,
                  onTap: () {
                    controller.saveDeclaration();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
