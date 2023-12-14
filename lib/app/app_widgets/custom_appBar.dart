
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';

class CustomAppBar extends GetView{
  const CustomAppBar( {required this.title,super.key});

final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children:[
          InkWell(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_ios_outlined)),
          SizedBox(width: 8.0,),
          Text20By700(text: title)
        ]
      ),
    );
  }}