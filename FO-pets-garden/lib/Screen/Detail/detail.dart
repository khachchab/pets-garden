import 'package:flutter/material.dart';
import 'package:pets_adoption_app/Model/pets_model.dart';
import 'package:pets_adoption_app/Screen/Chat/chat.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.pets});
  final PetsModel pets;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.73),
                  Text(
                    pets.name,
                    style: const TextStyle(
                      fontSize: 50,
                    ),
                  ),
                  // Since there is no 'description' field in your PetsModel, this is omitted.
                  // If you later add it, you can uncomment the following code:
                  /*
                  Text(
                    pets.description,
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black54,
                    ),
                  ),
                  */
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: size.height * 0.7,
              width: size.width,
              decoration: BoxDecoration(
                color: pets.color,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Column(
                  children: [
                    Center(
                      child: Hero(
                        tag: pets.image,
                        child: Image.asset(
                          pets.image,
                          height: size.height * 0.5,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ageSexOrigin(pets.age.toString(), "Age"),
                          ageSexOrigin(pets.sex, "Sex"),
                          ageSexOrigin(pets.breed, "Breed"), // Display breed instead of origin
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
            ),
          ),
          // Ajouter le bouton Contacter le propriétaire en bas de l'écran
          Positioned(
            bottom: 30,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ChatScreen(), // Navigate to ChatScreen
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                backgroundColor: const Color(0xffFF9166),
              ),
              child: const Text(
                "Contacter le propriétaire",
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container ageSexOrigin(String value, String name) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black45,
            ),
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black26,
            ),
          ),
        ],
      ),
    );
  }
}
