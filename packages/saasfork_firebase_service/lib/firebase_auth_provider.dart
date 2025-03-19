import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:saasfork_core/saasfork_core.dart';
import 'package:saasfork_firebase_service/cloud_functions/user_functions.dart';
import 'package:saasfork_firebase_service/models/auth_state_model.dart';
import 'package:saasfork_firebase_service/state_notifier.dart';

/// Les états d'authentification possibles:
/// - [AuthState.idle] : État initial ou après déconnexion
/// - [AuthState.authenticating] : Authentification en cours
/// - [AuthState.authenticated] : Utilisateur connecté
/// - [AuthState.unauthenticated] : Explicitement non-authentifié
/// - [AuthState.updating] : Mise à jour du profil en cours
/// - [AuthState.error] : Erreur survenue

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
/// if (authProvider.autState != null) {
///   print('User logged in: ${authProvider.autState!.email}');
/// }
/// ```
class SFFirebaseAuthProvider extends StateNotifier<AuthStateModel?> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Completer<void>? _initializeCompleter;
  StreamSubscription<User?>? _authSubscription;

  AuthStateModel? get autState => state;

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
    _initializeAuthListener();
  }

  Future<void> initialize() async {
    // Si l'initialisation est déjà en cours, retourner le même Future
    _initializeCompleter ??= Completer<void>();

    // Si l'état est déjà défini, compléter immédiatement
    if (state != null && state!.state != AuthState.idle) {
      _initializeCompleter!.complete();
    }

    return _initializeCompleter!.future;
  }

  void _initializeAuthListener() {
    try {
      _authSubscription = FirebaseAuth.instance.authStateChanges().listen((
        User? user,
      ) async {
        if (user == null) {
          setState(
            AuthStateModel(state: AuthState.unauthenticated, user: null),
          );
        } else {
          final claims = await getUserClaims();
          final userModel = UserModel(
            uid: user.uid,
            email: user.email,
            username: user.displayName,
            claims: claims,
          );

          setState(
            AuthStateModel(state: AuthState.authenticated, user: userModel),
          );
        }

        if (_initializeCompleter != null &&
            !_initializeCompleter!.isCompleted) {
          _initializeCompleter!.complete();
        }
      });
    } catch (e) {
      error('Error retrieving current user: ${e.toString()}');
      setState(
        AuthStateModel(
          state: AuthState.error,
          user: null,
          errorMessage: 'Error retrieving current user: ${e.toString()}',
        ),
      );
      if (_initializeCompleter != null && !_initializeCompleter!.isCompleted) {
        _initializeCompleter!.completeError(e);
      }
    }
  }

  /// Signs in a user with email and password.
  ///
  /// Returns an [AuthStateModel] containing the operation result.
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
  Future<AuthStateModel> login(String email, String password) async {
    AuthStateModel authStateModel = AuthStateModel(
      state: AuthState.idle,
      user: null,
      errorMessage: null,
    );

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final claims = await getUserClaims();

      authStateModel = authStateModel.copyWith(
        state: AuthState.authenticated,
        user: UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
          username: userCredential.user!.displayName,
          claims: claims,
        ),
        errorMessage: null,
      );
    } on FirebaseAuthException catch (e) {
      authStateModel = _handleFirebaseAuthError(e, authStateModel);
    } catch (e) {
      authStateModel = _handleFirebaseAuthError(e, authStateModel);
    }

    setState(authStateModel);
    return authStateModel;
  }

  /// Registers a new user with email and password.
  ///
  /// Returns an [AuthStateModel] containing the operation result.
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
  Future<AuthStateModel> register(String email, String password) async {
    AuthStateModel authStateModel = AuthStateModel(
      state: AuthState.idle,
      user: null,
      errorMessage: null,
    );

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

      authStateModel = authStateModel.copyWith(
        user: UserModel(
          uid: userCredential.user!.uid,
          email: userCredential.user!.email,
          claims: claims,
        ),
      );
    } on FirebaseAuthException catch (e) {
      authStateModel = _handleFirebaseAuthError(e, authStateModel);
    } catch (e) {
      authStateModel = _handleFirebaseAuthError(e, authStateModel);
    }

    setState(authStateModel);
    return authStateModel;
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

      IdTokenResult idTokenResult = await user!.getIdTokenResult();
      return UserClaims.fromJson(idTokenResult.claims!);
    } catch (e) {
      error('Error fetching user claims: ${e.toString()}', error: e);
    }

    return UserClaims(role: Roles.visitor);
  }

  /// Sends a password reset email to the specified address.
  ///
  /// Returns an [AuthStateModel] indicating whether the operation succeeded.
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
  Future<AuthStateModel> resetPassword(String email) async {
    String? errorString;

    try {
      await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      errorString = e.toString();
      error('Error sending reset email: $errorString');
    }

    return AuthStateModel(state: AuthState.idle, errorMessage: errorString);
  }

  /// Signs out the currently authenticated user.
  ///
  /// This method updates [autState] to null after logout.
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
      setState(
        AuthStateModel(state: AuthState.idle, user: null, errorMessage: null),
      );
    } catch (e) {
      // Handle the error silently or log it
      error('Error during sign out: ${e.toString()}');
    }
  }

  /// Met à jour le profil de l'utilisateur actuellement connecté.
  ///
  /// Returns an [AuthStateModel] containing the operation result.
  ///
  /// Paramètres:
  /// - [username]: Nouveau nom d'utilisateur (optionnel)
  /// - [email]: Nouvelle adresse email (optionnel)
  ///
  /// Example:
  /// ```dart
  /// final result = await authProvider.updateUserProfile(username: 'nouveau_pseudo');
  /// if (result.success) {
  ///   print('Profil mis à jour avec succès');
  /// } else {
  ///   print('Erreur lors de la mise à jour: ${result.error}');
  /// }
  /// ```
  Future<AuthStateModel> updateUserProfile({
    String? username,
    String? email,
  }) async {
    // Vérifier que l'utilisateur est connecté
    if (state == null || state!.user == null) {
      return AuthStateModel(
        state: AuthState.error,
        errorMessage: 'User not authenticated',
      );
    }

    mutateState((currentState) => state!.copyWith(state: AuthState.updating));

    try {
      User? currentFirebaseUser = _auth.currentUser;
      if (currentFirebaseUser == null) {
        throw Exception('User not authenticated');
      }

      if (email != null && email != currentFirebaseUser.email) {
        await currentFirebaseUser.verifyBeforeUpdateEmail(email);
      }

      if (username != null) {
        await currentFirebaseUser.updateProfile(
          displayName: username,
          // TODO : Conserve la photo actuelle ou utilise une chaîne vide
          photoURL: currentFirebaseUser.photoURL ?? "",
        );
      }

      mutateState(
        (currentState) => state!.copyWith(
          state: AuthState.authenticated,
          user: currentState!.user?.copyWith(
            username: username ?? currentFirebaseUser.displayName,
            email: email ?? currentFirebaseUser.email,
          ),
        ),
      );

      return state!;
    } on FirebaseAuthException catch (e) {
      setState(_handleFirebaseAuthError(e, state!));
    } catch (e) {
      setState(_handleFirebaseAuthError(e, state!));
    }

    return state!;
  }

  /// Supprime le compte utilisateur actuellement connecté.
  ///
  /// Cette méthode supprime directement l'utilisateur via Firebase Auth.
  /// Le nettoyage des données associées est géré automatiquement par une Cloud Function.
  ///
  /// Retourne un [AuthStateModel] indiquant le résultat de l'opération.
  ///
  /// Example:
  /// ```dart
  /// final result = await authProvider.deleteUserAccount();
  /// if (result.state != AuthState.error) {
  ///   print('Compte supprimé avec succès');
  ///   // La redirection sera automatique via authStateChanges
  /// } else {
  ///   print('Erreur: ${result.errorMessage}');
  /// }
  /// ```
  Future<AuthStateModel> deleteUserAccount() async {
    // Vérifier que l'utilisateur est connecté
    if (state == null || state!.user == null) {
      return AuthStateModel(
        state: AuthState.error,
        errorMessage: 'User not authenticated',
      );
    }

    // Indiquer que la suppression est en cours
    mutateState(
      (currentState) => currentState!.copyWith(state: AuthState.updating),
    );

    try {
      User? currentFirebaseUser = _auth.currentUser;
      if (currentFirebaseUser == null) {
        throw Exception('User not authenticated');
      }

      await currentFirebaseUser.delete();

      return AuthStateModel(state: AuthState.idle, errorMessage: null);
    } on FirebaseAuthException catch (e) {
      // Gérer spécifiquement le cas où une réauthentification est requise
      if (e.code == 'requires-recent-login') {
        setState(
          state!.copyWith(
            state: AuthState.error,
            errorMessage:
                'Cette opération nécessite une connexion récente. Veuillez vous reconnecter.',
          ),
        );
        return state!;
      }

      setState(_handleFirebaseAuthError(e, state!));
      return state!;
    } catch (e) {
      setState(_handleFirebaseAuthError(e, state!));
      return state!;
    }
  }

  // Créer une méthode utilitaire pour gérer les erreurs Firebase
  AuthStateModel _handleFirebaseAuthError(
    dynamic e,
    AuthStateModel currentState,
  ) {
    String? errorMessage;

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'Aucun utilisateur trouvé avec cet email';
          break;
        case 'wrong-password':
          errorMessage = 'Mot de passe incorrect';
          break;
        case 'email-already-in-use':
          errorMessage = 'Cette adresse email est déjà utilisée';
          break;
        default:
          errorMessage = e.message ?? e.toString();
      }
    } else {
      errorMessage = e.toString();
    }

    error('Auth error: $errorMessage', error: e);

    return currentState.copyWith(
      state: AuthState.error,
      errorMessage: errorMessage,
    );
  }

  /// Fonctionnalités à implementer:
  /// - Réauthentification de l'utilisateur pour les opérations sensibles
  /// - Changement de mot de passe pour l'utilisateur connecté

  @override
  void dispose() {
    _authSubscription?.cancel();
    _initializeCompleter = null;
    super.dispose();
  }
}
