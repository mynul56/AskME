import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboarding/bindings/onboarding_binding.dart';
import '../modules/onboarding/views/onboarding_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.splash;

  static final routes = <GetPage<dynamic>>[
    GetPage<dynamic>(name: Routes.splash, page: () => const SplashView(), binding: SplashBinding()),
    GetPage<dynamic>(name: Routes.onboarding, page: () => const OnboardingView(), binding: OnboardingBinding()),
    GetPage<dynamic>(name: Routes.home, page: () => const HomeView(), binding: HomeBinding()),
  ];
}
