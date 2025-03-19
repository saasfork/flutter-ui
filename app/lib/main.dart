import 'package:app/router/router_initialize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';
import 'package:saasfork_firebase_service/saasfork_firebase_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterLocalization.instance.ensureInitialized();
  await dotenv.load(fileName: ".env");

  await SFFirebaseBootstrap.initialize(
    apiKey: dotenv.env['FIREBASE_API_KEY']!,
    authDomain: dotenv.env['FIREBASE_AUTH_DOMAIN']!,
    projectId: dotenv.env['FIREBASE_PROJECT_ID']!,
    storageBucket: dotenv.env['FIREBASE_STORAGE_BUCKET']!,
    messagingSenderId: dotenv.env['FIREBASE_MESSAGING_SENDER_ID']!,
    appId: dotenv.env['FIREBASE_APP_ID']!,
    isDev: kDebugMode,
  );

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  Future<SFFirebaseAuthProvider> _initializeAuthProvider() async {
    final provider = SFFirebaseAuthProvider();
    // Attendre que le premier état soit défini (idle ou authentifié)
    await provider.initialize();

    return provider;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeAuthProvider(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO : Vrai loader
          return MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        if (snapshot.hasError) {
          // TODO : Vrai error
          return MaterialApp(
            home: Scaffold(
              body: Center(child: Text('Error: ${snapshot.error}')),
            ),
          );
        }

        final authProvider = snapshot.data!;

        return MultiProvider(
          providers: [
            ChangeNotifierProvider<SFFirebaseAuthProvider>.value(
              value: authProvider,
            ),
            ChangeNotifierProvider<ThemeToggle>(
              create: (context) => ThemeToggle(),
            ),
          ],
          child: RouterInitialize(),
        );
      },
    );
  }
}
