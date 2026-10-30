import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'screens/splash/splash_screen.dart';
import 'state/app_controller.dart';
import 'state/app_scope.dart';

/// Root widget: menyiapkan state aplikasi, tema, dan halaman pertama.
class CatatAjaApp extends StatefulWidget {
  const CatatAjaApp({super.key});

  @override
  State<CatatAjaApp> createState() => _CatatAjaAppState();
}

class _CatatAjaAppState extends State<CatatAjaApp> {
  late final AppController _controller = AppController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScope(
      controller: _controller,
      child: MaterialApp(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light(),
        home: const SplashScreen(),
      ),
    );
  }
}
