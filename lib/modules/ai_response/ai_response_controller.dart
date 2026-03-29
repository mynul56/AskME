import 'package:get/get.dart';
import '../../data/models/app_models.dart';
import '../../data/services/ai_service.dart';
import '../../data/services/user_service.dart';
import 'package:askme/modules/input/input_controller.dart';
import '../../core/constants/app_routes.dart';

class AiResponseController extends GetxController {
  final _aiService   = Get.find<AiService>();
  final _userService = Get.find<UserService>();

  final Rx<AiResponse?> response  = Rx<AiResponse?>(null);
  final RxBool isLoading          = true.obs;
  final RxString loadingStep      = 'Analysing your context...'.obs;
  final RxList<bool> taskChecked  = <bool>[].obs;

  @override
  void onInit() {
    super.onInit();
    _generateResponse();
  }

  Future<void> _generateResponse() async {
    isLoading.value = true;
    final input = Get.find<InputController>();

    final messages = [
      ChatMessage(role: 'user', content: input.builtContext),
    ];

    await Future.delayed(const Duration(milliseconds: 600));
    loadingStep.value = 'Pattern analysis complete...';
    await Future.delayed(const Duration(milliseconds: 800));
    loadingStep.value = 'Generating insights...';

    final rawText = await _aiService.sendMessage(messages);
    final parsed  = _aiService.parseStructuredResponse(rawText);
    response.value = parsed;
    taskChecked.value = List.filled(parsed.tasks.length, false);

    // Save session
    final session = Session(
      userId: _userService.user?.uid ?? '',
      situationText: input.situationCtrl.value,
      urgencyLevel: input.urgencyLevel.value,
      questionnaireAnswers: [],
      messages: messages,
      aiResponse: parsed,
      createdAt: DateTime.now(),
    );
    await _userService.saveSession(session);
    await _userService.incrementDailyCount();

    isLoading.value = false;
  }

  void toggleTask(int index) {
    taskChecked[index] = !taskChecked[index];
    taskChecked.refresh();
  }

  void goToChat() => Get.toNamed(AppRoutes.chat);
}
