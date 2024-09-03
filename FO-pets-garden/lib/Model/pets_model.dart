import 'package:flutter/material.dart';

class PetsModel {
  final String name;
  final String breed;
  final String sex;
  final String age;
  final String origin;
  final String description;
  final Color color;
  final String image;
  final String category;
  final String ownerEmail;  // Ajout de ownerEmail
  final String ownerPhone;  // Ajout de ownerPhone

  PetsModel({
    required this.name,
    required this.breed,
    required this.sex,
    required this.age,
    required this.origin,
    required this.description,
    required this.color,
    required this.image,
    required this.category,
    required this.ownerEmail,  // Ajout de ownerEmail
    required this.ownerPhone,  // Ajout de ownerPhone
  });

  factory PetsModel.fromJson(Map<String, dynamic> json) {
    return PetsModel(
      name: json['name'] ?? 'Unknown',  // Valeur par défaut 'Unknown' si null
      breed: json['breed'] ?? 'Unknown', // Valeur par défaut 'Unknown' si null
      sex: json['sex'] ?? 'Unknown',     // Valeur par défaut 'Unknown' si null
      age: json['age'] ?? 'Unknown',     // Valeur par défaut 'Unknown' si null
      origin: json['origin'] ?? 'Unknown', // Valeur par défaut 'Unknown' si null
      description: json['description'] ?? '', // Valeur par défaut vide si null
      color: json['color'] != null
          ? Color(int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000)
          : Colors.grey,  // Couleur par défaut si null
      image: json['animal_photo'] ?? 'default.png', // Image par défaut si null
      category: json['animal_type'],
      ownerEmail: json['ownerEmail'] ?? 'unknown@example.com', // Valeur par défaut si null
      ownerPhone: json['ownerPhone'] ?? '0000000000', // Valeur par défaut si null
    );
  }
}
