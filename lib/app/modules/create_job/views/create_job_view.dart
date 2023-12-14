import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';

import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../controllers/create_job_controller.dart';

class CreateJobView extends GetView<CreateJobController> {
  const CreateJobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Form(
            key: controller.createJobFormKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const CustomAppBar(title: AppString.createJobPageTitle),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(12.0),
                    shrinkWrap: true,
                    children: [
                      Obx(() =>controller.data.isNotEmpty? CustomDropdownButton(data: controller.data, controller: controller.customerNameTextEditingController, hinText: AppString.informationNeededPageClientText,):SizedBox.shrink()),
                      //AppTextField(controller: controller.numberOfDeliveryTextEditingController, hinText: AppString.createJobPageHintTextForNumberOfDelivery),
                      AppTextField(controller: controller.deliveryFromTextEditingController, hinText: AppString.createJobPageHintTextForDeliveryFrom),
                      AppTextField(controller: controller.deliveryToTextEditingController, hinText: AppString.createJobPageHintTextForDeliveryTo),
                      AppTextField(controller: controller.jobNumberTextEditingController, hinText: AppString.createJobPageHintTextForJobNumber),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 16.0,),

                          TextFormField(
                            onTap: () async {
                              picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true, minTime: DateTime(1932, 3, 5), maxTime: DateTime.now(), onChanged: (date) {}, onConfirm: (date) {
                                    print('confirm $date');
                                    controller.pickUpTimeTextEditingController.text=DateFormat('dd-MM-yyy').add_Hm().format(date);
                                  }, currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            controller:  controller.pickUpTimeTextEditingController,
                            readOnly: true,
                            validator: (v){
                              if(v!.isEmpty) {
                                return 'Fill the field';
                              }else{
                                return null;
                              }
                            },
                            onChanged: (v){

                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                              filled: true,
                              fillColor: AppColors.textFilledColor,
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                  borderSide: BorderSide.none
                              ),
                              hintText:  AppString.createJobPageHintTextForPickUpTime,
                              prefix: controller.pickUpTimeTextEditingController.text.isNotEmpty?Text('${ AppString.createJobPageHintTextForPickUpTime}:',style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),):Text(''),
                              hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),
                              suffixIcon: const Icon(Icons.calendar_month_rounded),
                              suffixIconColor: AppColors.appPrimaryLightColor,
                            ),
                          ),
                        ],
                      ),
                      AppTextField(controller: controller.remarksTextEditingController, hinText: AppString.createJobPageHintTextForRemarks),
                      CustomImageContainer(
                        controller: controller.signatureImagePathTextEditingController,
                        hinText: AppString.createJobPageHintTextForSign,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
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
                      const SizedBox(
                        height: 30,
                      ),
                      CustomSolidButton(
                          text: AppString.createJobPageUpdateButtonText,
                          onTap: () async {
                            await controller.signatureController.toPngBytes(height: 1000, width: 1000).then((value) async {
                              Uint8List yourUint8ListData = value!; // Replace with your data
                              String fileName = 'signature.jpg'; // Replace with your desired file name
                              controller.signaturePhotoPath.value = await controller.saveUint8ListToFile(yourUint8ListData, fileName);
                            });
                            controller.getAddJobInformation(
                                numberOfDelivery:controller.numberOfDeliveryTextEditingController.text, deliveryFrom: controller.deliveryFromTextEditingController.text, deliveryTo:controller.deliveryToTextEditingController.text, jobNumber: controller.jobNumberTextEditingController.text, pickUpTime: controller.pickUpTimeTextEditingController.text, remarks: controller.remarksTextEditingController.text, signatureImagePath: controller.signaturePhotoPath.value);
                          })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
