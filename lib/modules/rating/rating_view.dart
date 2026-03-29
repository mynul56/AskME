import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'rating_controller.dart';

class RatingView extends GetView<RatingController> {
  const RatingView({super.key});

  @override
  Widget build(BuildContext context) {
    final noteCtrl = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
        title: const Text('Daily Check-in'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Text('🌙', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            Text('End-of-Day\nResonance', style: Theme.of(context).textTheme.headlineMedium, textAlign: TextAlign.center),
            const SizedBox(height: 8),
            const Text('How aligned did you feel today?', style: TextStyle(fontSize: 14, color: AppTheme.textSub)),
            const SizedBox(height: 28),

            const Align(alignment: Alignment.centerLeft,
              child: Text('TODAY\'S OVERALL RATING', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            ),
            const SizedBox(height: 12),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) => GestureDetector(
                onTap: () => controller.setStar(i + 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    i < controller.starRating.value ? Icons.star_rounded : Icons.star_border_rounded,
                    color: i < controller.starRating.value ? AppTheme.goldAccent : AppTheme.borderLight,
                    size: 40,
                  ),
                ),
              )),
            )),
            const SizedBox(height: 24),

            const Align(alignment: Alignment.centerLeft,
              child: Text('EMOJI MOOD', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            ),
            const SizedBox(height: 12),
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: controller.emojis.map((e) => GestureDetector(
                onTap: () => controller.setEmoji(e),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 150),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: controller.moodEmoji.value == e ? AppTheme.offWhite : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(e, style: TextStyle(fontSize: controller.moodEmoji.value == e ? 34 : 28)),
                ),
              )).toList(),
            )),
            const SizedBox(height: 24),

            const Align(alignment: Alignment.centerLeft,
              child: Text('NOTES (OPTIONAL)', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: noteCtrl,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: 'What stood out today? Any breakthroughs or friction points?',
                hintStyle: TextStyle(fontSize: 13, color: AppTheme.textSub, height: 1.5),
                contentPadding: EdgeInsets.all(14),
              ),
            ),
            const SizedBox(height: 32),
            Obx(() => ElevatedButton(
              onPressed: controller.isSaving.value ? null : () => controller.save(noteCtrl.text),
              child: controller.isSaving.value
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Text('Save Day\'s Entry →'),
            )),
          ],
        ),
      ),
    );
  }
}
