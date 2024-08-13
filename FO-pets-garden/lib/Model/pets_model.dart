import 'package:flutter/material.dart';

class PetsModel {
  final String name;
  final String breed;
  final String sex;
  final int age;
  final Color color;
  final String image;

  PetsModel({
    required this.name,
    required this.breed,
    required this.sex,
    required this.age,
    required this.color,
    required this.image,
  });

  factory PetsModel.fromJson(Map<String, dynamic> json) {
    return PetsModel(
      name: json['name'],
      breed: json['breed'],
      sex: json['sex'],
      age: json['age'],
      color: Color(int.parse(json['color'])), // Assurez-vous que la couleur est bien traitée
      image: json['image'],
    );
  }
}
