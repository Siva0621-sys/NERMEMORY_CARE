import 'package:flutter/material.dart';

enum ReminderCategory { walk, hydration, medication, game, family, general }

/// Represents a daily reminder for routine and wellness
class ReminderModel {
  final String id;
  final String title;
  final String time; // e.g. "8:00 AM"
  final TimeOfDay timeOfDay;
  final ReminderCategory category;
  final bool isCompleted;
  final bool isEnabled;

  const ReminderModel({
    required this.id,
    required this.title,
    required this.time,
    required this.timeOfDay,
    required this.category,
    this.isCompleted = false,
    this.isEnabled = true,
  });

  IconData get icon {
    switch (category) {
      case ReminderCategory.walk:
        return Icons.directions_walk;
      case ReminderCategory.hydration:
        return Icons.water_drop;
      case ReminderCategory.medication:
        return Icons.medication;
      case ReminderCategory.game:
        return Icons.psychology;
      case ReminderCategory.family:
        return Icons.call;
      case ReminderCategory.general:
        return Icons.alarm;
    }
  }

  Color get categoryColor {
    switch (category) {
      case ReminderCategory.walk:
        return const Color(0xFF2E7D32);
      case ReminderCategory.hydration:
        return const Color(0xFF0288D1);
      case ReminderCategory.medication:
        return const Color(0xFFC2185B);
      case ReminderCategory.game:
        return const Color(0xFF00796B);
      case ReminderCategory.family:
        return const Color(0xFFE65100);
      case ReminderCategory.general:
        return const Color(0xFF5E35B1);
    }
  }

  String get categoryName {
    switch (category) {
      case ReminderCategory.walk:
        return 'Physical Activity';
      case ReminderCategory.hydration:
        return 'Hydration';
      case ReminderCategory.medication:
        return 'Wellness Care';
      case ReminderCategory.game:
        return 'Cognitive Practice';
      case ReminderCategory.family:
        return 'Social Connection';
      case ReminderCategory.general:
        return 'General';
    }
  }

  ReminderModel copyWith({
    String? id,
    String? title,
    String? time,
    TimeOfDay? timeOfDay,
    ReminderCategory? category,
    bool? isCompleted,
    bool? isEnabled,
  }) {
    return ReminderModel(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
      timeOfDay: timeOfDay ?? this.timeOfDay,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}
