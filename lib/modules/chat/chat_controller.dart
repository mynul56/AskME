import 'package:get/get.dart';
import '../../data/models/app_models.dart';
import '../../data/services/ai_service.dart';
import '../../data/services/user_service.dart';
import '../../core/constants/app_routes.dart';

class ChatController extends GetxController {
  final _aiService   = Get.find<AiService>();
  final _userService = Get.find<UserService>();

  final RxList<ChatMessage> messages  = <ChatMessage>[].obs;
  final RxBool isTyping               = false.obs;
  final RxInt  followUpCount          = 0.obs;

  Session? _session;

  @override
  void onInit() {
    super.onInit();
    // Seed with first session's messages if available
    if (_userService.sessions.isNotEmpty) {
      _session = _userService.sessions.first;
      final r = _session!.aiResponse;
      if (r != null) {
        messages.addAll([
          ChatMessage(role: 'user', content: _session!.situationText),
          ChatMessage(role: 'assistant', content: r.advice),
        ]);
      }
      followUpCount.value = _session!.followUpCount;
    }
  }

  bool get canFollowUp =>
      _session != null ? _userService.canFollowUp(_session!) : true;

  Future<void> send(String text) async {
    if (text.trim().isEmpty) return;

    if (!canFollowUp) {
      Get.toNamed(AppRoutes.paywall);
      return;
    }

    messages.add(ChatMessage(role: 'user', content: text));
    isTyping.value = true;

    final reply = await _aiService.sendMessage(messages.toList());

    messages.add(ChatMessage(role: 'assistant', content: reply));
    isTyping.value = false;
    followUpCount.value++;
  }
}
