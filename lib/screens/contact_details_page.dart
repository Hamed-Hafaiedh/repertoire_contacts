import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/contact_service.dart';

class ContactDetailsPage extends StatefulWidget {
  final String contactId;

  const ContactDetailsPage({required this.contactId, super.key});

  @override
  State<ContactDetailsPage> createState() => _ContactDetailsPageState();
}

class _ContactDetailsPageState extends State<ContactDetailsPage> {
  // Demande confirmation puis supprime le contact
  Future<void> _supprimer() async {
    final confirmer = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Supprimer le contact'),
        content: const Text('Voulez-vous vraiment supprimer ce contact ?'),
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
      ContactService.delete(widget.contactId);
      if (!mounted) return;
      context.pop(); // retour à la liste
    }
  }

  @override
  Widget build(BuildContext context) {
    final contact = ContactService.getById(widget.contactId);

    // Cas où le contact n'existe plus
    if (contact == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Détails du contact')),
        body: const Center(child: Text('Contact introuvable')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text('Détails du contact #${contact['id']}')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 45,
              child: Text(
                contact['name']![0].toUpperCase(),
                style: const TextStyle(fontSize: 36),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              contact['name']!,
              style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(contact['phone']!),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(contact['email']!),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await context.push('/contacts/${contact['id']}/edit');
                    setState(() {}); // rafraîchit après modification
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Modifier'),
                ),
                ElevatedButton.icon(
                  onPressed: _supprimer,
                  style: ElevatedButton.styleFrom(foregroundColor: Colors.red),
                  icon: const Icon(Icons.delete),
                  label: const Text('Supprimer'),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Retour'),
            ),
          ],
        ),
      ),
    );
  }
}