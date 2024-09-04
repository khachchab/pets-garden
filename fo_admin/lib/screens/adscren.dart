import 'package:flutter/material.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Annonces"),
        backgroundColor: Theme.of(context).primaryColor,  // Use primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                columns: [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Profile ID")),
                  DataColumn(label: Text("Animal Type")),
                  DataColumn(label: Text("Race")),
                  DataColumn(label: Text("Ville")),
                  DataColumn(label: Text("Image")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("1")),
                    DataCell(Text("Chat")),
                    DataCell(Text("British Shorthair")),
                    DataCell(Text("New York")),
                    DataCell(
                      Image.asset('assets/images/caty.png', height: 50, width: 50),  // Use pet image
                    ),
                    DataCell(Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Edit ad logic
                          },
                          child: Text("Modifier"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,  // Apply primary color
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Delete ad logic
                          },
                          child: Text("Supprimer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    )),
                  ]),
                  // Add more rows from the ads table dynamically here
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
