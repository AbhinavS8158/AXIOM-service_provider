import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/chat_list_provider.dart';
import 'package:service_provider/view/screen/chatlist/widget/chat_list_tile.dart';
import 'package:service_provider/view/screen/chatscreen/chat_screen.dart';

class ChatListBody extends StatelessWidget {
  final String currentUserId;

  const ChatListBody({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatListProvider>(
      builder: (context, provider, _) {
        if (provider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (provider.chats.isEmpty) {
          return const Center(
            child: Text("No conversations found"),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: provider.chats.length,
          separatorBuilder: (_, __) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final chatDoc = provider.chats[index];
            final data = chatDoc.data() as Map<String, dynamic>;

            final String userName = data['userName'] ?? 'User';
            final String userImage = data['userImage'] ?? '';
            final String lastMessage = data['lastMessage'] ?? '';
            final DateTime lastMessageTime = (data['lastMessageAt']as Timestamp?)?.toDate()??DateTime.now();

            return ChatListTile(
              name: userName,
              image: userImage,
              lastMessage: lastMessage,
              time: lastMessageTime,
              unreadCount: 0,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProviderChatScreen(
                      chatId: chatDoc.id,
                      providerId: currentUserId,
                      userName: userName,
                      userImage: userImage,
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
