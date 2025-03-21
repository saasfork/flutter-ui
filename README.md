# SaasFork - Plateforme SaaS Modulaire

## Présentation

SaasFork est une plateforme modulaire pour développer rapidement des applications SaaS avec Firebase. Le projet est structuré en plusieurs packages pour faciliter la réutilisation du code et la maintenance.

## Architecture

Le projet est divisé en plusieurs packages :

### Packages Core

- `saasfork_core` : Contient les modèles de données et utilitaires communs
- `saasfork_firebase_service` : Services d'authentification et d'accès aux données Firebase

### Application

- `app` : L'application principale qui utilise les différents packages

## Fonctionnalités principales

### Authentification

Le système d'authentification est géré via Firebase Auth et expose plusieurs fonctionnalités :

- Connexion avec email/mot de passe
- Inscription d'un nouvel utilisateur
- Gestion des profils utilisateurs
- Gestion des rôles et permissions
- Suppression de compte

```dart
// Exemple d'utilisation

// Connexion
final result = await ref.read(authProvider.notifier).login(email, password);

// Inscription
final result = await ref.read(authProvider.notifier).register(email, password);

// Mise à jour du profil
final result = await ref.read(authProvider.notifier).updateUserProfile(
  username: newUsername, 
  email: newEmail
);

// Déconnexion
await ref.read(authProvider.notifier).signOut();
```

### Gestion de l'état d'authentification

L'état d'authentification est représenté par les états suivants :

- `AuthState.idle` : État initial
- `AuthState.authenticated` : Utilisateur connecté
- `AuthState.unauthenticated` : Utilisateur non connecté
- `AuthState.updating` : Mise à jour en cours
- `AuthState.error` : Erreur d'authentification

```dart
// Accès à l'état d'authentification
final authState = ref.watch(authProvider);

switch (authState.state) {
  case AuthState.authenticated:
    // Utilisateur connecté
    break;
  case AuthState.unauthenticated:
    // Utilisateur non connecté
    break;
  // ...
}
```

### Routage et Navigation

La navigation est gérée via GoRouter avec une protection des routes selon l'état d'authentification :

```dart
// Vérification si une route nécessite une authentification
if (isAuthenticated && _privateRoutes.contains(currentPath)) {
  // Accès autorisé
} else {
  // Redirection vers la page de connexion
}
```

### Journalisation

Le système de journalisation fournit plusieurs niveaux pour faciliter le débogage :

```dart
// Journaliser des informations
log('Information à journaliser');

// Journaliser des avertissements
warn('Avertissement à signaler');

// Journaliser des erreurs avec détails
error('Message d'erreur', error: e, stackTrace: stackTrace);
```

## Modèles de données

### UserModel

Représente un utilisateur de l'application :

```dart
UserModel({
  this.uid,
  this.email,
  this.username,
  this.claims,
});
```

### UserClaims

Gère les rôles et permissions des utilisateurs :

```dart
enum Roles { visitor, user, admin, moderator }

UserClaims({required this.role});
```

## Configuration du projet

1. Créez un fichier `.env` à la racine du projet avec les variables suivantes :

```
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_domain
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
FIREBASE_MESSAGING_SENDER_ID=your_sender_id
FIREBASE_APP_ID=your_app_id
```

2. Installez les dépendances :

```
flutter pub get
```

3. Lancez l'application :

```
flutter run
```

## Structure du projet

```
clickpay/
├── app/                  # Application principale
│   ├── lib/
│   │   ├── constants.dart
│   │   ├── main.dart
│   │   ├── router/       # Système de routage
│   │   └── views/        # Écrans de l'application
│   └── pubspec.yaml
├── packages/
│   ├── saasfork_core/    # Package de base
│   │   ├── lib/
│   │   │   ├── models/   # Modèles de données
│   │   │   └── utils/    # Utilitaires (logger, etc.)
│   │   └── pubspec.yaml
│   └── saasfork_firebase_service/ # Services Firebase
│       ├── lib/
│       │   ├── cloud_functions/
│       │   ├── firebase_auth_provider.dart
│       │   └── models/
│       └── pubspec.yaml
└── pubspec.yaml
```

## Contribution

Les contributions sont les bienvenues ! N'hésitez pas à ouvrir une issue ou une pull request.

## Licence

Ce projet est sous licence [insérer type de licence].