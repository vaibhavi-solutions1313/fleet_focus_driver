import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_fields.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import 'package:staffin_softwares/app/app_widgets/custom_icon_text_button.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:staffin_softwares/app/modules/create_job/bindings/create_job_binding.dart';
import 'package:staffin_softwares/app/modules/create_job/views/create_job_view.dart';
import 'package:staffin_softwares/app/modules/home/views/roster_history.dart';
import 'package:staffin_softwares/app/modules/profile/model/user_basic_information.dart';
import 'package:staffin_softwares/app/modules/profile/views/profile_view.dart';
import '../../../../main.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/custom_roaster_button.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with WidgetsBindingObserver {
  final controller = Get.find<HomeController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.detached) {
      service.startService();
    }
  }

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    controller.markers.clear();
    // controller.markers.add(
    //   Marker(
    //     markerId: MarkerId("1"),
    //     position: LatLng(userPosition!.latitude, userPosition!.longitude),
    //   ),
    // );
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: controller.pageController,
          children: [
            /// Wages
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: controller.wagesFormKey,
                child: Column(
                  children: [
                    Column(
                      children: [
                        CustomAppBar(title: AppString.wagesPageTitle),
                        AppCalendarTextField(
                          controller:
                              controller.wagesStartDateTextEditingController,
                          hinText:
                              AppString.wagesPageHintTextForSelectStartDate,
                        ),
                        AppCalendarTextField(
                          controller:
                              controller.wagesEndDateTextEditingController,
                          hinText: AppString.wagesPageHintTextForSelectEndDate,
                        ),
                      ],
                    ),
                    Obx(() => Expanded(
                          child: Offstage(
                            offstage: controller.wagesModel.value.data != null
                                ? false
                                : true,
                            child: ListView(
                              padding: EdgeInsets.all(6.0),
                              shrinkWrap: true,
                              children: [
                                if (controller.wagesModel.value.data != null)
                                  ...List.generate(
                                      controller.wagesModel.value.data!.length,
                                      (index) => Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 6.0),
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16.0),
                                                boxShadow: [
                                                  BoxShadow(
                                                      offset: Offset(1.0, 1.0),
                                                      color: AppColors
                                                          .textFilledColor,
                                                      spreadRadius: 1.0,
                                                      blurRadius: 1.0)
                                                ]),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text14By400(
                                                    text:
                                                        'CustomerId: ${controller.wagesModel.value.data![index].name}'),
                                                Text14By400(
                                                    text:
                                                        'Driver Number: ${controller.wagesModel.value.data![index].driverNumber.toString()}'),
                                                Text14By400(
                                                    text:
                                                        'Working Hours: ${controller.wagesModel.value.data![index].name}'),
                                                Text14By400(
                                                    text:
                                                        'Wages: ${controller.wagesModel.value.data![index].amount.toString()}'),
                                              ],
                                            ),
                                          ))
                              ],
                            ),
                          ),
                        )),
                    const Spacer(),
                    CustomSolidButton(
                        text: AppString.wagesPagePageButtonText,
                        onTap: () {
                          controller.findWages(
                              startDate: controller
                                  .wagesStartDateTextEditingController.text,
                              endDate: controller
                                  .wagesEndDateTextEditingController.text);
                        })
                  ],
                ),
              ),
            ),

            ///Availability page start from here
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        CustomAppBar(title: 'Availability'),
                        CalendarDatePicker2(
                            config: CalendarDatePicker2Config(
                                firstDate: DateTime.now(),
                                lastMonthIcon: const Icon(
                                  Icons.arrow_back_ios,
                                  size: 15,
                                  color: AppColors.textAndOutlineColor,
                                ),
                                nextMonthIcon: const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 15,
                                  color: AppColors.textAndOutlineColor,
                                ),
                                dayBorderRadius: BorderRadius.circular(5.0),
                                yearTextStyle: TextStyle(
                                    color: AppColors.textAndOutlineColor,
                                    fontSize: 16,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                                controlsTextStyle: TextStyle(
                                  color: AppColors.textAndOutlineBottom
                                      .withOpacity(0.6),
                                  fontSize: 18,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                ),
                                dayTextStyle: TextStyle(
                                    color: AppColors.calendarTextFill,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                                weekdayLabels: [
                                  'Sun',
                                  'Mon',
                                  'Tue',
                                  'Wed',
                                  'Thu',
                                  'Fri',
                                  'Sat'
                                ],
                                weekdayLabelTextStyle: TextStyle(
                                    color: AppColors.textAndOutlineColor,
                                    fontSize: 15,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500),
                                selectedDayTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                                selectedDayHighlightColor:
                                    AppColors.textAndOutlineColor),
                            value: []
                        ),
                        // Obx(() =>
                        // TableCalendar(
                        //   onDaySelected: (selectedDay, focusedDay) {
                        //     controller.selectedDay.value = selectedDay;
                        //     controller.focusedDay.value = focusedDay;
                        //     print(selectedDay);
                        //   },
                        //   currentDay: controller.selectedDay.value,
                        //   focusedDay: controller.focusedDay.value,
                        //   firstDay: DateTime.now(),
                        //   lastDay: DateTime.now().add(Duration(days: 14)),
                        // )
                        // ),
                        GestureDetector(
                            onTap: () async {
                              picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(1932, 3, 5),
                                  maxTime: DateTime.now(),
                                  onChanged: (date) {}, onConfirm: (date) {
                                // controller.text = date.toString();
                                print('confirm $date');
                              },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: Container(
                                padding: const EdgeInsets.all(6.0),
                                child: const Text(
                                  'Select time',
                                  style: TextStyle(color: Colors.blue),
                                )
                            )
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomSolidButton(
                      text: "Book Wages",
                      onTap: () {
                        CustomLoader.showLoader();
                        Future.delayed(Duration(seconds: 2), () {
                          CustomLoader.cancelLoader();
                          AppServices()
                              .showToastMessage(toastMessage: 'Booked');
                        });
                      }),
                ],
              ),
            ),

            ///Availability page end
            //TODO MAP
            /// Home Screen Page
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //         height: 75,
                  //         width: 75,
                  //         child: Image.asset(AppImages.appLogoImage)),
                  //     Text(
                  //       'fleet focus pro driver',
                  //       style: GoogleFonts.roboto(
                  //           color: Color(0xff0455BF),
                  //           fontWeight: FontWeight.w900,
                  //           fontSize: 20),
                  //     )
                  //   ],
                  // ),
                  AppBar(
                    backgroundColor: AppColors.canvasColor,
                    scrolledUnderElevation: 0.0,
                    elevation: 0.0,
                    automaticallyImplyLeading: false,
                    toolbarHeight: 80.0,
                    centerTitle: true,
                    title: Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Image.asset(
                        "assets/splashAndLogo/fleet_focus_logo.png",
                        height: 120,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 500,
                    margin: EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                              'Hello, ${userBasicInformation.data?.name}',
                              style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.2,
                                color: Colors.black,
                                fontSize: 18
                              ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          height: 60,
                          margin: EdgeInsets.symmetric(vertical: 18, horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blueGrey.withOpacity(0.5),
                                blurRadius: 4,
                                spreadRadius: 1.5,
                                offset: Offset(0, 2),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    // height: 30,
                                    // width: 30,
                                    padding: EdgeInsets.all(8.0),
                                    margin: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          begin: Alignment.bottomCenter,
                                          end: Alignment.topCenter,
                                          colors: [AppColors.btnLight1, AppColors.btnLight2],
                                        ),
                                        borderRadius: BorderRadius.circular(12.0)
                                    ),
                                    child: ShaderMask(
                                      blendMode: BlendMode.srcIn,
                                      shaderCallback: (bounds) => LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.textAndOutlineTop,
                                          AppColors.textAndOutlineBottom
                                        ],
                                      ).createShader(Rect.fromLTWH(
                                          0, 0, bounds.width, bounds.height)),
                                      child: Icon(
                                        Icons.access_time,
                                        size: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (bounds) => LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.textAndOutlineTop.withOpacity(0.5),
                        AppColors.textAndOutlineBottom.withOpacity(0.8)
                      ],
                    ).createShader(Rect.fromLTWH(
                        0, 0, bounds.width, bounds.height)),
                    child: Text(
                        controller.getCurrentTime(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontFamily: "Montserrat",
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(15.0),
                                child: Text(
                                  controller.getCurrentDate(),
                                  style: TextStyle(
                                      color: AppColors.currentDateTextColor,
                                      fontSize: 15.0,
                                      fontFamily: "Inter",
                                      fontWeight: FontWeight.w500
                                  ),
                                ),
                              ),
                              /*SizedBox(
                                width: 36,
                                height: 34,
                                child: Card(
                                    margin: EdgeInsets.only(right: 4.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Center(
                                          child: Text15By500(
                                              text: controller.hour.toString().padLeft(2, '0'))),
                                    )),
                              ),
                              SizedBox(
                                width: 36,
                                height: 34,
                                child: Card(
                                    margin: EdgeInsets.only(right: 4.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Center(
                                          child: Text15By500(
                                              text: controller.minute.toString().padLeft(2, '0'))),
                                    )),
                              ),
                              SizedBox(
                                width: 36,
                                height: 34,
                                child: Card(
                                    margin: EdgeInsets.only(right: 4.0),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(6.0)),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      child: Center(
                                          child: Text15By500(
                                              text: controller.seconds.toString().padLeft(2, '0'))),
                                    )),
                              ),*/
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomIconTextButton(
                                text: 'Create Job',
                            onTap: () {
                              Get.to(() => const CreateJobView(),
                                  binding: CreateJobBinding());
                            },
                                icon: Icon(Icons.add_circle_outline_rounded, size: 16, color: Colors.black,),
                            ),
                            CustomIconTextButton(
                                text: 'Close Job',
                              onTap: () {
                                controller.closeJob();
                              },
                                icon: Icon(Icons.stop_circle_outlined, size: 16, color: Colors.black,),
                            ),
                            CustomIconTextButton(
                                text: 'Waiting',
                                onTap: (){
                                  controller.resumeOrWait();
                                  // controller.startTime(resumeTimeAt:controller.workedTime.value);
                                },
                                icon: Icon(Icons.pause_circle_outline_rounded, size: 16, color: Colors.black,),
                            ),

                          ],
                        ),
                        SizedBox(height: 15,),
                        // Expanded(
                        //   child: GoogleMap(
                        //     initialCameraPosition: CameraPosition(
                        //         target: LatLng(
                        //             userPosition!.latitude, userPosition!.longitude),
                        //         zoom: 13),
                        //     onMapCreated: (GoogleMapController gController) {
                        //       controller.completer.complete(gController);
                        //     },
                        //     markers: controller.markers,
                        //     mapType: MapType.normal,
                        //     myLocationButtonEnabled: true,
                        //     zoomControlsEnabled: true,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: GoogleMap(
                      initialCameraPosition: CameraPosition(target: LatLng(userPosition!.latitude, userPosition!.longitude),zoom: 13),
                      onMapCreated: (GoogleMapController gController) {
                        controller.completer.complete(gController);
                      },
                      markers: controller.markers,
                      mapType: MapType.normal,
                      myLocationButtonEnabled: true,
                      zoomControlsEnabled: true,
                    ),
                  ),
                ],
              ),
            ),

            /// Roaster list
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                   Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       // SizedBox(width: 8.0),
                       CustomAppBar(title: 'Roaster List'),
                       TextButton(
                           onPressed: (){
                             // CustomLoader.showLoader();
                             Get.to(() => ShowRosterHistoryView());
                             // CustomLoader.cancelLoader();
                           },
                           child: Text('Show History',
                           style: TextStyle(
                             fontSize: 14,
                             fontFamily: 'Open Sans',
                             fontWeight: FontWeight.normal,
                             letterSpacing: 0.37,
                             color: Colors.black
                           ),)
                       )
                     ],
                   ),

                    /*Expanded(
                      child: ListView.builder(
                        // physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 3,
                          itemBuilder: (context, index) {
                            return Card(
                              color: Colors.white,
                              margin: const EdgeInsets.symmetric(vertical: 6.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12.0),
                              ),
                              elevation: 2.0,
                              shadowColor: AppColors.appPrimaryColor.withOpacity(0.5),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            // 'Rego: ${controller.userRoasterModelClass.value.data![index].rego!}'),
                                            'USERNAME', // set to all caps property
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                          color: Color(0xFF383838),
                                          letterSpacing: 0.7
                                        ),),
                                        Text(
                                              // 'Dated: ${controller.userRoasterModelClass.value.data![index].date!}'),
                                              'AK6075POS',
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                            color: Color(0xFF8B8B8B),
                                            letterSpacing: 0.3
                                        ),),
                                        Row(
                                          children: [
                                            Text(
                                                // 'Dated: ${controller.userRoasterModelClass.value.data![index].date!}'),
                                                '25 August, 2000',
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF626262),
                                                  letterSpacing: -0.3
                                              ),
                                            ),
                                            SizedBox(width: 20,),
                                            Text(
                                              // 'Start time: ${controller.userRoasterModelClass.value.data![index].startTime!}',
                                              '12:00 PM - 2:00 PM',
                                              style: TextStyle(
                                                  fontFamily: 'Lato',
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.normal,
                                                  color: Color(0xFF626262),
                                                  letterSpacing: -0.3
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Text(
                                        //   // 'End time: ${controller.userRoasterModelClass.value.data![index].endTime!}',
                                        //   'End time: {controller.userRoasterModelClass.value.data![index].endTime!}',
                                        //   style: TextStyle(fontSize: 13),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 8.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.end,
                                      children: [
                                        CustomRoasterButton(
                                            text: 'Reject',
                                            onTap: () {
                                              // controller.getAcceptRoaster(
                                              //     roasterId: controller
                                              //         .userRoasterModelClass
                                              //         .value
                                              //         .data![index]
                                              //         .id
                                              //         .toString(),
                                              //     isAccepted: '2');
                                            }),
                                        SizedBox(
                                          width: 8,
                                        ),
                                        CustomRoasterButton(
                                            text: 'Accept',
                                            onTap: () {
                                              // controller.getAcceptRoaster(
                                              //     roasterId: controller
                                              //         .userRoasterModelClass
                                              //         .value
                                              //         .data![index]
                                              //         .id
                                              //         .toString(),
                                              //     isAccepted: '1');
                                            }),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),*/

                    Obx(() => controller.userRoasterModelClass.value.data?.isNotEmpty == true
                        ? Expanded(
                            child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.userRoasterModelClass.value.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(16.0),
                                        boxShadow: const [
                                          BoxShadow(
                                              offset: Offset(1.0, 1.0),
                                              color: AppColors.textFilledColor,
                                              spreadRadius: 1.0,
                                              blurRadius: 1.0)
                                        ]),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text15By500(
                                                    text:
                                                        'Rego: ${controller.userRoasterModelClass.value.data![index].rego!}'),
                                                Text14By400(
                                                    text:
                                                        'Date: ${DateFormat('dd MMM, yyyy').format(controller.userRoasterModelClass.value.data![index].date!)}'),
                                              ],
                                            ),
                                            Text(
                                              'Start time: ${controller.userRoasterModelClass.value.data![index].startTime!}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                            Text(
                                              'End time: ${controller.userRoasterModelClass.value.data![index].endTime!}',
                                              style: TextStyle(fontSize: 13),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 8.0,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            CustomSolidButton(
                                                text: 'Reject',
                                                height: 38,
                                                onTap: () {
                                                  controller.getAcceptRoaster(
                                                      roasterId: controller
                                                          .userRoasterModelClass
                                                          .value
                                                          .data![index]
                                                          .id
                                                          .toString(),
                                                      isAccepted: '2');
                                                }),
                                            SizedBox(
                                              width: 16,
                                            ),
                                            CustomSolidButton(
                                                text: 'Accept',
                                                height: 38,
                                                onTap: () {
                                                  controller.getAcceptRoaster(
                                                      roasterId: controller
                                                          .userRoasterModelClass
                                                          .value
                                                          .data![index]
                                                          .id
                                                          .toString(),
                                                      isAccepted: '1');
                                                }),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Expanded(
                      child: Center(
                        child: Container(
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/dashboard_images/empty_roster.png',
                                height: 128,
                                width: 128,
                              ),
                              SizedBox(height: 5,),
                              Text(
                                'It\'s empty here',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32,
                                    color: Color(0xFF171A1F)
                                ),
                              ),
                              SizedBox(height: 5,),
                              Text('To view your history, Click the button below',
                                style: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18,
                                    color: Color(0xFF9095A0)
                                ),
                              ),
                              SizedBox(height: 40,),
                              CustomSolidButton(
                                  text: 'Show History',
                                  onTap: () {
                                    Get.to(() => ShowRosterHistoryView());
                                  }
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                    )
                  ],
                ),
              ),
            ),

            /// Profile View
            const ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            // iconSize: 50,
            currentIndex: controller.bottomBarCurrentIndex.value,
            onTap: (v) {
              controller.jumpToPage(v);
            },
            // selectedItemColor: AppColors.appPrimaryLightColor,
            // unselectedItemColor: AppColors.lightBlackishTextColor,
            type: BottomNavigationBarType.fixed,
            // showUnselectedLabels: false,
            // showSelectedLabels: false,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Image.asset(
                  "assets/dashboard_images/dashboard_salary_payment.png",
                  width: controller.bottomBarCurrentIndex.value == 0 ? 50 : 35,
                  height: controller.bottomBarCurrentIndex.value == 0 ? 50 : 35,
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/dashboard_images/dashboard_calendar.png",
                    width:
                        controller.bottomBarCurrentIndex.value == 1 ? 50 : 35,
                    height:
                        controller.bottomBarCurrentIndex.value == 1 ? 50 : 35,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/dashboard_images/dashboard_home.png",
                    width:
                        controller.bottomBarCurrentIndex.value == 2 ? 50 : 35,
                    height:
                        controller.bottomBarCurrentIndex.value == 2 ? 50 : 35,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/dashboard_images/dashboard_roaster.png",
                    width:
                        controller.bottomBarCurrentIndex.value == 3 ? 50 : 35,
                    height:
                        controller.bottomBarCurrentIndex.value == 3 ? 50 : 35,
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    "assets/dashboard_images/dashboard_customer.png",
                    width:
                        controller.bottomBarCurrentIndex.value == 4 ? 50 : 35,
                    height:
                        controller.bottomBarCurrentIndex.value == 4 ? 50 : 35,
                  ),
                  label: ''),
            ],
          )),
    );
  }
}

