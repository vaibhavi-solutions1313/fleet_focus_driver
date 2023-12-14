
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class CustomSolidButton extends GetView{
  const CustomSolidButton( {required this.text,  required this.onTap,this.isCircularButton=false,this.height=48, super.key});
  final VoidCallback onTap;
  final String text;
  final double height;
  final bool isCircularButton;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 1.0,

      borderRadius: BorderRadius.circular(12.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.0),
        child: Ink(
          height: height,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [AppColors.appPrimaryLightColor,AppColors.appPrimaryColor]),
            shape: isCircularButton?BoxShape.circle:BoxShape.rectangle,
            borderRadius: isCircularButton?null:BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0.5, 0.5),
                spreadRadius: -0.5,
                blurRadius: 1.0,
                color: AppColors.lightBlackishTextColor
              )
            ]
          ),
          child: Center(child: isCircularButton?const Icon(Icons.timer,color: Colors.white,):Text(text,style: GoogleFonts.openSans(fontSize: 16,fontWeight: FontWeight.w400,color: AppColors.whiteColor),)),
        ),
      ),
    );
  }}