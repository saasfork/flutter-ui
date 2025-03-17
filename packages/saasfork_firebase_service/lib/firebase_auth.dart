import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Service d'authentification Firebase pour SaasFork.
///
/// Cette classe fournit une méthode pour initialiser Firebase Authentication
/// avec les configurations nécessaires.
///
/// Exemple d'utilisation:
///
/// ```dart
/// await SFFirebaseAuth.initialize(
///   apiKey: 'votre-api-key',
///   authDomain: 'votre-projet.firebaseapp.com',
///   projectId: 'votre-projet-id',
///   storageBucket: 'votre-projet.appspot.com',
///   messagingSenderId: '1234567890',
///   appId: '1:1234567890:web:abcdef1234567890',
///   isDev: true, // Utiliser l'émulateur en développement
/// );
///
/// // Après initialisation, vous pouvez utiliser FirebaseAuth
/// // Pour se connecter avec un utilisateur:
/// await FirebaseAuth.instance.signInWithEmailAndPassword(
///   email: 'user@example.com',
///   password: 'password123'
/// );
/// ```
class SFFirebaseAuth {
  /// Initialise Firebase avec les configurations spécifiées.
  ///
  /// Cette méthode doit être appelée avant toute autre opération Firebase.
  ///
  /// Paramètres:
  /// - [apiKey]: Clé API Firebase de votre projet
  /// - [authDomain]: Domaine d'authentification Firebase
  /// - [projectId]: ID du projet Firebase
  /// - [storageBucket]: Bucket de stockage Firebase
  /// - [messagingSenderId]: ID d'expéditeur pour Firebase Cloud Messaging
  /// - [appId]: ID de l'application Firebase
  /// - [isDev]: Si `true`, Firebase Auth utilisera l'émulateur local
  ///   sur localhost:9099. Par défaut à `false`.
  ///
  /// Exemple:
  ///
  /// ```dart
  /// // Initialisation pour environnement de production
  /// await SFFirebaseAuth.initialize(
  ///   apiKey: 'AIzaSyD_example_key',
  ///   authDomain: 'my-app.firebaseapp.com',
  ///   projectId: 'my-app',
  ///   storageBucket: 'my-app.appspot.com',
  ///   messagingSenderId: '1234567890',
  ///   appId: '1:1234567890:web:abcdef1234567890',
  /// );
  ///
  /// // Initialisation pour environnement de développement avec émulateur
  /// await SFFirebaseAuth.initialize(
  ///   apiKey: 'demo-key',
  ///   authDomain: 'localhost',
  ///   projectId: 'demo-project',
  ///   storageBucket: '',
  ///   messagingSenderId: '',
  ///   appId: '',
  ///   isDev: true,
  /// );
  /// ```
  static Future<void> initialize({
    required String apiKey,
    required String authDomain,
    required String projectId,
    required String storageBucket,
    required String messagingSenderId,
    required String appId,
    bool isDev = false,
  }) async {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: apiKey,
        authDomain: authDomain,
        projectId: projectId,
        storageBucket: storageBucket,
        messagingSenderId: messagingSenderId,
        appId: appId,
      ),
    );

    if (isDev) {
      await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    }
  }
}
