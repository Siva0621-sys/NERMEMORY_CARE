import 'package:flutter/material.dart';

/// Central application constants for NER MemoryCare
/// SIH 2026 Problem Statement 26003 (MDoNER)
class AppConstants {
  AppConstants._();

  // App Identity
  static const String appName = 'NER MEMORY CARE';
  static const String appTagline = 'Small moments. Stronger memories.';
  static const String appDescription =
      'AI-Based Cognitive Gaming and Memory Assistance Platform for Elderly Dementia Patients in North Eastern Region (NER).';
  static const String problemStatementId = '26003';
  static const String ministry =
      'Ministry of Development of North Eastern Region (MDoNER)';
  static const String appVersion = '1.0.0 (SIH 2026 Prototype)';

  // Calming Healthcare Color Palette (Material 3)
  static const Color primaryTeal = Color(0xFF00796B); // Deep Calm Teal
  static const Color primaryTealDark = Color(0xFF004D40);
  static const Color primaryTealLight = Color(0xFFE0F2F1);
  static const Color secondaryCream = Color(0xFFFAF7F2); // Warm gentle cream
  static const Color secondaryCreamDark = Color(0xFFF0EAE1);
  static const Color accentGreen = Color(0xFF2E7D32); // Gentle forest green
  static const Color accentGreenLight = Color(0xFFE8F5E9);
  static const Color gentleAmber = Color(0xFFE65100); // Gentle warm amber
  static const Color gentleAmberLight = Color(0xFFFFF3E0);
  static const Color softBlue = Color(0xFF1976D2);
  static const Color softBlueLight = Color(0xFFE3F2FD);
  static const Color neutralTextDark = Color(0xFF263238);
  static const Color neutralTextMuted = Color(0xFF546E7A);
  static const Color cardBorderColor = Color(0xFFE2E8F0);

  // High Contrast Palette for Low Vision Accessibility
  static const Color highContrastBackground = Color(0xFF121212);
  static const Color highContrastSurface = Color(0xFF1E1E1E);
  static const Color highContrastYellow = Color(0xFFFFD600);
  static const Color highContrastWhite = Color(0xFFFFFFFF);

  // Layout & Spacing Tokens
  static const double cardRadius = 18.0;
  static const double buttonRadius = 16.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double minTouchTargetElderly = 56.0;

  // Disclaimer
  static const String medicalDisclaimer =
      'Activity information shown here is illustrative demo data, not a medical assessment. '
      'NER MemoryCare is a supportive wellness platform and does not diagnose, cure, or treat dementia.';

  // North Eastern Region Cultural Elements & Symbols
  static const List<Map<String, dynamic>> nerCulturalSymbols = [
    {
      'id': 'tea_leaf',
      'name': 'Assam Tea Garden',
      'icon': Icons.eco,
      'color': Color(0xFF2E7D32),
      'description': 'Lush green tea leaves from the valleys of Assam.',
    },
    {
      'id': 'hornbill',
      'name': 'Great Hornbill',
      'icon': Icons.flutter_dash,
      'color': Color(0xFFF57C00),
      'description': 'The majestic bird of Arunachal Pradesh & Nagaland.',
    },
    {
      'id': 'orchid',
      'name': 'Blue Vanda Orchid',
      'icon': Icons.local_florist,
      'color': Color(0xFF7B1FA2),
      'description': 'Rare and beautiful wild orchids of Meghalaya.',
    },
    {
      'id': 'bamboo',
      'name': 'Mizoram Bamboo',
      'icon': Icons.forest,
      'color': Color(0xFF388E3C),
      'description': 'Evergreen bamboo crafts of Mizoram and Tripura.',
    },
    {
      'id': 'loom',
      'name': 'Traditional Loom',
      'icon': Icons.texture,
      'color': Color(0xFFC2185B),
      'description': 'Intricate handwoven patterns of Manipur and Assam.',
    },
    {
      'id': 'dhol',
      'name': 'Bihu Dhol Drum',
      'icon': Icons.music_note,
      'color': Color(0xFFD84315),
      'description': 'Rhythmic folk celebration drum of the Brahmaputra.',
    },
  ];
}
