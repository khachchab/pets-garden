import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatelessWidget {
  final String ownerEmail;
  final String ownerPhone;
  final String petImage;

  const ChatScreen({
    super.key,
    required this.ownerEmail,
    required this.ownerPhone,
    required this.petImage,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacter le propriétaire'),
        backgroundColor: const Color(0xffFF9166),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              petImage, // Path to the pet's image
              fit: BoxFit.cover,
            ),
          ),
          // Content
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    final Uri emailUri = Uri(
                      scheme: 'mailto',
                      path: ownerEmail,
                      query: 'subject=Information concernant votre animal&body=Bonjour,',
                    );
                    if (await canLaunchUrl(emailUri)) {
                      await launchUrl(emailUri);
                    } else {
                      print('Could not launch $emailUri');
                    }
                  },
                  icon: const Icon(Icons.email),
                  label: const Text("Contacter par Email"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF9166),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () async {
                    final Uri phoneUri = Uri(
                      scheme: 'tel',
                      path: ownerPhone,
                    );
                    if (await canLaunchUrl(phoneUri)) {
                      await launchUrl(phoneUri);
                    } else {
                      print('Could not launch $phoneUri');
                    }
                  },
                  icon: const Icon(Icons.phone),
                  label: const Text("Contacter par Téléphone"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xffFF9166),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 15,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
