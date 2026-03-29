import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'questionnaire_controller.dart';

class QuestionnaireView extends GetView<QuestionnaireController> {
  const QuestionnaireView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
        title: const Text('Cognitive Sanctuary'),
        actions: [const CircleAvatar(radius: 16, backgroundColor: AppTheme.indigoLight, child: Icon(Icons.person, size: 16, color: Colors.white)), const SizedBox(width: 12)],
      ),
      body: Obx(() {
        final q = controller.currentQ;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('STEP ${controller.currentStep.value + 1} OF ${controller.totalSteps}',
                      style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Expanded(child: Text('Daily Resonance', style: Theme.of(context).textTheme.headlineMedium)),
                      Text('${(controller.progress * 100).round()}%',
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.indigoDark)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(3),
                    child: LinearProgressIndicator(
                      value: controller.progress,
                      backgroundColor: AppTheme.borderLight,
                      color: AppTheme.indigoDark,
                      minHeight: 5,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(q.title, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: AppTheme.textDark, height: 1.4)),
                  const SizedBox(height: 6),
                  Text(q.hint, style: const TextStyle(fontSize: 13, color: AppTheme.textSub)),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: GetBuilder<QuestionnaireController>(
                builder: (ctrl) => ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: q.options.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 10),
                  itemBuilder: (context, i) {
                    final selected = ctrl.selectedIndex == i;
                    return GestureDetector(
                      onTap: () => ctrl.selectOption(i),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: selected ? AppTheme.indigoDark : Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(color: selected ? AppTheme.indigoDark : AppTheme.borderLight, width: 1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: 40, height: 40,
                              decoration: BoxDecoration(
                                color: selected ? Colors.white.withValues(alpha: 0.15) : AppTheme.offWhite,
                                shape: BoxShape.circle,
                              ),
                              child: Icon(_optionIcon(i), color: selected ? Colors.white : AppTheme.indigoDark),
                            ),
                            const SizedBox(width: 12),
                            Expanded(child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(q.options[i], style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: selected ? Colors.white : AppTheme.textDark)),
                                const SizedBox(height: 2),
                                Text(q.subTexts[i], style: TextStyle(fontSize: 12, color: selected ? Colors.white70 : AppTheme.textSub)),
                              ],
                            )),
                            Container(
                              width: 24, height: 24,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected ? Colors.white : Colors.transparent,
                                border: Border.all(color: selected ? Colors.transparent : AppTheme.borderLight, width: 2),
                              ),
                              child: selected ? const Icon(Icons.check, size: 14, color: AppTheme.indigoDark) : null,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(child: OutlinedButton(onPressed: controller.previous, child: const Text('← Previous'))),
                  const SizedBox(width: 12),
                  Expanded(flex: 2, child: ElevatedButton(onPressed: controller.next, child: const Text('Continue →'))),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }

  IconData _optionIcon(int i) {
    const icons = [Icons.wb_sunny_outlined, Icons.cloud_outlined, Icons.blur_on, Icons.loop];
    return i < icons.length ? icons[i] : Icons.circle_outlined;
  }
}
