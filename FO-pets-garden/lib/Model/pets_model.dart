import 'package:flutter/material.dart';

class PetsModel {
  final String name;
  final String breed;
  final String sex;
  final String age; // Utiliser String pour correspondre au format de votre base de données
  final String origin;
  final String description;
  final Color color;
  final String image;

  PetsModel({
    required this.name,
    required this.breed,
    required this.sex,
    required this.age,
    required this.origin,
    required this.description,
    required this.color,
    required this.image,
  });

  factory PetsModel.fromJson(Map<String, dynamic> json) {
    return PetsModel(
      name: json['name'],
      breed: json['breed'],
      sex: json['sex'],
      age: json['age'], // Gardé comme String pour correspondre à la structure de votre BD
      origin: json['origin'],
      description: json['description'] ?? '', // Valeur par défaut si description est null
      color: Color(int.parse(json['color'].substring(1, 7), radix: 16) + 0xFF000000), // Convertit la couleur HEX en objet Color
      image: json['image'],
    );
  }
}
