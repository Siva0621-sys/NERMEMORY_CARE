import 'package:flutter/material.dart';

/// Helper utilities for formatting and display in NER MemoryCare
class AppUtils {
  AppUtils._();

  /// Returns friendly greeting based on current local time
  static String getTimeBasedGreeting({String? name}) {
    final hour = DateTime.now().hour;
    String greeting;
    if (hour < 12) {
      greeting = 'Good morning';
    } else if (hour < 17) {
      greeting = 'Good afternoon';
    } else {
      greeting = 'Good evening';
    }

    if (name != null && name.trim().isNotEmpty) {
      return '$greeting, $name';
    }
    return greeting;
  }

  /// Format TimeOfDay into 12-hour AM/PM string
  static String formatTimeOfDay(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }

  /// Format DateTime into friendly display
  static String formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  /// Encouraging quotes for elderly and caregiver
  static const List<String> elderlyEncouragements = [
    'Take your time. You are doing great.',
    'Every small memory brings joy.',
    'You are surrounded with care and warmth.',
    'A little game every day keeps the mind bright.',
    'Be proud of the steps you take today.',
  ];

  static const List<String> caregiverEncouragements = [
    'Every little moment of engagement matters.',
    'Your patience and love build a safe world for Meena.',
    'Consistency and warmth are the best therapy.',
    'Remember to take care of yourself too.',
    'You are making an extraordinary difference every single day.',
  ];

  /// Get random encouraging quote
  static String getRandomEncouragement({bool isCaregiver = false}) {
    final list = isCaregiver ? caregiverEncouragements : elderlyEncouragements;
    return list[DateTime.now().second % list.length];
  }
}
