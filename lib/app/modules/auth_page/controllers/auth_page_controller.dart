import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pinput/pinput.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_constants/getstorage_keys.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/daily_login_page_controller.dart';
import 'package:staffin_softwares/app/modules/auth_page/providers/auth_provider.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/auth_page_view.dart';
import 'package:staffin_softwares/app/modules/profile/views/profile_details_view.dart';
import 'package:staffin_softwares/main.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_widgets/custom_loader.dart';
import '../../profile/providers/profile_provider.dart';
import '../views/contract_view.dart';
import '../views/daily_login_page_view.dart';
import '../views/update_additional_info_view.dart';

class AuthPageController extends GetxController {
  //TODO: Implement AuthPageController
  AuthProvider provider = AuthProvider();

  ///Login
  final loginFormKey = GlobalKey<FormState>();
  final truckDetailsFormKey = GlobalKey<FormState>();
  final customerDetailsFormKey = GlobalKey<FormState>();
  final truckImagesFormKey = GlobalKey<FormState>();
  final termsConditionsFormKey = GlobalKey<FormState>();
  TextEditingController loginUserNameTextEditingController = TextEditingController(text: '');
  TextEditingController loginPasswordTextEditingController = TextEditingController(text: '');

  ///Register
  final signUpFormKey = GlobalKey<FormState>();
  final pinController = TextEditingController();
  TextEditingController fullNameTextEditingController = TextEditingController();
  TextEditingController signUpEmailTextEditingController = TextEditingController();
  TextEditingController signUpMobileTextEditingController = TextEditingController();
  TextEditingController signUpPasswordTextEditingController = TextEditingController();
  TextEditingController signUpConfirmPasswordTextEditingController = TextEditingController();
  TextEditingController signUpReferralCodeEditingController = TextEditingController(text: ''); // FLE7569

  ///Update Profile
  final updateProfileFormKey = GlobalKey<FormState>();
  var userAvatarImagePath = ''.obs;

  TextEditingController dobTextEditingController = TextEditingController();
  TextEditingController ageTextEditingController = TextEditingController();
  TextEditingController nationalityTextEditingController = TextEditingController();
  TextEditingController stateTextEditingController = TextEditingController();
  TextEditingController passportNumberTextEditingController = TextEditingController();
  TextEditingController passportImageTextEditingController = TextEditingController();
  TextEditingController addressTextEditingController = TextEditingController();
  Rx<TextEditingController> dropdownSpouseTextEditingController = TextEditingController().obs;
  TextEditingController marriageCertificateImageTextEditingController = TextEditingController();

  TextEditingController cOEImageTextEditingController = TextEditingController();
  TextEditingController visaImageTextEditingController = TextEditingController();
  TextEditingController workHourTextEditingController = TextEditingController();
  TextEditingController breakTypeTextEditingController = TextEditingController();
  TextEditingController wagesTypeTextEditingController = TextEditingController();
  TextEditingController visaTypeTextEditingController = TextEditingController();
  TextEditingController visaStartDateTextEditingController = TextEditingController();
  TextEditingController visaEndDateTextEditingController = TextEditingController();
  TextEditingController truckNumberTextEditingController = TextEditingController();
  TextEditingController odometerValueTextEditingController = TextEditingController();

  ///Additional information page
  SignatureController signatureController = SignatureController();
  DailyLoginPageController dailyLoginPageController  = DailyLoginPageController();
  var signaturePhotoPath = "".obs;
  List<dynamic> licenseTypeDropdownData=[];
  List<dynamic> visaTypeDropdownData=[];
  List<dynamic> licenseStateDropdownData=[];
  List<dynamic> workingHourDropdownData=['Part time','Full time'];
  List<dynamic> breakTypeDropdownData=['Paid','Unpaid'];
  List<dynamic> wagesTypeDropdownData=['Per hour','Per day'];
  List<dynamic> data = [];
  final updateAdditionalProfileFormKey = GlobalKey<FormState>();
  TextEditingController licenseNumberTextEditingController = TextEditingController();
  TextEditingController licenseTypeEditingController = TextEditingController();
  TextEditingController licenseImageTextEditingController = TextEditingController();

  TextEditingController bankNameTextEditingController = TextEditingController();
  TextEditingController bsbTextEditingController = TextEditingController();
  TextEditingController abnTextEditingController = TextEditingController();
  TextEditingController accountNumberTextEditingController = TextEditingController();

