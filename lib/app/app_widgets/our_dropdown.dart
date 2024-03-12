import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class OurListObjectDropDown extends StatefulWidget {
  final String hintText;
  final String keyName;
  final List<dynamic> dropdownItems;
  final dynamic selectedDropdownItem;
  final ValueChanged<dynamic> onDropdownChanged;

  const OurListObjectDropDown({
    Key? key,
    required this.dropdownItems,
    required this.onDropdownChanged,
    this.selectedDropdownItem,
    this.hintText = "Select",
    required this.keyName,
  }) : super(key: key);

  @override
  State<OurListObjectDropDown> createState() => _OurListObjectDropDownState();
}

class _OurListObjectDropDownState extends State<OurListObjectDropDown> {
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: AppColors.textAndOutlineBottom,
              width: 1.0
          )
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<dynamic>(
              hint: ShaderMask(
                blendMode: BlendMode.srcIn,
                shaderCallback: (bounds) => LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.textAndOutlineTop.withOpacity(0.6), AppColors.textAndOutlineBottom.withOpacity(0.6)],
                ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                child: Text(
                  widget.hintText,
                  style: GoogleFonts.urbanist(fontSize: 16, color: Colors.black.withOpacity(0.65), fontWeight: FontWeight.w400),
                ),
              ),
              value: _selectedItem,
              onChanged: (dynamic newValue) {
                setState(() {
                  _selectedItem = newValue;
                }); // Notify parent about the change
              },
              underline: const SizedBox(),
              isExpanded: true,
              icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.textAndOutlineColor,),
              iconEnabledColor: AppColors.appPrimaryLightColor,
              dropdownColor: Colors.white,
              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w600),
              items: widget.dropdownItems.map((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item[widget.keyName],
                  onTap: () {
                    widget.onDropdownChanged(item);
                  },
                  child: ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [AppColors.textAndOutlineTop, AppColors.textAndOutlineBottom],
                    ).createShader(Rect.fromLTWH(0, 0, bounds.width, bounds.height)),
                    child: Text(
                      item[widget.keyName].toString(),
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
