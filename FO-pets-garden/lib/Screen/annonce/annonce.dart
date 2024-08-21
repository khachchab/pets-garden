import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For image picking

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
  String? age;
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
              'images/chienchat.jpg',  // Path to the image
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

                  // Sex Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Sexe",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer le sexe de l'animal";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      sex = value;
                    },
                  ),
                  const SizedBox(height: 20),

                  // Age Field
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Âge",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Veuillez entrer l'âge de l'animal";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      age = value;
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
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
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
                          // Handle form submission
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Annonce déposée avec succès!')),
                          );
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
