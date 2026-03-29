import 'dart:async';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class SplashController extends GetxController {
  final progress = 0.0.obs;

  Timer? _timer;
  static const _step = 0.03;
  static const _interval = Duration(milliseconds: 70);

  @override
  void onInit() {
    super.onInit();
    _startBootSequence();
  }

  void _startBootSequence() {
    _timer = Timer.periodic(_interval, (timer) {
      final next = (progress.value + _step).clamp(0.0, 1.0);
      progress.value = next;

      if (next >= 1.0) {
        timer.cancel();
        Get.offAllNamed(Routes.onboarding);
      }
    });
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
