
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
as picker;
import 'package:intl/intl.dart';
import '../app_constants/app_colors.dart';

class AppTextField extends GetView{
  const AppTextField({this.onChanged, required this.controller,this.textInputType=TextInputType.text, this.isSuffixIcon=false, required this.hinText,this.suffixIcon,this.isSecureText=false, this.isValidatorRequired=true,  super.key});
  @override
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hinText;
  final bool isSuffixIcon;
   final bool isSecureText;
   final bool isValidatorRequired;
  final IconData? suffixIcon;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    RxBool showPassword=isSecureText.obs;
    RxBool showPrefix=false.obs;
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 16.0,),
        Obx(() => Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.textAndOutlineBottom,
              width: 1.0
            )
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: textInputType,
            obscureText: showPassword.value,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            style: GoogleFonts.urbanist(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textAndOutlineColor,
            ),
            validator: (v){
              if(isValidatorRequired==true){
                if(v!.isEmpty) {
                  return 'Fill the field';
                }else{
                  return null;
                }
              }else{
                return null;
              }

            },
            onChanged: (v){
              if(onChanged != null) {
                onChanged!(v);
              }

              if(controller.text.isNotEmpty){
                showPrefix.value=true;
              }else{
                showPrefix.value=false;
              }
            },
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16.0),
              filled: true,
              fillColor:Colors.white,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none
              ),
              hintText: hinText,
              // prefix: showPrefix.value?Text('$hinText:',style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor),):Text(''),
              hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor.withOpacity(0.4)),
              suffixIcon: isSuffixIcon?InkWell(
                  onTap: (){
                    showPassword.value=!showPassword.value;
                  },
                  child: Icon(suffixIcon)):null,
              suffixIconColor: showPassword.value?AppColors.textAndOutlineColor:AppColors.splashLight,
            ),
          ),
        )),
      ],
    );
  }

}
/////////////////////////////////////////////////////////////////////////////////////////
class AppCalendarTextField extends GetView{
  const AppCalendarTextField({required this.controller,this.textInputType=TextInputType.datetime, this.isSuffixIcon=false, required this.hinText,this.differenceInYearTextController, super.key});
  @override
  final TextEditingController controller;
  final TextEditingController? differenceInYearTextController;
  final TextInputType textInputType;
  final String hinText;
  final bool isSuffixIcon;

  // final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    RxBool showPrefix=false.obs;
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 16.0,),

        Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: AppColors.textAndOutlineColor,
                width: 1.0
            )
        ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              onTap: ()async{

                picker.DatePicker.showDatePicker(context,
                    showTitleActions: true,
                    minTime: DateTime(1932, 3, 5),
                    // maxTime: DateTime.now(),
                    onChanged: (date) {
                      if (kDebugMode) {
                        print('change $date');
                      }
                    },
                    onConfirm: (date) {
                      final DateFormat formatter = DateFormat('dd-MM-yyyy');
                      final String formatted = formatter.format(date);
                      controller.text=formatted.toString();

                      differenceInYearTextController?.text= (DateTime.now().year-date.year).toString();

                    }, currentTime: DateTime.now(), locale: LocaleType.en);
              },
              controller: controller,
              keyboardType: textInputType,
              readOnly: true,
              validator: (v){
                if(v!.isEmpty) {
                  return 'Fill the field';
                }else{
                  return null;
                }
              },
              onChanged: (v){
                if(controller.text.isNotEmpty){
                  showPrefix.value=true;
                }else{
                  showPrefix.value=false;
                }
              },
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                filled: true,
                // fillColor: AppColors.textFilledColor,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none
                ),
                hintText: hinText,
                prefix: showPrefix.value?Text('$hinText:',style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineBottom),):Text(''),
                hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineBottom.withOpacity(0.6)),
                suffixIcon: const Icon(Icons.calendar_month_rounded),
                suffixIconColor: AppColors.textAndOutlineColor,

              ),
              style: GoogleFonts.urbanist(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textAndOutlineColor,
              )
            ),
          ),
        ),
      ],
    );
  }

}

/////////////////////////////////

