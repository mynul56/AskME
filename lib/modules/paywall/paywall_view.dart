import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_routes.dart';

class PaywallView extends StatelessWidget {
  const PaywallView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.close), onPressed: () => Get.back()),
        title: const Text('Upgrade'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Hero
            const Text('👑', style: TextStyle(fontSize: 52)),
            const SizedBox(height: 12),
            RichText(text: const TextSpan(
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: AppTheme.textDark, height: 1.2),
              children: [
                TextSpan(text: 'Unlock the Full\n'),
                TextSpan(text: 'Sanctuary', style: TextStyle(color: AppTheme.indigoDark)),
              ],
            ), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            const Text('Remove all limits and access the complete cognitive intelligence suite.',
                style: TextStyle(fontSize: 14, color: AppTheme.textSub, height: 1.5), textAlign: TextAlign.center),
            const SizedBox(height: 20),

            // Trial banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [Color(0xFFFEF3C7), Color(0xFFFDE68A)]),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppTheme.goldAccent),
              ),
              child: const Text('🎁  7-Day Free Trial included', textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w700, color: Color(0xFF92400E))),
            ),
            const SizedBox(height: 20),

            // Plan comparison
            Row(
              children: [
                // Free plan
                Expanded(child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: AppTheme.borderLight, width: 1.5),
                  ),
                  child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Free', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: AppTheme.textDark)),
                    SizedBox(height: 12),
                    _PlanFeature(text: '5 questions/day', included: true),
                    _PlanFeature(text: '1 follow-up only', included: true),
                    _PlanFeature(text: 'No task export', included: false),
                    _PlanFeature(text: 'No history', included: false),
                    SizedBox(height: 12),
                    Text('\$0', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: AppTheme.indigoDark)),
                  ]),
                )),
                const SizedBox(width: 10),

                // Pro plan
                Expanded(child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(16, 30, 16, 16),
                      decoration: BoxDecoration(
                        color: AppTheme.indigoDark,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.25), blurRadius: 24, offset: const Offset(0, 8))],
                      ),
                      child: const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Pro', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: Colors.white)),
                        SizedBox(height: 12),
                        _PlanFeatureDark(text: '50 questions/day'),
                        _PlanFeatureDark(text: 'Unlimited follow-ups'),
                        _PlanFeatureDark(text: 'Full task export'),
                        _PlanFeatureDark(text: 'Full history access'),
                        SizedBox(height: 12),
                        Text.rich(TextSpan(children: [
                          TextSpan(text: '\$9.99', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white)),
                          TextSpan(text: '/mo', style: TextStyle(fontSize: 13, color: Colors.white60)),
                        ])),
                      ]),
                    ),
                    Positioned(
                      top: -12, left: 0, right: 0,
                      child: Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(color: AppTheme.goldAccent, borderRadius: BorderRadius.circular(20)),
                          child: const Text('MOST POPULAR', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w800, letterSpacing: 1, color: Color(0xFF1A1A2E))),
                        ),
                      ),
                    ),
                  ],
                )),
              ],
            ),
            const SizedBox(height: 28),

            ElevatedButton(
              onPressed: () => Get.offAllNamed(AppRoutes.dashboard),
              child: const Text('Start Free Trial → Subscribe'),
            ),
            const SizedBox(height: 12),
            const Text('🔒  Secure payment · Cancel anytime via App Store',
                style: TextStyle(fontSize: 11, color: AppTheme.textSub), textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

class _PlanFeature extends StatelessWidget {
  final String text;
  final bool included;
  const _PlanFeature({required this.text, required this.included});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      Icon(included ? Icons.check_circle : Icons.cancel, size: 14, color: included ? AppTheme.indigoDark : Colors.grey.shade400),
      const SizedBox(width: 6),
      Expanded(child: Text(text, style: TextStyle(fontSize: 12, color: included ? AppTheme.textDark : Colors.grey.shade400,
          decoration: included ? null : TextDecoration.lineThrough))),
    ]),
  );
}

class _PlanFeatureDark extends StatelessWidget {
  final String text;
  const _PlanFeatureDark({required this.text});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(children: [
      const Icon(Icons.check_circle, size: 14, color: Colors.white70),
      const SizedBox(width: 6),
      Expanded(child: Text(text, style: const TextStyle(fontSize: 12, color: Colors.white))),
    ]),
  );
}
