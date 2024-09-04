import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Gestion des Profils"),
        backgroundColor: Theme.of(context).primaryColor,  // Use primary color
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
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
                columns: [
                  DataColumn(label: Text("ID")),
                  DataColumn(label: Text("Account ID")),
                  DataColumn(label: Text("Nom")),
                  DataColumn(label: Text("Type")),
                  DataColumn(label: Text("Actions")),
                ],
                rows: [
                  DataRow(cells: [
                    DataCell(Text("1")),
                    DataCell(Text("1")),
                    DataCell(Text("John Doe")),
                    DataCell(Text("A")),
                    DataCell(Row(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Edit profile logic
                          },
                          child: Text("Modifier"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).primaryColor,  // Apply primary color
                          ),
                        ),
                        SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: () {
                            // Delete profile logic
                          },
                          child: Text("Supprimer"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ],
                    )),
                  ]),
                  // Add more rows from the profiles table dynamically here
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
