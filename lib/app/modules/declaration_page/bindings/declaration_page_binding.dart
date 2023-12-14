import 'package:get/get.dart';

import '../controllers/declaration_page_controller.dart';

class DeclarationPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DeclarationPageController>(
      () => DeclarationPageController(),
    );
  }
}
