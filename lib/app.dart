import 'package:flutter/material.dart';
import 'package:role_game_app/common_layer/theme/app_theme.dart';
import 'package:role_game_app/presentation_layer/router/router.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        title: 'Gymini',
        routerConfig: router,
        theme: AppTheme.theme,
        supportedLocales: const [
          Locale('en', 'US'),  // English
          Locale('es', 'ES'),  // Spanish
        ],
        locale: const Locale('en', 'US'),  // Default locale
    );
  }
}