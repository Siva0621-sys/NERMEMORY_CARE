import 'package:flutter/material.dart';
import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';
import 'screens/onboarding/welcome_screen.dart';
import 'services/app_state_notifier.dart';

/// Root application widget configuring theme, accessibility scale, and initial route
class MemoryCareApp extends StatefulWidget {
  const MemoryCareApp({super.key});

  @override
  State<MemoryCareApp> createState() => _MemoryCareAppState();
}

class _MemoryCareAppState extends State<MemoryCareApp> {
  late final AppStateNotifier _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppStateNotifier();
    _appState.addListener(_onStateChange);
  }

  @override
  void dispose() {
    _appState.removeListener(_onStateChange);
    super.dispose();
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = _appState.isHighContrast
        ? AppTheme.highContrastTheme
        : AppTheme.lightTheme;

    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: theme,
      builder: (context, child) {
        // Apply accessibility text scaling factor globally
        return MediaQuery(
          data: MediaQuery.of(
            context,
          ).copyWith(textScaler: TextScaler.linear(_appState.textScaleFactor)),
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const WelcomeScreen(),
    );
  }
}
