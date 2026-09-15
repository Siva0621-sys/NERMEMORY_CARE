import 'package:flutter/material.dart';

/// Represents a cognitive game available in the platform
class GameModel {
  final String id;
  final String title;
  final String description;
  final String difficulty;
  final IconData icon;
  final Color themeColor;
  final bool isPlayable;
  final int playsCount;
  final int bestScore;

  const GameModel({
    required this.id,
    required this.title,
    required this.description,
    this.difficulty = 'Easy',
    required this.icon,
    required this.themeColor,
    this.isPlayable = true,
    this.playsCount = 0,
    this.bestScore = 0,
  });

  GameModel copyWith({
    String? id,
    String? title,
    String? description,
    String? difficulty,
    IconData? icon,
    Color? themeColor,
    bool? isPlayable,
    int? playsCount,
    int? bestScore,
  }) {
    return GameModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      difficulty: difficulty ?? this.difficulty,
      icon: icon ?? this.icon,
      themeColor: themeColor ?? this.themeColor,
      isPlayable: isPlayable ?? this.isPlayable,
      playsCount: playsCount ?? this.playsCount,
      bestScore: bestScore ?? this.bestScore,
    );
  }
}
