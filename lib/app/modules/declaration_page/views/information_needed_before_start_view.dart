import 'dart:ffi';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import 'package:staffin_softwares/app/app_widgets/custom_dropdown.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/daily_login_page_controller.dart';
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
                // const CustomAppBar(title: 'Information'),
                Text('Job Details', style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                    fontSize: 20,
                    letterSpacing: 0.2
                ),),
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
                AppTextField(controller: controller.startTimeTextEditingController, hinText: AppString.informationNeededPageTextStartTime),
                const SizedBox(
                  height: 20,
                ),
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
                        // numberOfJobs: controller.numberOfJobsTextEditingController.value.text,
                      );
                      dailyLoginPageController.updateDailyLoginGrid(2);
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: 'Customer Details saved successfully');
                    })
              ],
            ),
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
        /*Container(
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
        ),*/
      ],
    );
  }
}