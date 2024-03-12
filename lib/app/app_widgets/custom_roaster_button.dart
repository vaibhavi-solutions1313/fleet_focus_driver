import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class CustomRoasterButton extends GetView {
  const CustomRoasterButton(
      {required this.text,
        required this.onTap,
        this.isCircularButton = false,
        super.key});

  final VoidCallback onTap;
  final String text;
  final bool isCircularButton;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      elevation: 1.0,
      borderRadius: BorderRadius.circular(6.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6.0),
        child: Ink(
          height: 32,
          width: 150,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.btnLight1, AppColors.btnLight2],
            ),
            shape: isCircularButton ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircularButton ? null : BorderRadius.circular(12.0),
            // boxShadow: const [
            //   BoxShadow(
            //     offset: Offset(0.5, 0.5),
            //     spreadRadius: -0.5,
            //     blurRadius: 1.0,
            //     color: AppColors.lightBlackishTextColor
            //   )
            // ]
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: 'Open Sans',
                  letterSpacing: 0.37,
                  // color: Colors.white,
                  color: Colors.white,
                  fontWeight: FontWeight.normal),
            ),
          ),

        ),
      ),
    );
  }
}
