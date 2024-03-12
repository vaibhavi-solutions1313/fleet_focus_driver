import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffin_softwares/main.dart';

import '../../../app_widgets/custom_bottom_sheet.dart';
import '../../../app_widgets/custom_grid_item.dart';
import '../../../app_widgets/custom_loader.dart';
import '../../auth_page/views/bank_details_view.dart';
import '../../auth_page/views/basic_details_view.dart';
import '../../auth_page/views/license_detail.dart';
import '../../auth_page/views/upload_image_view.dart';
import '../../auth_page/views/visa_passport_detail_view.dart';
import '../providers/profile_provider.dart';

class ProfileController extends GetxController {
  //TODO: Implement ProfileController
  ProfileProvider provider=ProfileProvider();
  ///Profile
  final updatePasswordFormKey=GlobalKey<FormState>();
  Rx<String?> userAvatarUrl=userBasicInformation.data?.profilePhotoUrl.obs??''.obs;
  var isUserNeedsToUpdatePassword=false.obs;
  TextEditingController fullNameTextEditingController=TextEditingController(text: userBasicInformation.data?.name??'');
  TextEditingController mobileNumberTextEditingController=TextEditingController(text: driverInfo.data?.mobileNumber??'');
  TextEditingController addressTextEditingController=TextEditingController(text: userBasicInformation.data?.address??'');
  TextEditingController oldPasswordTextEditingController=TextEditingController();
  TextEditingController newPasswordTextEditingController=TextEditingController();
  TextEditingController cnfPasswordTextEditingController=TextEditingController();
  ///Update Profile
  // TextEditingController fullNameTextEditingController=TextEditingController(text: userBasicInformation.data?.name??'');
  // TextEditingController dobTextEditingController=TextEditingController(text: driverInfo.data?.dob??'');
  // TextEditingController nationalityTextEditingController=TextEditingController(text: driverInfo.data?.passportCountry??'');
  // TextEditingController passportImageTextEditingController=TextEditingController();
  // TextEditingController dropdownSpouseTextEditingController=TextEditingController();
  // TextEditingController marriageCertificateImageTextEditingController=TextEditingController();
  //
  // TextEditingController cOEImageTextEditingController=TextEditingController();
  // TextEditingController visaImageTextEditingController=TextEditingController();
  // TextEditingController workHourTextEditingController=TextEditingController();
  // TextEditingController visaStartDateTextEditingController=TextEditingController();
  // TextEditingController visaEndDateTextEditingController=TextEditingController();
  // //Dropdown
  // List<DropdownMenuItem> data=<DropdownMenuItem>[
  //   DropdownMenuItem(child: Text('a'),value: 'a',),
  //   DropdownMenuItem(child: Text('b'),value: 'b',),
  // ];

  ///Additional information page
 //  TextEditingController licenseNumberTextEditingController=TextEditingController();
 //  TextEditingController licenseTypeEditingController=TextEditingController();
 //  TextEditingController licenseImageTextEditingController=TextEditingController();
 //
 //  TextEditingController bankNameTextEditingController=TextEditingController();
 //  TextEditingController bsbTextEditingController=TextEditingController();
 //  TextEditingController accountNumberTextEditingController=TextEditingController();
 //
 //  TextEditingController confirmAccountNumberTextEditingController=TextEditingController();
 //  TextEditingController signatureTextEditingController=TextEditingController();
 // RxString isRegisteredForGst='Yes'.obs;
 // RxBool isReadTermsAndCondition=false.obs;

  var profileDetailsList = <GridItem>[
    GridItem(
      image: 'assets/daily_login/truck_customer_img.png',
      title: '1. Basic Details',
      subtitle: 'Incomplete'.obs,
      icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          BasicDetailsView(),
        );
      },
    ),
    GridItem(
      image: 'assets/daily_login/visa_details.png',
      title: '2. Visa & Passport Details',
      subtitle: 'Incomplete'.obs,
      icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
            VisaPassportDetails()
        );
      },
    ),
    GridItem(
      image: 'assets/daily_login/truck_customer_img.png',
      title: '3. License Detail',
      subtitle: 'Incomplete'.obs,
      icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          LicenseDetailsView(),
        );
      },
    ),
    GridItem(
      image: 'assets/daily_login/bank_details.png',
      title: '4. Bank Details',
      subtitle: 'Incomplete'.obs,
      icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          BankDetailsView(),
        );
      },
    ),
    GridItem(
      image: 'assets/daily_login/truck_img.png',
      title: '5. Upload Images',
      subtitle: 'Incomplete'.obs,
      icon: 'assets/daily_login/red_wrong.png'.obs,
      onTap: () {
        CustomBottomSheet.show(
          UploadImagesView(),
        );
      },
    ),

  ];

  void updateGridItem(int index){
    profileDetailsList[index].icon.value = 'assets/daily_login/green_tick.png';
    profileDetailsList[index].subtitle.value = 'Completed';
  }

  @override
  void onInit() {
    if (kDebugMode) {
      print('88888888888888888888888888888888888888888');
      print(userBasicInformation.data?.profilePhotoUrl);
    }
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
//////////////
getUpdatePassword({required String oldPassword,required String newPassword,required String cnfPassword,})async{
    if(updatePasswordFormKey.currentState!.validate()){
      CustomLoader.showLoader();
      provider.updatePassword(oldPassword: oldPassword, newPassword: newPassword, cnfPassword: cnfPassword).then((value) {
        CustomLoader.cancelLoader();
      });
    }
}

}
