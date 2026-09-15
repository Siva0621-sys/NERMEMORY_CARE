import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/section_header.dart';
import '../../services/game_service.dart';
import '../../widgets/game_card.dart';
import 'game_play_screen.dart';

/// Screen 10: Cognitive Games selection screen for Elderly and Caregiver
class CognitiveGamesScreen extends StatefulWidget {
  final bool isElderlyView;

  const CognitiveGamesScreen({super.key, this.isElderlyView = true});

  @override
  State<CognitiveGamesScreen> createState() => _CognitiveGamesScreenState();
}

class _CognitiveGamesScreenState extends State<CognitiveGamesScreen> {
  late final GameService _gameService;

  @override
  void initState() {
    super.initState();
    _gameService = GameService();
    _gameService.addListener(_onChanged);
  }

  @override
  void dispose() {
    _gameService.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  void _launchGame(String gameId, String gameTitle) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GamePlayScreen(gameId: gameId, gameTitle: gameTitle),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final games = _gameService.games;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text("Let's Play & Remember"),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(widget.isElderlyView ? 20 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Calming Intro Banner
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(widget.isElderlyView ? 20 : 16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  border: Border.all(
                    color: AppConstants.primaryTeal.withValues(alpha: 0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.psychology_rounded,
                        color: AppConstants.primaryTealDark,
                        size: 32,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gentle Activities',
                            style: TextStyle(
                              fontSize: widget.isElderlyView ? 20 : 17,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Choose an activity you enjoy. Play at your own pace.',
                            style: TextStyle(
                              fontSize: widget.isElderlyView ? 14 : 13,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              const SectionHeader(
                title: 'Available Cognitive Games',
                subtitle:
                    'Designed for comfort, familiarity, and calm practice',
                icon: Icons.sports_esports_rounded,
              ),
              const SizedBox(height: 10),

              // Game cards list
              ...games.map((game) {
                return GameCard(
                  game: game,
                  isElderlyView: widget.isElderlyView,
                  onPlay: () => _launchGame(game.id, game.title),
                );
              }),

              const SizedBox(height: 20),
              // Non-medical disclaimer
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: AppConstants.cardBorderColor),
                ),
                child: const Text(
                  AppConstants.medicalDisclaimer,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppConstants.neutralTextMuted,
                    height: 1.3,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
