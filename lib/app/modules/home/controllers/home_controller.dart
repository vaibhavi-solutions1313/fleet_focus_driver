import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/app_widgets/app_text_styles.dart';
import 'package:staffin_softwares/app/app_widgets/custom_loader.dart';
import 'package:staffin_softwares/app/app_widgets/custom_solid_button.dart';
import 'package:staffin_softwares/app/modules/create_job/bindings/create_job_binding.dart';
import 'package:staffin_softwares/app/modules/create_job/views/close_job_view.dart';
import 'package:staffin_softwares/app/modules/home/providers/home_provider.dart';
import 'package:staffin_softwares/main.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_constants/getstorage_keys.dart';
import '../model/user_roaster_model_class.dart';
import '../model/wages_model.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  HomeProvider provider=HomeProvider();
  PageController pageController=PageController();
  TextEditingController textEditingController=TextEditingController();

  ///Wages
  Rx<WagesModel> wagesModel=WagesModel().obs;
  final wagesFormKey=GlobalKey<FormState>();
  TextEditingController wagesStartDateTextEditingController=TextEditingController();
  TextEditingController wagesEndDateTextEditingController=TextEditingController();

    //TODO Main page
  ///Google Map
  RxInt bottomBarCurrentIndex = 2.obs;
  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(30.73, 76.77),
    zoom: 10.5,
  );
  final Completer<GoogleMapController> completer = Completer<GoogleMapController>();
  final Set<Marker> markers = new Set();

  var isWorkStared = false.obs;
  int workTimeForTheDay = 0; // IN SECONDS.
  var workedTime = "Started just now".obs;


  Rx<UserRoasterModelClass> userRoasterModelClass=UserRoasterModelClass().obs;

  var selectedDay = DateTime.now().obs;
  var focusedDay = DateTime.now().obs;

  late Timer _timer;
  RxInt elapsedSeconds = 0.obs;
  RxBool isPaused = false.obs;

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
  RxInt seconds=0.obs,minute=0.obs,hour=0.obs;
  RxBool isTimerPaused=false.obs;
  startTimer(){
    timerX= Timer.periodic(Duration(seconds: 1), (timer) {
  seconds=seconds+1;
  if(seconds>59){
    seconds.value=0;
    minute.value=minute.value+1;
  }
  if(minute>59){
    minute.value=0;
    hour.value=hour.value+1;
  }

});
  }
  pauseTimer(){
    print('any----------------------');
    timerX.cancel();
  }
  @override
  void onInit() {
    startTimer();
    ever(isTimerPaused, (callback) => isTimerPaused.value?pauseTimer():startTimer());

    // getUserCurrentLocation();
    pageController=PageController(initialPage: bottomBarCurrentIndex.value);
    // ever(isWorkStared, (callback) => startTime(resumeTimeAt: workedTime.value));
    listenLocationChanges();

    getUserRoaster();

    elapsedSeconds(getStorage.read('elapsedTime') ?? 0);
    isPaused(getStorage.read('isPaused') ?? false);
    super.onInit();
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

  updateWorkingStatus({required String resumeTimeAt,required String isJobClosed,required String isJobPaused})async{
    CustomLoader.showLoader();
    provider.requestUpdateWorkingStatus(resumeTimeAt: resumeTimeAt, isJobClosed: isJobClosed, isJobPaused: isJobPaused).then((value)async {
      var workingStatusJsonDecodedData=jsonDecode(await value.stream.bytesToString());
      print(workingStatusJsonDecodedData.toString());
      CustomLoader.cancelLoader();
      if(workingStatusJsonDecodedData['success']==true){
        if(isJobPaused=='0'){
          isWorkStared.value=true;
          startTime(resumeTimeAt: resumeTimeAt);
        }else{
      isWorkStared.value=false;
        }
        AppServices().showToastMessage(toastMessage: workingStatusJsonDecodedData['data']['message']);
      }else{
        AppServices().showToastMessage(toastMessage: workingStatusJsonDecodedData['message']);
      }
    });
  }

  resumeOrWait()async{
    Get.dialog(
      Center(
        child: Container(
          margin: EdgeInsets.all(16.0),
          padding: EdgeInsets.all(18.0),
          decoration:  BoxDecoration(
              gradient: LinearGradient(colors: [AppColors.appPrimaryLightColor,AppColors.appPrimaryColor],begin: Alignment.bottomCenter,end: Alignment.topCenter),
              borderRadius: BorderRadius.circular(16.0),
              boxShadow: const [
                BoxShadow(
                    offset: Offset(0.5, 0.5),
                    spreadRadius: -0.2,
                    blurRadius: 2.0,
                    color: AppColors.lightBlackishTextColor
                )
              ]
          ),
          child: Material(
            color: Colors.transparent,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text14By400(text: "Do you want to resume or close this job?",textColor: AppColors.whiteColor),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    CustomSolidButton(height: 38, onTap: (){
                      Get.back();
                      CustomLoader.showLoader();
                      // isTimerPaused.toggle();
                       provider.getEndWaiting(userId: userBasicInformation.data!.id.toString(), waitingTime: DateTime.now().toString()).then((value)async {
                        CustomLoader.cancelLoader();
                        var decodedData=jsonDecode(await value.stream.bytesToString());
                        AppServices().showToastMessage(toastMessage: decodedData['message']);
                      });
                      // updateWorkingStatus(resumeTimeAt: DateTime.now().toString(),isJobClosed: '0',isJobPaused: '0');
                    },text: 'Resume',),

                    CustomSolidButton(height: 38, onTap: (){
                      Get.back();
                      CustomLoader.showLoader();
                      // isTimerPaused.toggle();
                        provider.getStartWaiting(userId: userBasicInformation.data!.id.toString(), waitingTime: DateTime.now().toString()).then((value)async {
                          CustomLoader.cancelLoader();
                          var decodedData=jsonDecode(await value.stream.bytesToString());
                          AppServices().showToastMessage(toastMessage: decodedData['message']);
                        });
                    },text: 'Start waiting',),
                  ],
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  closeJob()async{
    Get.to(()=>const CloseJobView(),binding: CreateJobBinding(),fullscreenDialog: true);
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

  jumpToPage(int index){
    pageController.jumpToPage(index);
    // pageController.animateToPage(bottomBarCurrentIndex.value, duration: Duration(microseconds: 400), curve: Curves.bounceIn,);
    bottomBarCurrentIndex.value=index;
  }
  ///Wages
  findWages({required String startDate,required String endDate}){
    if(wagesFormKey.currentState!.validate()){
      CustomLoader.showLoader();
      provider.findWages(startDate: startDate, endDate: endDate).then((wagesResponseValue) async{
        var decodedData=jsonDecode(await wagesResponseValue.stream.bytesToString());
        CustomLoader.cancelLoader();
        if(decodedData['success']==true){
          wagesModel.value=WagesModel.fromJson(decodedData);
          if(wagesModel.value.data!.isEmpty){
            AppServices().showToastMessage(toastMessage: 'Not found');
          }
        }else{
          AppServices().showToastMessage(toastMessage: 'Unable to load wages');
        }
      });
    }
  }

  ///UserRoaster
  getUserRoaster()async{
    provider.fetchUserRoaster().then((val)async{
var data=jsonDecode(await val.stream.bytesToString());
if(data['success']==true){
  userRoasterModelClass.value=UserRoasterModelClass.fromJson(data);
  userRoasterModelClass.value =  UserRoasterModelClass(data: userRoasterModelClass.value.data!.where((element) => element.status == 0).toList()); // UNANSWERED STATUS RESPONSE
}
    });
  }

  getAcceptRoaster({required String roasterId,required String isAccepted})async{
    CustomLoader.showLoader();
    provider.fetchAcceptRoaster(roasterId: roasterId, isAccepted: isAccepted).then((value)async{
      await getUserRoaster();
      CustomLoader.cancelLoader();
      var decodedData=jsonDecode(await value.stream.bytesToString());
      if(decodedData['success']==true){
        AppServices().showToastMessage(toastMessage: 'Accepted successfully');
      }else{
        AppServices().showToastMessage(toastMessage: decodedData['data'].toString());
      }
    });
  }
}



