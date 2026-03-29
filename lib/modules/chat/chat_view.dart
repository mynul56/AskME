import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../core/constants/app_routes.dart';
import '../../data/services/user_service.dart';
import 'chat_controller.dart';

class ChatView extends GetView<ChatController> {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    final inputCtrl = TextEditingController();
    final user = Get.find<UserService>().user;
    final isFree = !(user?.hasFullAccess ?? false);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => Get.back()),
        title: const Text('AI Chat'),
        actions: [const CircleAvatar(radius: 16, backgroundColor: AppTheme.indigoLight, child: Icon(Icons.person, size: 16, color: Colors.white)), const SizedBox(width: 12)],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(36),
          child: Obx(() => Container(
            color: AppTheme.offWhite,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Row(children: [
              const Icon(Icons.repeat, size: 14, color: AppTheme.textSub),
              const SizedBox(width: 6),
              Text(
                isFree ? 'Follow-ups left: ${1 - controller.followUpCount.value > 0 ? 1 - controller.followUpCount.value : 0}' : 'Unlimited follow-ups',
                style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppTheme.textDark),
              ),
              const Spacer(),
              if (isFree) GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.paywall),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                  decoration: BoxDecoration(color: AppTheme.indigoDark, borderRadius: BorderRadius.circular(20)),
                  child: const Text('Upgrade ↑', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: Colors.white)),
                ),
              ),
            ]),
          )),
        ),
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: Obx(() => ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: controller.messages.length + (controller.isTyping.value ? 1 : 0),
              itemBuilder: (context, i) {
                if (i == controller.messages.length) return const _TypingBubble();
                final msg = controller.messages[i];
                return _ChatBubble(message: msg);
              },
            )),
          ),

          // Paywall prompt when limit reached
          Obx(() => (!controller.canFollowUp && isFree)
            ? _PaywallPrompt()
            : const SizedBox.shrink()),

          // Input bar
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: inputCtrl,
                    decoration: const InputDecoration(hintText: 'Ask a follow-up question...', contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12)),
                    onSubmitted: (v) { controller.send(v); inputCtrl.clear(); },
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () { controller.send(inputCtrl.text); inputCtrl.clear(); },
                  child: Container(
                    width: 44, height: 44,
                    decoration: const BoxDecoration(color: AppTheme.indigoDark, shape: BoxShape.circle),
                    child: const Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final dynamic message;
  const _ChatBubble({required this.message});

  bool get isUser => message.role == 'user';

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser) ...[
          const CircleAvatar(radius: 14, backgroundColor: AppTheme.indigoDark, child: Icon(Icons.auto_awesome, size: 14, color: Colors.white)),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isUser ? AppTheme.indigoDark : Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(18),
                topRight: const Radius.circular(18),
                bottomLeft: Radius.circular(isUser ? 18 : 4),
                bottomRight: Radius.circular(isUser ? 4 : 18),
              ),
              border: isUser ? null : Border.all(color: AppTheme.borderLight),
              boxShadow: isUser ? null : [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 8)],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (!isUser) ...[
                  const Text('Sanctuary', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: AppTheme.indigoDark)),
                  const SizedBox(height: 4),
                ],
                Text(
                  message.content,
                  style: TextStyle(fontSize: 13, color: isUser ? Colors.white : AppTheme.textDark, height: 1.5),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

class _TypingBubble extends StatelessWidget {
  const _TypingBubble();
  @override
  Widget build(BuildContext context) => const Padding(
    padding: EdgeInsets.only(bottom: 12),
    child: Row(
      children: [
        CircleAvatar(radius: 14, backgroundColor: AppTheme.indigoDark, child: Icon(Icons.auto_awesome, size: 14, color: Colors.white)),
        SizedBox(width: 8),
        Text('Sanctuary is thinking...', style: TextStyle(fontSize: 13, color: AppTheme.textSub, fontStyle: FontStyle.italic)),
      ],
    ),
  );
}

class _PaywallPrompt extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: AppTheme.borderLight),
      boxShadow: [BoxShadow(color: AppTheme.indigoDark.withValues(alpha: 0.08), blurRadius: 16)],
    ),
    child: Column(
      children: [
        const Text('🔐', style: TextStyle(fontSize: 28)),
        const SizedBox(height: 8),
        const Text('Follow-up limit reached', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppTheme.textDark)),
        const SizedBox(height: 4),
        const Text('Upgrade to Pro for unlimited conversation depth', style: TextStyle(fontSize: 12, color: AppTheme.textSub), textAlign: TextAlign.center),
        const SizedBox(height: 12),
        ElevatedButton(
          onPressed: () => Get.toNamed(AppRoutes.paywall),
          style: ElevatedButton.styleFrom(minimumSize: const Size(0, 40)),
          child: const Text('Unlock Pro →'),
        ),
      ],
    ),
  );
}
