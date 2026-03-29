import 'package:get/get.dart';
import '../../data/models/app_models.dart';
import '../../data/services/user_service.dart';
import '../../core/constants/app_routes.dart';

class RatingController extends GetxController {
  final _userService = Get.find<UserService>();

  final RxInt    starRating  = 0.obs;
  final RxString moodEmoji   = '🙂'.obs;
  final RxBool   isSaving    = false.obs;

  final emojis = ['😔', '😐', '🙂', '😊', '🤩'];

  void setStar(int star) => starRating.value = star;
  void setEmoji(String emoji) => moodEmoji.value = emoji;

  Future<void> save(String note) async {
    if (starRating.value == 0) {
      Get.snackbar('Rate your day', 'Please select a star rating.',
          backgroundColor: Get.theme.colorScheme.primary.withValues(alpha: 0.9),
          colorText: Get.theme.colorScheme.onPrimary);
      return;
    }
    isSaving.value = true;
    await _userService.saveDailyRating(DailyRating(
      userId: _userService.user?.uid ?? '',
      rating: starRating.value,
      moodEmoji: moodEmoji.value,
      note: note,
      date: DateTime.now(),
    ));
    isSaving.value = false;
    Get.offAllNamed(AppRoutes.dashboard);
  }
}
