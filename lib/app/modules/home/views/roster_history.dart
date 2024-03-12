import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:staffin_softwares/app/app_widgets/custom_appBar.dart';
import '../../../app_constants/app_colors.dart';
import '../../../app_widgets/custom_roaster_button.dart';
import '../controllers/home_controller.dart';

class ShowRosterHistoryView extends GetView<HomeController> {
  const ShowRosterHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(HomeController());
    return Scaffold(
      body:
      /// Roaster History list
      SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomAppBar(title: 'Roaster History'),
              /*Expanded(
                child: ListView.builder(
                  // physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 2,
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
                              Row(
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
                                      SizedBox(height: 8,),
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
                                      SizedBox(height: 8,),
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
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      CustomRoasterButton(
                                          text: 'Accepted',
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
                                      SizedBox(height: 20,),
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
              )*/
              Obx(() {
                print('Inside Obx builder...');
                print('Data length: ${controller.rosterHistoryModels.value.data?.length ?? 0}');
                final data = controller.rosterHistoryModels.value.data;
                if(data != null && data.isNotEmpty){
                      return Expanded(
                    child: ListView.builder(
                      // physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data.length,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Rego: ${data[index].rego!}',
                                            style: TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xFF383838),
                                                letterSpacing: 0.7
                                            ),),
                                          SizedBox(height: 8,),
                                          Text(
                                            'Date: ${DateFormat('dd MMM, yyyy').format(data[index].date!)}',
                                            // '25 August, 2000',
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xFF626262),
                                                letterSpacing: -0.3
                                            ),
                                          ),
                                          SizedBox(height: 5,),
                                          Text(
                                            'Time: ${data[index].startTime!} - ${data[index].endTime!}',
                                            style: TextStyle(
                                                fontFamily: 'Lato',
                                                fontSize: 14,
                                                fontWeight: FontWeight.normal,
                                                color: Color(0xFF626262),
                                                letterSpacing: -0.3
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          CustomRoasterButton(
                                              text: data[index].status == 0? 'Accepted': 'Rejected',
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
                                          SizedBox(height: 20,),

                                        ],
                                      ),
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
                  );
                } else{
                  return Expanded(
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
                            Text('No Roster History available...',
                              style: TextStyle(
                                  fontFamily: 'Lato',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 18,
                                  color: Color(0xFF9095A0)
                              ),
                            ),
                            // SizedBox(height: 40,),
                            // CustomSolidButton(
                            //     text: 'Show History',
                            //     onTap: () {
                            //       Get.to(() => ShowRosterHistoryView());
                            //     }
                            // )
                          ],
                        ),
                      ),
                    ),
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }

}