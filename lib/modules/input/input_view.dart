import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'input_controller.dart';

class InputView extends GetView<InputController> {
  const InputView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
        title: const Text('Cognitive Sanctuary'),
        actions: [const CircleAvatar(radius: 16, backgroundColor: AppTheme.indigoLight, child: Icon(Icons.person, size: 16, color: Colors.white)), const SizedBox(width: 12)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Step progress
            Row(children: List.generate(3, (i) => Expanded(child: Container(
              height: 4, margin: EdgeInsets.only(right: i < 2 ? 6 : 0),
              decoration: BoxDecoration(
                color: i == 0 ? AppTheme.indigoDark : AppTheme.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            )))),
            const SizedBox(height: 20),
            Text('What\'s on your mind?', style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: 8),
            const Text('Describe the situation you\'re navigating. The more context you provide, the better I can assist your clarity.',
                style: TextStyle(fontSize: 14, color: AppTheme.textSub, height: 1.5)),
            const SizedBox(height: 20),
            const Text('DESCRIBE THE CONTEXT', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.borderLight, width: 1.5),
              ),
              child: Column(
                children: [
                  TextField(
                    maxLines: 5,
                    onChanged: (v) => controller.situationCtrl.value = v,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(14),
                      hintText: 'I\'ve been feeling overwhelmed by a project at work. The deadlines are shifting and I\'m not sure if my current strategy is sound...',
                      hintStyle: TextStyle(fontSize: 13, color: AppTheme.textSub, height: 1.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [
                        Icon(Icons.mic_none_rounded, color: AppTheme.textSub, size: 20),
                        SizedBox(width: 10),
                        Icon(Icons.attach_file, color: AppTheme.textSub, size: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Text('HOW URGENT IS THIS?', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            const SizedBox(height: 10),
            Obx(() => GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.95,
              physics: const NeverScrollableScrollPhysics(),
              children: controller.urgencyOptions.map((opt) {
                final sel = controller.urgencyLevel.value == opt;
                return GestureDetector(
                  onTap: () => controller.urgencyLevel.value = opt,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    decoration: BoxDecoration(
                      color: sel ? AppTheme.indigoDark : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: sel ? AppTheme.indigoDark : AppTheme.borderLight, width: 1.5),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(_urgencyIcon(opt), color: sel ? Colors.white : AppTheme.indigoDark, size: 24),
                        const SizedBox(height: 6),
                        Text(opt, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: sel ? Colors.white : AppTheme.textDark)),
                        const SizedBox(height: 2),
                        Text(_urgencySub(opt), style: TextStyle(fontSize: 10, color: sel ? Colors.white70 : AppTheme.textSub), textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                );
              }).toList(),
            )),
            const SizedBox(height: 24),
            const Text('ATMOSPHERE PREFERENCE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
            const SizedBox(height: 10),
            Obx(() => SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: controller.atmosphereOpts.map((opt) {
                  final sel = controller.atmosphere.value == opt;
                  return GestureDetector(
                    onTap: () => controller.atmosphere.value = opt,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                      decoration: BoxDecoration(
                        color: sel ? AppTheme.indigoDark : Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: sel ? AppTheme.indigoDark : AppTheme.borderLight, width: 1.5),
                      ),
                      child: Text(opt, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: sel ? Colors.white : AppTheme.textDark)),
                    ),
                  );
                }).toList(),
              ),
            )),
            const SizedBox(height: 32),
            ElevatedButton(onPressed: controller.proceedToQuestionnaire, child: const Text('Continue →')),
            const SizedBox(height: 12),
            OutlinedButton(onPressed: () => Get.back(), child: const Text('Skip')),
          ],
        ),
      ),
      bottomNavigationBar: _BottomNav(current: 0),
    );
  }

  IconData _urgencyIcon(String opt) {
    switch (opt) {
      case 'Low': return Icons.settings_outlined;
      case 'Active': return Icons.bolt;
      default: return Icons.priority_high;
    }
  }

  String _urgencySub(String opt) {
    switch (opt) {
      case 'Low': return 'Casual reflection';
      case 'Active': return 'Requires focus';
      default: return 'Immediate action';
    }
  }
}

class _BottomNav extends StatelessWidget {
  final int current;
  const _BottomNav({required this.current});
  @override
  Widget build(BuildContext context) => BottomNavigationBar(
    currentIndex: current,
    onTap: (i) {
      const routes = ['/input', '/chat', '/dashboard', '/input'];
      if (i < routes.length) Get.toNamed(routes[i]);
    },
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
      BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
      BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
      BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
    ],
  );
}
