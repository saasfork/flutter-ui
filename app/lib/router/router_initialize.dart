import 'package:app/generated/l10n.dart';
import 'package:app/router/router.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class RouterInitialize extends StatelessWidget {
  const RouterInitialize({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.watch<ThemeToggle>().isDarkMode
              ? ThemeMode.dark
              : ThemeMode.light,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.getRouter(context),
    );
  }
}
