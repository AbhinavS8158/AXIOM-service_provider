import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:service_provider/model/message_model.dart';

class ProviderChatProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<ChatMessage> messages = [];

  late String chatId;
  late String providerId;

  void initChat({
    required String chatId,
    required String providerId,
  }) {
    this.chatId = chatId;
    this.providerId = providerId;
    _listenMessages();
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;

    messageController.clear();

    await _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .add({
      'text': text,
      'senderId': providerId,
      'senderType': 'provider',
      'createdAt': FieldValue.serverTimestamp(),
    });

    await _firestore.collection('chats').doc(chatId).update({
      'lastMessage': text,
      'lastMessageAt': FieldValue.serverTimestamp(),
    });
  }

  void _listenMessages() {
    _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('createdAt')
        .snapshots()
        .listen((snapshot) {
      messages
        ..clear()
        ..addAll(snapshot.docs.map((doc) {
          final data = doc.data();

          final Timestamp? timestamp = data['createdAt'];
          final DateTime createdAt =
              timestamp != null ? timestamp.toDate() : DateTime.now();

          return ChatMessage(
            message: data['text'] ?? '',
            isMe: data['senderType'] == 'provider',
            time: createdAt,
          );
        }));

      notifyListeners();
        Future.delayed(const Duration(milliseconds: 100), scrollToBottom);
    });
  }
  void scrollToBottom() {
  if (!scrollController.hasClients) return;

  scrollController.animateTo(
    scrollController.position.maxScrollExtent,
    duration: const Duration(milliseconds: 300),
    curve: Curves.easeOut,
  );
}


  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
