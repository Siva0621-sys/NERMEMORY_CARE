import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/widgets/app_card.dart';
import '../models/game_model.dart';

/// Interactive game card for game selection screen and patient home
class GameCard extends StatelessWidget {
  final GameModel game;
  final VoidCallback onPlay;
  final bool isElderlyView;

  const GameCard({
    super.key,
    required this.game,
    required this.onPlay,
    this.isElderlyView = false,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onPlay,
      margin: const EdgeInsets.only(bottom: 14),
      padding: EdgeInsets.all(isElderlyView ? 20 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            width: isElderlyView ? 68 : 58,
            height: isElderlyView ? 68 : 58,
            decoration: BoxDecoration(
              color: game.themeColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: game.themeColor.withValues(alpha: 0.25),
                width: 1.5,
              ),
            ),
            child: Icon(
              game.icon,
              size: isElderlyView ? 36 : 30,
              color: game.themeColor,
            ),
          ),
          const SizedBox(width: 16),
          // Game Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        game.title,
                        style: TextStyle(
                          fontSize: isElderlyView ? 19 : 17,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.neutralTextDark,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.accentGreenLight,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        game.difficulty,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.accentGreen,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  game.description,
                  style: TextStyle(
                    fontSize: isElderlyView ? 14 : 13,
                    color: AppConstants.neutralTextMuted,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (!isElderlyView && game.playsCount > 0) ...[
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.history_rounded,
                        size: 14,
                        color: AppConstants.neutralTextMuted,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Played ${game.playsCount} times',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppConstants.neutralTextMuted,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: Color(0xFFF57C00),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Best: ${game.bestScore}%',
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: AppConstants.neutralTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          // Play Button Icon
          Container(
            padding: EdgeInsets.all(isElderlyView ? 12 : 10),
            decoration: BoxDecoration(
              color: game.themeColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: isElderlyView ? 26 : 22,
            ),
          ),
        ],
      ),
    );
  }
}
