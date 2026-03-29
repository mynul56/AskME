import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'ai_response_controller.dart';

class AiResponseView extends GetView<AiResponseController> {
  const AiResponseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text('Cognitive Sanctuary'),
        actions: [const CircleAvatar(radius: 16, backgroundColor: AppTheme.indigoLight, child: Icon(Icons.person, size: 16, color: Colors.white)), const SizedBox(width: 12)],
      ),
      body: Obx(() {
        if (controller.isLoading.value) return _LoadingView(step: controller.loadingStep.value);
        final r = controller.response.value;
        if (r == null) return const Center(child: Text('No response'));
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('DAILY INSIGHT REPORT', style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1.5)),
              const SizedBox(height: 8),
              RichText(text: const TextSpan(
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.w800, color: AppTheme.textDark, height: 1.2),
                children: [TextSpan(text: 'Your path to clarity\n'), TextSpan(text: 'is evolving.')],
              )),
              const SizedBox(height: 16),

              // Advice card
              _ResponseCard(
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  const Row(children: [
                    Icon(Icons.radio_button_checked, size: 14, color: AppTheme.indigoDark),
                    SizedBox(width: 6),
                    Text('Core Advice', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.indigoDark)),
                  ]),
                  const SizedBox(height: 10),
                  Text(r.advice, style: const TextStyle(fontSize: 13, color: AppTheme.textSub, height: 1.6)),
                  const SizedBox(height: 12),
                  Wrap(spacing: 6, children: ['Cognitive Load', 'Neuroplasticity', 'Focus Mode'].map((t) =>
                    Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(color: AppTheme.offWhite, borderRadius: BorderRadius.circular(20)),
                      child: Text(t, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.indigoDark)),
                    )
                  ).toList()),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Refined by AI Insights 2.4', style: TextStyle(fontSize: 11, color: AppTheme.textSub)),
                      ElevatedButton(
                        onPressed: controller.goToChat,
                        style: ElevatedButton.styleFrom(minimumSize: const Size(0, 36), padding: const EdgeInsets.symmetric(horizontal: 14)),
                        child: const Text('Explore Depth', style: TextStyle(fontSize: 12)),
                      ),
                    ],
                  ),
                ]),
              ),

              // Response Bridge card
              if (r.message.isNotEmpty)
                Container(
                  margin: const EdgeInsets.only(bottom: 14),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(color: AppTheme.indigoDark, borderRadius: BorderRadius.circular(20)),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Row(children: [
                      Icon(Icons.trending_up, size: 14, color: Color(0xFFA5B4FC)),
                      SizedBox(width: 6),
                      Text('Response Bridge', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFA5B4FC))),
                    ]),
                    const SizedBox(height: 10),
                    Text('"${r.message}"', style: const TextStyle(fontSize: 13, color: Colors.white, height: 1.6)),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () {
                        Clipboard.setData(ClipboardData(text: r.message));
                        Get.snackbar('Copied', 'Message copied to clipboard', backgroundColor: AppTheme.indigoLight, colorText: Colors.white);
                      },
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                        ),
                        child: const Center(child: Text('📋  Copy Prompt', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600))),
                      ),
                    ),
                  ]),
                ),

              // Tasks card
              if (r.tasks.isNotEmpty)
                _ResponseCard(
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Row(children: [
                      const Text('✅  Precision Tasks', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: AppTheme.indigoDark)),
                      const Spacer(),
                      Obx(() => Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(color: AppTheme.offWhite, borderRadius: BorderRadius.circular(20)),
                        child: Text('${controller.taskChecked.where((c) => !c).length} REMAINING',
                            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.indigoDark)),
                      )),
                    ]),
                    const SizedBox(height: 12),
                    ...r.tasks.asMap().entries.map((e) => Obx(() => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Checkbox(
                          value: controller.taskChecked[e.key],
                          onChanged: (_) => controller.toggleTask(e.key),
                          activeColor: AppTheme.indigoDark,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                        Expanded(child: Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(e.value,
                            style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600,
                              color: controller.taskChecked[e.key] ? AppTheme.textSub : AppTheme.textDark,
                              decoration: controller.taskChecked[e.key] ? TextDecoration.lineThrough : null,
                            ),
                          ),
                        )),
                      ]),
                    ))),
                  ]),
                ),

              // Harmony score
              Container(
                margin: const EdgeInsets.only(bottom: 80),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 2))]),
                child: Row(children: [
                  Container(
                    width: 70, height: 70,
                    decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppTheme.indigoDark, width: 5)),
                    child: const Center(child: Text('82%', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900, color: AppTheme.indigoDark))),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Cognitive Alignment High', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                    SizedBox(height: 4),
                    Text('You are currently performing 15% better than your 7-day average.', style: TextStyle(fontSize: 12, color: AppTheme.textSub, height: 1.4)),
                  ])),
                ]),
              ),
            ],
          ),
        );
      }),
      bottomNavigationBar: const _ResNav(current: 2),
    );
  }
}

class _ResponseCard extends StatelessWidget {
  final Widget child;
  const _ResponseCard({required this.child});
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.only(bottom: 14),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 2))],
    ),
    child: child,
  );
}

class _LoadingView extends StatelessWidget {
  final String step;
  const _LoadingView({required this.step});
  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
            width: 80, height: 80,
            child: CircularProgressIndicator(color: AppTheme.indigoDark, strokeWidth: 3),
          ),
          const SizedBox(height: 32),
          const Text('Analysing Your Context', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
          const SizedBox(height: 12),
          Text('Sanctuary is synthesising your input with precision intelligence...',
              style: const TextStyle(fontSize: 14, color: AppTheme.textSub, height: 1.5), textAlign: TextAlign.center),
          const SizedBox(height: 28),
          Container(
            padding: const EdgeInsets.all(16), width: double.infinity,
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)]),
            child: Column(children: [
              _LStep(text: '✓  Context processed', done: true),
              const SizedBox(height: 8),
              _LStep(text: '✓  Pattern analysis complete', done: true),
              const SizedBox(height: 8),
              _LStep(text: step, done: false),
            ]),
          ),
        ],
      ),
    ),
  );
}

class _LStep extends StatelessWidget {
  final String text;
  final bool done;
  const _LStep({required this.text, required this.done});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      color: AppTheme.offWhite,
      border: Border(left: BorderSide(color: done ? AppTheme.indigoDark : AppTheme.goldAccent, width: 3)),
    ),
    child: Text(text, style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: done ? AppTheme.indigoDark : AppTheme.textSub)),
  );
}

class _ResNav extends StatelessWidget {
  final int current;
  const _ResNav({required this.current});
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
