


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class Text20By700 extends GetView{
  final String text;
  final Color textColor;
  const Text20By700(  {super.key,required this.text,this.textColor=AppColors.darkBlackishTextColor,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style: GoogleFonts.montserrat(fontSize: 20,fontWeight: FontWeight.w700,color: textColor),);
  }
  }
  ///////////////////////////////////////////////////////////////////////////////
class Text14By400 extends GetView{
  final String text;
  final Color textColor;
  const Text14By400(  {super.key,required this.text,this.textColor=AppColors.lightBlackishTextColor69,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style: GoogleFonts.roboto(fontSize: 14,fontWeight: FontWeight.w400,color: textColor),);
  }
}
///////////////////////////////////////////////////////////////////////////////////////
class Text14By700 extends GetView{
  final String text;
  final Color textColor;
  const Text14By700(  {super.key,required this.text,this.textColor=AppColors.darkBlackishTextColor,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style: GoogleFonts.montserrat(fontSize: 14,fontWeight: FontWeight.w700,color: textColor),);
  }
}
////////////////////////////////////////////////////////////////////////////////////////////////
class Text15By500 extends GetView{
  final String text;
  final Color textColor;
  const Text15By500(  {super.key,required this.text,this.textColor=AppColors.darkBlackishTextColor,});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(text,style: GoogleFonts.urbanist(fontSize: 15,fontWeight: FontWeight.w500,color: textColor),);
  }
}