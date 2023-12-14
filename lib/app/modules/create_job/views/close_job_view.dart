import 'package:flutter/material.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/app_widgets/our_dropdown.dart';
import 'package:staffin_softwares/app/modules/create_job/controllers/create_job_controller.dart';
import 'package:staffin_softwares/main.dart';

import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/app_text_fields.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_dropdown.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../../app_widgets/our_dropdown_strings.dart';

class CloseJobView extends GetView<CreateJobController> {
  const CloseJobView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CreateJobController(), permanent: true);
    // controller.closeJobList.clear();
    return Scaffold(
        body: SafeArea(
      child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          SafeArea(
            child: Form(
              key: controller.closeJobFormKey,
              child: Column(
                children: [
                  const CustomAppBar(
                    title: 'Close Job',
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  TextFormField(
                    controller: controller.totalJobTextEditingController,
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Fill the field';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        print('gggggggggggggggggggggggg');
                        controller.totalJob.value = int.parse(v);
                        controller.totalJob.value < 1
                            ? controller.totalJob.value = 1
                            : controller.totalJob.value > 10
                                ? controller.totalJob.value = 10
                                : controller.totalJob.value = controller.totalJob.value;
                        controller.totalJobTextEditingController.text = controller.totalJob.value.toString();
                      } else {
                        controller.totalJob.value = 1;
                        controller.totalJobTextEditingController.clear();
                      }
                      controller.closeJobList.clear();
                    },
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                        filled: true,
                        fillColor: AppColors.textFilledColor,
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
                        hintText: AppString.informationNeededPageTextNumberOfJobs,
                        // prefix: Text( AppString.informationNeededPageTextNumberOfJobs ,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),),
                        hintStyle: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                        suffixText: 'Max 10'),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Obx(() => ListView.builder(
                        itemCount: controller.totalJob.value,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          controller.closeJobList.add({
                            'job_number': "",
                            'customer_name': "",
                            'shrub': "",
                            'status': "",
                            'remarks': "",
                            'latitude': "${latitude.value}",
                            'longitude': "${longitude.value}",
                            'odo_value': "",
                            'front_image': "",
                            'back_image': "",
                            'left_image': "",
                            'right_image': ""
                          });
                          return CloseJobFormWidget(
                            index: index,
                          );
                        },
                      )),
                  CustomSolidButton(
                      text: AppString.additionalProfileInfoButtonSave,
                      onTap: () {
                        bool isAllOkay = true;

                        controller.closeJobList.forEach((element) {
                          if (element['job_number'].isEmpty ||
                              element['customer_name'].isEmpty ||
                              element['shrub'].isEmpty ||
                              element['status'].isEmpty ||
                              element['remarks'].isEmpty ||
                              element['odo_value'].isEmpty ||
                              element['front_image'].isEmpty ||
                              element['back_image'].isEmpty ||
                              element['left_image'].isEmpty ||
                              element['right_image'].isEmpty) {
                            isAllOkay = false;
                          }
                        });

                        if (isAllOkay == true) {
                          CustomLoader.showLoader();
                          controller.closeJob().whenComplete(() {
                            CustomLoader.cancelLoader();
                          });
                        } else {
                          AppServices().showToastMessage(toastMessage: 'Please provide all information.');
                        }
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    ));
  }
}

class CloseJobFormWidget extends StatefulWidget {
  final int index;
  const CloseJobFormWidget({super.key, required this.index});

  @override
  State<CloseJobFormWidget> createState() => _CloseJobFormWidgetState();
}

class _CloseJobFormWidgetState extends State<CloseJobFormWidget> {
  CreateJobController controller = Get.find<CreateJobController>();
  final closeJobFormKey = GlobalKey<FormState>();
  var selectedJobData = {}.obs;
  var truckFrontImagePath = "";
  var truckBackImagePath = "";
  var truckRightImagePath = "";
  var truckLeftImagePath = "";
  final updateProfileFormKey = GlobalKey<FormState>();
  var userAvatarImagePath = ''.obs;
  var statusDropDown = ['Delivered', 'Pending', 'Returned'];
  var selectedStatus;

  TextEditingController jobNumberEditingController = TextEditingController();
  TextEditingController customerEditingController = TextEditingController();
  TextEditingController shrubTextEditingController = TextEditingController();
  TextEditingController statusTextEditingController = TextEditingController();
  // TextEditingController latitudeTextEditingController = TextEditingController();
  // TextEditingController longitudeTextEditingController = TextEditingController();
  TextEditingController odometerTextEditingController = TextEditingController();

  TextEditingController closeRemarksTextEditingController = TextEditingController();
  TextEditingController frontImageImageTextEditingController = TextEditingController();
  TextEditingController backImageTextEditingController = TextEditingController();
  TextEditingController leftImageTextEditingController = TextEditingController();
  TextEditingController rightImageTextEditingController = TextEditingController();

  // {
  // 'job_number': "",
  // 'customer_name': "",
  // 'shrub': "",
  // 'status': "",
  // 'remarks': "",
  // 'latitude': "",
  // 'longitude': "",
  // 'odo_value': "",
  // 'front_image': "",
  // 'back_image': "",
  // 'left_image': "",
  // 'right_image': ""
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => OurListObjectDropDown(
              dropdownItems: controller.jobNumberData.value,
              keyName: 'id',
              hintText: "Select Job ID",
              onDropdownChanged: (value) {
                print(value);
                selectedJobData.addAll(value);
                jobNumberEditingController.text = value['id'].toString();
                customerEditingController.text = value['company'].toString();
                odometerTextEditingController.text = value['odometer_value'].toString();
                setState(() {
                  controller.closeJobList[widget.index]['job_number'] = value['id'].toString();
                  controller.closeJobList[widget.index]['odo_value'] = value['odometer_value'].toString();
                  controller.closeJobList[widget.index]['customer_name'] = value['company'].toString();
                });
              },
            )),
        AppTextField(
          controller: customerEditingController,
          hinText: AppString.informationNeededPageClientText,
          onChanged: (p0) {
            controller.closeJobList[widget.index]['customer_name'] = p0;
          },
        ),
        AppTextField(
          controller: shrubTextEditingController,
          hinText: AppString.closeJobPageShrub,
          onChanged: (p0) {
            controller.closeJobList[widget.index]['shrub'] = p0;
          },
        ),
        SizedBox(height: 16.0,),
        OurListStringDropDown(
            onDropdownChanged: (value) {
              controller.closeJobList[widget.index]['status'] = value;
            },
            dropdownItems: statusDropDown,
            hintText: 'Status',
            selectedDropdownItem: selectedStatus),
        // CustomDropdownButton(
        //   data: statusDropDown,
        //   controller: statusTextEditingController,
        //   hinText: 'Status',
        // ),
        AppTextField(
          controller: closeRemarksTextEditingController,
          hinText: AppString.closeJobPageRemarks,
          onChanged: (p0) {
            controller.closeJobList[widget.index]['remarks'] = p0;
          },
        ),
        AppTextField(
          controller: odometerTextEditingController,
          hinText: AppString.closeJobPageOdometer,
          onChanged: (p0) {
            controller.closeJobList[widget.index]['odo_value'] = p0;
          },
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
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.pickImage().then((value) {
                          if (value != null) {
                            truckFrontImagePath = value;
                            controller.closeJobList[widget.index]['front_image'] = value;
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        width: Get.width * 0.22,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                        ),
                        child: truckFrontImagePath == ""
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
                            : Image.file(File(truckFrontImagePath)),
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
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.pickImage().then((value) {
                          if (value != null) {
                            truckBackImagePath = value;
                            controller.closeJobList[widget.index]['back_image'] = value;
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        width: Get.width * 0.22,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                        ),
                        child: truckBackImagePath == ""
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
                            : Image.file(File(truckBackImagePath)),
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
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.pickImage().then((value) {
                          if (value != null) {
                            truckRightImagePath = value;
                            controller.closeJobList[widget.index]['right_image'] = value;
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        width: Get.width * 0.22,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                        ),
                        child: truckRightImagePath == ""
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
                            : Image.file(File(truckRightImagePath)),
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
                SizedBox(
                  width: 10,
                ),
                Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        controller.pickImage().then((value) {
                          if (value != null) {
                            truckLeftImagePath = value;
                            controller.closeJobList[widget.index]['left_image'] = value;
                            setState(() {});
                          }
                        });
                      },
                      child: Container(
                        width: Get.width * 0.22,
                        padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          borderRadius: BorderRadius.circular(16.0),
                          boxShadow: [BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 2.0)],
                        ),
                        child: truckLeftImagePath == ""
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
                            : Image.file(File(truckLeftImagePath)),
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
            ),
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}
