import 'dart:io';
import 'dart:convert'; // Required for encoding image to base64

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking
import 'package:pets_adoption_app/services/api_service.dart'; // Assuming you have this file for API handling

class PostAdScreen extends StatefulWidget {
  const PostAdScreen({super.key});

  @override
  State<PostAdScreen> createState() => _PostAdScreenState();
}

class _PostAdScreenState extends State<PostAdScreen> {
  final _formKey = GlobalKey<FormState>();
  String? petType;
  String? breed;
  String? sex;
  int? age;
  String? origin;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? city;
  String? comments;
  XFile? petImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffFF9166),
        title: const Text("Ajouter une annonce"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'images/chienchat.jpg', // Path to the image
              fit: BoxFit.cover,
            ),
          ),
          // Form
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  // Type of Animal Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Type d'animal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Chat", child: Text("Chat")),
                      DropdownMenuItem(value: "Chien", child: Text("Chien")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        petType = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Veuillez sélectionner un type d'animal";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Breed Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Race",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer la race de l'animal";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      breed = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Sex Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Sexe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                    ],
                    onChanged: (value) {
                      setState(() {
                        sex = value;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return "Veuillez sélectionner le sexe de l'animal";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Age Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Âge (en années)",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer l'âge de l'animal";
                      }
                      if (int.tryParse(value) == null || int.parse(value) <= 0) {
                        return "Veuillez entrer un âge valide";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      age = int.tryParse(value!);
                    },
                  ),
                  const SizedBox(height: 20),

                  // Origin Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Origine",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer l'origine de l'animal";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      origin = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Description Field
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onSaved: (value) {
                      description = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Date Picker for Start Date
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date de début",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          startDate = pickedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (startDate == null) {
                        return "Veuillez sélectionner une date de début";
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      text: startDate != null
                          ? "${startDate!.day}/${startDate!.month}/${startDate!.year}"
                          : "",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Date Picker for End Date
                  TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date de fin",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: startDate ?? DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        setState(() {
                          endDate = pickedDate;
                        });
                      }
                    },
                    validator: (value) {
                      if (endDate == null) {
                        return "Veuillez sélectionner une date de fin";
                      }
                      if (endDate != null && startDate != null && endDate!.isBefore(startDate!)) {
                        return "La date de fin doit être après la date de début";
                      }
                      return null;
                    },
                    controller: TextEditingController(
                      text: endDate != null
                          ? "${endDate!.day}/${endDate!.month}/${endDate!.year}"
                          : "",
                    ),
                  ),
                  const SizedBox(height: 20),

                  // City Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Ville",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer la ville";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      city = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Comments Field
                  TextFormField(
                    maxLines: 4,
                    decoration: InputDecoration(
                      labelText: "Commentaires",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    onSaved: (value) {
                      comments = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Upload Image Button
                  ElevatedButton.icon(
                    onPressed: () async {
                      final ImagePicker _picker = ImagePicker();
                      final XFile? image =
                          await _picker.pickImage(source: ImageSource.gallery);
                      setState(() {
                        petImage = image;
                      });
                    },
                    icon: const Icon(Icons.photo_camera),
                    label: const Text("Ajouter une photo"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffFF9166),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Display selected image
                  petImage != null
                      ? Image.file(
                          File(petImage!.path),
                          height: 150,
                        )
                      : const SizedBox(),
                  const SizedBox(height: 20),

                  // Submit Button
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();

                          // Convert image to base64 if available
                          String? base64Image;
                          if (petImage != null) {
                            base64Image = base64Encode(
                              File(petImage!.path).readAsBytesSync(),
                            );
                          }

                          Map<String, dynamic> adData = {
                            "profile_id": 1, // Remplacer avec l'ID du profil réel
                            "animal_type": petType,
                            "breed": breed,
                            "sex": sex,
                            "age": age,
                            "origin": origin,
                            "description": description,
                            "start_date": startDate?.toIso8601String(),
                            "end_date": endDate?.toIso8601String(),
                            "city": city,
                            "comments": comments,
                            "animal_photo": base64Image, // base64 encoded image
                          };

                          ApiService().addAd(adData).then((response) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Annonce déposée avec succès!')),
                            );
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Erreur: $error')),
                            );
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 80,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: const Color(0xffFF9166),
                      ),
                      child: const Text(
                        "Déposer l'annonce",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
