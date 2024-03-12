import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/create_job/bindings/create_job_binding.dart';
import 'package:staffin_softwares/app/modules/create_job/views/close_job_view.dart';
import 'package:staffin_softwares/app/modules/home/model/roster_history_model.dart';
import 'package:staffin_softwares/app/modules/home/providers/home_provider.dart';
import 'package:staffin_softwares/main.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/getstorage_keys.dart';
import '../model/user_roaster_model_class.dart';
import '../model/wages_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  HomeProvider provider = HomeProvider();
  PageController pageController = PageController();
  TextEditingController textEditingController = TextEditingController();

  ///Wages
  Rx<WagesModel> wagesModel = WagesModel().obs;

  final wagesFormKey = GlobalKey<FormState>();
  TextEditingController wagesStartDateTextEditingController =
      TextEditingController();
  TextEditingController wagesEndDateTextEditingController =
      TextEditingController();

  //TODO Main page
  ///Google Map
  RxInt bottomBarCurrentIndex = 2.obs;
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(30.73, 76.77),
    zoom: 10.5,
  );
  final Completer<GoogleMapController> completer =
      Completer<GoogleMapController>();
  final Set<Marker> markers = Set();

  var isWorkStared = false.obs;
  int workTimeForTheDay = 0; // IN SECONDS.
  var workedTime = "Started just now".obs;

  Rx<UserRoasterModelClass> userRoasterModelClass = UserRoasterModelClass().obs;
  RxList<UserRoasterData> userRoasterList = <UserRoasterData>[].obs;
  Rx<RosterHistoryModel> rosterHistoryModels = RosterHistoryModel().obs;

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  late Timer _timer;
  RxInt elapsedSeconds = 0.obs;
  RxBool isPaused = false.obs;
  RxString currentTime = RxString('');

  void listenLocationChanges() async {
    Geolocator.getPositionStream().listen((event) {
      userPosition = event;
      markers.clear();
      markers.add(
        Marker(
          markerId: MarkerId("1"),
          position: LatLng(event.latitude, event.longitude),
        ),
      );
    });
  }

  ///timer
  late Timer timerX;

  RxInt seconds = 0.obs, minute = 0.obs, hour = 0.obs;
  RxBool isTimerPaused = false.obs;

  String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd MMMM, yyyy', 'en-US');
    return formatter.format(now);
  }

  // Future<String> updateTime() async{
  //   return Stream.periodic(Duration(seconds: 1), (int count){
  //     var now = DateTime.now();
  //     var formatter = DateFormat('HH:mm:ss');
  //     return formatter.format(now);
  //   }).first;
  // }
  void updateCurrentTime() {
    currentTime.value = getCurrentTime();
    update(); // Inform GetX about the change
  }

  String getCurrentTime() {
    var now = DateTime.now();
    var formatter = DateFormat('HH:mm:ss');
    return formatter.format(now);
  }

  startTimer() async {
    // await Workmanager().registerPeriodicTask(uniqueName, taskName);
    await provider.fetchTimeDuration().then((value) async {
      if (value.statusCode == 200) {
        Map<dynamic, dynamic> decodedResponse =
            jsonDecode(await value.stream.bytesToString());
        print('fetchTimeDuration :: $decodedResponse');
        if (decodedResponse['success'] == true &&
            decodedResponse.containsKey('data') &&
            decodedResponse['data'] is List<dynamic> &&
            (decodedResponse['data'] as List<dynamic>).isNotEmpty) {
          var second = decodedResponse['data']['time_difference_seconds'];
          Duration duration = Duration(seconds: second);
          hour.value = duration.inHours;
          minute.value = (duration.inMinutes % 60);
          seconds.value = (duration.inSeconds % 60);
          print(seconds.value);
          print('vikram');
          Fluttertoast.showToast(msg: second.toString());
        }
      }
      timerX = Timer.periodic(Duration(seconds: 1), (timer) {
        seconds.value = seconds.value + 1;
        if (seconds.value > 59) {
          print('anydata 32 -------');
          seconds.value = 0;
          minute.value = minute.value + 1;
        }
        if (minute > 59) {
          print('anydata 64 -------');
          minute.value = 0;
          hour.value = hour.value + 1;
        }
      });
    });
  }

