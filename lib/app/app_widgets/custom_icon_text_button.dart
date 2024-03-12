import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class CustomIconTextButton extends GetView {
  const CustomIconTextButton(
      {required this.text,
        required this.onTap,
        required this.icon,
        this.isCircularButton = false,
        this.height = 48,
        super.key});

  final VoidCallback onTap;
  final String text;
  final Widget icon;
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
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [AppColors.btnLight1, AppColors.btnLight2],
            ),
            shape: isCircularButton ? BoxShape.circle : BoxShape.rectangle,
            borderRadius: isCircularButton ? null : BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              icon,
              SizedBox(width: 3,),
              Text(
                text,
                style: TextStyle(
                    fontSize: 16,
                    letterSpacing: 0.5,
                    // color: Colors.white,
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
