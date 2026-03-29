import 'package:get/get.dart';
import '../../modules/dashboard/dashboard_controller.dart';
import '../../modules/rating/rating_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => DashboardController());
    Get.lazyPut(() => RatingController());
  }
}
