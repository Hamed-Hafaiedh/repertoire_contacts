import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../data/contact_service.dart';

class ContactFormPage extends StatefulWidget {
  final String? contactId; // null = ajout, sinon = modification

  const ContactFormPage({this.contactId, super.key});

  @override
  State<ContactFormPage> createState() => _ContactFormPageState();
}

class _ContactFormPageState extends State<ContactFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();

  bool get _estModification => widget.contactId != null;

  @override
  void initState() {
    super.initState();
    // En mode modification, on pré-remplit les champs
    if (_estModification) {
      final contact = ContactService.getById(widget.contactId!);
      if (contact != null) {
        _nameController.text = contact['name']!;
        _phoneController.text = contact['phone']!;
        _emailController.text = contact['email']!;
      }
    }
  }

  void _enregistrer() {
    // Vérifie les validators des champs
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();
    final email = _emailController.text.trim();

    if (_estModification) {
      ContactService.update(widget.contactId!, name, phone, email);
    } else {
      ContactService.add(name, phone, email);
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_estModification ? 'Contact modifié' : 'Contact ajouté'),
      ),
    );
    context.pop(); // retour à la page précédente
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(_estModification ? 'Modifier le contact' : 'Nouveau contact'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Champ Nom
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nom',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Le nom est obligatoire';
                }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Champ Téléphone
              TextFormField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Téléphone',
                  prefixIcon: Icon(Icons.phone),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Le téléphone est obligatoire';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Champ Email
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "L'email est obligatoire";
                  }
                  if (!value.contains('@')) {
                    return 'Email invalide';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _enregistrer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  child: Text(
                    _estModification ? 'Enregistrer' : 'Ajouter',
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}