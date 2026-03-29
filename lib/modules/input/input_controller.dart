import 'package:get/get.dart';
import '../../core/constants/app_routes.dart';

class InputController extends GetxController {
  final situationCtrl = RxString('');
  final urgencyLevel  = 'Active'.obs;
  final atmosphere    = 'Zen'.obs;

  final urgencyOptions  = ['Low', 'Active', 'High'];
  final atmosphereOpts  = ['Zen', 'Focus', 'Deep Work'];

  String get builtContext => '''
Situation: ${situationCtrl.value}
Urgency: ${urgencyLevel.value}
Atmosphere: ${atmosphere.value}
''';

  void proceedToQuestionnaire() {
    if (situationCtrl.value.trim().isEmpty) {
      Get.snackbar('Required', 'Please describe your situation before continuing.',
          backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
          colorText: Get.theme.colorScheme.onPrimary);
      return;
    }
    Get.toNamed(AppRoutes.questionnaire);
  }
}
