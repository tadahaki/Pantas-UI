import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class PantasApp extends StatelessWidget {
  const PantasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PANTAS',
      theme: AppTheme.lightTheme,
      routerConfig: AppRouter.router,
    );
  }
}
