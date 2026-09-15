import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../models/progress_model.dart';
import '../data/mock_data.dart';
import 'progress_service.dart';

/// In-memory game state management for tracking active sessions and stats
class GameService extends ChangeNotifier {
  static final GameService _instance = GameService._internal();
  factory GameService() => _instance;
  GameService._internal() {
    _games = List.from(MockData.initialGames);
  }

  late List<GameModel> _games;

  List<GameModel> get games => List.unmodifiable(_games);

  GameModel? getGameById(String id) {
    try {
      return _games.firstWhere((g) => g.id == id);
    } catch (_) {
      return null;
    }
  }

  /// Records game completion and updates progress metrics
  void recordGameCompletion({
    required String gameId,
    required String gameTitle,
    required int score,
    required int totalPossible,
    required int durationSeconds,
  }) {
    // Update local game stats
    final index = _games.indexWhere((g) => g.id == gameId);
    if (index != -1) {
      final game = _games[index];
      final currentScore = ((score / totalPossible) * 100).round();
      _games[index] = game.copyWith(
        playsCount: game.playsCount + 1,
        bestScore: currentScore > game.bestScore
            ? currentScore
            : game.bestScore,
      );
    }

    // Register session in ProgressService
    ProgressService().addGameSession(
      GameSessionRecord(
        gameTitle: gameTitle,
        timestamp: 'Just now',
        score: score,
        totalPossible: totalPossible,
        durationSeconds: durationSeconds,
      ),
    );

    notifyListeners();
  }
}
