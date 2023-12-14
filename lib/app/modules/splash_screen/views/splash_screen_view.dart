import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:staffin_softwares/app/app_constants/app_colors.dart';
import 'package:staffin_softwares/app/app_constants/app_strings.dart';

import '../../../app_constants/app_Images.dart';
import '../../../app_widgets/app_text_styles.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SplashScreenController controller=Get.put(SplashScreenController());
    return Scaffold(
     // floatingActionButton: Container(
     //   padding: EdgeInsets.all(6.0),
     //     decoration: BoxDecoration(
     //       shape: BoxShape.circle,
     //       border: Border.all(
     //         color: Colors.white
     //       )
     //     ),
     //     child: FloatingActionButton(
     //         onPressed: (){
     //           controller.tryAutoLogin();
     //         },
     //         child: const Icon(Icons.navigate_next_outlined),
     //       shape: const CircleBorder(),
     //       elevation: 2,
     //       splashColor: Colors.yellow.shade300,
     //       highlightElevation: 5,
     //     )),
      body: Column(
        children: [
          Expanded(
            child: ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                height: Get.height * 0.9,
                width: Get.width,
                decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.vertical(bottom: Radius.circular(80.0)),
                    gradient: LinearGradient(
                        colors: [AppColors.appPrimaryColor, AppColors.appPrimaryLightColor, AppColors.appPrimaryLightColor], end: Alignment.topCenter,begin: Alignment.bottomCenter)),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/splashAndLogo/location-sharp.png',width: Get.width*0.3,fit: BoxFit.contain,),
                      Image.asset('assets/splashAndLogo/Group 1000005741.png',width: Get.width*0.5,height:120,fit: BoxFit.fitWidth,scale: 1.0,),
                    ],
                  ),
                ),
              ),
            ),
          ),
          TextButton(
              onPressed: () {
                controller.tryAutoLogin();
              },
              child: const Text('Get Started',style: TextStyle(fontSize: 15,fontWeight: FontWeight.w700),),style: TextButton.styleFrom(),),
          SizedBox(height: 6.0,)
          // Container(
          //   width: Get.width,
          //   decoration: const BoxDecoration(
          //       gradient: LinearGradient(colors: [AppColors.appPrimaryLightColor,AppColors.appPrimaryColor],begin: Alignment.topLeft,end: Alignment.bottomRight),
          //     // image: DecorationImage(image: AssetImage(AppImages.mapImage),alignment: Alignment.topCenter,),
          //   ),
          //   child:  Column(
          //     // mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     crossAxisAlignment: CrossAxisAlignment.start,
          //     children: [
          //       Stack(
          //         children: [
          //           Image.asset(AppImages.mapImage,fit: BoxFit.fill,width: Get.width,height: Get.height*0.7,),
          //           SafeArea(child: Padding(
          //             padding: const EdgeInsets.all(18.0),
          //             child: Row(
          //
          //               children: [
          //                 Image.asset(AppImages.appLogoImage,width: 180,),
          //                 Spacer(),
          //                 Chip(label: Text(AppString.splashScreenStringSkipText),elevation: 2,
          //                   backgroundColor: AppColors.whiteColor,shadowColor: AppColors.lightBlackishTextColor,
          //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26.0)),side: BorderSide.none,)
          //               ],
          //             ),
          //           )),
          //         ],
          //       ),
          //
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //         child: Column(
          //           crossAxisAlignment: CrossAxisAlignment.start,
          //           children: [
          //             Text20By700(text: AppString.splashScreenStringTitle,textColor: AppColors.whiteColor),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 8.0),
          //               child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(Icons.check_circle_rounded,color: AppColors.greenishColor,size: 15),
          //                   SizedBox(width: 2.0,),
          //                   Text14By400(text: AppString.splashScreenStringSubTitle,textColor: AppColors.creamColor),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 8.0),
          //               child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(Icons.check_circle_rounded,color: AppColors.greenishColor,size: 15),
          //                   SizedBox(width: 2.0,),
          //                   Text14By400(text: AppString.splashScreenStringSubTitle2,textColor: AppColors.creamColor),
          //                 ],
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.only(top: 8.0),
          //               child: Row(
          //                 crossAxisAlignment: CrossAxisAlignment.start,
          //                 children: [
          //                   Icon(Icons.check_circle_rounded,color: AppColors.greenishColor,size: 16),
          //                   SizedBox(width: 2.0,),
          //                   Text14By400(text: AppString.splashScreenStringSubTitle3,textColor: AppColors.creamColor),
          //                 ],
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    Path path=Path();

    // path.moveTo(0,  0);
    path.lineTo(0, size.height*0.9);
    path.quadraticBezierTo(size.width/2, size.height, size.width, size.height*0.9);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}
