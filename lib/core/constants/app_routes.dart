import 'package:get/get.dart';
import '../../modules/welcome/welcome_view.dart';
import '../../modules/auth/auth_view.dart';
import '../../modules/input/input_view.dart';
import '../../modules/questionnaire/questionnaire_view.dart';
import '../../modules/ai_response/ai_response_view.dart';
import '../../modules/chat/chat_view.dart';
import '../../modules/paywall/paywall_view.dart';
import '../../modules/rating/rating_view.dart';
import '../../modules/dashboard/dashboard_view.dart';
import '../bindings/auth_binding.dart';
import '../bindings/session_binding.dart';
import '../bindings/dashboard_binding.dart';

class AppRoutes {
  AppRoutes._();

  static const String welcome      = '/';
  static const String auth         = '/auth';
  static const String input        = '/input';
  static const String questionnaire= '/questionnaire';
  static const String aiResponse   = '/ai-response';
  static const String chat         = '/chat';
  static const String paywall      = '/paywall';
  static const String rating       = '/rating';
  static const String dashboard    = '/dashboard';

  static List<GetPage> get pages => [
    GetPage(name: welcome,       page: () => const WelcomeView()),
    GetPage(name: auth,          page: () => const AuthView(),         binding: AuthBinding()),
    GetPage(name: input,         page: () => const InputView(),        binding: SessionBinding()),
    GetPage(name: questionnaire, page: () => const QuestionnaireView()),
    GetPage(name: aiResponse,    page: () => const AiResponseView()),
    GetPage(name: chat,          page: () => const ChatView()),
    GetPage(name: paywall,       page: () => const PaywallView()),
    GetPage(name: rating,        page: () => const RatingView()),
    GetPage(name: dashboard,     page: () => const DashboardView(),    binding: DashboardBinding()),
  ];
}
