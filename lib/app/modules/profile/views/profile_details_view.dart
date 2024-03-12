import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:staffin_softwares/app/app_services/services.dart';
import 'package:staffin_softwares/app/modules/auth_page/bindings/auth_page_binding.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/auth_page_controller.dart';
import 'package:staffin_softwares/app/modules/auth_page/views/auth_page_view.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../../declaration_page/controllers/declaration_page_controller.dart';
import '../controllers/profile_controller.dart';

class ProfileDetailsPageView extends GetView<ProfileController> {
  const ProfileDetailsPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(ProfileController());
    Get.put(DeclarationPageController());
    AuthPageController authPageController = Get.put(AuthPageController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'Profile'),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16.0,
                    mainAxisSpacing: 16.0,
                  ),
                  itemCount: controller.profileDetailsList.length,
                  itemBuilder: (context, index) {
                    var item = controller.profileDetailsList[index];
                    return item;
                    //   GridItem(
                    //   image: item.image,
                    //   title: item.title,
                    //   subtitle: item.subtitle,
                    //   icon: item.icon,
                    //   onTap: () {
                    //     CustomBottomSheet.show(
                    //       DeclarationPageView(),
                    //     );
                    //
                    //     print('Tapped on item $index');
                    //   },
                    // );
                  },
                ),

              ),
              CustomSolidButton(text: AppString.saveButtonText,
                  onTap: (){
                // if(authPageController.getRegisterUser()) {
                    Get.to(() => AuthPageView(), binding: AuthPageBinding());
                  AppServices().showToastMessage(
                      toastMessage: 'Registration successfully completed...!');
                  print('Daily Login Details Saved successfully------------');
                // }
              }),
            ],
          ),
        ),
      ),
    );
  }
}