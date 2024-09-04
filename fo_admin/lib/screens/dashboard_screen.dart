import 'package:flutter/material.dart';
import 'adscren.dart';
import 'profilescreen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isExpanded = false;
  int _selectedIndex = 0;  // Track which page is selected

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,  // Use primary color
        title: Text(
          "Admin Panel",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: Row(
        children: [
          NavigationRail(
            extended: isExpanded,
            backgroundColor: Theme.of(context).primaryColor,  // Use primary color
            unselectedIconTheme: IconThemeData(color: Colors.white, opacity: 1),
            unselectedLabelTextStyle: TextStyle(color: Colors.white),
            selectedIconTheme: IconThemeData(color: Theme.of(context).colorScheme.secondary),
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text("Dashboard"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.list),
                label: Text("Manage Ads"),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text("Manage Profiles"),
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
          if (_selectedIndex == 1) ...[
            Expanded(
              child: AdsScreen(),  // Navigate to AdsScreen
            ),
          ] else if (_selectedIndex == 2) ...[
            Expanded(
              child: ProfileScreen(),  // Navigate to ProfileScreen
            ),
          ] else ...[
            Expanded(
              child: Center(
                child: Text(
                  'Welcome to the Admin Dashboard!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
