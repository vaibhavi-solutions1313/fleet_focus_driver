import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import 'package:staffin_softwares/app/app_widgets/custom_dropdown.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../controllers/declaration_page_controller.dart';

class InformationNeededBeforeStartView extends GetView<DeclarationPageController> {
  const InformationNeededBeforeStartView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: controller.informationNeededFormKey,
          child: ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              const CustomAppBar(title: 'Information'),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0,),
                  AppTextField(controller: controller.driverNumberTextEditingController, hinText: 'Driver number',),
                  const SizedBox(height: 10.0,),
                  TextFormField(
                    controller: controller.numberOfJobsTextEditingController.value,
                    keyboardType: TextInputType.phone,
                    validator: (v){
                      if(v!.isEmpty) {
                        return 'Fill the field';
                      }else{
                        return null;
                      }
                    },
                    onChanged: (v){
                      if(v.isNotEmpty){
                        print('gggggggggggggggggggggggg');
                        controller.countJobs.value=int.parse(v);
                        controller.countJobs.value<1?controller.countJobs.value=1:null;
                      }else{
                        controller.countJobs.value=1;
                        controller.numberOfJobsTextEditingController.value.clear();
                      }
                    },
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                      filled: true,
                      fillColor: AppColors.textFilledColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          borderSide: BorderSide.none
                      ),
                      // hintText: AppString.informationNeededPageTextNumberOfJobs,
                      prefix: Text( AppString.informationNeededPageTextNumberOfJobs ,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),),
                      hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),
                    ),
                  ),
                ],
              ),
              Obx(() => Column(
                children: List.generate(controller.countJobs.value, (index) => Row(
                  children: [
                    Text('${index + 1}. '),
                    Expanded(child: SelectCustomer(data:controller.data, hinText: AppString.informationNeededPageClientText, addCustomer: controller.storedCustomerNames,)),
                  ],
                )),
              )),
              // CustomDropdownButton(data: controller.data, controller: controller.clientTextEditingController, hinText: AppString.informationNeededPageClientText,),
              Column(
                children: [
                  const SizedBox(
                    height: 16.0,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    decoration: BoxDecoration(color: AppColors.textFilledColor, borderRadius: BorderRadius.circular(12.0)),
                    child: DropdownButtonHideUnderline(
                        child: Obx(() => DropdownButton(
                          value: controller.userRegoId.value,
                          onChanged: (value) {
                            controller.registrationTextEditingController.text= value;
                            controller.userRegoId.value=value;
                          },
                          iconEnabledColor: AppColors.appPrimaryLightColor,
                          isExpanded: true,
                          hint: Text(
                           AppString.informationNeededPageRegistrationText,
                            style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                          ),
                          style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                          icon: const Icon(Icons.keyboard_arrow_down_rounded),
                          items: controller.regoData.map((dynamic item) {
                            return DropdownMenuItem<dynamic>(
                              value: item,
                              child: Text(item.toString(),style: const TextStyle(fontSize: 16, color: Colors.black54),),
                            );
                          }).toList(),
                        ))),
                  ),
                ],
              ),
              Obx(() => Visibility(
                  visible: controller.userRegoId.value.isNotEmpty?true:false,
                  child: AppTextField(
                    isValidatorRequired: controller.userRegoId.value.isNotEmpty?true:false,
                      controller: controller.odometerTextEditingController, hinText: AppString.informationNeededPageTextOdometer))),
              const SizedBox(
                height: 12,
              ),
              const Text15By500(text: AppString.informationNeededPageTextUploadTruckPhotos),
              const SizedBox(
                height: 6,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  height: 100,
                  child: Obx(()=>Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckFrontImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckFrontImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckFrontImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckFrontImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(6.0),

                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckBackImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckBackImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckBackImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckBackImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(6.0),

                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckRightImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckRightImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckRightImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckRightImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(6.0),

                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckLeftImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckLeftImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckLeftImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckLeftImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: const EdgeInsets.all(6.0),
                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.all(6.0),
                  height: 100,
                  child: Obx(()=>Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckRightTyreImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckRightTyreImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckLeftTyreImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckRightTyreImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(6.0),

                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 10,),
                      Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckLeftTyreImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width:Get.width*0.22,
                              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(16.0),
                                boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                              ),
                              child: controller.truckLeftTyreImagePath.value == ""
                                  ? Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(6.0),
                                    decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.perm_media_outlined,
                                      color: AppColors.appPrimaryLightColor,
                                      size: 12,
                                    ),
                                  ),
                                  Text(
                                    AppString.informationNeededPageTextUploadTruckRightTyreImage,
                                    style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                  ),
                                ],
                              )
                                  : Image.file(File(controller.truckLeftTyreImagePath.value)),
                            ),
                          ),
                          Positioned(
                            right: 5.0,
                            child: Container(
                              // padding:EdgeInsets.all(3.0),
                              margin: EdgeInsets.all(6.0),

                              child: Icon(
                                Icons.cancel_presentation_outlined,
                                color: Colors.blue,
                                size: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text15By500(text: AppString.informationNeededPageTextHadDentOrDamage),
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: AppString.informationNeededPageTextYes,
                            groupValue: controller.hasDentOrDamageTruck.value,
                            onChanged: (v) {
                              controller.hasDentOrDamageTruck.value = v!;
                            },
                          ),
                          Text15By500(text: AppString.informationNeededPageTextYes),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: AppString.informationNeededPageTextNo,
                            groupValue: controller.hasDentOrDamageTruck.value,
                            onChanged: (v) {
                              controller.hasDentOrDamageTruck.value = v!;
                            },
                          ),
                          Text15By500(text: AppString.informationNeededPageTextNo),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                      visible: controller.hasDentOrDamageTruck.value==AppString.informationNeededPageTextYes?true:false,
                      child: Row(
                        children: [
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pickImage().then((value) {
                                    if (value != null) {
                                      controller.truckDamageImagePath1.value = value;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  width:Get.width*0.22,
                                   padding: controller.truckDamageImagePath1.value == ""?EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0):EdgeInsets.zero,
                                  decoration: BoxDecoration(

                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                                  ),
                                  child: controller.truckDamageImagePath1.value == ""
                                      ? Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                        child: Icon(
                                          Icons.perm_media_outlined,
                                          color: AppColors.appPrimaryLightColor,
                                          size: 12,
                                        ),
                                      ),
                                      Text(
                                        AppString.informationNeededPageTextUploadDamageTruckImage1,
                                        style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                      ),
                                    ],
                                  )
                                      : ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.file(File(controller.truckDamageImagePath1.value),fit: BoxFit.fill,)),
                                ),
                              ),
                              Positioned(
                                right: 5.0,
                                child: Container(
                                  // padding:EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(6.0),

                                  child: Icon(
                                    Icons.cancel_presentation_outlined,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16.0,),
                          Stack(
                            children: [
                              InkWell(
                                onTap: () {
                                  controller.pickImage().then((value) {
                                    if (value != null) {
                                      controller.truckDamageImagePath2.value = value;
                                    }
                                  });
                                },
                                child: Container(
                                  height: 80,
                                  width:Get.width*0.22,
                                  padding: controller.truckDamageImagePath2.value == ""?EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0):EdgeInsets.zero,
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                    boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                                  ),
                                  child: controller.truckDamageImagePath2.value == ""
                                      ? Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(6.0),
                                        decoration: BoxDecoration(color: AppColors.appPrimaryLightColor.withOpacity(0.2), shape: BoxShape.circle),
                                        child: const Icon(
                                          Icons.perm_media_outlined,
                                          color: AppColors.appPrimaryLightColor,
                                          size: 12,
                                        ),
                                      ),
                                      Text(
                                        AppString.informationNeededPageTextUploadDamageTruckImage2,
                                        style: GoogleFonts.roboto(fontSize: 11, fontWeight: FontWeight.w400, color: AppColors.lightBlackishTextColor69),
                                      ),
                                    ],
                                  )
                                      : ClipRRect(
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Image.file(File(controller.truckDamageImagePath2.value),fit: BoxFit.fill,)),
                                ),
                              ),
                              Positioned(
                                right: 5.0,
                                child: Container(
                                  // padding:EdgeInsets.all(3.0),
                                  margin: EdgeInsets.all(6.0),

                                  child: Icon(
                                    Icons.cancel_presentation_outlined,
                                    color: Colors.blue,
                                    size: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ],
              )),
              const SizedBox(
                height: 10,
              ),
              Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text15By500(text: AppString.informationNeededPageTextHaveAFuelCard),
                  Row(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: AppString.informationNeededPageTextYes,
                            groupValue: controller.isHavingAFuelCard.value,
                            onChanged: (v) {
                              controller.isHavingAFuelCard.value = v!;
                            },
                          ),
                          Text15By500(text: AppString.informationNeededPageTextYes),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Radio(
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            value: AppString.informationNeededPageTextNo,
                            groupValue: controller.isHavingAFuelCard.value,
                            onChanged: (v) {
                              controller.isHavingAFuelCard.value = v!;
                            },
                          ),
                          Text15By500(text: AppString.informationNeededPageTextNo),
                        ],
                      ),
                    ],
                  ),
                  Visibility(
                      visible: controller.isHavingAFuelCard.value==AppString.informationNeededPageTextYes?true:false,
                      child: CustomImageContainer(
                        isValidatorRequired: controller.isHavingAFuelCard.value==AppString.informationNeededPageTextYes?true:false,
                        controller: controller.fuelCardImageTextEditingController,
                        hinText: AppString.informationNeededPageTextFuelCardPicture,
                      )),
                ],
              )),
              AppTextField(controller: controller.startTimeTextEditingController, hinText: AppString.informationNeededPageTextStartTime),
              const SizedBox(
                height: 20,
              ),
              CustomSolidButton(
                  text: AppString.informationNeededPageButtonText,
                  onTap: () {
                    print(controller.storedCustomerNames);
                    controller.startWork(
                      driverNumber: controller.driverNumberTextEditingController.text.trim(),
                        vehicleTypeId: controller.vehicleTypeId.value,
                        driverName: controller.storedCustomerNames,
                        rego: controller.registrationTextEditingController.text,
                        odometer: controller.odometerTextEditingController.text,
                        serviceDue: controller.serviceDue.value,
                        truckFrontImage: controller.truckFrontImagePath.value,
                        truckBackImage:controller.truckBackImagePath.value,
                        truckRightImage:controller.truckRightImagePath.value,
                        truckLeftImage: controller.truckLeftImagePath.value,
                        truckDamageImagePath1: controller.truckDamageImagePath1.value,
                        truckDamageImagePath2: controller.truckDamageImagePath2.value,
                        truckLeftTyreImage: controller.truckLeftTyreImagePath.value,
                        truckRightTyreImage:controller.truckRightTyreImagePath.value,
                      fuelCardImage: controller.fuelCardImageTextEditingController.text,
                      startWorkTime:controller.startTimeTextEditingController.text,
                      // numberOfJobs: controller.numberOfJobsTextEditingController.value.text,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}


class SelectCustomer extends GetView{
  const SelectCustomer( {required this.data,required this.hinText,required this.addCustomer, super.key});
  final List<dynamic> data;
  final List<dynamic> addCustomer;
  final String hinText;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     TextEditingController controller=TextEditingController();
    var selectedItem = ''.obs;
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(color: AppColors.textFilledColor, borderRadius: BorderRadius.circular(12.0)),
          child: DropdownButtonHideUnderline(
              child: Obx(() => DropdownButton(
                value: selectedItem.value==''?data[0]:selectedItem.value,
                onChanged: (value) {
                 if(value!='Select customer name'){
                   if(!addCustomer.contains(value)){
                     addCustomer.remove(selectedItem.value);
                     addCustomer.add(value);
                   }
                   selectedItem.value=value;
                    print(addCustomer.toString());
                 }else{
                   addCustomer.remove(selectedItem.value);
                   selectedItem.value=value;
                 }
                },
                iconEnabledColor: AppColors.appPrimaryLightColor,
                isExpanded: true,
                hint: Text(
                  hinText,
                  style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                ),
                style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                items: data.map((dynamic item) {
                  return DropdownMenuItem<dynamic>(
                    value: item,
                    child: Text(item.toString(),style: const TextStyle(fontSize: 16, color: Colors.black54),),
                  );
                }).toList(),
              ))),
        ),
      ],
    );
  }
}