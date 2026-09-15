/// Represents daily cognitive activity duration
class DailyActivityRecord {
  final String dayName;
  final String shortDay;
  final int minutes;
  final bool isToday;

  const DailyActivityRecord({
    required this.dayName,
    required this.shortDay,
    required this.minutes,
    this.isToday = false,
  });
}

/// Represents a completed game session record
class GameSessionRecord {
  final String gameTitle;
  final String timestamp;
  final int score;
  final int totalPossible;
  final int durationSeconds;

  const GameSessionRecord({
    required this.gameTitle,
    required this.timestamp,
    required this.score,
    required this.totalPossible,
    required this.durationSeconds,
  });

  int get accuracyPercentage {
    if (totalPossible == 0) return 100;
    return ((score / totalPossible) * 100).round();
  }
}

/// Overall progress summary
class ProgressModel {
  final int gamesCompleted;
  final int totalActivityMinutes;
  final int gameAccuracyPercentage;
  final int currentStreakDays;
  final List<DailyActivityRecord> weeklyHistory;
  final List<GameSessionRecord> recentSessions;

  const ProgressModel({
    required this.gamesCompleted,
    required this.totalActivityMinutes,
    required this.gameAccuracyPercentage,
    required this.currentStreakDays,
    required this.weeklyHistory,
    required this.recentSessions,
  });

  ProgressModel copyWith({
    int? gamesCompleted,
    int? totalActivityMinutes,
    int? gameAccuracyPercentage,
    int? currentStreakDays,
    List<DailyActivityRecord>? weeklyHistory,
    List<GameSessionRecord>? recentSessions,
  }) {
    return ProgressModel(
      gamesCompleted: gamesCompleted ?? this.gamesCompleted,
      totalActivityMinutes: totalActivityMinutes ?? this.totalActivityMinutes,
      gameAccuracyPercentage:
          gameAccuracyPercentage ?? this.gameAccuracyPercentage,
      currentStreakDays: currentStreakDays ?? this.currentStreakDays,
      weeklyHistory: weeklyHistory ?? this.weeklyHistory,
      recentSessions: recentSessions ?? this.recentSessions,
    );
  }
}
