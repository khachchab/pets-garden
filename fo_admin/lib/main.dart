import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/profilescreen.dart';
import 'screens/adscren.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFFFFA36C),  // Orange from the design
        hintColor: Color(0xFF4D5061),   // Dark grey from the design
        textTheme: TextTheme(
          // Apply Montserrat font globally (regular and bold)
          bodyLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.normal),
          bodyMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.normal),
          displayLarge: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
        ),
        buttonTheme: ButtonThemeData(
          buttonColor: Color(0xFFFFA36C), // Orange for buttons
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      routes: {
        '/ads': (context) => AdsScreen(),
        '/users': (context) => ProfileScreen(),
      },
      home: DashboardScreen(),  // Set initial page as DashboardScreen
    );
  }
}
