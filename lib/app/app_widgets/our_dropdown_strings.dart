import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_constants/app_colors.dart';

class OurListStringDropDown extends StatefulWidget {
  final String hintText;
  final List<dynamic> dropdownItems;
  final dynamic selectedDropdownItem;
  final ValueChanged<dynamic> onDropdownChanged;
  const OurListStringDropDown({super.key, required this.dropdownItems, this.selectedDropdownItem, required this.onDropdownChanged, this.hintText = "Select"});
  @override
  State<OurListStringDropDown> createState() => _OurListStringDropDownState();
}

class _OurListStringDropDownState extends State<OurListStringDropDown> {
  dynamic _selectedItem;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.selectedDropdownItem;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: AppColors.textFilledColor,
        borderRadius: BorderRadius.circular(12.0),
      ),

      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButton<dynamic>(

              hint: Text(
                widget.hintText,
                style: GoogleFonts.urbanist(fontSize: 16, color: Colors.black.withOpacity(0.65),fontWeight: FontWeight.w500),
              ),
              value: _selectedItem,
              onChanged: (dynamic newValue) {
                setState(() {
                  _selectedItem = newValue;
                });
                widget.onDropdownChanged(newValue); // Notify parent about the change
              },
              underline: const SizedBox(),
              isExpanded: true,
              dropdownColor: Colors.grey.shade200,
              style: GoogleFonts.urbanist(fontSize: 16, color: Colors.black54,fontWeight: FontWeight.w600),
              items: widget.dropdownItems.map((dynamic item) {
                return DropdownMenuItem<dynamic>(
                  value: item,
                  child: Text(item.toString(),style: TextStyle(fontSize: 16, color: Colors.black54),),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}



