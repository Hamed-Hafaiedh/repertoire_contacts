// Import des packages nécessaires
import 'package:flutter/material.dart';
import 'screens/login_page.dart';

// Fonction principale - point d'entrée de l'application
void main() {
  runApp(const MyApp());
}

// Classe principale de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mon App d'Authentification",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, // Couleur principale
      ),
      home: const LoginPage(), // Premier écran affiché
    );
  }
}