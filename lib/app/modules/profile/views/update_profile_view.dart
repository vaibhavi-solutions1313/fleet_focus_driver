// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
// import 'package:staffin_softwares/app/modules/profile/controllers/profile_controller.dart';
// import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
// as picker;
// import 'package:staffin_softwares/app/modules/profile/views/update_additional_info_view.dart';
// import '../../../app_constants/app_strings.dart';
// import '../../../app_widgets/app_text_fields.dart';
// import '../../../app_widgets/custom_Image_container.dart';
// import '../../../app_widgets/custom_appBar.dart';
// import '../../../app_widgets/custom_dropdown.dart';
// import '../../../app_widgets/edit_profile_image.dart';
// import '../../auth_page/views/update_additional_info_view.dart';
//
//
// class UpdateProfileView extends GetView<ProfileController> {
//   const UpdateProfileView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       body: ListView(
//         padding: EdgeInsets.all(16.0),
//         children: [
//           SafeArea(
//             child: Column(
//               children: [
//
//                 const CustomAppBar(title: AppString.updateProfilePageTitle,),
//                 const UserAvatar(),
//                 AppTextField(controller: controller.fullNameTextEditingController, hinText: AppString.updateProfilePageHintTextForFullName),
//                 AppCalendarTextField(controller: controller.dobTextEditingController, hinText: AppString.updateProfilePageHintTextForDob,),
//
//                 CustomImageContainer(controller: controller.nationalityTextEditingController, hinText: AppString.updateProfilePageHintTextForNationality,),
//                 CustomImageContainer(controller: controller.passportImageTextEditingController, hinText: AppString.updateProfilePagePassportSizeImage,),
//                 CustomDropdownButton(data:controller.data,controller:controller.dropdownSpouseTextEditingController, hinText: AppString.updateProfilePageDropdownSpouse,),
//                 CustomImageContainer(controller: controller.marriageCertificateImageTextEditingController, hinText: AppString.updateProfilePageMarriageCertificateImage,),
//                 CustomImageContainer(controller: controller.cOEImageTextEditingController, hinText: AppString.updateProfilePageCOEImage,),
//                 CustomImageContainer(controller: controller.visaImageTextEditingController, hinText: AppString.updateProfilePageVisaImage,),
//                 CustomDropdownButton(data:controller.data,controller:controller.workHourTextEditingController, hinText: AppString.updateProfilePageDropdownWorkHour),
//
//                 Row(
//                   children: [
//                     Expanded(child:AppCalendarTextField(controller: controller.visaStartDateTextEditingController, hinText: AppString.updateProfilePageHintTextForVisaStartDate,)),
//                     SizedBox(width: 6.0,),
//                     Expanded(child:AppCalendarTextField(controller: controller.visaEndDateTextEditingController, hinText: AppString.updateProfilePageHintTextForVisaEndDate,)),
//                   ],
//                 ),
//
//                 SizedBox(height: 20.0,),
//                 CustomSolidButton(text: AppString.updateProfilePageButtonSaveAndNext, onTap: (){
//                   // Get.to(()=>const UpdateAdditionalInfoView());
//                 })
//               ],
//             ),
//           )
//         ],
//       )
//     );
//   }
// }
//
//
// ////////////////////////////////////////
//
//
//
