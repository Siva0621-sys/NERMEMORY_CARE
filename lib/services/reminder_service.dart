import 'package:flutter/material.dart';
import '../models/reminder_model.dart';
import '../data/mock_data.dart';

/// In-memory reminder state management with ChangeNotifier
class ReminderService extends ChangeNotifier {
  static final ReminderService _instance = ReminderService._internal();
  factory ReminderService() => _instance;
  ReminderService._internal() {
    _reminders = List.from(MockData.initialReminders);
  }

  late List<ReminderModel> _reminders;

  List<ReminderModel> get reminders => List.unmodifiable(_reminders);

  int get completedCount => _reminders.where((r) => r.isCompleted).length;
  int get totalCount => _reminders.length;
  int get pendingCount =>
      _reminders.where((r) => !r.isCompleted && r.isEnabled).length;

  void toggleCompletion(String id) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      final current = _reminders[index];
      _reminders[index] = current.copyWith(isCompleted: !current.isCompleted);
      notifyListeners();
    }
  }

  void toggleEnabled(String id) {
    final index = _reminders.indexWhere((r) => r.id == id);
    if (index != -1) {
      final current = _reminders[index];
      _reminders[index] = current.copyWith(isEnabled: !current.isEnabled);
      notifyListeners();
    }
  }

  void addReminder(ReminderModel reminder) {
    _reminders.add(reminder);
    notifyListeners();
  }

  void updateReminder(ReminderModel reminder) {
    final index = _reminders.indexWhere((r) => r.id == reminder.id);
    if (index != -1) {
      _reminders[index] = reminder;
      notifyListeners();
    }
  }

  void deleteReminder(String id) {
    _reminders.removeWhere((r) => r.id == id);
    notifyListeners();
  }

  void resetToDemo() {
    _reminders = List.from(MockData.initialReminders);
    notifyListeners();
  }
}
