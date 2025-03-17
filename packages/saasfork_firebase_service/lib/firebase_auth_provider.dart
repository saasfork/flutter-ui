import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_firebase_service/models/auth_result.dart';
import 'package:saasfork_firebase_service/models/user_model.dart';

/// Service d'authentification Firebase pour SaasFork.
///
/// Cette classe gère toutes les opérations d'authentification telles que la connexion,
/// l'inscription et la récupération de l'utilisateur courant.
///
/// Exemple d'utilisation:
/// ```dart
/// final authProvider = SFFirebaseAuthProvider(context);
///
/// // Vérifier si un utilisateur est connecté
/// if (authProvider.currentUser != null) {
///   print('Utilisateur connecté: ${authProvider.currentUser!.email}');
/// }
/// ```
class SFFirebaseAuthProvider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Utilisateur actuellement authentifié ou null si aucun utilisateur n'est connecté
  UserModel? currentUser;

  /// Crée une instance du service d'authentification et vérifie l'état de connexion actuel.
  ///
  /// Le paramètre [context] est utilisé pour accéder au contexte de l'application.
  ///
  /// Exemple:
  /// ```dart
  /// final authProvider = SFFirebaseAuthProvider(context);
  /// ```
  SFFirebaseAuthProvider(BuildContext context) {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          currentUser = null;
          return;
        }

        currentUser = UserModel(uid: user.uid, email: user.email);
      });
    } catch (e) {
      debugPrint(
        'Erreur lors de la récupération de l\'utilisateur courant: ${e.toString()}',
      );
      currentUser = null;
    }

    notifyListeners();
  }

  /// Connecte un utilisateur avec son email et son mot de passe.
  ///
  /// Retourne un [AuthResultModel] contenant le résultat de l'opération.
  ///
  /// Paramètres:
  /// - [email] : Adresse email de l'utilisateur
  /// - [password] : Mot de passe de l'utilisateur
  ///
  /// Exemple:
  /// ```dart
  /// final result = await authProvider.login('utilisateur@exemple.com', 'motdepasse123');
  /// if (result.success) {
  ///   print('Connecté avec succès: ${result.user!.email}');
  /// } else {
  ///   print('Erreur de connexion: ${result.error}');
  /// }
  /// ```
  Future<AuthResultModel> login(String email, String password) async {
    bool success = false;
    UserModel? userModel;
    String? error;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
      );

      currentUser = userModel;
      success = true;

      notifyListeners();
    } catch (e) {
      error = e.toString();
    }

    return AuthResultModel(success: success, user: userModel, error: error);
  }

  /// Inscrit un nouvel utilisateur avec son email et son mot de passe.
  ///
  /// Retourne un [AuthResultModel] contenant le résultat de l'opération.
  ///
  /// Paramètres:
  /// - [email] : Adresse email du nouvel utilisateur
  /// - [password] : Mot de passe du nouvel utilisateur
  ///
  /// Exemple:
  /// ```dart
  /// final result = await authProvider.register('nouveau@exemple.com', 'motdepasse123');
  /// if (result.success) {
  ///   print('Compte créé avec succès: ${result.user!.email}');
  /// } else {
  ///   print('Erreur lors de l\'inscription: ${result.error}');
  /// }
  /// ```
  Future<AuthResultModel> register(String email, String password) async {
    bool success = false;
    UserModel? userModel;
    String? error;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
      );

      currentUser = userModel;
      success = true;

      notifyListeners();
    } catch (e) {
      error = e.toString();
    }

    return AuthResultModel(success: success, user: userModel, error: error);
  }

  /// Envoie un email de réinitialisation de mot de passe à l'adresse spécifiée.
  ///
  /// Retourne un [AuthResultModel] indiquant si l'opération a réussi.
  ///
  /// Paramètres:
  /// - [email] : Adresse email de l'utilisateur souhaitant réinitialiser son mot de passe
  ///
  /// Exemple:
  /// ```dart
  /// final result = await authProvider.resetPassword('utilisateur@exemple.com');
  /// if (result.success) {
  ///   print('Email de réinitialisation envoyé avec succès');
  /// } else {
  ///   print('Erreur lors de l\'envoi de l\'email: ${result.error}');
  /// }
  /// ```
  Future<AuthResultModel> resetPassword(String email) async {
    bool success = false;
    String? error;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      success = true;
    } catch (e) {
      error = e.toString();
    }

    return AuthResultModel(success: success, error: error);
  }

  /// Déconnecte l'utilisateur actuellement authentifié.
  ///
  /// Cette méthode met à jour le [currentUser] à null après déconnexion.
  ///
  /// Exemple:
  /// ```dart
  /// await authProvider.signOut();
  /// print('Utilisateur déconnecté');
  /// ```
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      currentUser = null;
    } catch (e) {
      // Gérer l'erreur silencieusement ou la journaliser
      debugPrint('Erreur lors de la déconnexion: ${e.toString()}');
    }

    notifyListeners();
  }
}
