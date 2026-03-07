import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:service_provider/controller/provider/chat_list_provider.dart';
import 'package:service_provider/view/screen/chatlist/widget/chat_list_body.dart';
import 'package:service_provider/view/screen/chatlist/widget/message_appbar.dart';

class ChatListScreen extends StatelessWidget {
  final String currentUserId;

  const ChatListScreen({
    super.key,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChatListProvider()..fetchChats(currentUserId),
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

      
        appBar: const MessagesAppBar(),

    
        body: ChatListBody(currentUserId: currentUserId),
      ),
    );
  }
}
