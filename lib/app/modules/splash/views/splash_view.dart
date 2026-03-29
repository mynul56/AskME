import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  static const _bgTop = Color(0xFFF8F9FA);
  static const _primary = Color(0xFF000666);
  static const _primaryContainer = Color(0xFF1A237E);
  static const _tertiaryContainer = Color(0xFF5C1800);
  static const _textMain = Color(0xFF191C1D);
  static const _textMuted = Color(0xFF6C6F7B);
  static const _line = Color(0xFFC6C5D4);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bgTop,
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: MediaQuery.of(context).size.height * 0.46,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  'https://lh3.googleusercontent.com/aida-public/AB6AXuBWtAnMox543GTqu9M7QaZODhsElpxqvFpCjx8ZXOp38Gmek3jmPg8AXYELDYDwj4EIICEqY1BbkuN8BG-UvGVvkfAF5RTn2wLtWK0jsyT4LdZey9QQbWuvRu2p_vgj30qn0tDtg5zhgGdTQaHyacLKc5bHheUygBSVWQJvbbhF-d59ufaFSzlG7Oxhgs0Q_DRH5zeQbioQlAtknZ5G09db4DWl0pmC3QTksv2ZaWcfW1XqbgCVA-IU1l3M6B85MU5Wf1Gtn149oN8o',
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xFFD5D8DD), Color(0xFF283850)],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [_bgTop, Color(0xCCF8F9FA), Color(0x11F8F9FA)],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 2),
                  _LogoCluster(),
                  const SizedBox(height: 30),
                  const Text(
                    'Ethereal\nIntelligence',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: _textMain,
                      fontSize: 56,
                      fontWeight: FontWeight.w800,
                      height: 0.95,
                      letterSpacing: -1.0,
                    ),
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'THE SILENT CONCIERGE',
                    style: TextStyle(color: _textMuted, fontSize: 12, letterSpacing: 6, fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 34),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F5F7),
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0xFFE4E6EA)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.verified_user_outlined, color: _primary, size: 18),
                        SizedBox(width: 10),
                        Text(
                          'ENCRYPTED NEURAL LINK',
                          style: TextStyle(color: _textMuted, fontSize: 12, letterSpacing: 2.2, fontWeight: FontWeight.w800),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(child: Divider(color: _line, thickness: 1, endIndent: 18)),
                      Text(
                        'SYSTEM STATUS: OPTIMAL',
                        style: TextStyle(color: _textMuted, fontSize: 11, letterSpacing: 4, fontWeight: FontWeight.w800),
                      ),
                      Expanded(child: Divider(color: _line, thickness: 1, indent: 18)),
                    ],
                  ),
                  const SizedBox(height: 38),
                  SizedBox(
                    width: 180,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Obx(
                        () => LinearProgressIndicator(
                          value: controller.progress.value,
                          minHeight: 6,
                          backgroundColor: const Color(0xFFE8EAEE),
                          valueColor: const AlwaysStoppedAnimation<Color>(_primary),
                        ),
                      ),
                    ),
                  ),
                  const Spacer(flex: 5),
                  const Text(
                    'EDITION NO. 001\nLONDON • NEW YORK • TOKYO',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0x8A5E6470),
                      fontSize: 11,
                      letterSpacing: 1.6,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LogoCluster extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 98,
      height: 98,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Center(
            child: Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(color: Color(0x1A1A237E), shape: BoxShape.circle),
            ),
          ),
          Center(
            child: Transform.rotate(
              angle: 0.2,
              child: Container(
                width: 62,
                height: 62,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [SplashView._primary, SplashView._primaryContainer]),
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [BoxShadow(color: Color(0x26191C1D), blurRadius: 24, offset: Offset(0, 10))],
                ),
                child: const Icon(Icons.hub_rounded, color: Colors.white, size: 30),
              ),
            ),
          ),
          Positioned(
            right: 5,
            top: 5,
            child: Container(
              width: 28,
              height: 28,
              decoration: const BoxDecoration(
                color: SplashView._tertiaryContainer,
                shape: BoxShape.circle,
                boxShadow: [BoxShadow(color: Color(0x26191C1D), blurRadius: 16, offset: Offset(0, 6))],
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Color(0xFFE17C5A), size: 14),
            ),
          ),
        ],
      ),
    );
  }
}
