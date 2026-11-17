import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/login_page.dart';
import 'screens/register_page.dart';
import 'screens/home_page.dart';
import 'screens/contact_details_page.dart';
import 'screens/contact_form_page.dart';
import 'screens/settings_page.dart';

// Fonction principale - point d'entrée de l'application
void main() {
  runApp(const MyApp());
}

// --- Configuration du routeur ---
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterPage(),
    ),
    GoRoute(
      path: '/contacts',
      builder: (context, state) => const HomePage(),
    ),
    // IMPORTANT : '/contacts/add' doit être AVANT '/contacts/:id'
    GoRoute(
      path: '/contacts/add',
      builder: (context, state) => const ContactFormPage(),
    ),
    GoRoute(
      path: '/contacts/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ContactDetailsPage(contactId: id);
      },
    ),
    GoRoute(
      path: '/contacts/:id/edit',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ContactFormPage(contactId: id);
      },
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
  ],
);

// Classe principale de l'application
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Répertoire de contacts',
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}