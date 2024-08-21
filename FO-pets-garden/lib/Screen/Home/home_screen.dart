import 'package:flutter/material.dart';
import 'package:pets_adoption_app/Model/pets_model.dart';
import 'package:pets_adoption_app/Screen/Conversations/Conversations.dart';
import 'package:pets_adoption_app/Screen/Detail/detail.dart';
import 'package:pets_adoption_app/Screen/Profile/profile.dart';
import 'package:pets_adoption_app/Screen/annonce/annonce.dart';
import 'package:pets_adoption_app/Screen/Conversations/conversations_screen.dart';
import 'package:pets_adoption_app/services/api_service.dart';

class PetsHomeScreen extends StatefulWidget {
  const PetsHomeScreen({super.key});

  @override
  State<PetsHomeScreen> createState() => _PetsHomeScreenState();
}

class _PetsHomeScreenState extends State<PetsHomeScreen> {
  int selectedIndex = 0;
  List<String> categoryList = ["Cats", "Dogs", "Messages", "Profile"];
  List<PetsModel> pets = [];
  bool isLoading = true;
  final ApiService apiService = ApiService();

  @override
  void initState() {
    super.initState();
    fetchPets();
  }

  Future<void> fetchPets() async {
    try {
      List<dynamic> ads = await apiService.getAds();
      setState(() {
        pets = ads.map((ad) => PetsModel.fromJson(ad)).toList();
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la récupération des annonces: $e');
    }
  }

  List<PetsModel> getFilteredPets() {
    if (selectedIndex == 0) {
      return pets.where((pet) => pet.category.toLowerCase() == "cat").toList();
    } else if (selectedIndex == 1) {
      return pets.where((pet) => pet.category.toLowerCase() == "dog").toList();
    } else {
      return pets;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const Padding(
          padding: EdgeInsets.only(left: 22),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("images/profile.png"),
          ),
        ),
        title: const Text(
          "Hi, Abin",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PostAdScreen(),
                ),
              );
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Padding(
                padding: EdgeInsets.only(left: 22),
                child: Text.rich(
                  TextSpan(
                    text: "Trouvez un gardien pour votre compagnon\n",
                    style: TextStyle(
                      height: 1.1,
                      fontSize: 37,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "ou devenez gardien!",
                        style: TextStyle(
                          fontSize: 35,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              categorySelection(),
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : selectedIndex < categoryList.length && selectedIndex < 2
                      ? Padding(
                          padding: const EdgeInsets.only(left: 22),
                          child: SizedBox(
                            height: 570,
                            child: ListView.builder(
                              itemCount: getFilteredPets().length,
                              itemBuilder: (context, index) {
                                final filteredPets = getFilteredPets();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => DetailScreen(
                                          pets: filteredPets[index],
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 30, right: 15),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Stack(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.circular(20),
                                                ),
                                                height: 50,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 30),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: filteredPets[index].color,
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                  height: 230,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 230,
                                                child: Center(
                                                  child: Hero(
                                                    tag: filteredPets[index].image,
                                                    child: Image.asset(
                                                      'images/' + filteredPets[index].image,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 25),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: filteredPets[index].color.withOpacity(0.2),
                                                borderRadius: const BorderRadius.only(
                                                  topRight: Radius.circular(20),
                                                  bottomRight: Radius.circular(20),
                                                ),
                                              ),
                                              height: 150,
                                              child: Padding(
                                                padding: const EdgeInsets.only(left: 15),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      filteredPets[index].name,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 25,
                                                      ),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      filteredPets[index].breed,
                                                      style: const TextStyle(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          filteredPets[index].sex,
                                                          style: const TextStyle(fontSize: 15),
                                                        ),
                                                        Text(
                                                          ", ${filteredPets[index].age} year old",
                                                          style: const TextStyle(fontSize: 15),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  SizedBox categorySelection() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categoryList.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: ((context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
              if (index == 3) {  // Si "Profile" est sélectionné (index 3)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              } else if (index == 2) {  // Si "Messages" est sélectionné (index 2)
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ConversationsScreen(),
                  ),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 30, top: 10),
              child: Column(
                children: [
                  Container(
                    height: 80,
                    width: 75,
                    decoration: BoxDecoration(
                      color: selectedIndex == index
                          ? const Color(0xffFF9166)
                          : const Color(0xffFF9166).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: selectedIndex == index
                              ? const Color(0xffFF9166).withOpacity(0.5)
                              : Colors.transparent,
                          blurRadius: 12,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        categoryList[index],
                        style: TextStyle(
                            color: selectedIndex == index
                                ? Colors.white
                                : Colors.amber[900],
                            fontWeight: selectedIndex == index
                                ? FontWeight.bold
                                : FontWeight.normal,
                            fontSize: 18),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