//   startTimer()async{
//     // await Workmanager().registerPeriodicTask(uniqueName, taskName);
//     await Workmanager().registerOneOffTask('uniqueId', 'taskName');
//     timerX= Timer.periodic(Duration(seconds: 1), (timer) {
//   seconds=seconds+1;
//   if(seconds>59){
//     seconds.value=0;
//     minute.value=minute.value+1;
//   }
//   if(minute>59){
//     minute.value=0;
//     hour.value=hour.value+1;
//   }
//
// });
//   }
  pauseTimer() {
    print('----------------any----------------------');
    timerX.cancel();
  }

  @override
  void onInit() {
    super.onInit();
    startTimer();
    // updateCurrentTime();
    ever(isTimerPaused,
        (callback) => isTimerPaused.value ? pauseTimer() : startTimer());

    // getUserCurrentLocation();
    pageController = PageController(initialPage: bottomBarCurrentIndex.value);
    // ever(isWorkStared, (callback) => startTime(resumeTimeAt: workedTime.value));
    listenLocationChanges();

    print('From init -------');
    getUserRoasterList();
    getRosterHistory();

    elapsedSeconds(getStorage.read('elapsedTime') ?? 0);
    isPaused(getStorage.read('isPaused') ?? false);

    // ever(currentTime, (callback) => Future.delayed(Duration(seconds: 1), () => currentTime.value = getCurrentTime()));
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

//TODO
  void startTime({required String resumeTimeAt}) async {
    if (isPaused.isTrue) {
      isPaused.toggle();
    } else {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        elapsedSeconds++;
        getStorage.write('elapsedTime', elapsedSeconds.value);
      });
    }

    // CustomLoader.showLoader();
    //   CustomLoader.cancelLoader();
    getStorage.write(GetStorageKeys.workStartTime, DateTime.now().toString());
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (Timer t) {
      workTimeForTheDay = workTimeForTheDay + 1;
      reformattedTime();
    });
  }

  updateWorkingStatus(
      {required String resumeTimeAt,
      required String isJobClosed,
      required String isJobPaused}) async {
    CustomLoader.showLoader();
    provider
        .requestUpdateWorkingStatus(
            resumeTimeAt: resumeTimeAt,
            isJobClosed: isJobClosed,
            isJobPaused: isJobPaused)
        .then((value) async {
      var workingStatusJsonDecodedData =
          jsonDecode(await value.stream.bytesToString());
      print(workingStatusJsonDecodedData.toString());
      CustomLoader.cancelLoader();
      if (workingStatusJsonDecodedData['success'] == true) {
        if (isJobPaused == '0') {
          isWorkStared.value = true;
          startTime(resumeTimeAt: resumeTimeAt);
        } else {
          isWorkStared.value = false;
        }
        AppServices().showToastMessage(
            toastMessage: workingStatusJsonDecodedData['data']['message']);
      } else {
        AppServices().showToastMessage(
            toastMessage: workingStatusJsonDecodedData['message']);
      }
    });
  }

  resumeOrWait() async {
    Get.dialog(Center(
      child: Container(
        margin: EdgeInsets.all(16.0),
        padding: EdgeInsets.all(18.0),
        // color: Colors.white10,
        decoration: BoxDecoration(
            // gradient: LinearGradient(colors: [AppColors.appPrimaryLightColor,AppColors.appPrimaryColor],begin: Alignment.bottomCenter,end: Alignment.topCenter),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: const [
              BoxShadow(
                  offset: Offset(0.5, 0.5),
                  spreadRadius: -0.2,
                  blurRadius: 2.0,
                  color: AppColors.whiteColor)
            ]),
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Do You Want to Resume \n or Close this Job?",
                style: GoogleFonts.urbanist(
                    color: AppColors.textAndOutlineColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomSolidButton(
                    height: 40,
                    onTap: () {
                      Get.back();
                      CustomLoader.showLoader();
                      // isTimerPaused.toggle();
                      provider
                          .getEndWaiting(
                              userId: userBasicInformation.data!.id.toString(),
                              waitingTime: DateTime.now().toString())
                          .then((value) async {
                        CustomLoader.cancelLoader();
                        var decodedData =
                            jsonDecode(await value.stream.bytesToString());
                        AppServices().showToastMessage(
                            toastMessage: decodedData['message']);
                      });
                      // updateWorkingStatus(resumeTimeAt: DateTime.now().toString(),isJobClosed: '0',isJobPaused: '0');
                    },
                    text: 'Resume',
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  CustomSolidButton(
                    height: 40,
                    onTap: () {
                      Get.back();
                      CustomLoader.showLoader();
                      // isTimerPaused.toggle();
                      provider
                          .getStartWaiting(
                              userId: userBasicInformation.data!.id.toString(),
                              waitingTime: DateTime.now().toString())
                          .then((value) async {
                        CustomLoader.cancelLoader();
                        var decodedData =
                            jsonDecode(await value.stream.bytesToString());
                        AppServices().showToastMessage(
                            toastMessage: decodedData['message']);
                      });
                    },
                    text: 'Start waiting',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }

  closeJob() async {
    Get.to(() => const CloseJobView(),
        binding: CreateJobBinding(), fullscreenDialog: true);
  }

  String formatDuration(Duration duration) {
    if (duration.inSeconds < 60) {
      return 'Just Now';
    }
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    String hoursText = hours == 1 ? 'hour' : 'hours';
    String minutesText = minutes == 1 ? 'min' : 'mins';
    return '$hours $hoursText, $minutes $minutesText';
  }

  void reformattedTime() {
    Duration duration = Duration(seconds: workTimeForTheDay);
    String formattedDuration = formatDuration(duration);
    workedTime.value = formattedDuration;
  }

  jumpToPage(int index) {
    pageController.jumpToPage(index);
    // pageController.animateToPage(bottomBarCurrentIndex.value, duration: Duration(microseconds: 400), curve: Curves.bounceIn,);
    bottomBarCurrentIndex.value = index;
  }

  ///Wages
  findWages({required String startDate, required String endDate}) {
    if (wagesFormKey.currentState!.validate()) {
      CustomLoader.showLoader();
      provider
          .findWages(startDate: startDate, endDate: endDate)
          .then((wagesResponseValue) async {
        var decodedData =
            jsonDecode(await wagesResponseValue.stream.bytesToString());
        CustomLoader.cancelLoader();
        if (decodedData['success'] == true) {
          wagesModel.value = WagesModel.fromJson(decodedData);
          if (wagesModel.value.data!.isEmpty) {
            AppServices().showToastMessage(toastMessage: 'Not found');
          }
        } else {
          AppServices().showToastMessage(toastMessage: 'Unable to load wages');
        }
      });
    }
  }

  ///UserRoaster
  getUserRoasterList() async {
    print('This is roaster list controller method------------');
    provider.fetchUserRoaster().then((val) async {
      var data = jsonDecode(await val.stream.bytesToString());
      if (data['success'] == true) {
        print('Successfully fetched Roaster list-------');
        userRoasterModelClass.value = UserRoasterModelClass.fromJson(data);
        // userRoasterModelClass.value = UserRoasterModelClass(
        //     data: userRoasterModelClass.value.data!
        //         .where((element) => element.status == 0)
        //         .toList()
        // ); // UNANSWERED STATUS RESPONSE
        userRoasterModelClass.value = UserRoasterModelClass(
          data: userRoasterModelClass.value.data
              ?.where((element) =>
                      element.status ==
                      0 // Check for null before accessing 'status'
                  )
              .toList(),
        );
      }
    });
  }

  /// Roster History
  getRosterHistory() async {
    print('Fetching roster history----------');
    provider.fetchRosterHistory().then((value) async {
      var historyData = jsonDecode(await value.stream.bytesToString());
      if (historyData['success'] == true) {
        print('Successfully fetched Roaster History List-------');
        rosterHistoryModels.value = RosterHistoryModel.fromJson(historyData);
        rosterHistoryModels.value = RosterHistoryModel(
            data: rosterHistoryModels.value.data?.where((element) => element.status == 0)
                .toList());
        print('------------------------ Roster History -------------------------');
        print(historyData);
      }
    });
  }

  getAcceptRoaster(
      {required String roasterId, required String isAccepted}) async {
    CustomLoader.showLoader();
    provider
        .fetchAcceptRoaster(roasterId: roasterId, isAccepted: isAccepted)
        .then((value) async {
      await getUserRoasterList();
      await getRosterHistory();
      CustomLoader.cancelLoader();
      var decodedData = jsonDecode(await value.stream.bytesToString());
      if (decodedData['success'] == true) {
        AppServices().showToastMessage(toastMessage: 'Accepted successfully');
      } else {
        AppServices()
            .showToastMessage(toastMessage: decodedData['data'].toString());
      }
    });
  }
}
