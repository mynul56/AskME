import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/app_models.dart';

/// Calls the secured Firebase Cloud Function which internally calls OpenAI.
/// The base URL must be set to your deployed function URL once Firebase is set up.
class AiService extends GetxService {
  // TODO: Replace with your deployed Firebase Cloud Function URL
  static const String _functionBaseUrl =
      'https://YOUR_REGION-YOUR_PROJECT_ID.cloudfunctions.net/getAIResponse';

  // Fallback prompt fetched from Firestore. Editable by client without app update.
  final String _systemPrompt = '''You are a supportive and highly intelligent cognitive assistant.
The user will describe a situation they are navigating. Based on their input and questionnaire answers, you will provide:
1. Core Advice - practical, actionable guidance (2-3 sentences)
2. Tasks - 3 specific action items (short, clear)
3. Response Bridge - a word-for-word message they can send to someone relevant

Respond in this exact JSON format:
{
  "advice": "...",
  "tasks": ["...", "...", "..."],
  "message": "..."
}''';

  Future<void> loadPromptFromFirestore() async {
    // TODO: fetch from Firestore prompts/main document and cache locally
    // final doc = await FirebaseFirestore.instance.collection('prompts').doc('main').get();
    // (update cached prompt in a local variable or Hive, not this final field)
  }

  /// Sends a conversation to the AI and returns the assistant's reply text.
  Future<String> sendMessage(List<ChatMessage> messages) async {
    // Build full messages array with system prompt prepended
    final fullMessages = [
      ChatMessage(role: 'system', content: _systemPrompt),
      ...messages,
    ].map((m) => m.toJson()).toList();

    try {
      final response = await http.post(
        Uri.parse(_functionBaseUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'messages': fullMessages}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['result'] as String? ?? 'No response received.';
      } else {
        return _mockAiResponse();
      }
    } catch (_) {
      // Return mock while Firebase Function URL is not yet configured
      return _mockAiResponse();
    }
  }

  String _mockAiResponse() => jsonEncode({
    "advice": "The tension you're experiencing stems from a misalignment between cognitive load and sensory input. Prioritize 'Mono-Tasking' for the next 48 hours to recalibrate your focus and reduce neural friction.",
    "tasks": [
      "Archive 3 non-essential notifications to reduce ambient noise instantly",
      "10-minute divergent breathing to reset pre-frontal cortex activity",
      "Define Tomorrow's 'One Thing' — anchor your intent before rest"
    ],
    "message": "I value our project's momentum, but to deliver my best work, I need to focus on one milestone at a time today. Let's sync on the remaining items Wednesday."
  });

  AiResponse parseStructuredResponse(String text) {
    try {
      // Try extracting JSON block
      final start = text.indexOf('{');
      final end   = text.lastIndexOf('}');
      if (start >= 0 && end > start) {
        final json = jsonDecode(text.substring(start, end + 1));
        return AiResponse(
          advice:  json['advice'] as String? ?? text,
          tasks:   (json['tasks'] as List<dynamic>?)?.cast<String>() ?? [],
          message: json['message'] as String? ?? '',
          rawText: text,
        );
      }
    } catch (_) {}
    return AiResponse(advice: text, message: '', tasks: [], rawText: text);
  }
}
