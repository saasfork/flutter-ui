import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:saasfork_firebase_service/models/auth_result.dart';
import 'package:saasfork_firebase_service/models/user_model.dart';
import 'package:saasfork_firebase_service/state_notifier.dart';

/// Firebase Authentication service for SaasFork.
///
/// This class handles all authentication operations such as login,
/// registration, and current user retrieval.
///
/// Usage example:
/// ```dart
/// final authProvider = SFFirebaseAuthProvider(context);
///
/// // Check if a user is logged in
/// if (authProvider.currentUser != null) {
///   print('User logged in: ${authProvider.currentUser!.email}');
/// }
/// ```
class SFFirebaseAuthProvider extends StateNotifier<UserModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Currently authenticated user or null if no user is logged in
  UserModel? get currentUser => state;

  /// Creates an authentication service instance and checks the current login state.
  ///
  /// The [context] parameter is used to access the application context.
  ///
  /// Example:
  /// ```dart
  /// final authProvider = SFFirebaseAuthProvider(context);
  /// ```
  SFFirebaseAuthProvider() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          resetState();
          return;
        }

        setState(UserModel(uid: user.uid, email: user.email));
      });
    } catch (e) {
      debugPrint('Error retrieving current user: ${e.toString()}');
      resetState();
    }
  }

  /// Signs in a user with email and password.
  ///
  /// Returns an [AuthResultModel] containing the operation result.
  ///
  /// Parameters:
  /// - [email]: User's email address
  /// - [password]: User's password
  ///
  /// Example:
  /// ```dart
  /// final result = await authProvider.login('user@example.com', 'password123');
  /// if (result.success) {
  ///   print('Successfully logged in: ${result.user!.email}');
  /// } else {
  ///   print('Login failed: ${result.error}');
  ///   // Handle specific error cases
  ///   if (result.error!.contains('user-not-found')) {
  ///     // Show user not found message
  ///   } else if (result.error!.contains('wrong-password')) {
  ///     // Show incorrect password message
  ///   }
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

      setState(userModel);
      success = true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          error = 'Aucun utilisateur trouvé avec cet email';
          break;
        case 'wrong-password':
          error = 'Mot de passe incorrect';
          break;
        // Autres cas spécifiques
        default:
          error = e.message ?? e.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    return AuthResultModel(success: success, user: userModel, error: error);
  }

  /// Registers a new user with email and password.
  ///
  /// Returns an [AuthResultModel] containing the operation result.
  ///
  /// Parameters:
  /// - [email]: New user's email address
  /// - [password]: New user's password
  ///
  /// Example:
  /// ```dart
  /// final result = await authProvider.register('newuser@example.com', 'password123');
  /// if (result.success) {
  ///   print('Account created successfully: ${result.user!.email}');
  ///   // Navigate to onboarding or home screen
  /// } else {
  ///   print('Registration error: ${result.error}');
  ///   // Handle specific errors (e.g., email already in use)
  ///   if (result.error!.contains('email-already-in-use')) {
  ///     // Show appropriate message
  ///   }
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
      setState(userModel);
      success = true;
    } catch (e) {
      error = e.toString();
    }

    return AuthResultModel(success: success, user: userModel, error: error);
  }

  /// Sends a password reset email to the specified address.
  ///
  /// Returns an [AuthResultModel] indicating whether the operation succeeded.
  ///
  /// Parameters:
  /// - [email]: Email address of the user requesting password reset
  ///
  /// Example:
  /// ```dart
  /// final result = await authProvider.resetPassword('user@example.com');
  /// if (result.success) {
  ///   print('Password reset email sent successfully');
  ///   // Show confirmation message to user
  /// } else {
  ///   print('Error sending reset email: ${result.error}');
  ///   // Handle potential errors such as invalid email
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

  /// Signs out the currently authenticated user.
  ///
  /// This method updates [currentUser] to null after logout.
  ///
  /// Example:
  /// ```dart
  /// await authProvider.signOut();
  /// print('User signed out');
  /// // Navigate to login screen
  /// Navigator.of(context).pushReplacementNamed('/login');
  /// ```
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      resetState();
    } catch (e) {
      // Handle the error silently or log it
      debugPrint('Error during sign out: ${e.toString()}');
    }
  }

  /// TODO: Pas de méthode pour réauthentifier l'utilisateur (Modification de profile)
  /// TODO: Pas de méthode pour changer le mot de passe
}
