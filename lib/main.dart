import 'dart:async';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'app/modules/home/controllers/home_controller.dart';
import 'app/modules/profile/model/driver_info.dart';
import 'app/modules/profile/model/user_basic_information.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/app_constants/app_colors.dart';
import 'app/routes/app_pages.dart';
GetStorage getStorage=GetStorage();
UserBasicInformation userBasicInformation=UserBasicInformation();
DriverInfo driverInfo=DriverInfo();
var loginToken='';
Position? userPosition;
var latitude = 78.0.obs;
var longitude = 84.0.obs;



final service = FlutterBackgroundService();

Timer? myTime;
int totalSeconds = 0;
int totalMinutes = 0;
int totalHours = 0;
@pragma('vm:entry-point')
onStart(ServiceInstance serviceInstance) async {
  myTime = Timer.periodic(const Duration(seconds: 1), (timer) {
    totalSeconds++;
    if (totalSeconds == 60) {
      totalSeconds = 0;
      totalMinutes++;

      if (totalMinutes == 60) {
        totalMinutes = 0;
        totalHours++;
      }
    }
  });
}

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await getStorage.initStorage;

  DartPluginRegistrant.ensureInitialized();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(),
  );

  runApp(
    GlobalLoaderOverlay(
      useDefaultLoading: false,
      overlayWidget: const Center(
        child: SpinKitCircle(
          color: Colors.blue,
          size: 50.0,
        ),
      ),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Fleet Focus Pro Driver",
        initialRoute: AppPages.INITIAL,

        defaultTransition: Transition.circularReveal,
        transitionDuration: const Duration(microseconds: 200),
        getPages: AppPages.routes,
        theme: ThemeData(
          useMaterial3: true,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
          primaryTextTheme: GoogleFonts.montserratTextTheme(),
          canvasColor: AppColors.canvasColor,
        ),
      ),
    ),
  );
}


////////////////////////////////////////////////////////
final spinkit = SpinKitCircle(
  color: Colors.blue,
  size: 50.0,
  // controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
);
////////////////////////////////////////////////////////


// this will be used as notification channel id
// const notificationChannelId = 'my_foreground';
//
// // this will be used for notification id, So you can update your custom notification with this id.
// const notificationId = 888;
//
// Future<void> initializeService() async {
//   final service = FlutterBackgroundService();
//   await service.configure(
//       androidConfiguration: AndroidConfiguration(
//       // this will be executed when app is in foreground or background in separated isolate
//       onStart: onStart,
//
//       // auto start service
//       autoStart: true,
//       isForegroundMode: true,
//
//       notificationChannelId: notificationChannelId, // this must match with notification channel you created above.
//       initialNotificationTitle: 'AWESOME SERVICE',
//       initialNotificationContent: 'Initializing',
//       foregroundServiceNotificationId: notificationId,
//   ), iosConfiguration:IosConfiguration(
//   // auto start service
//   autoStart: true,
//
//   // this will be executed when app is in foreground in separated isolate
//   onForeground: onStart,
//
//   // you have to enable background fetch capability on xcode project
//   onBackground: onIosBackground,
//   ),
//   );
//
//   await service.startService();
//   }
//
// @pragma('vm:entry-point')
//
// Future<void> onStart(ServiceInstance service) async {
//   // Only available for flutter 3.0.0 and later
//   DartPluginRegistrant.ensureInitialized();
//
//
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 1), (timer) async {
//     if (service is AndroidServiceInstance) {
//       if (await service.isForegroundService()) {
//         flutterLocalNotificationsPlugin.show(
//           notificationId,
//           'COOL SERVICE',
//           'Awesome ${DateTime.now()}',
//           const NotificationDetails(
//             android: AndroidNotificationDetails(
//               notificationChannelId,
//               'MY FOREGROUND SERVICE',
//               icon: 'ic_bg_service_small',
//               ongoing: true,
//             ),
//           ),
//         );
//       }
//     }
//   });
// }