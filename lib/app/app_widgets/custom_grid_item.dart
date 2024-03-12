
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GridItem extends GetView {
  final String image;
  final String title;
  final RxString subtitle;
  final RxString icon;
  final VoidCallback onTap;

  const GridItem({
    required this.image,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2.0,
        child: Container(
          color: Colors.white,
          height: 150,
          width: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                image,
                height: 45.0,
                width: 45.0,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 5,),
              Obx(() => Text(
                  subtitle.value,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Obx(() => Image.asset(
                  icon.value,
                  width: 24,
                  height: 24,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}