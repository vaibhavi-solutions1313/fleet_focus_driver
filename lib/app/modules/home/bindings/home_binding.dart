import 'package:get/get.dart';
import '../../create_job/controllers/create_job_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
    Get.lazyPut<CreateJobController>(
          () => CreateJobController(),
    );
    Get.lazyPut<CreateJobController>(()=>CreateJobController());
  }
}
