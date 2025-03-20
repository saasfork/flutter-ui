import 'package:app/generated/l10n.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:saasfork_design_system/saasfork_design_system.dart';

class RouterInitialize extends ConsumerWidget {
  const RouterInitialize({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = AppRouter(ref);

    return MaterialApp.router(
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      // context.watch<ThemeToggle>().isDarkMode
      //     ? ThemeMode.dark
      //     : ThemeMode.light,
      localizationsDelegates: [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter.config(),
    );
  }
}
