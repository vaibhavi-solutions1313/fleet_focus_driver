import 'package:country_picker/country_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/update_additional_info_view.dart';
import 'package:staffin_softwares/app/modules/profile/controllers/profile_controller.dart';
import 'dart:io';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/custom_Image_container.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown.dart';
import '../controllers/auth_page_controller.dart';

class BasicDetailsView extends GetView<AuthPageController> {
  const BasicDetailsView({Key? key}) : super(key: key);
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
                        child: Text('1. Basic Details', style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat',
                            fontSize: 15,
                            letterSpacing: 0.2
                        ),),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        children: [
                          Center(
                            child: Stack(
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.appPrimaryLightColor,
                                  radius: 38,
                                  child: Obx(() => CircleAvatar(
                                    radius: 36,
                                    backgroundImage: controller.userAvatarImagePath.value != '' ? FileImage(File(controller.userAvatarImagePath.value)) : null,
                                  )),
                                ),
                                Positioned(
                                  bottom: 2.0,
                                  right: 1.0,
                                  child: InkWell(
                                      onTap: () async {
                                        var imageFile = await AppServices().selectImageFromGallery();
                                        {
                                          if (imageFile!.path.isNotEmpty) {
                                            controller.userAvatarImagePath.value = imageFile.path;
                                          }
                                        }
                                      },
                                      child: Image.asset("assets/daily_login/edit_profile_img.png")
                                    // const Card(
                                    //   color: AppColors.lightBlackTextColor,
                                    //   child: Padding(
                                    //     padding: EdgeInsets.all(4.0),
                                    //     child: Icon(Icons.edit, size: 16, color: AppColors.textAndOutlineBottom,),
                                    //   ),
                                    // ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            'Profile picture',
                            style: GoogleFonts.lato(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.lightBlackishTextColor69,
                            ),
                          ),
                        ],
                      ),
                      AppTextField(
                          controller: controller.fullNameTextEditingController,
                          hinText: AppString.updateProfilePageHintTextForFullName
                      ),
                      AppCalendarTextField(
                        controller: controller.dobTextEditingController,
                        differenceInYearTextController: controller.ageTextEditingController,
                        hinText: AppString.updateProfilePageHintTextForDob,
                      ),
                      AppTextField(controller: controller.ageTextEditingController,
                          hinText: AppString.updateProfilePageHintTextForAge),

                      AppTextField(controller: controller.addressTextEditingController, hinText: AppString.updateProfilePagePassportAddress),
                      AppTextField(controller: controller.stateTextEditingController, hinText: AppString.updateProfilePageHintTextForState),
                      SizedBox(height: 12,),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.textAndOutlineColor,
                                width: 1.0
                            )
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            TextFormField(
                              style: GoogleFonts.urbanist(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.textAndOutlineColor,
                              ),
                              onTap: ()async{
                                showCountryPicker(
                                  context: context,
                                  showPhoneCode: false, // optional. Shows phone code before the country name.
                                  onSelect: (Country country) {
                                    print('Select country: ${country.displayName}');
                                    controller.nationalityTextEditingController.text=country.name;
                                  },
                                );
                              },
                              controller: controller.nationalityTextEditingController,
                              // keyboardType: textInputType,
                              readOnly: true,
                              validator: (v){
                                if(v!.isEmpty) {
                                  return 'Fill the field';
                                }else{
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                    borderSide: BorderSide.none
                                ),
                                hintText: AppString.updateProfilePageHintTextForNationality,
                                hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor.withOpacity(0.4)),
                                suffixIcon: const Icon(CupertinoIcons.map_pin_ellipse),
                                suffixIconColor: AppColors.textAndOutlineColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      CustomDropdownButton(data: controller.workingHourDropdownData, controller: controller.workHourTextEditingController, hinText: AppString.updateProfilePageDropdownWorkHour),

                      const SizedBox(height: 20.0),
                      CustomSolidButton(
                          text: AppString.saveButtonText,
                          onTap: () {
                            // controller.getAdditionalInformation();
                            profileController.updateGridItem(0);
                            Fluttertoast.showToast(msg: 'Basic Details uploaded successfully');
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