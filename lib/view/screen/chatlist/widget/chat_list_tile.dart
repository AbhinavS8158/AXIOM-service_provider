import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatListTile extends StatelessWidget {
  final String name;
  final String image;
  final String lastMessage;
  final DateTime time;
  final int unreadCount;
  final VoidCallback onTap;

  const ChatListTile({
    super.key,
    required this.name,
    required this.image,
    required this.lastMessage,
    required this.time,
    required this.unreadCount,
    required this.onTap,
  });

  String get formattedTime{

      final now = DateTime.now();

    final isToday =
        now.year == time.year &&
        now.month == time.month &&
        now.day == time.day;

    if (isToday) {
      return DateFormat('hh:mm a').format(time); 
    } else {
      return DateFormat('dd MMM').format(time); 
    }
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage:
                  image.isNotEmpty ? NetworkImage(image) : null,
              child: image.isEmpty ? const Icon(Icons.person) : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formattedTime,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.grey.shade500,
                  ),
                ),
                if (unreadCount > 0) ...[
                  const SizedBox(height: 6),
                  CircleAvatar(
                    radius: 10,
                    backgroundColor: Colors.blue,
                    child: Text(
                      unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