  TextEditingController confirmAccountNumberTextEditingController = TextEditingController();
  TextEditingController signatureImageTextEditingController = TextEditingController();
  RxString isRegisteredForGst = 'Yes'.obs;
  RxBool isReadTermsAndCondition = false.obs;
  RxBool isReadContracts = false.obs;
  RxBool isReadDeed = false.obs;

  Future userContract({required String abn,required String name})async{
    ///Call contract
    try{
      CustomLoader.showLoader();
     await provider.fetchUserContract(abn: abn, name: name).then((value) async{
       CustomLoader.cancelLoader();
       if(value.statusCode==200){
         var data = await value.stream.bytesToString();
         Get.dialog(Padding(
           padding: const EdgeInsets.all(16.0),
           child: ContractView(htmlText: data, title: 'Contract',),
         ));
         // Get.to(()=>ContractView(htmlText: data, title: 'Contract',),fullscreenDialog: true);
       }
     });
    }catch (e){
      CustomLoader.cancelLoader();
    }
  }
  Future userDeed({required String abn,required String name,required String address,})async{
    ///Call deed
    await provider.fetchDeed(abn: abn, name: name, address: address);

    try{
      CustomLoader.showLoader();
      await provider.fetchDeed(abn: abn, name: name, address: address).then((value) async{
        CustomLoader.cancelLoader();
        if(value.statusCode==200){
          var data = await value.stream.bytesToString();
          Get.dialog(Padding(
            padding: const EdgeInsets.all(16.0),
            child: ContractView(htmlText: data, title: 'User Deed',),
          ));
          // Get.to(()=>ContractView(htmlText: data,),fullscreenDialog: true);
        }
      });
    }catch (e){
      CustomLoader.cancelLoader();
    }
  }

