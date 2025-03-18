abstract class NavigationState {
  /// L'URL ou le chemin de la route actuelle
  String get path;

  /// Les paramètres de l'URL ou de la route
  Map<String, String> get params;

  /// Les paramètres de requête (query parameters)
  Map<String, String> get queryParams;

  /// Informations additionnelles spécifiques à l'implémentation
  Map<String, dynamic> get extra;
}
