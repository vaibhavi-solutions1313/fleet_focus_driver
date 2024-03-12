import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/daily_login_page_controller.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../declaration_page/controllers/declaration_page_controller.dart';

class TruckImagesPageView extends GetView<DeclarationPageController> {
  const TruckImagesPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    DailyLoginPageController dailyLoginPageController = Get.put(DailyLoginPageController());
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(40.0),
        topRight: Radius.circular(40.0),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Form(
            key: controller.informationNeededFormKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Text('Truck Images', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    letterSpacing: 0.2
                ),),
                SizedBox(height: 20,),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            blurRadius: 3,
                            spreadRadius: 0.5,
                            offset: Offset(0, 2),
                          ),
                        ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              AppString
                                  .informationNeededPageTextUploadTruckFrontImage,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.2,
                                fontSize: 15,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                   controller.truckFrontImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckFrontImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckFrontImagePath.value), fit: BoxFit.fill),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
                    // Truck back image
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Truck front image
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              AppString
                                  .informationNeededPageTextUploadTruckBackImage,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          // Truck back image
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckBackImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckBackImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.lato(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckBackImagePath.value), fit: BoxFit.fill,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child:Text(
                              AppString
                                  .informationNeededPageTextUploadTruckRightImage,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckRightImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckRightImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckRightImagePath.value), fit: BoxFit.fill,),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
                    // Truck left image
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Truck front image
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              AppString
                                  .informationNeededPageTextUploadTruckLeftImage,
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          // Truck back image
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckLeftImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckLeftImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckLeftImagePath.value), fit: BoxFit.fill,),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
                    // Truck right tyre
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Truck front image
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'Right Tyre Image',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          // Truck back image
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckRightTyreImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckRightTyreImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckRightTyreImagePath.value), fit: BoxFit.fill,),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: 5,),
                    // Truck left image
                    Container(
                      width: Get.width,
                      height: 200,
                      padding: EdgeInsets.all(15.0),
                      margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              blurRadius: 3,
                              spreadRadius: 0.5,
                              offset: Offset(0, 2),
                            ),
                          ]
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Truck front image
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Text(
                              'Left Tyre Image',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                letterSpacing: 0.2,
                                color: Colors.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          // Truck back image
                          InkWell(
                            onTap: () {
                              controller.pickImage().then((value) {
                                if (value != null) {
                                  controller.truckLeftTyreImagePath.value = value;
                                }
                              });
                            },
                            child: Container(
                              width: Get.width,
                              height: 130,
                              margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                              // padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                              decoration: BoxDecoration(
                                color:
                                AppColors.imageContainerFill.withOpacity(0.38),
                                borderRadius: BorderRadius.circular(15.0),
                                boxShadow: [
                                  BoxShadow(
                                      offset: Offset(1.0, 1.0),
                                      color: AppColors.textFilledColor,
                                      spreadRadius: 2.0)
                                ],
                              ),
                              child: controller.truckLeftTyreImagePath == ""
                                  ? Center(
                                child: ShaderMask(
                                  blendMode: BlendMode.srcIn,
                                  shaderCallback: (bounds) => LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      AppColors.textAndOutlineTop,
                                      AppColors.textAndOutlineBottom
                                    ],
                                  ).createShader(Rect.fromLTWH(
                                      0, 0, bounds.width, bounds.height)),
                                  child: Text(
                                    AppString.closeJobPageUploadTruckPhoto,
                                    style: GoogleFonts.urbanist(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: AppColors
                                            .lightBlackishTextColor69),
                                  ),
                                ),
                              )
                                  : Image.file(File(controller.truckLeftTyreImagePath.value), fit: BoxFit.fill,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: Get.width,
                                  height: 200,
                                  padding: EdgeInsets.all(15.0),
                                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 3,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                        child: Text(
                                          AppString
                                              .informationNeededPageTextUploadDamageTruckImage1,
                                          style: TextStyle(
                                            fontFamily: 'Montserrat',
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 0.2,
                                            fontSize: 15,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 6,
                                      ),
                                      InkWell(
                                          onTap: () {
                                            controller.pickImage().then((value) {
                                              if (value != null) {
                                                controller.truckDamageImagePath1.value = value;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: Get.width,
                                            height: 130,
                                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                            // padding: controller.truckDamageImagePath1.value == ""?EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0):EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              color:
                                              AppColors.imageContainerFill.withOpacity(0.38),
                                              borderRadius: BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(1.0, 1.0),
                                                    color: AppColors.textFilledColor,
                                                    spreadRadius: 2.0)
                                              ],
                                            ),
                                            child: controller.truckDamageImagePath1.value == ""
                                                ? Center(
                                              child: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback: (bounds) => LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.textAndOutlineTop,
                                                    AppColors.textAndOutlineBottom
                                                  ],
                                                ).createShader(Rect.fromLTWH(
                                                    0, 0, bounds.width, bounds.height)),
                                                child: Text(
                                                  AppString.closeJobPageUploadTruckPhoto,
                                                  style: GoogleFonts.urbanist(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors
                                                          .lightBlackishTextColor69),
                                                ),
                                              ),
                                            )
                                                : ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Image.file(File(controller.truckDamageImagePath1.value),fit: BoxFit.fill,)),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 5.0,),
                                Container(
                                  width: Get.width,
                                  height: 200,
                                  padding: EdgeInsets.all(15.0),
                                  margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.0),
                                      color: Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          blurRadius: 3,
                                          spreadRadius: 0.5,
                                          offset: Offset(0, 2),
                                        ),
                                      ]
                                  ),
                                  child:
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                                          child: Text(
                                            AppString
                                                .informationNeededPageTextUploadDamageTruckImage2,
                                            style: TextStyle(
                                              fontFamily: 'Montserrat',
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.2,
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            controller.pickImage().then((value) {
                                              if (value != null) {
                                                controller.truckDamageImagePath2.value = value;
                                              }
                                            });
                                          },
                                          child: Container(
                                            width: Get.width,
                                            height: 130,
                                            margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                            // padding: controller.truckDamageImagePath1.value == ""?EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0):EdgeInsets.zero,
                                            decoration: BoxDecoration(
                                              color:
                                              AppColors.imageContainerFill.withOpacity(0.38),
                                              borderRadius: BorderRadius.circular(15.0),
                                              boxShadow: [
                                                BoxShadow(
                                                    offset: Offset(1.0, 1.0),
                                                    color: AppColors.textFilledColor,
                                                    spreadRadius: 2.0)
                                              ],
                                            ),
                                            child: controller.truckDamageImagePath2.value == ""
                                                ? Center(
                                              child: ShaderMask(
                                                blendMode: BlendMode.srcIn,
                                                shaderCallback: (bounds) => LinearGradient(
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,
                                                  colors: [
                                                    AppColors.textAndOutlineTop,
                                                    AppColors.textAndOutlineBottom
                                                  ],
                                                ).createShader(Rect.fromLTWH(
                                                    0, 0, bounds.width, bounds.height)),
                                                child: Text(
                                                  AppString.closeJobPageUploadTruckPhoto,
                                                  style: GoogleFonts.urbanist(
                                                      fontSize: 15,
                                                      fontWeight: FontWeight.w700,
                                                      color: AppColors
                                                          .lightBlackishTextColor69),
                                                ),
                                              ),
                                            )
                                                : ClipRRect(
                                                borderRadius: BorderRadius.circular(16.0),
                                                child: Image.file(File(controller.truckDamageImagePath2.value),fit: BoxFit.fill,)),
                                          ),
                                        ),
                                      ],
                                    ),
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
                                Text15By500(
                                    text: AppString.informationNeededPageTextYes),
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
                                Text15By500(
                                    text: AppString.informationNeededPageTextNo
                                ),
                              ],
                            ),
                          ],
                        ),
                        Visibility(
                            visible: controller.isHavingAFuelCard.value==AppString.informationNeededPageTextYes?true:false,
                            child: Container(
                              width: Get.width,
                              height: 200,
                              padding: EdgeInsets.all(15.0),
                              margin: EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      blurRadius: 3,
                                      spreadRadius: 0.5,
                                      offset: Offset(0, 2),
                                    ),
                                  ]
                              ),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                              Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Text(
                                'Fuel Image',
                                style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.2,
                                  fontSize: 15,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                                    SizedBox(
                                      height: 6,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        controller.pickImage().then((value) {
                                          if (value != null) {
                                            controller.fuelCardImagePath.value = value;
                                          }
                                        });
                                      },
                                      child: Container(
                                        width: Get.width,
                                        height: 130,
                                        margin: EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
                                        // padding: controller.truckDamageImagePath1.value == ""?EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0):EdgeInsets.zero,
                                        decoration: BoxDecoration(
                                          color:
                                          AppColors.imageContainerFill.withOpacity(0.38),
                                          borderRadius: BorderRadius.circular(15.0),
                                          boxShadow: [
                                            BoxShadow(
                                                offset: Offset(1.0, 1.0),
                                                color: AppColors.textFilledColor,
                                                spreadRadius: 2.0)
                                          ],
                                        ),
                                        child: controller.fuelCardImagePath.value == ""
                                        ? Center(
                                          child: ShaderMask(
                                            blendMode: BlendMode.srcIn,
                                            shaderCallback: (bounds) => LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [
                                                AppColors.textAndOutlineTop,
                                                AppColors.textAndOutlineBottom
                                              ],
                                            ).createShader(Rect.fromLTWH(
                                                0, 0, bounds.width, bounds.height)),
                                            child: Text(
                                              AppString.closeJobPageUploadTruckPhoto,
                                              style: GoogleFonts.urbanist(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w700,
                                                  color: AppColors
                                                      .lightBlackishTextColor69),
                                            ),
                                          ),
                                        )
                                        :Image.file(File(
                                            controller.fuelCardImagePath.value),
                                          fit: BoxFit.fill,)

                                      ),
                                    )
                            ]
                              ),
                            )
                        ),
                      ],
                    )),
                  ],
                ),
                SizedBox(height: 30,),
                CustomSolidButton(
                    text: AppString.saveButtonText,
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
                      );
                      dailyLoginPageController.updateDailyLoginGrid(3);
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: 'Truck Images saved successfully');
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}