import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatListProvider extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<QueryDocumentSnapshot<Map<String, dynamic>>> chats = [];
  bool isLoading = true;

  StreamSubscription<QuerySnapshot<Map<String, dynamic>>>? _subscription;

  /// Fetch chats where current user is a participant
  void fetchChats(String currentUserId) {
    isLoading = true;
    notifyListeners();

    _subscription?.cancel();

    _subscription = _firestore
        .collection('chats')
        .where('participants', arrayContains: currentUserId)
        // .orderBy('lastMessageAt', descending: true)
        .snapshots()
        .listen(
      (snapshot) {
        chats = snapshot.docs;
        isLoading = false;
        notifyListeners();
      },
      onError: (error) {
        isLoading = false;
        notifyListeners();
      },
    );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
