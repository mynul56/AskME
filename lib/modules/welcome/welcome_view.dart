import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_routes.dart';

class WelcomeView extends StatelessWidget {
  const WelcomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero image area
              Container(
                height: 220,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF1A1A2E), Color(0xFF16213E), Color(0xFF0F3460)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    // Decorative orb
                    Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [
                          AppTheme.indigoXL.withValues(alpha: 0.7),
                          AppTheme.indigoDark.withValues(alpha: 0.3),
                          Colors.transparent,
                        ]),
                      ),
                    ),
                    const Icon(Icons.auto_awesome, size: 56, color: Colors.white70),
                    Positioned(
                      bottom: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 7, height: 7,
                              decoration: const BoxDecoration(color: Color(0xFF4ADE80), shape: BoxShape.circle),
                            ),
                            const SizedBox(width: 8),
                            const Text('SYSTEM ONLINE',
                                style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700, letterSpacing: 1.5)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                decoration: BoxDecoration(
                  color: AppTheme.indigoDark.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text('THE COGNITIVE SANCTUARY',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: AppTheme.indigoDark, letterSpacing: 2)),
              ),
              const SizedBox(height: 14),
              RichText(
                text: const TextSpan(
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: AppTheme.textDark, height: 1.1),
                  children: [
                    TextSpan(text: 'Intelligence,\n'),
                    TextSpan(text: 'Refined.', style: TextStyle(color: AppTheme.indigoDark)),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              const Text(
                'Step into a workspace where AI doesn\'t just respond—it understands. A professional concierge for the high-end digital era.',
                style: TextStyle(fontSize: 14, color: AppTheme.textSub, height: 1.6),
              ),
              const SizedBox(height: 24),
              _FeatureTile(icon: Icons.memory_rounded, title: 'Context Aware', sub: 'Deep semantic memory for seamless workflows.'),
              const SizedBox(height: 14),
              _FeatureTile(icon: Icons.lock_rounded, title: 'Vault Secure', sub: 'End-to-end encryption for your intellectual property.'),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Get.toNamed(AppRoutes.auth),
                child: const Text('Get Started →'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Get.toNamed(AppRoutes.auth),
                child: const Text('Learn More'),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  _stackedAvatars(),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text.rich(TextSpan(
                      style: TextStyle(fontSize: 12, color: AppTheme.textSub),
                      children: [
                        TextSpan(text: 'Join '),
                        TextSpan(text: '12k+ ', style: TextStyle(fontWeight: FontWeight.w700, color: AppTheme.textDark)),
                        TextSpan(text: 'professionals using Sanctuary.'),
                      ],
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _stackedAvatars() {
    final colors = [AppTheme.indigoDark, AppTheme.indigoLight, AppTheme.indigoXL];
    return SizedBox(
      width: 72,
      height: 32,
      child: Stack(
        children: List.generate(3, (i) => Positioned(
          left: i * 20.0,
          child: CircleAvatar(radius: 16, backgroundColor: colors[i],
              child: Icon(Icons.person, size: 16, color: Colors.white.withValues(alpha: 0.8))),
        )),
      ),
    );
  }
}

class _FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String sub;
  const _FeatureTile({required this.icon, required this.title, required this.sub});

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Icon(icon, size: 22, color: AppTheme.indigoDark),
      const SizedBox(width: 12),
      Expanded(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
          const SizedBox(height: 2),
          Text(sub, style: const TextStyle(fontSize: 12, color: AppTheme.textSub)),
        ],
      )),
    ],
  );
}
