import 'package:flutter/material.dart';
import 'package:pets_adoption_app/Screen/Chat/chat.dart';

class ConversationsScreen extends StatelessWidget {
  const ConversationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF9166),
        title: const Text(
          "Messages",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 5, // Vous pouvez ajuster le nombre de conversations
        itemBuilder: (context, index) {
          return ConversationCard();
        },
      ),
    );
  }
}

class ConversationCard extends StatelessWidget {
  const ConversationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          backgroundImage: AssetImage('images/profile.png'), // Image de l'utilisateur
          radius: 30,
        ),
        title: const Text(
          'Nom de l\'utilisateur',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Dernier message...',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.message, color: Colors.grey, size: 18),
                const SizedBox(width: 5),
                const Text(
                  '24 Replies',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              '12 Mar 2018',
              style: TextStyle(
                color: Colors.black45,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 5),
            IconButton(
              icon: Icon(
                Icons.favorite_border,
                color: Colors.red.shade400,
              ),
              onPressed: () {},
            ),
          ],
        ),
        onTap: () {
          // Naviguer vers la page de chat individuelle
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(), // Créez et connectez cette page ultérieurement
            ),
          );
        },
      ),
    );
  }
}
