class Validators {
  // Vérifie le nom
  static String? nom(String? value) { // static permet d’appeler la fonction sans créer d’objet : Validators.email
    if (value == null || value.isEmpty) {
      return 'Entrez votre nom';
    }
    return null;
  }

  // Vérifie l'email
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entrez votre email';
    }
    if (!value.contains('@')) {
      return 'Email invalide';
    }
    return null;
  }

  // Vérifie le mot de passe
  static String? motDePasse(String? value) {
    if (value == null || value.isEmpty) {
      return 'Entrez votre mot de passe';
    }
    if (value.length < 6) {
      return 'Minimum 6 caractères';
    }
    return null;
  }
}