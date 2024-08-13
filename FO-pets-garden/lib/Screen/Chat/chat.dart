import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat avec le propriétaire'),
        backgroundColor: const Color(0xffFF9166),
      ),
      body: Center(
        child: Text(
          'This is where the chat interface would be.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
