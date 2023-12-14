import 'package:get/get.dart';

import '../controllers/term_and_condition_controller.dart';

class TermAndConditionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TermAndConditionController>(
      () => TermAndConditionController(),
    );
  }
}
