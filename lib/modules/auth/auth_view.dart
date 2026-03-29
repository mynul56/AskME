import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    final emailCtrl = TextEditingController();
    final passCtrl  = TextEditingController();
    final passObscure = true.obs;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 40),
          child: Column(
            children: [
              // Logo
              Container(
                width: 64, height: 64,
                decoration: BoxDecoration(
                  color: AppTheme.indigoDark,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.3), blurRadius: 24, offset: const Offset(0, 8))],
                ),
                child: const Icon(Icons.auto_awesome, color: Colors.white, size: 30),
              ),
              const SizedBox(height: 20),
              Obx(() => Text(
                controller.isSignUp.value ? 'Create Account' : 'Cognitive Sanctuary',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: AppTheme.textDark),
                textAlign: TextAlign.center,
              )),
              const SizedBox(height: 8),
              const Text(
                'Enter your personal space of quiet intelligence.',
                style: TextStyle(fontSize: 14, color: AppTheme.textSub),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),

              // Social buttons
              _SocialButton(icon: Icons.apple, label: 'Continue with Apple',   onTap: () {}),
              const SizedBox(height: 10),
              _SocialButton(icon: Icons.g_mobiledata_rounded, label: 'Continue with Google', onTap: () {}),
              const SizedBox(height: 20),

              Row(children: const [
                Expanded(child: Divider()),
                Padding(padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Text('OR EMAIL', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppTheme.textSub, letterSpacing: 1))),
                Expanded(child: Divider()),
              ]),
              const SizedBox(height: 20),

              // Email field
              TextField(
                controller: emailCtrl,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.alternate_email, size: 18),
                  hintText: 'Email address',
                ),
              ),
              const SizedBox(height: 12),

              // Password field
              Obx(() => TextField(
                controller: passCtrl,
                obscureText: passObscure.value,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.lock_outline, size: 18),
                  hintText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(passObscure.value ? Icons.visibility_off : Icons.visibility, size: 18),
                    onPressed: () => passObscure.value = !passObscure.value,
                  ),
                ),
              )),
              const SizedBox(height: 20),

              // Error
              Obx(() => controller.error.value.isNotEmpty
                ? Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(color: Colors.red.shade50, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.red.shade200)),
                    child: Text(controller.error.value, style: TextStyle(color: Colors.red.shade700, fontSize: 13)),
                  )
                : const SizedBox.shrink()),

              // Submit button
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null
                    : () => controller.submit(emailCtrl.text.trim(), passCtrl.text),
                child: controller.isLoading.value
                    ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : Obx(() => Text(controller.isSignUp.value ? 'Create Account →' : 'Sign In →')),
              )),
              const SizedBox(height: 16),
              TextButton(onPressed: () {}, child: const Text('Forgot your password?', style: TextStyle(color: AppTheme.textSub))),
              const SizedBox(height: 8),
              Obx(() => GestureDetector(
                onTap: controller.toggle,
                child: Text.rich(TextSpan(
                  style: const TextStyle(fontSize: 14, color: AppTheme.textSub),
                  children: [
                    TextSpan(text: controller.isSignUp.value ? 'Already have an account? ' : 'New here? '),
                    TextSpan(text: controller.isSignUp.value ? 'Sign In' : 'Create Account',
                      style: const TextStyle(color: AppTheme.indigoDark, fontWeight: FontWeight.w700)),
                  ],
                )),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialButton({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) => OutlinedButton(
    onPressed: onTap,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 20, color: AppTheme.textDark),
        const SizedBox(width: 10),
        Text(label),
      ],
    ),
  );
}
