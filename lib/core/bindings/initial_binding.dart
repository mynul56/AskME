import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../data/services/user_service.dart';
import '../../data/services/ai_service.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(UserService(), permanent: true);
    Get.put(AiService(), permanent: true);
  }
}
