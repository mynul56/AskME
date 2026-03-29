import 'package:get/get.dart';
import '../models/app_models.dart';

/// Stub service. Replace method bodies with Firebase Auth calls once
/// google-services.json / GoogleService-Info.plist are added.
class AuthService extends GetxService {
  final Rx<AppUser?> currentUser = Rx<AppUser?>(null);
  bool get isLoggedIn => currentUser.value != null;

  Future<void> signInWithEmail(String email, String password) async {
    // TODO: FirebaseAuth.instance.signInWithEmailAndPassword(...)
    await Future.delayed(const Duration(seconds: 1));
    currentUser.value = AppUser(
      uid: 'mock-uid-001',
      email: email,
      displayName: 'Alex',
      trialStartDate: DateTime.now(),
    );
  }

  Future<void> signUpWithEmail(String email, String password) async {
    // TODO: FirebaseAuth.instance.createUserWithEmailAndPassword(...)
    await Future.delayed(const Duration(seconds: 1));
    currentUser.value = AppUser(
      uid: 'mock-uid-001',
      email: email,
      displayName: email.split('@').first,
      trialStartDate: DateTime.now(),
    );
  }

  Future<void> signOut() async {
    // TODO: FirebaseAuth.instance.signOut();
    currentUser.value = null;
  }
}
