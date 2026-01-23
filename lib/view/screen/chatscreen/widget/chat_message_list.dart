import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/chat_provider.dart';
import 'package:service_provider/view/screen/chatscreen/widget/chat_bubble.dart';

class ChatMessagesList extends StatelessWidget {
  const ChatMessagesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer<ProviderChatProvider>(
        builder: (_, provider, __) {
          return ListView.builder(
            controller: provider.scrollController,
            padding: const EdgeInsets.all(16),
            itemCount: provider.messages.length,
            itemBuilder: (context, index) {
              final msg = provider.messages[index];

              final bool showDateHeader = _isNewDate(
                index,
                provider.messages,
              );

              return Column(
                children: [
                  if (showDateHeader)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          _formatDate(msg.time),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ChatBubble(
                    message: msg.message,
                    isMe: msg.isMe,
                    time: TimeOfDay.fromDateTime(
                      msg.time,
                    ).format(context),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  /// ---------- DATE HELPERS ----------

  String _formatDate(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final msgDate = DateTime(date.year, date.month, date.day);

  if (msgDate == today) return "Today";
  if (msgDate == yesterday) return "Yesterday";

  return "${date.day}/${date.month}/${date.year}";
}

bool _isNewDate(int index, List messages) {
  if (index == 0) return true;
  final prev = messages[index - 1].time;
  final current = messages[index].time;

  return prev.year != current.year ||
      prev.month != current.month ||
      prev.day != current.day;
}
}