  @override
  void onInit() {
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

  ///Login Methods
  Future<String?> getDeviceToken() async {
    var messaging = FirebaseMessaging.instance;
    var deviceToken = await messaging.getToken();
    return deviceToken;
  }

  Future getTruckDetails({
    required String driverNumber,
    required String rego,
    required String odometerValue,
}) async{
    if(truckDetailsFormKey.currentState!.validate()){
      CustomLoader.showLoader();
      AppServices().showToastMessage(toastMessage: 'Truck Details Saved Successfully');
      dailyLoginPageController.updateDailyLoginGrid(1);
      ///TODO: Make API call
    } else {
      CustomLoader.cancelLoader();
      AppServices().showToastMessage(toastMessage: 'Unable to save truck details');
    }
  }
  Future getStartLogin({
    required String userName,
    required String password,
  }) async {
    if (loginFormKey.currentState!.validate()) {
      CustomLoader.showLoader();
      getDeviceToken().then((deviceToken) {
        provider.getRequestLogin(deviceToken: deviceToken!, userName: userName, password: password).then((loginResponse) async {
          var loginJsonDecodedData = jsonDecode(await loginResponse.stream.bytesToString());
          if (loginJsonDecodedData['success'] == true) {
            loginToken=loginJsonDecodedData['data']['token'];
            getStorage.write(GetStorageKeys.userLoginToken, loginJsonDecodedData['data']['token']);
            getStorage.write(GetStorageKeys.lastLoginTime, DateTime.now().toString());
            ProfileProvider().fetchUserInfo(loginUserToken: loginJsonDecodedData['data']['token']).then((userInfo) {
              ProfileProvider().fetchDriverInfo(loginUserToken: loginJsonDecodedData['data']['token']).then((driverInfo) {
                CustomLoader.cancelLoader();
                print('-----------login success-------------------');
                if (userInfo.data != null && driverInfo.data != null) {
                  // Get.to(() => const DeclarationPageView(), binding: DeclarationPageBinding());
                  Get.to(() => const DailyLoginPageView());
                  AppServices().determinePosition();
                  AppServices().showToastMessage(toastMessage: 'Logged In Successfully...!');
                } else {
                  AppServices().showToastMessage(toastMessage: 'Something went wrong');
                }
              });
            });

          } else {
            CustomLoader.cancelLoader();
            AppServices().showToastMessage(toastMessage: loginJsonDecodedData['data']);
          }
        });
      });
    }
  }


  ///Start registration process
  getStartRegistration() async{
    // if (signUpFormKey.currentState!.validate()) {
    if (updateAdditionalProfileFormKey.currentState!.validate()) {
      // await getLicenseType();
      // await getLicenseState();
      // await getVisaType();
      // await Get.to(() => const UpdateProfileView());
      getRegisterUser();
      await Get.to(() => const ProfileDetailsPageView());
    }
  }

  getLicenseType()async{
    CustomLoader.showLoader();
    await provider.fetchLicenseType().then((value)async{
        var decodedData=jsonDecode(await value.stream.bytesToString());
        if(decodedData['success']==true){
          CustomLoader.cancelLoader();
          licenseTypeDropdownData.clear();
          licenseTypeDropdownData=decodedData['data'];
          // if(decodedData['data'].isNotEmpty){
          //   licenseTypeDropdownData.clear();
          //   for(var x in decodedData['data']){
          //     licenseTypeDropdownData.add(x['type']);
          //   }
          // }
          // licenseTypeDropdownData.insert(0, 'Select License Type');
        }else{
          CustomLoader.cancelLoader();
          AppServices().showToastMessage(toastMessage:decodedData['message']);
        }
    });
  }
  getLicenseState()async{
    CustomLoader.showLoader();
    await provider.fetchLicenseState().then((value)async{
      var decodedData=jsonDecode(await value.stream.bytesToString());
      if(decodedData['success']==true){
        CustomLoader.cancelLoader();
        licenseStateDropdownData.clear();
        if(decodedData['data'].isNotEmpty){
          for(var x in decodedData['data']){
            licenseStateDropdownData.add(x['state']);
          }
        }
        licenseStateDropdownData.insert(0, 'Select License State');
      }else{
        CustomLoader.cancelLoader();
        AppServices().showToastMessage(toastMessage:decodedData['message']);
      }
    });
  }
  getVisaType()async{
    CustomLoader.showLoader();
    await provider.fetchVisaType().then((value)async{
      var decodedData=jsonDecode(await value.stream.bytesToString());
      if(decodedData['success']==true){
        CustomLoader.cancelLoader();
        visaTypeDropdownData.clear();
        if(decodedData['data'].isNotEmpty){
          visaTypeDropdownData=decodedData['data'];
        }
      }else{
        CustomLoader.cancelLoader();
        AppServices().showToastMessage(toastMessage:decodedData['message']);
      }
    });
  }



  ///Add additional info
  getAdditionalInformation() {
    if (updateProfileFormKey.currentState!.validate()) {
      Get.to(() => const UpdateAdditionalInfoView());
    }
  }

  ///Register Methods
  getRegisterUser() async {
    print(wagesTypeTextEditingController.text);
    if (updateAdditionalProfileFormKey.currentState!.validate()) {
      // await signatureController.toPngBytes(height: 1000, width: 1000).then((value) async {
      //   Uint8List yourUint8ListData = value!; // Replace with your data
      //   String fileName = 'signature.jpg'; // Replace with your desired file name
      //   signaturePhotoPath.value = await saveUint8ListToFile(yourUint8ListData, fileName);
      // });
      CustomLoader.showLoader();
      // if (userAvatarImagePath.value != '') {
        if (updateAdditionalProfileFormKey.currentState!.validate()) {
          Map mapData = {
            'ref_code': signUpReferralCodeEditingController.text.trim(),
            'full_name': fullNameTextEditingController.text.trim(),
            'email': signUpEmailTextEditingController.text.trim(),
            'password': signUpPasswordTextEditingController.text.trim(),
            // 'address': addressTextEditingController.text.trim(),
            // 'age': ageTextEditingController.text.trim(),
            // 'mobile_number': signUpMobileTextEditingController.text.trim(),
            // 'dob': dobTextEditingController.text.trim(),
            // 'passport_number': passportNumberTextEditingController.text.trim(),
            // 'passport_country': nationalityTextEditingController.text.trim(),
            // 'wages_type':wagesTypeTextEditingController.text.trim(),
            // 'break_type':breakTypeTextEditingController.text.trim(),
            // 'visa_status_id': visaTypeTextEditingController.text,
            // 'hours_allowed_to_work': workHourTextEditingController.text=='Full time'?'12':'8',
            // 'bank_bsb': bsbTextEditingController.text.trim(),
            // 'abn': abnTextEditingController.text.trim(),
            // 'bank_account_number': accountNumberTextEditingController.text.trim(),
            // 'license_type_id': licenseTypeEditingController.text.trim(),
            // 'license_state': licenseTypeEditingController.text.trim(),
            // 'license_number': licenseNumberTextEditingController.text.trim(),
            // 'employee_category': 'driver',
            // 'ip_address': '192.168.0.1',
            'is_condition_check': '1',
          };
          provider.registerUser(
            data: mapData,
            // userAvatarPath: userAvatarImagePath.value,
            // passportImagePath: passportImageTextEditingController.text,
            // passportBackImagePath: '',
            // visaImagePath: visaImageTextEditingController.text,
            // abnImagePath: '',
            // licenseImagePath: licenseImageTextEditingController.text,
            // licenseBackImagePath: licenseImageTextEditingController.text,
            // signatureImagePath: signaturePhotoPath.value,
          ).then((newRegistrationResponse) async {

            var newRegistrationResponseJsonDecodedData = jsonDecode(await newRegistrationResponse.stream.bytesToString());
            print('New User :: ${newRegistrationResponseJsonDecodedData.toString()}');
            if(newRegistrationResponse.statusCode==200){
              if (newRegistrationResponseJsonDecodedData['success'] == true) {

                provider.sendOtpForNewRegistration(emailId: signUpEmailTextEditingController.text.trim()).then((otpResponseValue) async {
                  var otpResponseJsonDecodedData = jsonDecode(await otpResponseValue.stream.bytesToString());
                  if (otpResponseJsonDecodedData['success'] == true) {
                    print('Account successfully registered');
                    CustomLoader.cancelLoader();
                    Get.dialog(
                        barrierDismissible: false,
                        WillPopScope(
                            child: Center(
                              child: Material(
                                child: Container(
                                  margin: EdgeInsets.all(16.0),
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color:AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text15By500(text: 'Enter Otp'),
                                      const SizedBox(height: 10,),
                                      Pinput(
                                        length: 6,
                                        controller: pinController,
                                        // focusNode: focusNode,
                                        androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                                        listenForMultipleSmsOnAndroid: true,
                                        // defaultPinTheme: defaultPinTheme,
                                        separatorBuilder: (index) => const SizedBox(width: 8),
                                        // validator: (value) {
                                        //   return value == '2222' ? null : 'Pin is incorrect';
                                        // },
                                        // onClipboardFound: (value) {
                                        //   debugPrint('onClipboardFound: $value');
                                        //   pinController.setText(value);
                                        // },
                                        hapticFeedbackType: HapticFeedbackType.lightImpact,
                                        onCompleted: (pin) {
                                          debugPrint('onCompleted: $pin');
                                        },
                                        onChanged: (value) {
                                          debugPrint('onChanged: $value');
                                        },
                                        cursor: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              margin: const EdgeInsets.only(bottom: 9),
                                              width: 22,
                                              height: 1,
                                              // color: focusedBorderColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 20,),
                                      CustomSolidButton(text: "Submit", onTap: (){
                                        CustomLoader.showLoader();
                                        verifyNewRegisteredAccount(emailId: signUpEmailTextEditingController.text.trim(),
                                            otp:pinController.text).whenComplete(() {
                                          CustomLoader.cancelLoader();
                                        });
                                      }),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            onWillPop: () => Future.value(true)));
                  } else {
                    CustomLoader.cancelLoader();
                    print('-------------------otp sending error-------------------');
                  }
                });
              } else {
                CustomLoader.cancelLoader();
                print('-------------------registration unsuccessful-------------------');

                AppServices().showToastMessage(toastMessage: newRegistrationResponseJsonDecodedData['message']);
              }
            }else{
              AppServices().showToastMessage(toastMessage: 'Something went wrong, try later.');
            }

          });
        }
      // } else {
      //   CustomLoader.cancelLoader();
      //   AppServices().showToastMessage(toastMessage: 'Add profile image');
      // }
    }
  }
  Future verifyNewRegisteredAccount({required String emailId,required String otp})async{
    await provider.verifyAccountByOtp(emailId: emailId, otp: otp).then((value)async {
      var decodedData=jsonDecode(await value.stream.bytesToString());
      if(decodedData['success']==true){
        AppServices().showToastMessage(toastMessage: 'registered successfully');
        Get.offAll(()=>const AuthPageView(),binding: AuthPageBinding());
      }else{
        AppServices().showToastMessage(toastMessage: decodedData['message']);
      }
    });
  }
  Future<String> saveUint8ListToFile(Uint8List data, String fileName) async {
    try {
      Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();
      File file = File('${appDocumentsDirectory.path}/$fileName');
      await file.writeAsBytes(data);
      return file.path;
    } catch (e) {
      print('Error saving file: $e');
      return "";
    }
  }


}
