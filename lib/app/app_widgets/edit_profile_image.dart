import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:staffin_softwares/app/app_services/services.dart';

import '../app_constants/app_colors.dart';

class UserAvatar extends StatefulWidget {
  const UserAvatar({
    this.getSelectedImagePath,
    this.userAvatar,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  final String? userAvatar;
  final String? getSelectedImagePath;
  final Function(String) onTap;

  @override
  _UserAvatarState createState() => _UserAvatarState();
}

class _UserAvatarState extends State<UserAvatar> {
  XFile? selectedImage;
  String selectedImagePath = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.appPrimaryLightColor,
              radius: 35,
              child: CircleAvatar(
                radius: 33,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(40),
                  child: selectedImage == null && widget.userAvatar!=null
                      ? SvgPicture.network(widget.userAvatar!, fit: BoxFit.cover,)
                      : Image.file(
                    File(selectedImage!.path),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0.0,
              right: -5.0,
              child: InkWell(
                onTap: () async {
                  selectedImage = await AppServices().selectImageFromGallery();
                  if (selectedImage != null && selectedImage!.path.isNotEmpty) {
                    selectedImagePath = selectedImage!.path;
                    widget.onTap(selectedImage!.path);
                  }
                  setState(() {});
                },
                child: const Card(
                  child: Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Icon(Icons.edit, size: 16),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: 15,
        ),
        Text(
          'Profile picture',
          style: GoogleFonts.lato(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.lightBlackishTextColor69,
          ),
        ),
      ],
    );
  }
}


