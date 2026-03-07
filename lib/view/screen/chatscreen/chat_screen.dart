import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/chat_provider.dart';
import 'package:service_provider/view/screen/chatscreen/widget/chat_appbar.dart';
import 'package:service_provider/view/screen/chatscreen/widget/chat_input.dart';
import 'package:service_provider/view/screen/chatscreen/widget/chat_message_list.dart';

class ProviderChatScreen extends StatelessWidget {
  final String chatId;
  final String providerId;
  final String userName;
  final String userImage;

  const ProviderChatScreen({
    super.key,
    required this.chatId,
    required this.providerId,
    required this.userName,
    required this.userImage,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create:(_) =>ProviderChatProvider()
                ..initChat(chatId: chatId, providerId: providerId),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,
       appBar: ChatAppBar(userName: userName, userImage: userImage),
        body: Column(
          children: [
           ChatMessagesList(),
            ChatInputBar()
          ],
        ),
      ),
    );
  }
}