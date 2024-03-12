import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:staffin_softwares/app/modules/auth_page/controllers/auth_page_controller.dart';
import 'package:staffin_softwares/app/modules/home/bindings/home_binding.dart';
import 'package:staffin_softwares/app/modules/home/views/home_view.dart';
import '../../../app_constants/app_strings.dart';
import '../../../app_widgets/custom_appBar.dart';
import '../../../app_widgets/custom_solid_button.dart';
import '../controllers/daily_login_page_controller.dart';
import '../../declaration_page/controllers/declaration_page_controller.dart';

class DailyLoginPageView extends GetView<DailyLoginPageController> {
  const DailyLoginPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(DailyLoginPageController());
    Get.put(DeclarationPageController());
    AuthPageController loginController = Get.put(AuthPageController());
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: SafeArea(
          child: Column(
            children: [
              CustomAppBar(title: 'Daily Login'),
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
                  itemCount: controller.dailyLoginItems.length,
                  itemBuilder: (context, index) {
                    var item = controller.dailyLoginItems[index];
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
              CustomSolidButton(
                  text: AppString.saveButtonText,
                  onTap: () {
                    Get.to(() => HomeView(), binding: HomeBinding());
                    print('Daily Login Details Saved successfully------------');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
