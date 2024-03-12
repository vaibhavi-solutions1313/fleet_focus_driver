
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:staffin_softwares/app/app_services/services.dart';

import '../app_constants/app_colors.dart';

class CustomImageContainer extends GetView{
  const CustomImageContainer({required this.controller,this.textInputType=TextInputType.text, this.isSuffixIcon=false, required this.hinText,this.isValidatorRequired=true,  super.key});
  @override
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hinText;
  final bool isSuffixIcon;
  final bool isValidatorRequired;

  // final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    RxBool showPrefix=false.obs;
    // TODO: implement build
    return Column(
      children: [
        SizedBox(height: 12.0,),
        Container(
          height: 120,
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: AppColors.btnMedium1.withOpacity(0.5),
                blurRadius: 3,
                spreadRadius: 0.5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            onTap: ()async{
              controller.text=(await AppServices().selectImageFromGallery())?.path??'';
              if(controller.text.isNotEmpty){
                showPrefix.value=true;
              }else{
                showPrefix.value=false;
              }
            },
            controller: controller,
            keyboardType: textInputType,
            readOnly: true,
            validator: (v){
              if(isValidatorRequired){
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
              if(controller.text.isNotEmpty){
                showPrefix.value=true;
              }else{
                showPrefix.value=false;
              }
            },

            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              filled: true,
              fillColor: AppColors.whiteColor,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none
              ),
              hintText: hinText,
              // prefix: showPrefix.value?Text('$hinText:',style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),):Text(''),
              hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor),
              prefixIcon: Icon(Icons.cloud_upload_outlined),
              prefixIconColor: AppColors.textAndOutlineColor,
            ),
          ),
        )
       // Obx(() => Container(
       //   margin: EdgeInsets.symmetric(horizontal: 8),
       //   decoration: BoxDecoration(
       //     color: Colors.white,
       //     borderRadius: BorderRadius.circular(12),
       //     boxShadow: [
       //       BoxShadow(
       //         color: AppColors.btnMedium1.withOpacity(0.5),
       //         blurRadius: 3,
       //         spreadRadius: 0.5,
       //         offset: Offset(0, 2),
       //       ),
       //     ],
       //   ),
       //   child: TextFormField(
       //     onTap: ()async{
       //       controller.text=(await AppServices().selectImageFromGallery())?.path??'';
       //       if(controller.text.isNotEmpty){
       //         showPrefix.value=true;
       //       }else{
       //         showPrefix.value=false;
       //       }
       //     },
       //     controller: controller,
       //     keyboardType: textInputType,
       //     readOnly: true,
       //     validator: (v){
       //       if(isValidatorRequired){
       //         if(v!.isEmpty) {
       //           return 'Fill the field';
       //         }else{
       //           return null;
       //         }
       //       }else{
       //         return null;
       //       }
       //
       //     },
       //     onChanged: (v){
       //       if(controller.text.isNotEmpty){
       //         showPrefix.value=true;
       //       }else{
       //         showPrefix.value=false;
       //       }
       //     },
       //
       //     decoration: InputDecoration(
       //       contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
       //       filled: true,
       //       fillColor: AppColors.whiteColor,
       //       border: OutlineInputBorder(
       //           borderRadius: BorderRadius.circular(12.0),
       //           borderSide: BorderSide.none
       //       ),
       //       hintText: hinText,
       //       // prefix: showPrefix.value?Text('$hinText:',style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textFillHintTextColor),):Text(''),
       //       hintStyle: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w600,color: AppColors.textAndOutlineColor),
       //       prefixIcon: Icon(Icons.cloud_upload_outlined),
       //       prefixIconColor: AppColors.textAndOutlineColor,
       //     ),
       //   ),
       // )),
      ],
    );
  }

}

