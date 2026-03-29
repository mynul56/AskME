import 'package:get/get.dart';
import '../../data/services/auth_service.dart';
import '../../core/constants/app_routes.dart';

class AuthController extends GetxController {
  final _auth = Get.find<AuthService>();

  final RxBool isLoading  = false.obs;
  final RxBool isSignUp   = false.obs;
  final RxString error    = ''.obs;

  Future<void> submit(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      error.value = 'Please fill all fields.';
      return;
    }
    isLoading.value = true;
    error.value = '';
    try {
      if (isSignUp.value) {
        await _auth.signUpWithEmail(email, password);
      } else {
        await _auth.signInWithEmail(email, password);
      }
      Get.offAllNamed(AppRoutes.dashboard);
    } catch (e) {
      error.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void toggle() {
    isSignUp.value = !isSignUp.value;
    error.value = '';
  }
}
