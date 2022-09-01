import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasData) {
          final chatDocs = snapshot.data!.docs;
          final user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
            reverse: true,
            itemBuilder: ((context, index) {
              return MessageBubble(
                username: chatDocs[index]['username'],
                message: chatDocs[index]['text'],
                isAuthor: chatDocs[index]['userId'] == user!.uid,
                key: ValueKey(chatDocs[index].id),
              );
            }),
            itemCount: chatDocs.length,
          );
        }
        return const Text('No messages yet!');
      }),
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy('createdAt', descending: true)
          .snapshots(),
    );
  }
}
