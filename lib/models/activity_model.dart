import 'package:flutter/material.dart';

enum ActivityPeriod { morning, afternoon, evening }

/// Model for patient's daily activity timeline
class ActivityModel {
  final String id;
  final String title;
  final String subtitle;
  final ActivityPeriod period;
  final String time;
  final IconData icon;
  final Color iconColor;
  final bool isCompleted;

  const ActivityModel({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.period,
    required this.time,
    required this.icon,
    required this.iconColor,
    this.isCompleted = true,
  });

  String get periodLabel {
    switch (period) {
      case ActivityPeriod.morning:
        return 'Morning';
      case ActivityPeriod.afternoon:
        return 'Afternoon';
      case ActivityPeriod.evening:
        return 'Evening';
    }
  }
}
