import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_constants/getstorage_keys.dart';
import 'package:staffin_softwares/app/modules/declaration_page/views/information_needed_before_start_view.dart';
import 'package:staffin_softwares/app/modules/home/bindings/home_binding.dart';
import 'package:staffin_softwares/app/modules/home/views/home_view.dart';
import 'package:staffin_softwares/main.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_services/services.dart';
import '../../../app_widgets/custom_loader.dart';
import '../../create_job/providers/job_provider.dart';
import '../../home/providers/home_provider.dart';
import '../providers/declaration_provider.dart';

class DeclarationPageController extends GetxController {
  //TODO: Implement DeclarationPageController
  DeclarationProvider provider=DeclarationProvider();

  var declaration = [
    {
      'title': 'Have you got a valid driver license?',
      'value': false,
    },
    {
      'title': 'The vehicle has been check for the roadworthyness condition and does not have any defects.',
      'value': false,
    },
    {
      'title': 'Are you free from the influence of alcohol/drugs or any medications that would affect you in any way to perform your duties?',
      'value': false,
    },
    {
      'title': 'You are wearing proper uniform? Saftey shoes, visibility vest, helmet',
      'value': false,
    },
  ].obs;
  SignatureController signatureController=SignatureController();
  ///Information needed before start
  final informationNeededFormKey=GlobalKey<FormState>();
  List<dynamic> data=[];
  List<dynamic> regoData=[];
  List<String> storedCustomerNames=[];
  TextEditingController driverNumberTextEditingController = TextEditingController(text: '3107');
  TextEditingController clientTextEditingController = TextEditingController();
  TextEditingController registrationTextEditingController = TextEditingController();
  var userRegoId=''.obs;
  var vendorId=''.obs;
  var vehicleTypeId=''.obs;
  var serviceDue=''.obs;
  TextEditingController odometerTextEditingController = TextEditingController();
  TextEditingController frontTruckPhotosTextEditingController = TextEditingController();
  TextEditingController fuelCardImageTextEditingController = TextEditingController();
  TextEditingController backTruckPhotosTextEditingController = TextEditingController();
  TextEditingController startTimeTextEditingController = TextEditingController();
  Rx<TextEditingController> numberOfJobsTextEditingController = TextEditingController(text: '1').obs;
  var countJobs = 1.obs;

  RxString isHavingAFuelCard = AppString.informationNeededPageTextYes.obs;
  RxString hasDentOrDamageTruck = AppString.informationNeededPageTextYes.obs;
  RxBool isReadTermsAndCondition = false.obs;
  var truckFrontImagePath = "".obs;
  var truckBackImagePath = "".obs;
  var truckRightImagePath = "".obs;
  var truckLeftImagePath = "".obs;
  var truckRightTyreImagePath = "".obs;
  var truckLeftTyreImagePath = "".obs;

  var truckDamageImagePath1 = "".obs;
  var truckDamageImagePath2 = "".obs;
  var fuelCardImagePath = "".obs;

