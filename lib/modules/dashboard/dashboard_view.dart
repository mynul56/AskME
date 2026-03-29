import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_routes.dart';
import 'dashboard_controller.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {}),
        title: const Text('Dashboard'),
        actions: [const CircleAvatar(radius: 16, backgroundColor: AppTheme.indigoLight, child: Icon(Icons.person, size: 16, color: Colors.white)), const SizedBox(width: 12)],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: AppTheme.indigoDark));
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting row
              Row(
                children: [
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    const Text('Good afternoon', style: TextStyle(fontSize: 12, color: AppTheme.textSub)),
                    Text('Welcome back, ${controller.greetingName} 👋',
                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                  ])),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFF7ED),
                      border: Border.all(color: const Color(0xFFFED7AA)),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text('🔥 7-day streak', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFFC2410C))),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Stats
              Row(children: [
                Expanded(child: _StatCard(num: '24', label: 'Questions Asked', highlight: true)),
                const SizedBox(width: 8),
                Expanded(child: _StatCard(num: '82%', label: 'Avg. Harmony')),
                const SizedBox(width: 8),
                Expanded(child: GestureDetector(
                  onTap: controller.openPaywall,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(colors: [AppTheme.indigoDark, AppTheme.indigoXL]),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Column(children: [
                      Text('PRO', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w800, color: Colors.white)),
                      SizedBox(height: 4),
                      Text('Active', style: TextStyle(fontSize: 10, color: Colors.white60, fontWeight: FontWeight.w600)),
                    ]),
                  ),
                )),
              ]),
              const SizedBox(height: 20),

              // Chart
              const Text('WEEKLY MOOD CHART', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.06), blurRadius: 12)]),
                child: SizedBox(height: 90, child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    _Bar('M', 0.55), _Bar('T', 0.80), _Bar('W', 0.40),
                    _Bar('T', 0.90), _Bar('F', 0.65), _Bar('S', 0.82, active: true), _Bar('S', 0.30),
                  ].map((w) => Expanded(child: w)).toList(),
                )),
              ),
              const SizedBox(height: 20),

              // Sessions list
              const Text('RECENT SESSIONS', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1)),
              const SizedBox(height: 10),
              Obx(() => controller.sessions.isEmpty
                ? Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
                    child: const Column(children: [
                      Icon(Icons.auto_awesome, size: 40, color: AppTheme.indigoXL),
                      SizedBox(height: 12),
                      Text('Your AI journey starts here.', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                      Text('Ask your first question!', style: TextStyle(fontSize: 13, color: AppTheme.textSub)),
                    ]),
                  )
                : Column(
                    children: controller.sessions.asMap().entries.map((e) => _SessionCard(
                      session: e.value,
                      onTap: () => controller.openSession(e.key),
                    )).toList(),
                  )),
              const SizedBox(height: 16),
              ElevatedButton(onPressed: controller.newSession, child: const Text('+ New Session')),
              const SizedBox(height: 12),
              OutlinedButton(onPressed: controller.openRating, child: const Text('Rate Today →')),
              const SizedBox(height: 16),
            ],
          ),
        );
      }),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (i) {
          const routes = [AppRoutes.dashboard, AppRoutes.chat, AppRoutes.aiResponse, AppRoutes.input];
          if (i < routes.length) Get.toNamed(routes[i]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline_rounded), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.history_rounded), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_outlined), label: 'Settings'),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String num, label;
  final bool highlight;
  const _StatCard({required this.num, required this.label, this.highlight = false});
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.06), blurRadius: 8)]),
    child: Column(children: [
      Text(num, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900, color: highlight ? AppTheme.indigoDark : AppTheme.textDark)),
      const SizedBox(height: 4),
      Text(label, style: const TextStyle(fontSize: 10, color: AppTheme.textSub, fontWeight: FontWeight.w600), textAlign: TextAlign.center),
    ]),
  );
}

class _Bar extends StatelessWidget {
  final String day;
  final double ratio;
  final bool active;
  const _Bar(this.day, this.ratio, {this.active = false});
  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      Flexible(child: FractionallySizedBox(
        heightFactor: ratio,
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 3),
          decoration: BoxDecoration(
            color: active ? AppTheme.indigoDark : AppTheme.offWhite,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
          ),
        ),
      )),
      const SizedBox(height: 4),
      Text(day, style: const TextStyle(fontSize: 10, color: AppTheme.textSub, fontWeight: FontWeight.w600)),
    ],
  );
}

class _SessionCard extends StatelessWidget {
  final dynamic session;
  final VoidCallback onTap;
  const _SessionCard({required this.session, required this.onTap});
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.06), blurRadius: 8)]),
      child: Row(children: [
        Container(width: 10, height: 10, decoration: const BoxDecoration(color: AppTheme.indigoDark, shape: BoxShape.circle)),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(session.situationText.length > 30 ? '${session.situationText.substring(0, 30)}...' : session.situationText,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 2),
          Text('${session.followUpCount} follow-ups · ${session.urgencyLevel}',
              style: const TextStyle(fontSize: 11, color: AppTheme.textSub)),
        ])),
        const Icon(Icons.arrow_forward_ios, size: 14, color: AppTheme.indigoDark),
      ]),
    ),
  );
}
