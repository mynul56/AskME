import 'package:get/get.dart';
import '../models/app_models.dart';
import 'auth_service.dart';

/// Stub service. Replace Firestore stubs when Firebase is configured.
class UserService extends GetxService {
  final _auth = Get.find<AuthService>();

  final RxList<Session> sessions = <Session>[].obs;
  final RxList<DailyRating> ratings = <DailyRating>[].obs;

  AppUser? get user => _auth.currentUser.value;

  // ── Usage limit helpers ─────────────────────────────────────────────────
  static const int freeQuestionsPerDay  = 5;
  static const int freePaidQuestionsDay = 50;
  static const int freeFollowUpsPerQ    = 1;

  bool get canAskQuestion {
    if (user == null) return false;
    if (user!.hasFullAccess) return user!.dailyQuestionCount < freePaidQuestionsDay;
    return user!.dailyQuestionCount < freeQuestionsPerDay;
  }

  bool canFollowUp(Session session) {
    if (user == null) return false;
    if (user!.hasFullAccess) return true;
    return session.followUpCount < freeFollowUpsPerQ;
  }

  Future<void> incrementDailyCount() async {
    if (user == null) return;
    final today = DateTime.now();
    final reset = user!.lastResetDate;
    int count = user!.dailyQuestionCount;
    if (reset == null || !_sameDay(reset, today)) count = 0;
    _auth.currentUser.value = user!.copyWith(
      dailyQuestionCount: count + 1,
      lastResetDate: today,
    );
    // TODO: Update Firestore user document
  }

  Future<void> saveSession(Session session) async {
    sessions.insert(0, session);
    // TODO: await FirebaseFirestore.instance.collection('sessions').add(...)
  }

  Future<void> saveDailyRating(DailyRating rating) async {
    ratings.insert(0, rating);
    // TODO: await FirebaseFirestore.instance.collection('ratings').add(...)
  }

  Future<void> loadUserData() async {
    // TODO: Load sessions & ratings from Firestore
    await Future.delayed(const Duration(milliseconds: 300));
    sessions.value = _mockSessions();
  }

  bool _sameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  List<Session> _mockSessions() => [
    Session(
      id: '1',
      userId: 'mock-uid-001',
      situationText: 'Work stress and cognitive load',
      urgencyLevel: 'Active',
      questionnaireAnswers: ['Effortless & Radiant'],
      followUpCount: 3,
      createdAt: DateTime.now(),
      messages: [],
      aiResponse: AiResponse(
        advice: 'Prioritize Mono-Tasking for the next 48 hours.',
        message: 'I value our project\'s momentum, but to deliver my best work, I need to focus on one milestone at a time today.',
        tasks: ['Archive 3 non-essential notifications', '10-minute divergent breathing', 'Define Tomorrow\'s "One Thing"'],
        rawText: '',
      ),
    ),
  ];
}
