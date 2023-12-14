import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:loader_overlay/loader_overlay.dart';
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

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Firebase.initializeApp();
  // final messaging= FirebaseMessaging.instance;
  await getStorage.initStorage;
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