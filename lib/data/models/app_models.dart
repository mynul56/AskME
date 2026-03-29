class ChatMessage {
  final String role;   // 'system' | 'user' | 'assistant'
  final String content;

  const ChatMessage({required this.role, required this.content});

  Map<String, dynamic> toJson() => {'role': role, 'content': content};

  factory ChatMessage.fromJson(Map<String, dynamic> json) =>
      ChatMessage(role: json['role'] as String, content: json['content'] as String);
}

class AiResponse {
  final String advice;
  final String message;
  final List<String> tasks;
  final String rawText;

  const AiResponse({
    required this.advice,
    required this.message,
    required this.tasks,
    required this.rawText,
  });

  factory AiResponse.fromText(String text) {
    // Parse structured JSON response from AI if available, else fallback
    return AiResponse(advice: text, message: '', tasks: [], rawText: text);
  }
}

class Session {
  final String? id;
  final String userId;
  final String situationText;
  final String urgencyLevel;
  final List<String> questionnaireAnswers;
  final AiResponse? aiResponse;
  final List<ChatMessage> messages;
  final int followUpCount;
  final DateTime createdAt;

  const Session({
    this.id,
    required this.userId,
    required this.situationText,
    required this.urgencyLevel,
    required this.questionnaireAnswers,
    this.aiResponse,
    required this.messages,
    this.followUpCount = 0,
    required this.createdAt,
  });

  Session copyWith({
    String? id,
    AiResponse? aiResponse,
    List<ChatMessage>? messages,
    int? followUpCount,
  }) => Session(
    id: id ?? this.id,
    userId: userId,
    situationText: situationText,
    urgencyLevel: urgencyLevel,
    questionnaireAnswers: questionnaireAnswers,
    aiResponse: aiResponse ?? this.aiResponse,
    messages: messages ?? this.messages,
    followUpCount: followUpCount ?? this.followUpCount,
    createdAt: createdAt,
  );
}

class DailyRating {
  final String? id;
  final String userId;
  final int rating;        // 1-5
  final String moodEmoji;
  final String note;
  final DateTime date;

  const DailyRating({
    this.id,
    required this.userId,
    required this.rating,
    required this.moodEmoji,
    required this.note,
    required this.date,
  });
}

class AppUser {
  final String uid;
  final String email;
  final String displayName;
  final bool isPremium;
  final DateTime? trialStartDate;
  final int dailyQuestionCount;
  final DateTime? lastResetDate;

  const AppUser({
    required this.uid,
    required this.email,
    required this.displayName,
    this.isPremium = false,
    this.trialStartDate,
    this.dailyQuestionCount = 0,
    this.lastResetDate,
  });

  bool get isTrialActive {
    if (trialStartDate == null) return false;
    return DateTime.now().difference(trialStartDate!).inDays < 7;
  }

  bool get hasFullAccess => isPremium || isTrialActive;

  AppUser copyWith({int? dailyQuestionCount, DateTime? lastResetDate}) =>
      AppUser(
        uid: uid,
        email: email,
        displayName: displayName,
        isPremium: isPremium,
        trialStartDate: trialStartDate,
        dailyQuestionCount: dailyQuestionCount ?? this.dailyQuestionCount,
        lastResetDate: lastResetDate ?? this.lastResetDate,
      );
}
