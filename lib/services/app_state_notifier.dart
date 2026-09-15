import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import '../data/mock_data.dart';

enum UserMode { caregiver, elderly }

enum TextScaleOption { normal, large, extraLarge }

/// Global app state notifier managing active user mode, accessibility, and patient data
class AppStateNotifier extends ChangeNotifier {
  static final AppStateNotifier _instance = AppStateNotifier._internal();
  factory AppStateNotifier() => _instance;
  AppStateNotifier._internal() {
    _patient = MockData.defaultPatient;
  }

  UserMode _userMode = UserMode.caregiver;
  TextScaleOption _textScale = TextScaleOption.normal;
  bool _isHighContrast = false;
  bool _reduceAnimations = false;
  String _selectedLanguage = 'English';
  late PatientModel _patient;

  UserMode get userMode => _userMode;
  bool get isCaregiver => _userMode == UserMode.caregiver;
  bool get isElderly => _userMode == UserMode.elderly;

  TextScaleOption get textScale => _textScale;
  double get textScaleFactor {
    switch (_textScale) {
      case TextScaleOption.normal:
        return 1.0;
      case TextScaleOption.large:
        return 1.18;
      case TextScaleOption.extraLarge:
        return 1.35;
    }
  }

  bool get isHighContrast => _isHighContrast;
  bool get reduceAnimations => _reduceAnimations;
  String get selectedLanguage => _selectedLanguage;
  PatientModel get patient => _patient;

  void setUserMode(UserMode mode) {
    _userMode = mode;
    notifyListeners();
  }

  void toggleUserMode() {
    _userMode = _userMode == UserMode.caregiver
        ? UserMode.elderly
        : UserMode.caregiver;
    notifyListeners();
  }

  void setTextScale(TextScaleOption scale) {
    _textScale = scale;
    notifyListeners();
  }

  void setHighContrast(bool value) {
    _isHighContrast = value;
    notifyListeners();
  }

  void setReduceAnimations(bool value) {
    _reduceAnimations = value;
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    _patient = _patient.copyWith(preferredLanguage: language);
    notifyListeners();
  }

  void updatePatient(PatientModel updated) {
    _patient = updated;
    notifyListeners();
  }
}
