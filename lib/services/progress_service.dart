import 'package:flutter/material.dart';
import '../models/progress_model.dart';
import '../data/mock_data.dart';

/// Progress tracking service for caregiver insights
class ProgressService extends ChangeNotifier {
  static final ProgressService _instance = ProgressService._internal();
  factory ProgressService() => _instance;
  ProgressService._internal() {
    _progress = MockData.initialProgress;
  }

  late ProgressModel _progress;

  ProgressModel get progress => _progress;

  int get gamesCompleted => _progress.gamesCompleted;
  int get totalActivityMinutes => _progress.totalActivityMinutes;
  int get accuracyPercentage => _progress.gameAccuracyPercentage;
  int get currentStreak => _progress.currentStreakDays;
  List<DailyActivityRecord> get weeklyHistory => _progress.weeklyHistory;
  List<GameSessionRecord> get recentSessions => _progress.recentSessions;

  void addGameSession(GameSessionRecord session) {
    final updatedSessions = [session, ..._progress.recentSessions];
    final additionalMinutes = (session.durationSeconds / 60).ceil();

    // Recalculate average accuracy
    int totalScore = 0;
    int totalPossible = 0;
    for (final s in updatedSessions) {
      totalScore += s.score;
      totalPossible += s.totalPossible;
    }
    final avgAccuracy = totalPossible > 0
        ? ((totalScore / totalPossible) * 100).round()
        : _progress.gameAccuracyPercentage;

    // Update today's entry in weekly history
    final updatedWeekly = _progress.weeklyHistory.map((d) {
      if (d.isToday) {
        return DailyActivityRecord(
          dayName: d.dayName,
          shortDay: d.shortDay,
          minutes: d.minutes + additionalMinutes,
          isToday: true,
        );
      }
      return d;
    }).toList();

    _progress = _progress.copyWith(
      gamesCompleted: _progress.gamesCompleted + 1,
      totalActivityMinutes: _progress.totalActivityMinutes + additionalMinutes,
      gameAccuracyPercentage: avgAccuracy,
      weeklyHistory: updatedWeekly,
      recentSessions: updatedSessions,
    );

    notifyListeners();
  }

  void resetToDemo() {
    _progress = MockData.initialProgress;
    notifyListeners();
  }
}
