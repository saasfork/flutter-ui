import 'package:flutter/material.dart';

/// An abstract class for state management that extends [ChangeNotifier].
///
/// This class serves as a base for implementing state management solutions
/// that need to notify listeners when state changes.
///
/// Example implementation:
/// ```dart
/// class CounterNotifier extends StateNotifier<int> {
///   // Initialize with a default value
///   CounterNotifier() {
///     setState(0);
///   }
///
///   void increment() {
///     setState((state ?? 0) + 1);
///   }
///
///   void decrement() {
///     setState((state ?? 0) - 1);
///   }
/// }
/// ```
///
/// Usage example:
/// ```dart
/// // Create an instance
/// final counter = CounterNotifier();
///
/// // Add a listener
/// counter.addListener(() {
///   print('Counter changed to ${counter.state}');
/// });
///
/// // Update state
/// counter.increment(); // Prints: Counter changed to 1
///
/// // Use with a provider
/// ChangeNotifierProvider(
///   create: (_) => CounterNotifier(),
///   child: Consumer<CounterNotifier>(
///     builder: (context, notifier, _) => Text('${notifier.state}'),
///   ),
/// );
/// ```
abstract class StateNotifier<T> extends ChangeNotifier {
  /// Internal state value that can be null.
  T? _state;

  /// Returns the current state value.
  ///
  /// May return null if the state hasn't been initialized or has been reset.
  ///
  /// Example:
  /// ```dart
  /// final authNotifier = AuthNotifier();
  /// if (authNotifier.state != null) {
  ///   // User is logged in
  /// }
  /// ```
  T? get state => _state;

  /// Updates the state with a new value and notifies all listeners.
  ///
  /// This will trigger a rebuild of all widgets that depend on this notifier.
  ///
  /// Example:
  /// ```dart
  /// class UserNotifier extends StateNotifier<User> {
  ///   void login(User user) {
  ///     setState(user); // Update state and notify listeners
  ///   }
  /// }
  /// ```
  void setState(T newState) {
    _state = newState;
    notifyListeners();
  }

  /// Resets the state to null and notifies all listeners.
  ///
  /// This is useful for clearing the state, such as when logging out a user
  /// or resetting a form.
  ///
  /// Example:
  /// ```dart
  /// class AuthNotifier extends StateNotifier<AuthState> {
  ///   void logout() {
  ///     // Clear user data
  ///     resetState();
  ///     // Navigate to login screen
  ///   }
  /// }
  /// ```
  void resetState() {
    _state = null;
    notifyListeners();
  }
}
