import 'package:firebase_auth/firebase_auth.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_firebase_service/cloud_functions/user_functions.dart';
import 'package:saasfork_firebase_service/models/auth_result.dart';
import 'package:saasfork_firebase_service/state_notifier.dart';

/// Firebase Authentication service for SaasFork.
///
/// This class handles all authentication operations such as login,
/// registration, and current user retrieval.
///
/// Usage example:
/// ```dart
/// final authProvider = SFFirebaseAuthProvider();
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
  /// This constructor initializes the auth listener to update the current user state
  /// whenever the authentication status changes.
  ///
  /// Example:
  /// ```dart
  /// final authProvider = SFFirebaseAuthProvider();
  /// ```
  SFFirebaseAuthProvider() {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) async {
        if (user == null) {
          resetState();
          return;
        }

        final UserClaims claims = await getUserClaims();
        setState(UserModel(uid: user.uid, email: user.email, claims: claims));
      });
    } catch (e) {
      error('Error retrieving current user: ${e.toString()}');
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
  ///   if (result.error!.contains('Aucun utilisateur trouvé')) {
  ///     // Show user not found message
  ///   } else if (result.error!.contains('Mot de passe incorrect')) {
  ///     // Show incorrect password message
  ///   }
  /// }
  /// ```
  Future<AuthResultModel> login(String email, String password) async {
    bool success = false;
    UserModel? userModel;
    String? errorString;

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final claims = await getUserClaims();

      userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        claims: claims,
      );

      setState(userModel);
      success = true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          errorString = 'Aucun utilisateur trouvé avec cet email';
          break;
        case 'wrong-password':
          errorString = 'Mot de passe incorrect';
          break;
        // Autres cas spécifiques
        default:
          errorString = e.message ?? e.toString();
      }

      error('Login error: $errorString');
    } catch (e) {
      error('Login error: ${e.toString()}');
      errorString = e.toString();
    }

    return AuthResultModel(
      success: success,
      user: userModel,
      error: errorString,
    );
  }

  /// Registers a new user with email and password.
  ///
  /// Returns an [AuthResultModel] containing the operation result.
  /// Automatically initializes user claims with a default 'user' role.
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
  /// }
  /// ```
  Future<AuthResultModel> register(String email, String password) async {
    bool success = false;
    UserModel? userModel;
    String? errorString;

    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      try {
        String roleString = Roles.user.toString();

        await UserFunctions.initializeUserClaims(userCredential.user!.uid, {
          'role': roleString,
        });
      } catch (e) {
        error('Warning: Unable to set default claims: ${e.toString()}');
      }

      // Récupérer les claims (qui pourraient être vides si l'initialisation a échoué)
      final UserClaims claims = await getUserClaims();

      userModel = UserModel(
        uid: userCredential.user!.uid,
        email: userCredential.user!.email,
        claims: claims,
      );

      setState(userModel);
      success = true;
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'email-already-in-use':
          errorString =
              'Vous ne pouvez pas créer de compte avec ces informations';
          break;

        case 'weak-password':
          errorString = 'Le mot de passe fourni est trop faible';
          break;

        default:
          errorString = e.message ?? e.toString();
      }

      error('Registration error: $errorString');
    } catch (e) {
      error('Registration error: ${e.toString()}');
      errorString = e.toString();
    }

    return AuthResultModel(
      success: success,
      user: userModel,
      error: errorString,
    );
  }

  /// Retrieves the current user's claims from Firebase Authentication.
  ///
  /// Claims contain user role and other authorization information.
  /// Returns a default visitor role if claims cannot be retrieved.
  ///
  /// Returns a [UserClaims] object containing the user's permissions.
  ///
  /// Example:
  /// ```dart
  /// final claims = await authProvider.getUserClaims();
  /// if (claims.role == Roles.admin) {
  ///   // Show admin features
  /// }
  /// ```
  Future<UserClaims> getUserClaims() async {
    try {
      User? user = _auth.currentUser;

      if (user != null) {
        IdTokenResult idTokenResult = await user.getIdTokenResult();
        return UserClaims.fromJson(idTokenResult.claims!);
      }
    } catch (e) {
      error('Error fetching user claims: ${e.toString()}', error: e);
    }

    return UserClaims(role: Roles.visitor);
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
  ///   print('Instructions de réinitialisation envoyées à votre email');
  /// } else {
  ///   print('Erreur: ${result.error}');
  /// }
  /// ```
  Future<AuthResultModel> resetPassword(String email) async {
    bool success = false;
    String? errorString;

    try {
      await _auth.sendPasswordResetEmail(email: email);
      success = true;
    } catch (e) {
      errorString = e.toString();
      error('Error sending reset email: $errorString');
    }

    return AuthResultModel(success: success, error: errorString);
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
      error('Error during sign out: ${e.toString()}');
    }
  }

  /// Fonctionnalités à implementer:
  /// - Réauthentification de l'utilisateur pour les opérations sensibles
  /// - Changement de mot de passe pour l'utilisateur connecté
}
