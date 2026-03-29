import 'package:get/get.dart';
import '../../modules/input/input_controller.dart';
import '../../modules/questionnaire/questionnaire_controller.dart';
import '../../modules/ai_response/ai_response_controller.dart';
import '../../modules/chat/chat_controller.dart';

class SessionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InputController());
    Get.lazyPut(() => QuestionnaireController());
    Get.lazyPut(() => AiResponseController());
    Get.lazyPut(() => ChatController());
  }
}
