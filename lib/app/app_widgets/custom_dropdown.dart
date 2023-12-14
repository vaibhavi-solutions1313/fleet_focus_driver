
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../app_constants/app_colors.dart';

class CustomDropdownButton extends GetView {
  const CustomDropdownButton({required this.data, required this.controller, this.textInputType = TextInputType.text, required this.hinText, super.key});
  final List<dynamic> data;
  @override
  final TextEditingController controller;
  final TextInputType textInputType;
  final String hinText;

  // final IconData? suffixIcon;

  @override
  Widget build(BuildContext context) {
    var selectedItem = ''.obs;
    // TODO: implement build
    return Column(
      children: [
        const SizedBox(
          height: 16.0,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(color: AppColors.textFilledColor, borderRadius: BorderRadius.circular(12.0)),
          child: DropdownButtonHideUnderline(
              child: Obx(() => DropdownButton(
                value: selectedItem.value.isEmpty?data[0]:selectedItem.value,
                onChanged: (value) {
                  controller.text = value;
                  selectedItem.value=value;
                },
                icon: const Icon(Icons.keyboard_arrow_down_rounded),
                iconEnabledColor: AppColors.appPrimaryLightColor,
                isExpanded: true,
                hint: Text(
                  hinText,
                  style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                ),
                style: GoogleFonts.urbanist(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textFillHintTextColor),
                items: data.map((dynamic item) {
                  return DropdownMenuItem<dynamic>(
                    value: item,
                    child: Text(item.toString(),style: const TextStyle(fontSize: 16, color: Colors.black54),),
                  );
                }).toList(),
              ))),
        ),
      ],
    );
  }
}
