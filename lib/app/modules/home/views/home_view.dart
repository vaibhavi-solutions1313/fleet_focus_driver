import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_fields.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart' as picker;
import 'package:staffin_softwares/app/modules/create_job/bindings/create_job_binding.dart';
import 'package:staffin_softwares/app/modules/create_job/views/create_job_view.dart';
import 'package:staffin_softwares/app/modules/profile/views/profile_view.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../main.dart';
import '../../../app_constants/app_Images.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/app_strings.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    controller.markers.clear();
    controller.markers.add(
      Marker(
        markerId: MarkerId("1"),
        position: LatLng(userPosition!.latitude, userPosition!.longitude),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.horizontal,
          controller: controller.pageController,
          children: [
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
                          controller: controller.wagesStartDateTextEditingController,
                          hinText: AppString.wagesPageHintTextForSelectStartDate,
                        ),
                        AppCalendarTextField(
                          controller: controller.wagesEndDateTextEditingController,
                          hinText: AppString.wagesPageHintTextForSelectEndDate,
                        ),
                      ],
                    ),
                    Obx(() => Expanded(
                          child: Offstage(
                            offstage: controller.wagesModel.value.data != null ? false : true,
                            child: ListView(
                              padding: EdgeInsets.all(6.0),
                              shrinkWrap: true,
                              children: [
                                if (controller.wagesModel.value.data != null)
                                  ...List.generate(
                                      controller.wagesModel.value.data!.length,
                                      (index) => Container(
                                            margin: const EdgeInsets.symmetric(vertical: 6.0),
                                            padding: const EdgeInsets.all(12.0),
                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: [
                                              BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 1.0, blurRadius: 1.0)
                                            ]),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text14By400(text: 'CustomerId: ${controller.wagesModel.value.data![index].name}'),
                                                Text14By400(text: 'Driver Number: ${controller.wagesModel.value.data![index].driverNumber.toString()}'),
                                                Text14By400(text: 'Working Hours: ${controller.wagesModel.value.data![index].name}'),
                                                Text14By400(text: 'Wages: ${controller.wagesModel.value.data![index].amount.toString()}'),
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
                              startDate: controller.wagesStartDateTextEditingController.text, endDate: controller.wagesEndDateTextEditingController.text);
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
                        Obx(() => TableCalendar(
                              onDaySelected: (selectedDay, focusedDay) {
                                controller.selectedDay.value = selectedDay;
                                controller.focusedDay.value = focusedDay;
                                print(selectedDay);
                              },
                              currentDay: controller.selectedDay.value,
                              focusedDay: controller.focusedDay.value,
                              firstDay: DateTime(1935, 1, 1),
                              lastDay: DateTime.now(),
                            )),
                        GestureDetector(
                            onTap: () async {
                              picker.DatePicker.showDateTimePicker(context,
                                  showTitleActions: true, minTime: DateTime(1932, 3, 5), maxTime: DateTime.now(), onChanged: (date) {}, onConfirm: (date) {
                                // controller.text = date.toString();
                                print('confirm $date');
                              }, currentTime: DateTime.now(), locale: LocaleType.en);
                            },
                            child: Container(
                                padding: EdgeInsets.all(6.0),
                                child: Text(
                                  'Selet time',
                                  style: TextStyle(color: Colors.blue),
                                ))),
                      ],
                    ),
                  ),
                  Spacer(),
                  CustomSolidButton(
                      text: "Book now",
                      onTap: () {
                        CustomLoader.showLoader();
                        Future.delayed(Duration(seconds: 2), () {
                          CustomLoader.cancelLoader();
                          AppServices().showToastMessage(toastMessage: 'Booked');
                        });
                      }),
                ],
              ),
            ),

            ///Availability page end
            //TODO MAP
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(height: 75,width: 75, child: Image.asset(AppImages.appLogoImage)),
                    Text('fleet focus pro driver',style: GoogleFonts.roboto(color: Color(0xff0455BF),fontWeight: FontWeight.w900,fontSize: 20),)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical: 6.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CustomSolidButton(
                              text: 'Create a job',
                              height: 38,
                              onTap: () {
                                Get.to(() => const CreateJobView(), binding: CreateJobBinding());
                              }),
                          Obx(() => InkWell(
                                onTap: () {
                                  controller.resumeOrWait();
                                  // controller.startTime(resumeTimeAt:controller.workedTime.value);
                                },
                                borderRadius: BorderRadius.circular(12.0),
                                child: Ink(
                                    height: 38,
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    decoration: BoxDecoration(
                                        gradient: controller.isWorkStared.value
                                            ? LinearGradient(colors: [AppColors.appPrimaryLightColor, AppColors.appPrimaryColor])
                                            : LinearGradient(colors: [AppColors.whiteColor, AppColors.lightBlackishTextColor]),
                                        shape: BoxShape.circle,
                                        boxShadow: const [
                                          BoxShadow(offset: Offset(0.5, 0.5), spreadRadius: -0.2, blurRadius: 2.0, color: AppColors.lightBlackishTextColor)
                                        ]),
                                    child: const Center(
                                      child: Icon(
                                        Icons.timer,
                                        color: Colors.white,
                                      ),
                                    )),
                              )),
                        ],
                      ),
                      Obx(() => Row(
                        children: [
                          InkWell(
                            onTap: () {
                              controller.closeJob();
                            },
                            borderRadius: BorderRadius.circular(12.0),
                            child: Ink(
                                height: 34,
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                decoration: BoxDecoration(
                                    gradient: controller.isWorkStared.value
                                        ? LinearGradient(colors: [AppColors.appPrimaryLightColor, AppColors.appPrimaryColor])
                                        : LinearGradient(colors: [AppColors.appPrimaryColor, AppColors.appPrimaryLightColor]),
                                    shape: BoxShape.circle,
                                    boxShadow: const [
                                      BoxShadow(offset: Offset(0.5, 0.5), spreadRadius: -0.5, blurRadius: 2.0, color: AppColors.lightBlackishTextColor)
                                    ]
                                    ),
                                child:  Icon(
                                  controller.isTimerPaused.value?Icons.stop_circle_outlined:Icons.play_circle_outline_rounded,
                                  color: Colors.white,
                                )),
                          ),
                          SizedBox(
                            width: 36,
                            height: 34,
                            child: Card(
                              margin: EdgeInsets.only(right: 4.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Center(child: Text15By500(text: controller.hour.toString().padLeft(2,'0'))),
                                )),
                          ),
                          SizedBox(
                            width: 36,
                            height: 34,
                            child: Card(
                              margin: EdgeInsets.only(right: 4.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Center(child: Text15By500(text: controller.minute.toString().padLeft(2,'0'))),
                                )),
                          ),
                          SizedBox(
                            width: 36,
                            height: 34,
                            child: Card(
                              margin: EdgeInsets.only(right: 4.0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.0)
                              ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                  child: Center(child: Text15By500(text: controller.seconds.toString().padLeft(2,'0'))),
                                )),
                          ),

                        ],
                      ))
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

            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(width: 8.0),
                    Text20By700(text: 'Roaster List'),
                    Obx(() => controller.userRoasterModelClass.value.data!.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                                // physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: controller.userRoasterModelClass.value.data!.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    margin: EdgeInsets.symmetric(vertical: 8.0),
                                    padding: EdgeInsets.all(12.0),
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16.0), boxShadow: const [
                                      BoxShadow(offset: Offset(1.0, 1.0), color: AppColors.textFilledColor, spreadRadius: 1.0, blurRadius: 1.0)
                                    ]),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                         Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                             Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                                                 Text15By500(text: 'Rego: ${controller.userRoasterModelClass.value.data![index].rego!}'),
                                                 Text14By400(text: 'Dated: ${controller.userRoasterModelClass.value.data![index].date!}'),
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

                                        SizedBox(height: 8.0,),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            CustomSolidButton(
                                                text: 'Reject',
                                                height: 38,
                                                onTap: () {
                                                  controller.getAcceptRoaster(
                                                      roasterId: controller.userRoasterModelClass.value.data![index].id.toString(), isAccepted: '2');
                                                }),
                                            SizedBox(width: 16,),
                                            CustomSolidButton(
                                                text: 'Accept',
                                                height: 38,
                                                onTap: () {
                                                  controller.getAcceptRoaster(
                                                      roasterId: controller.userRoasterModelClass.value.data![index].id.toString(), isAccepted: '1');
                                                }),

                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          )
                        : Container(
                            height: Get.height * 0.6,
                            child: const Center(
                              child: Text15By500(
                                text: "Data not available",
                              ),
                            ),
                          ))
                  ],
                ),
              ),
            ),
            ProfileView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.bottomBarCurrentIndex.value,
            onTap: (v) {
              controller.jumpToPage(v);
            },
            selectedItemColor: AppColors.appPrimaryLightColor,
            unselectedItemColor: AppColors.lightBlackishTextColor,
            type: BottomNavigationBarType.fixed,
            showUnselectedLabels: false,
            showSelectedLabels: false,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(icon: Icon(Icons.monetization_on_rounded), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.calendar_month_outlined), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.location_on_rounded), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
            ],
          )),
    );
  }
}


