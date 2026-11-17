import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/contact_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Demande confirmation puis supprime le contact
  Future<void> _supprimerContact(Map<String, String> contact) async {
    final confirmer = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le contact'),
        content: Text('Voulez-vous vraiment supprimer ${contact['name']} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Annuler'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Supprimer', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmer == true) {
      setState(() {
        ContactService.delete(contact['id']!);
      });
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Contact supprimé')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final contacts = ContactService.getAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Contacts'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
      body: contacts.isEmpty
          ? const Center(child: Text('Aucun contact. Appuyez sur + pour en ajouter.'))
          : ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          final contact = contacts[index];
          return ListTile(
            leading: CircleAvatar(
              child: Text(contact['name']![0].toUpperCase()),
            ),
            title: Text(contact['name']!),
            subtitle: Text(contact['phone']!),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () => _supprimerContact(contact),
            ),
            onTap: () async {
              // Navigation vers la page de détails
              await context.push('/contacts/${contact['id']}');
              // Au retour, on rafraîchit la liste
              setState(() {});
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await context.push('/contacts/add');
          setState(() {}); // rafraîchit après l'ajout
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}