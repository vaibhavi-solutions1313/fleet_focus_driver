import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:signature/signature.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/modules/declaration_page/bindings/declaration_page_binding.dart';
import 'package:staffin_softwares/app/modules/declaration_page/views/declaration_page_view.dart';
import 'package:staffin_softwares/app/modules/home/controllers/home_controller.dart';
import '../../../../main.dart';
import '../../declaration_page/providers/declaration_provider.dart';
import '../../splash_screen/bindings/splash_screen_binding.dart';
import '../../splash_screen/views/splash_screen_view.dart';
import '../providers/job_provider.dart';

class CreateJobController extends GetxController {
  //TODO: Implement CreateJobController
  ///Provider
  JobProvider provider = JobProvider();
  var data = [].obs;
  var totalJob = 1.obs;

  SignatureController signatureController = SignatureController();
  final createJobFormKey = GlobalKey<FormState>();
  TextEditingController totalJobTextEditingController = TextEditingController();
  TextEditingController customerNameTextEditingController = TextEditingController();
  TextEditingController numberOfDeliveryTextEditingController = TextEditingController();
  TextEditingController deliveryFromTextEditingController = TextEditingController();
  TextEditingController deliveryToTextEditingController = TextEditingController();
  TextEditingController jobNumberTextEditingController = TextEditingController();
  TextEditingController pickUpTimeTextEditingController = TextEditingController();
  TextEditingController remarksTextEditingController = TextEditingController();
  TextEditingController signatureImagePathTextEditingController = TextEditingController();
  var signaturePhotoPath = "".obs;

  ///Close job
  var jobNumberData = <dynamic>[].obs;
  var selectedJobData = {}.obs;
  final closeJobFormKey = GlobalKey<FormState>();
  var truckFrontImagePath = "".obs;
  var truckBackImagePath = "".obs;
  var truckRightImagePath = "".obs;
  var truckLeftImagePath = "".obs;
  final updateProfileFormKey = GlobalKey<FormState>();
  var userAvatarImagePath = ''.obs;
  var statusDropDown = ['Delivered', 'Pending', 'Returned'];
  var closeJobList = [];

  // TextEditingController jobNumberEditingController = TextEditingController();
  // TextEditingController customerEditingController = TextEditingController();
  // TextEditingController shrubTextEditingController = TextEditingController();
  // TextEditingController statusTextEditingController = TextEditingController();
  // // TextEditingController latitudeTextEditingController = TextEditingController();
  // // TextEditingController longitudeTextEditingController = TextEditingController();
  // TextEditingController odometerTextEditingController = TextEditingController();
  //
  // TextEditingController closeRemarksTextEditingController = TextEditingController();
  // TextEditingController frontImageImageTextEditingController = TextEditingController();
  // TextEditingController backImageTextEditingController = TextEditingController();
  // TextEditingController leftImageTextEditingController = TextEditingController();
  // TextEditingController rightImageTextEditingController = TextEditingController();

  @override
  void onInit() {
    getCustomerList();
    getJobNumber();
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

  // CONVERT UNIT8 to Image Path.
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

  getAddJobInformation({
    required String numberOfDelivery,
    required String deliveryFrom,
    required String deliveryTo,
    required String jobNumber,
    required String pickUpTime,
    required String remarks,
    required String signatureImagePath,
  }) {
    if (createJobFormKey.currentState!.validate()) {
      CustomLoader.showLoader();
      try {
        provider
            .requestAddJobInformation(
                numberOfDelivery: numberOfDelivery,
                deliveryFrom: deliveryFrom,
                deliveryTo: deliveryTo,
                jobNumber: jobNumber,
                pickUpTime: pickUpTime,
                remarks: remarks,
                signatureImagePath: signatureImagePath)
            .then((value) async {
          CustomLoader.cancelLoader();
          if (value.statusCode == 200) {
            var decodedData = jsonDecode(await value.stream.bytesToString());
            print(decodedData);
            if (decodedData['success'] == true) {
              AppServices().showToastMessage(toastMessage: 'Job updated successfully');
              Get.back();
            } else {
              AppServices().showToastMessage(toastMessage: 'error');
            }
          } else {
            AppServices().showToastMessage(toastMessage: 'Unable to create job');
          }
        });
      } catch (e) {
        CustomLoader.cancelLoader();
        AppServices().showToastMessage(toastMessage: 'Something went wrong');
      }
    }
  }

  Future newCloseJob({
    required String jobNumber,
    required String customerName,
    required String shrub,
    required String status,
    required String remarks,
    required String latitude,
    required String longitude,
    required String odometer,
    required File frontImage,
    required File backImage,
    required File leftImage,
    required File rightImage,
  }) async {
    List<Map<String, dynamic>> closeJobData = [
      {
        'job_number': jobNumber,
        'customer_name': customerName,
        'shrub': shrub,
        'status': status,
        'remarks': remarks,
        'latitude': latitude,
        'longitude': longitude,
        'odo_value': odometer,
        'front_image': frontImage,
        'back_image': backImage,
        'left_image': leftImage,
        'right_image': rightImage,
      }
    ];
    provider.newCloseJobApiCall(closeJobData);
  }

  Future closeJob() async {
    await provider
        .closeJob()
        .then((value) async {
      if (value.statusCode == 200) {
        var decodedData = jsonDecode(await value.stream.bytesToString());
        if (decodedData['success'] == true) {
          print('fffffffffffffffffffffff');
          await provider.closeTimer().then((value) async {
            var closeTimerDecodedData = jsonDecode(await value.stream.bytesToString());
            if (closeTimerDecodedData['success'] == true) {
              //TODO user will not able to create new job
              Get.find<HomeController>().timerX.cancel();
              AppServices().showToastMessage(toastMessage: closeTimerDecodedData['message']);
              // getStorage.erase();
              // Get.offAll(() => const DeclarationPageView(), binding: DeclarationPageBinding());
              Get.back();
            } else {
              AppServices().showToastMessage(toastMessage: closeTimerDecodedData['message']);
            }
          });
        } else {
          print(value.reasonPhrase);
          AppServices().showToastMessage(toastMessage: decodedData['message']);
        }
      } else {
        print(value.reasonPhrase);
      }
    });
  }

  getCustomerList() {
    provider.fetchCustomerList().then((customerListResponse) async {
      var decodedData = jsonDecode(await customerListResponse.stream.bytesToString());
      if (decodedData['success'] == true) {
        data.clear();
        data.value = ['Select customer name'];
        data.value = [...data, ...decodedData['data']];
        print('sssssssssssssssssss');
      }
    });
  }

  Future<String?> pickImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      print(image);
      return image.path;
    } else {
      AppServices().showToastMessage(toastMessage: 'Image not selected');
    }
  }

  void getJobNumber() {
    provider.fetchJobNumber().then((customerListResponse) async {
      var decodedData = jsonDecode(await customerListResponse.stream.bytesToString());
      print(decodedData);
      if (decodedData['success'] == true) {
        jobNumberData.value = decodedData['data'];
      }
    });
  }
}
