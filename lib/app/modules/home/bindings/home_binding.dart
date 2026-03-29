import 'package:get/get.dart';

import '../controllers/dialogcontroller_controller.dart';
import '../controllers/home_controller.dart';
import '../providers/user_provider.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(HomeController.new);
    Get.lazyPut<DialogcontrollerController>(DialogcontrollerController.new);
    Get.lazyPut<UserProvider>(UserProvider.new);
  }
}
