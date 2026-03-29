import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class OnboardingController extends GetxController {
  void onGetStarted() {
    Get.toNamed(Routes.home);
  }

  void onSignIn() {
    Get.snackbar(
      'Sign In',
      'Sign in flow can be connected here.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }
}
