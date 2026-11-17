// Service qui gère les contacts avec une simple liste de Map (sans base de données)
class ContactService {
  // Liste en mémoire
  static final List<Map<String, String>> _contacts = [
    {'id': '1', 'name': 'Alice', 'phone': '22 333 444', 'email': 'alice@mail.com'},
    {'id': '2', 'name': 'Bob', 'phone': '55 666 777', 'email': 'bob@mail.com'},
    {'id': '3', 'name': 'Charlie', 'phone': '98 111 222', 'email': 'charlie@mail.com'},
  ];

  static int _nextId = 4; // prochain id à attribuer

  // READ : tous les contacts
  static List<Map<String, String>> getAll() {
    return _contacts;
  }

  // READ : un contact par son id (null s'il n'existe pas)
  static Map<String, String>? getById(String id) {
    for (final contact in _contacts) {
      if (contact['id'] == id) return contact;
    }
    return null;
  }

  // CREATE : ajouter un contact
  static void add(String name, String phone, String email) {
    _contacts.add({
      'id': _nextId.toString(),
      'name': name,
      'phone': phone,
      'email': email,
    });
    _nextId++;
  }

  // UPDATE : modifier un contact
  static void update(String id, String name, String phone, String email) {
    final index = _contacts.indexWhere((c) => c['id'] == id);
    if (index != -1) {
      _contacts[index] = {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
      };
    }
  }

  // DELETE : supprimer un contact
  static void delete(String id) {
    _contacts.removeWhere((c) => c['id'] == id);
  }
}