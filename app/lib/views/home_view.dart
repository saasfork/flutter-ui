import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_firebase_service/firebase_auth_provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseAuthProvider = Provider.of<SFFirebaseAuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => firebaseAuthProvider.signOut(),
          ),
        ],
      ),
      body: const Placeholder(),
    );
  }
}
