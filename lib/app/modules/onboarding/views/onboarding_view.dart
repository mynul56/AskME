import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  static const _surface = Color(0xFFF8F9FA);
  static const _onSurface = Color(0xFF191C1D);
  static const _onSurfaceVariant = Color(0xFF454652);
  static const _primary = Color(0xFF000666);
  static const _primaryContainer = Color(0xFF1A237E);
  static const _secondaryContainer = Color(0xFFD2D4FF);
  static const _onSecondaryContainer = Color(0xFF575B7F);
  static const _outlineVariant = Color(0xFFC6C5D4);
  static const _surfaceContainer = Color(0xFFEDEEEF);
  static const _surfaceContainerLowest = Color(0xFFFFFFFF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _surface,
      body: Stack(
        children: [
          Positioned(
            right: -120,
            top: -40,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(colors: [Color(0x261A237E), Color(0x001A237E)]),
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: const BoxDecoration(color: _primaryContainer, shape: BoxShape.circle),
                          child: const Icon(Icons.auto_awesome, color: Colors.white, size: 22),
                        ),
                        const SizedBox(width: 10),
                        const Text(
                          'The Editorial',
                          style: TextStyle(color: _primary, fontSize: 34, fontWeight: FontWeight.w700, letterSpacing: -0.6),
                        ),
                      ],
                    ),
                    const SizedBox(height: 36),
                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          color: _onSurface,
                          fontSize: 62,
                          fontWeight: FontWeight.w800,
                          height: 1.03,
                          letterSpacing: -1.1,
                        ),
                        children: [
                          TextSpan(text: 'Master Your\nInteractions\nwith '),
                          TextSpan(
                            text: 'AI Clarity',
                            style: TextStyle(color: _primaryContainer),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    const Text(
                      'Guided emotional intelligence and structured advice at your fingertips.\n'
                      'Elevate every conversation with the silent concierge for the modern age.',
                      style: TextStyle(color: _onSurfaceVariant, fontSize: 18, height: 1.6, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        key: const Key('onboarding_get_started'),
                        onPressed: controller.onGetStarted,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primaryContainer,
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(64),
                          textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text('Get Started'),
                      ),
                    ),
                    const SizedBox(height: 14),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        key: const Key('onboarding_sign_in'),
                        onPressed: controller.onSignIn,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _secondaryContainer,
                          foregroundColor: _onSecondaryContainer,
                          minimumSize: const Size.fromHeight(64),
                          textStyle: const TextStyle(fontSize: 34, fontWeight: FontWeight.w700),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 0,
                        ),
                        child: const Text('Sign In'),
                      ),
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _statItem('12k+', 'ACTIVE MINDS'),
                        Container(
                          width: 1,
                          height: 42,
                          margin: const EdgeInsets.symmetric(horizontal: 24),
                          color: _outlineVariant.withValues(alpha: 0.35),
                        ),
                        _statItem('4.9/5', 'RELIABILITY'),
                      ],
                    ),
                    const SizedBox(height: 30),
                    _InsightCard(),
                    const SizedBox(height: 40),
                    const Center(
                      child: Text(
                        '© 2024 The Editorial Intelligence. All rights reserved.',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0x7A454652), fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Center(
                      child: Text(
                        'Privacy      Framework      Ethics',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color(0x8A454652), fontSize: 12, height: 1.5, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(color: Color(0xFF676C74), fontSize: 40, fontWeight: FontWeight.w700, letterSpacing: -0.7),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Color(0xFF7C8087), fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 2),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: OnboardingView._surfaceContainer, borderRadius: BorderRadius.circular(28)),
      padding: const EdgeInsets.all(14),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: SizedBox(
          height: 370,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuDOGgcG_EY89j4C2CEM-hwQaihL3qTK5gKLDRln2MawbWws3e_79QMJxmecU750VAm27hp-gX-1ozvZCvOLRLBxYLEoFn_kSCJM0wMqhXDbF6JM1FT44lRniF_pss4m8VnoB1__FL0xsfsTy--BgwuFxQjyoYx3Va3a9EpkrFP4J34AMVkmr2PuPxwAD4Ro5x11NQ_gYZNLhHXOKhSGoudXepsUrEZFG4_O17btOpyz-BYfGx9ZF276IbSafPulZPHHcxMYMEwx2WCQ',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [Color(0xFF080C22), Color(0xFF0D1B52)],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Positioned(
                left: 0,
                top: 22,
                child: Container(
                  width: 238,
                  padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
                  decoration: const BoxDecoration(
                    color: OnboardingView._surfaceContainerLowest,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(42), bottomRight: Radius.circular(42)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'INSIGHT FOUND',
                        style: TextStyle(
                          color: OnboardingView._onSurfaceVariant,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'Clarity of tone\nestablished',
                        style: TextStyle(
                          color: OnboardingView._onSurface,
                          fontSize: 34,
                          fontWeight: FontWeight.w700,
                          height: 1.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: -30,
                bottom: 42,
                child: Container(
                  width: 235,
                  padding: const EdgeInsets.fromLTRB(16, 14, 18, 16),
                  decoration: BoxDecoration(
                    color: OnboardingView._primaryContainer,
                    borderRadius: BorderRadius.circular(22),
                    boxShadow: const [BoxShadow(color: Color(0x332E3132), blurRadius: 20, offset: Offset(0, 8))],
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.psychology_alt_rounded, color: Colors.white, size: 14),
                          SizedBox(width: 8),
                          Text(
                            'COGNITIVE LAYER',
                            style: TextStyle(
                              color: Color(0xCCFFFFFF),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.8,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Adjusting communication\nframework to mirror high-value\neditorial standards.',
                        style: TextStyle(color: Colors.white, fontSize: 13, height: 1.45, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 26,
                top: 14,
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0x30D2D4FF)),
                ),
              ),
              Positioned(
                left: -18,
                bottom: 32,
                child: Container(
                  width: 86,
                  height: 86,
                  decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0x30FFB59D)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
