import 'package:flutter/material.dart';
import 'package:pets_adoption_app/Screen/Connexion/connexion.dart';
import 'package:pets_adoption_app/Screen/Home/home_screen.dart';
import 'package:pets_adoption_app/Screen/Connexion/connexion.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LogInScreen(), // Start with the LogIn screen
    );
  }
}