// class HomeView extends GetView<HomeController> {
//   const HomeView({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     controller.markers.clear();
//     controller.markers.add(
//       Marker(
//         markerId: MarkerId("1"),
//         position: LatLng(userPosition!.latitude, userPosition!.longitude),
//       ),
//     );
//     return Scaffold(
//       body: SafeArea(
//         child: PageView(
//           physics: const NeverScrollableScrollPhysics(),
//           scrollDirection: Axis.horizontal,
//           controller: controller.pageController,
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Form(
//                 key: controller.wagesFormKey,
//                 child: Column(
//                   children: [
//                     Column(
//                       children: [
//                         CustomAppBar(title: AppString.wagesPageTitle),
//                         AppCalendarTextField(
//                           controller: controller.wagesStartDateTextEditingController,
//                           hinText: AppString.wagesPageHintTextForSelectStartDate,
//                         ),
//                         AppCalendarTextField(
//                           controller: controller.wagesEndDateTextEditingController,
//                           hinText: AppString.wagesPageHintTextForSelectEndDate,
//                         ),
//                       ],
//                     ),
//                     Obx(() => Expanded(
//                           child: Offstage(
//                             offstage: controller.wagesModel.value.data != null ? false : true,
//                             child: ListView(
//                               padding: EdgeInsets.all(6.0),
//                               shrinkWrap: true,
//                               children: [
//                                 if (controller.wagesModel.value.data != null)
//                                   ...List.generate(
//                                       controller.wagesModel.value.data!.length,
//                                       (index) => Container(
//                                             margin: const EdgeInsets.symmetric(vertical: 6.0),
//                                             padding: const EdgeInsets.all(12.0),
//                                             decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: [
//                                               BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 1.0, blurRadius: 1.0)
//                                             ]),
//                                             child: Column(
//                                               crossAxisAlignment: CrossAxisAlignment.start,
//                                               children: [
//                                                 Text14By400(text: 'CustomerId: ${controller.wagesModel.value.data![index].name}'),
//                                                 Text14By400(text: 'Driver Number: ${controller.wagesModel.value.data![index].driverNumber.toString()}'),
//                                                 Text14By400(text: 'Working Hours: ${controller.wagesModel.value.data![index].name}'),
//                                                 Text14By400(text: 'Wages: ${controller.wagesModel.value.data![index].amount.toString()}'),
//                                               ],
//                                             ),
//                                           ))
//                               ],
//                             ),
//                           ),
//                         )),
//                     const Spacer(),
//                     CustomSolidButton(
//                         text: AppString.wagesPagePageButtonText,
//                         onTap: () {
//                           controller.findWages(
//                               startDate: controller.wagesStartDateTextEditingController.text, endDate: controller.wagesEndDateTextEditingController.text);
//                         })
//                   ],
//                 ),
//               ),
//             ),
//
//             ///Availability page start from here
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         CustomAppBar(title: 'Availability'),
//                         Obx(() => TableCalendar(
//                               onDaySelected: (selectedDay, focusedDay) {
//                                 controller.selectedDay.value = selectedDay;
//                                 controller.focusedDay.value = focusedDay;
//                                 print(selectedDay);
//                               },
//                               currentDay: controller.selectedDay.value,
//                               focusedDay: controller.focusedDay.value,
//                               firstDay: DateTime.now(),
//                               lastDay: DateTime.now().add(Duration(days: 14)),
//                             )),
//                         GestureDetector(
//                             onTap: () async {
//                               picker.DatePicker.showDateTimePicker(context,
//                                   showTitleActions: true, minTime: DateTime(1932, 3, 5),
//                                   maxTime: DateTime.now(),
//                                   onChanged: (date) {}, onConfirm: (date) {
//                                 // controller.text = date.toString();
//                                 print('confirm $date');
//                               }, currentTime: DateTime.now(), locale: LocaleType.en);
//                             },
//                             child: Container(
//                                 padding: EdgeInsets.all(6.0),
//                                 child: Text(
//                                   'Selet time',
//                                   style: TextStyle(color: Colors.blue),
//                                 ))),
//                       ],
//                     ),
//                   ),
//                   Spacer(),
//                   CustomSolidButton(
//                       text: "Book now",
//                       onTap: () {
//                         CustomLoader.showLoader();
//                         Future.delayed(Duration(seconds: 2), () {
//                           CustomLoader.cancelLoader();
//                           AppServices().showToastMessage(toastMessage: 'Booked');
//                         });
//                       }),
//                 ],
//               ),
//             ),
//
//             ///Availability page end
//             //TODO MAP
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Row(
//                   children: [
//                     SizedBox(height: 75,width: 75, child: Image.asset(AppImages.appLogoImage)),
//                     Text('fleet focus pro driver',style: GoogleFonts.roboto(color: Color(0xff0455BF),fontWeight: FontWeight.w900,fontSize: 20),)
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           CustomSolidButton(
//                               text: 'Create a job',
//                               height: 38,
//                               onTap: () {
//                                 Get.to(() => const CreateJobView(), binding: CreateJobBinding());
//                               }),
//                           Obx(() => InkWell(
//                                 onTap: () {
//                                   controller.resumeOrWait();
//                                   // controller.startTime(resumeTimeAt:controller.workedTime.value);
//                                 },
//                                 borderRadius: BorderRadius.circular(12.0),
//                                 child: Ink(
//                                     height: 38,
//                                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                                     decoration: BoxDecoration(
//                                         gradient: controller.isWorkStared.value
//                                             ? LinearGradient(colors: [AppColors.appPrimaryLightColor, AppColors.appPrimaryColor])
//                                             : LinearGradient(colors: [AppColors.whiteColor, AppColors.lightBlackishTextColor]),
//                                         shape: BoxShape.circle,
//                                         boxShadow: const [
//                                           BoxShadow(offset: Offset(0.5, 0.5), spreadRadius: -0.2, blurRadius: 2.0, color: AppColors.lightBlackishTextColor)
//                                         ]),
//                                     child: const Center(
//                                       child: Icon(
//                                         Icons.timer,
//                                         color: Colors.white,
//                                       ),
//                                     )),
//                               )),
//                         ],
//                       ),
//                       Obx(() => Row(
//                         children: [
//                           InkWell(
//                             onTap: () {
//                               controller.closeJob();
//                             },
//                             borderRadius: BorderRadius.circular(12.0),
//                             child: Ink(
//                                 height: 34,
//                                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                                 decoration: BoxDecoration(
//                                     gradient: controller.isWorkStared.value
//                                         ? LinearGradient(colors: [AppColors.appPrimaryLightColor, AppColors.appPrimaryColor])
//                                         : LinearGradient(colors: [AppColors.appPrimaryColor, AppColors.appPrimaryLightColor]),
//                                     shape: BoxShape.circle,
//                                     boxShadow: const [
//                                       BoxShadow(offset: Offset(0.5, 0.5), spreadRadius: -0.5, blurRadius: 2.0, color: AppColors.lightBlackishTextColor)
//                                     ]
//                                     ),
//                                 child:  Icon(
//                                   controller.isTimerPaused.value?Icons.stop_circle_outlined:Icons.play_circle_outline_rounded,
//                                   color: Colors.white,
//                                 )),
//                           ),
//                           SizedBox(
//                             width: 36,
//                             height: 34,
//                             child: Card(
//                               margin: EdgeInsets.only(right: 4.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6.0)
//                               ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                   child: Center(child: Text15By500(text: controller.hour.toString().padLeft(2,'0'))),
//                                 )),
//                           ),
//                           SizedBox(
//                             width: 36,
//                             height: 34,
//                             child: Card(
//                               margin: EdgeInsets.only(right: 4.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6.0)
//                               ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                   child: Center(child: Text15By500(text: controller.minute.toString().padLeft(2,'0'))),
//                                 )),
//                           ),
//                           SizedBox(
//                             width: 36,
//                             height: 34,
//                             child: Card(
//                               margin: EdgeInsets.only(right: 4.0),
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(6.0)
//                               ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(horizontal: 4.0),
//                                   child: Center(child: Text15By500(text: controller.seconds.toString().padLeft(2,'0'))),
//                                 )),
//                           ),
//
//                         ],
//                       ))
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: GoogleMap(
//
//                     initialCameraPosition: CameraPosition(target: LatLng(userPosition!.latitude, userPosition!.longitude),zoom: 13),
//                     onMapCreated: (GoogleMapController gController) {
//                       controller.completer.complete(gController);
//                     },
//                     markers: controller.markers,
//                     mapType: MapType.normal,
//                     myLocationButtonEnabled: true,
//                     zoomControlsEnabled: true,
//                   ),
//                 ),
//               ],
//             ),
//
//             SafeArea(
//               child: Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     SizedBox(width: 8.0),
//                     Text20By700(text: 'Roaster List'),
//                     Obx(() => controller.userRoasterModelClass.value.data!.isNotEmpty
//                         ? Expanded(
//                             child: ListView.builder(
//                                 // physics: NeverScrollableScrollPhysics(),
//                                 shrinkWrap: true,
//                                 itemCount: controller.userRoasterModelClass.value.data!.length,
//                                 itemBuilder: (context, index) {
//                                   return Container(
//                                     margin: EdgeInsets.symmetric(vertical: 8.0),
//                                     padding: EdgeInsets.all(12.0),
//                                     decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: const [
//                                       BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 1.0, blurRadius: 1.0)
//                                     ]),
//                                     child: Column(
//                                       mainAxisAlignment: MainAxisAlignment.start,
//                                       children: [
//                                          Column(
//                                            crossAxisAlignment: CrossAxisAlignment.start,
//                                            children: [
//                                              Row(
//                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                children: [
//                                                  Text15By500(text: 'Rego: ${controller.userRoasterModelClass.value.data![index].rego!}'),
//                                                  Text14By400(text: 'Dated: ${controller.userRoasterModelClass.value.data![index].date!}'),
//                                                ],
//                                              ),
//                                              Text(
//                                                'Start time: ${controller.userRoasterModelClass.value.data![index].startTime!}',
//                                                style: TextStyle(fontSize: 13),
//                                              ),
//                                              Text(
//                                                'End time: ${controller.userRoasterModelClass.value.data![index].endTime!}',
//                                                style: TextStyle(fontSize: 13),
//                                              ),
//                                            ],
//                                          ),
//
//                                         SizedBox(height: 8.0,),
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.end,
//                                           children: [
//                                             CustomSolidButton(
//                                                 text: 'Reject',
//                                                 height: 38,
//                                                 onTap: () {
//                                                   controller.getAcceptRoaster(
//                                                       roasterId: controller.userRoasterModelClass.value.data![index].id.toString(), isAccepted: '2');
//                                                 }),
//                                             SizedBox(width: 16,),
//                                             CustomSolidButton(
//                                                 text: 'Accept',
//                                                 height: 38,
//                                                 onTap: () {
//                                                   controller.getAcceptRoaster(
//                                                       roasterId: controller.userRoasterModelClass.value.data![index].id.toString(), isAccepted: '1');
//                                                 }),
//
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }),
//                           )
//                         : Container(
//                             height: Get.height * 0.6,
//                             child: const Center(
//                               child: Text15By500(
//                                 text: "Data not available",
//                               ),
//                             ),
//                           ))
//                   ],
//                 ),
//               ),
//             ),
//             ProfileView(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Obx(() => BottomNavigationBar(
//             currentIndex: controller.bottomBarCurrentIndex.value,
//             onTap: (v) {
//               controller.jumpToPage(v);
//             },
//             selectedItemColor: AppColors.appPrimaryLightColor,
//             unselectedItemColor: AppColors.lightBlackishTextColor,
//             type: BottomNavigationBarType.fixed,
//             showUnselectedLabels: false,
//             showSelectedLabels: false,
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(icon: Icon(Icons.monetization_on_rounded), label: ''),
//               BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: ''),
//               BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
//               BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded), label: ''),
//               BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
//             ],
//           )),
//     );
//   }
// }
