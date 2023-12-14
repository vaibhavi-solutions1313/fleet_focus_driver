// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:responsive_sizer/responsive_sizer.dart';
// import '../modules/home/controllers/home_controller.dart';
//
// class MapDriversView extends StatefulWidget {
//   final bool? isHome;
//   const MapDriversView({super.key, this.isHome = false});
//
//   @override
//   State<MapDriversView> createState() => _MapDriversViewState();
// }
//
// class _MapDriversViewState extends State<MapDriversView> {
//   final Set<Marker> _markers = new Set();
//   final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
//   GoogleMapController? mapControl;
//   late Uint8List customMarkerImageBytes;
//   Timer? timer;
//
//   // CUSTOM MARKET SETUP
//   Future<void> loadCustomMarkerImage() async {
//     final ByteData data = await rootBundle.load('assets/images/box-truck.png');
//     customMarkerImageBytes = data.buffer.asUint8List();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     if (widget.isHome == false) {
//       timer?.cancel();
//     }
//     // TODO: implement dispose
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Padding(
//             padding: EdgeInsets.all(8.0.sp),
//             child: Obx(() => Get.find<HomeController>().lastCoordModel.value.lat != null ? GoogleMap(
//               myLocationButtonEnabled: false,
//               myLocationEnabled: false,
//               mapType: MapType.normal,
//               compassEnabled: false,
//               markers: _markers,
//               initialCameraPosition:
//               CameraPosition(target: LatLng(Get.find<HomeController>().lastCoordModel.value.lat!, Get.find<HomeController>().lastCoordModel.value.long!), zoom: 16),
//               onMapCreated: (GoogleMapController controller) {
//                 _controller.complete(controller);
//                 mapControl = controller;
//               },
//             ): Center(child: Text("Trying to fetch location..."))),
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: SafeArea(
//               top: true,
//               child: IconButton(
//                   onPressed: () {
//                   },
//                   icon: Icon(Icons.refresh)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
