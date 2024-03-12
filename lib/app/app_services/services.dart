import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

import '../../main.dart';
import '../app_constants/app_colors.dart';

class AppServices {
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;
  late StreamSubscription<Position> streamSubscription;

  Future<XFile?> selectImageFromGallery() async {
    return await ImagePicker().pickImage(source: ImageSource.gallery);
  }

  ////////////////////////////////////////////////////////
  Future showLoader() async {}
  ////////////////////////////////////////////////////////////

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if the user has already denied location permission forever
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      await showPermissionDeniedForeverDialog();
      return;
    }

    // Check if the user has denied or granted location permission
    if (permission == LocationPermission.denied) {
      // Show a confirmation dialog before requesting permission
      bool allowLocation = await showPermissionConfirmationDialog();

      if (!allowLocation) {
        // User denied permission in the confirmation dialog
        return;
      }

      // Request location permission
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // User denied permission
        return;
      }
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await showLocationServiceDisabledDialog();
      return;
    }

    // Continue with getting the user's location
    userPosition = await Geolocator.getCurrentPosition();
  }

  Future<bool> showPermissionConfirmationDialog() async {
    return await Get.defaultDialog(
      barrierDismissible: false,
      title: 'Location Permission',
      titlePadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black
      ),
      radius: 5.0,
      contentPadding: EdgeInsets.all(15.0),
      content: Column(
        children: [
          Text('We need your location permission to create fast, accurate routes, deliver efficient services and provide correct latitude and longitude coordinates. Granting access enhances navigation, ensures precision and improves mapping, enabling seamless and effective functionality in this applictaion and it\'s services.',
            style: TextStyle(
              fontSize: 14,
            ),),
          SizedBox(height: 8,),
          Text('Location is used in the background even when the app is closed to the working of Location Sharing feature of the application',
            style: TextStyle(
              fontSize: 14,
            ),),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                onPressed: () {
                  Get.back(result: false); // Deny permission
                },
                child: Text('Deny'),
              ),
              ElevatedButton(
                onPressed: () {
                  Get.back(result: true); // Allow permission
                },
                child: Text('Allow'),
                style: ButtonStyle(
                  // padding: EdgeInsets.all(15.0),
                    backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                        if (states.contains(MaterialState.pressed)) {
                          // Color when button is pressed
                          return Colors.blue.withOpacity(0.3);
                        } else {
                          // Default color
                          return Colors.blue.withOpacity(0.3);
                        }
                      },
                    ),
                ),
              ),
            ],
          ),
        ],
      ),
    ) ?? false;
  }

  Future<void> showPermissionDeniedForeverDialog() async {
    await Get.defaultDialog(
      title: 'Permission Denied',
      content: Text(
        'Location permission is permanently denied. Please enable it in your device settings.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            // Open app settings
            Geolocator.openAppSettings();
            Get.back();
          },
          child: Text('Open Settings'),
        ),
      ],
    );
  }

  Future<void> showLocationServiceDisabledDialog() async {
    await Get.defaultDialog(
      title: 'Location Service Disabled',
      content: Text(
        'Location services are disabled. Please enable them in your device settings.',
      ),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: Text('OK'),
        ),
        TextButton(
          onPressed: () {
            // Open location settings
            Geolocator.openLocationSettings();
            Get.back();
          },
          child: Text('Open Location Settings'),
        ),
      ],
    );
  }

  /*Future determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      Get.dialog(
        barrierDismissible: false,
        barrierColor: Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
        useSafeArea: true,
        WillPopScope(
            onWillPop: () => Future.value(false),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: AppColors.textFilledColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [BoxShadow(offset: Offset(0.5, 0.5), color: AppColors.lightBlackishTextColor69, blurRadius: 0.5, spreadRadius: 0.6)]),
                child: Material(
                  color: AppColors.textFilledColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('We cannot process further without location access. Please allow location permission from phone settings'),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                await Geolocator.openAppSettings();
                              },
                              child: Text('Allow Permission')),
                          TextButton(onPressed: () {}, child: Text('Close App')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      );
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if(!serviceEnabled){
      Get.dialog(
        barrierDismissible: false,
        barrierColor: Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
        useSafeArea: true,
        WillPopScope(
            onWillPop: () => Future.value(true),
            child: Center(
              child: Container(
                margin: EdgeInsets.all(16.0),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: AppColors.textFilledColor,
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: const [BoxShadow(offset: Offset(0.5, 0.5), color: AppColors.lightBlackishTextColor69, blurRadius: 0.5, spreadRadius: 0.6)]),
                child: Material(
                  color: AppColors.textFilledColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('We cannot process further without location access. please allow location permission from phone settings'),
                      Row(
                        children: [
                          TextButton(
                              onPressed: () async {
                                // await location.getLocation();
                                await Geolocator.openLocationSettings();
                                // StreamSubscription<ServiceStatus> serviceStatusStream =
                                // Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
                                //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
                                //   if(serviceEnabled){
                                //     Get.back();
                                //   }
                                //   if (kDebugMode) {
                                //     print(status);
                                //     print('Turn on Gps');
                                //   }
                                // });
                              },
                              child: Text('Turn on Gps')),
                          TextButton(onPressed: () {
                            exit(0);
                          }, child: Text('Close App')),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ).then((value) async {
        if(serviceEnabled == false) {
          exit(0);
        } else {
          userPosition = await Geolocator.getCurrentPosition();
        }
      });
    }
    else {
      userPosition = await Geolocator.getCurrentPosition();
    }
    Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
      serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if(status == ServiceStatus.disabled) {
        Get.dialog(
          barrierDismissible: false,
          barrierColor: Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
          useSafeArea: true,
          WillPopScope(
              onWillPop: () => Future.value(true),
              child: Center(
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      color: AppColors.textFilledColor,
                      borderRadius: BorderRadius.circular(16.0),
                      boxShadow: const [BoxShadow(offset: Offset(0.5, 0.5), color: AppColors.lightBlackishTextColor69, blurRadius: 0.5, spreadRadius: 0.6)]),
                  child: Material(
                    color: AppColors.textFilledColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('We cannot process further without location access. please allow location permission from phone settings'),
                        Row(
                          children: [
                            TextButton(
                                onPressed: () async {
                                  // await location.getLocation();
                                  await Geolocator.openLocationSettings();
                                  // StreamSubscription<ServiceStatus> serviceStatusStream =
                                  // Geolocator.getServiceStatusStream().listen((ServiceStatus status) async {
                                  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
                                  //   if(serviceEnabled){
                                  //     Get.back();
                                  //   }
                                  //   if (kDebugMode) {
                                  //     print(status);
                                  //     print('Turn on Gps');
                                  //   }
                                  // });
                                },
                                child: Text('Turn on Gps')),
                            TextButton(onPressed: () {}, child: Text('Close App')),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )),
        );
      } else if( serviceEnabled == true && status == ServiceStatus.enabled) {
        Get.back();
        userPosition = await Geolocator.getCurrentPosition();
      }
    });
  }*/

  getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;
    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }
    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    streamSubscription = Geolocator.getPositionStream().listen((Position position) {
      latitude.value = position.latitude;
      longitude.value = position.longitude;
    });
  }

  Future<void> getStreamLocation() async {
    _permissionGranted = await location.hasPermission();
    print(_permissionGranted);

    if (_permissionGranted != null && _permissionGranted != PermissionStatus.granted) {
      // REQUEST PERMISSION
      _permissionGranted = await location.requestPermission();
    } else {
      // LOCATION PERMISSION GRANTED
      _serviceEnabled = await location.serviceEnabled();
    }

    if (_serviceEnabled != null && _serviceEnabled == false) {
      await _showLocationDialog();
    }
  }

  Future<void> _showLocationDialog() async {
    while (!await location.serviceEnabled()) {
      await Get.dialog(
        barrierDismissible: true,
        barrierColor: Theme.of(Get.context!).scaffoldBackgroundColor.withOpacity(0.3),
        useSafeArea: true,
        WillPopScope(
          onWillPop: () => Future.value(false),
          child: Center(
            child: Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.textFilledColor,
                borderRadius: BorderRadius.circular(16.0),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0.5, 0.5),
                    color: AppColors.lightBlackishTextColor69,
                    blurRadius: 0.5,
                    spreadRadius: 0.6,
                  )
                ],
              ),
              child: Material(
                color: AppColors.textFilledColor,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('We cannot process further without location access. Please allow location permission from phone settings'),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () async {
                            await location.requestService();
                            _serviceEnabled = await location.serviceEnabled();
                            Get.back();
                          },
                          child: Text('Turn on GPS'),
                        ),
                        TextButton(
                          onPressed: () {
                            // Close the app or any other action you want
                            Get.back();
                          },
                          child: Text('Close App'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }
  //////////////////////////////////////////////////////////////////////

  Future showToastMessage({required String toastMessage}) async {
    return await Fluttertoast.showToast(
        msg: toastMessage, textColor: AppColors.whiteColor, gravity: ToastGravity.CENTER, backgroundColor: AppColors.appPrimaryLightColor);
  }
}
/////////////////////////////////////////////////////////////////////
