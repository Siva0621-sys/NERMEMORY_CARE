import 'package:flutter/material.dart';
import '../models/patient_model.dart';
import '../models/game_model.dart';
import '../models/activity_model.dart';
import '../models/reminder_model.dart';
import '../models/progress_model.dart';

/// Centralized realistic mock data for NER MemoryCare
/// All patient data is fictional and clearly framed for prototype demonstration.
class MockData {
  MockData._();

  /// Default Demo Patient: Meena
  static final PatientModel defaultPatient = PatientModel(
    id: 'patient_001',
    name: 'Meena',
    status: 'Demo Profile',
    location: 'Guwahati, Assam (NER)',
    caregiverName: 'Aarav (Son)',
    emergencyPhone: '+91 98765 43210',
    doctorContact: 'Dr. H. Sharma (+91 98765 12345)',
    preferredLanguage: 'English',
    notes: 'Likes afternoon tea garden walks and soft memory games.',
  );

  /// 5 Cognitive Games catalog
  static final List<GameModel> initialGames = [
    const GameModel(
      id: 'memory_match',
      title: 'Memory Match',
      description: 'Find matching pairs of familiar North Eastern symbols.',
      difficulty: 'Easy',
      icon: Icons.grid_view_rounded,
      themeColor: Color(0xFF00796B),
      isPlayable: true,
      playsCount: 2,
      bestScore: 85,
    ),
    const GameModel(
      id: 'remember_picture',
      title: 'Remember the Picture',
      description: 'Look carefully at the picture, remember it, and spot it.',
      difficulty: 'Easy',
      icon: Icons.photo_library_rounded,
      themeColor: Color(0xFF1976D2),
      isPlayable: true,
      playsCount: 1,
      bestScore: 90,
    ),
    const GameModel(
      id: 'everyday_objects',
      title: 'Everyday Objects',
      description: 'Recognize and tap familiar everyday objects and utilities.',
      difficulty: 'Easy',
      icon: Icons.coffee_rounded,
      themeColor: Color(0xFF2E7D32),
      isPlayable: true,
      playsCount: 2,
      bestScore: 80,
    ),
    const GameModel(
      id: 'find_different',
      title: 'Find the Different One',
      description: 'Spot the gentle item that looks different from the group.',
      difficulty: 'Easy',
      icon: Icons.visibility_rounded,
      themeColor: Color(0xFFE65100),
      isPlayable: true,
      playsCount: 0,
      bestScore: 0,
    ),
    const GameModel(
      id: 'pattern_memory',
      title: 'Pattern Memory',
      description: 'Remember a simple sequence of colors and symbols.',
      difficulty: 'Easy',
      icon: Icons.grain_rounded,
      themeColor: Color(0xFF7B1FA2),
      isPlayable: true,
      playsCount: 0,
      bestScore: 0,
    ),
  ];

  /// Initial Reminders
  static final List<ReminderModel> initialReminders = [
    const ReminderModel(
      id: 'rem_1',
      title: 'Morning Walk',
      time: '8:00 AM',
      timeOfDay: TimeOfDay(hour: 8, minute: 0),
      category: ReminderCategory.walk,
      isCompleted: true,
      isEnabled: true,
    ),
    const ReminderModel(
      id: 'rem_2',
      title: 'Drink Water',
      time: '10:00 AM',
      timeOfDay: TimeOfDay(hour: 10, minute: 0),
      category: ReminderCategory.hydration,
      isCompleted: true,
      isEnabled: true,
    ),
    const ReminderModel(
      id: 'rem_3',
      title: 'Memory Game',
      time: '4:00 PM',
      timeOfDay: TimeOfDay(hour: 16, minute: 0),
      category: ReminderCategory.game,
      isCompleted: true,
      isEnabled: true,
    ),
    const ReminderModel(
      id: 'rem_4',
      title: 'Family Call',
      time: '6:30 PM',
      timeOfDay: TimeOfDay(hour: 18, minute: 30),
      category: ReminderCategory.family,
      isCompleted: false,
      isEnabled: true,
    ),
  ];

  /// Daily Activity Timeline
  static final List<ActivityModel> initialActivities = [
    const ActivityModel(
      id: 'act_1',
      title: 'Morning Walk & Fresh Air',
      subtitle: 'Completed 15 minutes of gentle stroll.',
      period: ActivityPeriod.morning,
      time: '8:15 AM',
      icon: Icons.directions_walk,
      iconColor: Color(0xFF2E7D32),
      isCompleted: true,
    ),
    const ActivityModel(
      id: 'act_2',
      title: 'Memory Match Activity',
      subtitle: 'Completed 6 card pairs with great focus.',
      period: ActivityPeriod.morning,
      time: '11:00 AM',
      icon: Icons.grid_view_rounded,
      iconColor: Color(0xFF00796B),
      isCompleted: true,
    ),
    const ActivityModel(
      id: 'act_3',
      title: 'Everyday Objects Recognition',
      subtitle: 'Recognized 4 everyday household items.',
      period: ActivityPeriod.afternoon,
      time: '3:30 PM',
      icon: Icons.coffee_rounded,
      iconColor: Color(0xFF1976D2),
      isCompleted: true,
    ),
    const ActivityModel(
      id: 'act_4',
      title: 'Family Call Scheduled',
      subtitle: 'Upcoming call with granddaughter Ananya.',
      period: ActivityPeriod.evening,
      time: '6:30 PM',
      icon: Icons.call,
      iconColor: Color(0xFFE65100),
      isCompleted: false,
    ),
  ];

  /// Initial Progress Summary
  static final ProgressModel initialProgress = ProgressModel(
    gamesCompleted: 3,
    totalActivityMinutes: 18,
    gameAccuracyPercentage: 82,
    currentStreakDays: 7,
    weeklyHistory: const [
      DailyActivityRecord(dayName: 'Monday', shortDay: 'M', minutes: 10),
      DailyActivityRecord(dayName: 'Tuesday', shortDay: 'T', minutes: 15),
      DailyActivityRecord(dayName: 'Wednesday', shortDay: 'W', minutes: 8),
      DailyActivityRecord(dayName: 'Thursday', shortDay: 'T', minutes: 18),
      DailyActivityRecord(dayName: 'Friday', shortDay: 'F', minutes: 12),
      DailyActivityRecord(dayName: 'Saturday', shortDay: 'S', minutes: 20),
      DailyActivityRecord(
        dayName: 'Sunday',
        shortDay: 'S',
        minutes: 18,
        isToday: true,
      ),
    ],
    recentSessions: const [
      GameSessionRecord(
        gameTitle: 'Memory Match',
        timestamp: 'Today, 11:05 AM',
        score: 6,
        totalPossible: 6,
        durationSeconds: 140,
      ),
      GameSessionRecord(
        gameTitle: 'Remember the Picture',
        timestamp: 'Today, 2:15 PM',
        score: 3,
        totalPossible: 3,
        durationSeconds: 110,
      ),
      GameSessionRecord(
        gameTitle: 'Everyday Objects',
        timestamp: 'Today, 3:35 PM',
        score: 4,
        totalPossible: 4,
        durationSeconds: 95,
      ),
    ],
  );
}
