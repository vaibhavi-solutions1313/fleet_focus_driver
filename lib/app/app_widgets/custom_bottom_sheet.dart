import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet extends GetView{
  final bool isDismissible ;
  final Widget child;
   CustomBottomSheet({
    required this.child,
     this.isDismissible = true,
});

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
      child: child,
    );
  }

  static void show(Widget child){
    Get.bottomSheet(
      CustomBottomSheet(child: child),
      backgroundColor: Colors.white70,
      isDismissible: false,
      enableDrag: true,

      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
      ),
    );
  }

}