  @override
  void onInit() {
    ever(userRegoId, (v) {getTruckDetailByRego(regoId:userRegoId.value);});
    startTimeTextEditingController.text=DateFormat('EEE, M/d/y').add_jm().format(DateTime.now());
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

  saveDeclaration() async {
    if(declaration[0]['value']==true){
      if(declaration[1]['value']==true){
        if(declaration[2]['value']==true){
          if(declaration[3]['value']==true){
            if(signatureController.isNotEmpty){
              if(isReadTermsAndCondition.value){
                CustomLoader.showLoader();
                provider.fetchCustomerList().then((customerListResponse)async {
                  print('-----------------customerListResponse-customerListResponse-------------------');
                  print(customerListResponse.statusCode.toString());
                  await provider.fetchRego().then((regoResponseValue) async{
                    CustomLoader.cancelLoader();
                    var customerListDecodedData=jsonDecode(await customerListResponse.stream.bytesToString());
                    var regoDecodedData=jsonDecode(await regoResponseValue.stream.bytesToString());
                    if(customerListDecodedData['success']==true && regoDecodedData['success']==true){
                      data.clear();
                      data=['Select customer name'];
                      data=[...data,...customerListDecodedData['data']];
                      print(data);
                      print(regoDecodedData);
                      if(regoDecodedData['data'].isNotEmpty){
                        regoData.clear();
                        for(var x in regoDecodedData['data']){
                          regoData.add(x['rego']);
                        }
                        userRegoId.value=regoDecodedData['data'][0]['rego']!;
                        // Get.to(() => const InformationNeededBeforeStartView(),);
                      }else{
                        AppServices().showToastMessage(toastMessage: 'Customer not available');
                      }
                    }else{
                      AppServices().showToastMessage(toastMessage: 'Customer not available or server error');
                    }
                  });
                });
              }else{
                AppServices().showToastMessage(toastMessage: 'Please accept our terms.');
              }
            }else{
              AppServices().showToastMessage(toastMessage: 'Please draw your signature');
            }
          }else{
            AppServices().showToastMessage(toastMessage: 'You are not authorised to move further because you do not wearing proper uniform');
          }
        }else{
          AppServices().showToastMessage(toastMessage: 'You are not authorised to move further because you are the influence of alcohol/drugs.');
        }
      }else{
        AppServices().showToastMessage(toastMessage: 'You are not authorised to move further because your vehicle conditions are not good.');
      }
    }else{
      AppServices().showToastMessage(toastMessage: 'You are not authorised to move further because you do not have a valid license.');
    }
  }

  Future<String?> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image.path);
      return image.path;
    } else {
      AppServices().showToastMessage(toastMessage: 'Image not selected or max reached.');
    }
  }

  /////////////////////////////////////
  ///Information needed
  startWork({required String driverNumber,required List<String> driverName,required String vehicleTypeId,required String rego,required String odometer,required String serviceDue,required String truckFrontImage,required String truckBackImage,required String truckRightImage,required String truckLeftImage,required String truckLeftTyreImage,required String truckRightTyreImage,required String truckDamageImagePath1,required String truckDamageImagePath2,required String fuelCardImage,required String startWorkTime,
    // required numberOfJobs
  }) async {
    if(informationNeededFormKey.currentState!.validate()){
          if(truckFrontImagePath.value!='' && truckBackImagePath.value!='' && truckRightTyreImagePath.value!='' && truckLeftTyreImagePath.value!=''){
            CustomLoader.showLoader();
            print(driverName.toString());
            await JobProvider().createJob(
                driverNumber: driverNumber,
                driverName: driverName,
                vehicleTypeId: vehicleTypeId,
                rego: rego, odometer: odometer,
                serviceDue: serviceDue,
                truckFrontImage: truckFrontImage,
                truckBackImage: truckBackImage,
                truckRightImage: truckRightImage,
                truckLeftImage: truckLeftImage,
                truckDamageImagePath1: truckDamageImagePath1,
                truckDamageImagePath2: truckDamageImagePath2,
                truckLeftTyreImage: truckLeftTyreImage, truckRightTyreImage: truckRightTyreImage,
                startWorkTime: startWorkTime,
                // numberOfJobs: numberOfJobs,
                fuelCardImage: fuelCardImage
            ).then((value)async {
              CustomLoader.cancelLoader();
              if(value.statusCode==200){
                var decodedData=jsonDecode(await value.stream.bytesToString());
                print(value.statusCode.toString());
                print(decodedData.toString());
                if(decodedData['success']==true){
                  print('999999999999999999999999999');
                  CustomLoader.showLoader();
                  await HomeProvider().getStartTimer().then((value)async {
                    var decodedTimerData=jsonDecode(await value.stream.bytesToString());
                    if(decodedTimerData['success']==true){
                      CustomLoader.cancelLoader();
                      ///Save date time to local
                      getStorage.write(GetStorageKeys.lastLoginTime, DateTime.now().toString());
                      Get.to(() => const HomeView(), binding: HomeBinding());
                    }else{
                      CustomLoader.cancelLoader();
                    }
                    AppServices().showToastMessage(toastMessage: decodedTimerData['message']);
                  });
                }else{
                  AppServices().showToastMessage(toastMessage: decodedData['message']);
                }
              }else{
                print(value.reasonPhrase.toString());
              }
            });
          }else{
            AppServices().showToastMessage(toastMessage: 'Add fuel card images');
          }
      }

    }


  getTruckDetailByRego({required String regoId})async{
    CustomLoader.showLoader();
    try{
      provider.fetchTruckDetailByRego(regoId: regoId).then((value)async {
        var decodeData=jsonDecode(await value.stream.bytesToString());
        if (kDebugMode) {
          print(decodeData.toString());
        }
        odometerTextEditingController.text=decodeData['data']['odometer_value'].toString();
        vendorId.value=decodeData['data']['vendor_id'].toString();
        vehicleTypeId.value=decodeData['data']['vehicle_type_id'].toString();
        serviceDue.value=decodeData['data']['service_due'].toString();
      });
      CustomLoader.cancelLoader();
    }catch(e){
      CustomLoader.cancelLoader();
    }

  }
  }



