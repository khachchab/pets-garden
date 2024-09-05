import 'package:flutter/material.dart';
import 'package:web_dashboard_app_tut/service/api_service.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ApiService apiService;
  List<dynamic> profiles = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    apiService = ApiService(baseUrl: 'http://localhost/BO-pets-garden/');
    fetchProfiles();
  }

  // Méthode pour récupérer les profils depuis l'API
  void fetchProfiles() async {
    try {
      List<dynamic> profilesData = await apiService.getProfiles();
      setState(() {
        profiles = profilesData;
        isLoading = false;
      });
    } catch (e) {
      print('Erreur lors de la récupération des profils: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Profils"),
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
                      "Gestion des Profils",
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
                        DataColumn(label: Text("Nom")),
                        DataColumn(label: Text("Email")),
                        DataColumn(label: Text("Type d'utilisateur")),
                        DataColumn(label: Text("Actions")),
                      ],
                      rows: profiles.map((profile) {
                        return DataRow(cells: [
                          DataCell(Text(profile['id'].toString())),
                          DataCell(Text(profile['name'])),
                          DataCell(Text(profile['account_email'])),
                          DataCell(Text(profile['user_type'])),
                          DataCell(Row(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Logique de modification du profil
                                },
                                child: Text("Modifier"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context).primaryColor,  // Utilise la couleur principale
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(
                                onPressed: () {
                                  // Logique de suppression du profil
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
