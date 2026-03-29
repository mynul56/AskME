import 'package:get/get.dart';
import '../../data/services/user_service.dart';
import '../../core/constants/app_routes.dart';

class DashboardController extends GetxController {
  final _userService = Get.find<UserService>();

  final RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadData();
  }

  Future<void> _loadData() async {
    isLoading.value = true;
    await _userService.loadUserData();
    isLoading.value = false;
  }

  List get sessions => _userService.sessions;

  String get greetingName => _userService.user?.displayName ?? 'Friend';

  void newSession() => Get.toNamed(AppRoutes.input);
  void openRating()  => Get.toNamed(AppRoutes.rating);
  void openPaywall() => Get.toNamed(AppRoutes.paywall);
  void openSession(int index) {
    if (index < _userService.sessions.length) {
      Get.toNamed(AppRoutes.aiResponse);
    }
  }
}
