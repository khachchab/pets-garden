import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/service/api_service.dart';

class AdsScreen extends StatefulWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  _AdsScreenState createState() => _AdsScreenState();
}

class _AdsScreenState extends State<AdsScreen> {
  late ApiService apiService;
  List<dynamic> ads = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://localhost/BO-pets-garden/');
    fetchAds();
  }

  // Méthode pour récupérer les annonces depuis l'API
  void fetchAds() async {
    try {
      List<dynamic> adsData = await apiService.getAds();
      setState(() {
        ads = adsData;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des annonces: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Annonces"),
        backgroundColor: Theme.of(context).primaryColor,  // Utilise la couleur principale
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())  // Affiche un indicateur de chargement pendant la récupération des données
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Gestion des Annonces",
                      style: TextStyle(
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    SizedBox(height: 20.0),
                    DataTable(
                      headingRowColor: MaterialStateProperty.resolveWith(
                        (states) => Colors.green.shade100,
                      ),
                      columns: const [
                        DataColumn(label: Text("ID")),
                        DataColumn(label: Text("Profile ID")),
                        DataColumn(label: Text("Nom")),
                        DataColumn(label: Text("Animal Type")),
                        DataColumn(label: Text("Race")),
                        DataColumn(label: Text("Ville")),
                        DataColumn(label: Text("Image")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: ads.map((ad) {
                        return DataRow(cells: [
                          DataCell(Text(ad['id'].toString())),
                          DataCell(Text(ad['profile_name'])),
                          DataCell(Text(ad['name'])),
                          DataCell(Text(ad['animal_type'])),
                          DataCell(Text(ad['breed'] ?? '')),
                          DataCell(Text(ad['city'] ?? '')),
                          DataCell(
                            ad['animal_photo'] != null && ad['animal_photo'] != ''
                                ? Image.asset(
                                    'images/${ad['animal_photo']}',  // Charge les images locales
                                    height: 50,
                                    width: 50,
                                  )
                                : Image.asset(
                                    'images/placeholder.png',  // Image par défaut si aucune image
                                    height: 50,
                                    width: 50,
                                  ),
                          ),
                          DataCell(Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Logique de modification de l'annonce
                                },
                                child: Text("Modifier"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,  // Utilise la couleur principale
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Logique de suppression de l'annonce
                                },
                                child: Text("Supprimer"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ],
                          )),
                        ]);
                      }).toList(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
