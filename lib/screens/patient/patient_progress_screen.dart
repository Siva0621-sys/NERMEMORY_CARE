import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../services/progress_service.dart';
import '../../widgets/achievement_card.dart';

/// Simplified encouraging progress milestone view for Elderly User
class PatientProgressScreen extends StatefulWidget {
  const PatientProgressScreen({super.key});

  @override
  State<PatientProgressScreen> createState() => _PatientProgressScreenState();
}

class _PatientProgressScreenState extends State<PatientProgressScreen> {
  late final ProgressService _progressService;

  @override
  void initState() {
    super.initState();
    _progressService = ProgressService();
    _progressService.addListener(_onChanged);
  }

  @override
  void dispose() {
    _progressService.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressService.progress;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('My Daily Stars'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Celebration Star Box
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  border: Border.all(
                    color: AppConstants.cardBorderColor,
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF8E1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.star_rounded,
                        size: 64,
                        color: Color(0xFFF57C00),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      '${progress.gamesCompleted} Activities Completed Today!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: AppConstants.neutralTextDark,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Every little moment helps keep your mind active and bright.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: AppConstants.neutralTextMuted,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Streak Highlight
              AppCard(
                color: const Color(0xFFE8F5E9),
                borderColor: AppConstants.accentGreen.withValues(alpha: 0.3),
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    const Icon(
                      Icons.local_fire_department_rounded,
                      size: 40,
                      color: Color(0xFFF57C00),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${progress.currentStreakDays} Days in a Row!',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'You have visited every day this week. Wonderful dedication, Meena!',
                            style: TextStyle(
                              fontSize: 14,
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

              // Encouraging Quote
              const AchievementCard(
                title: '“Small moments. Stronger memories.”',
                subtitle:
                    'Take a gentle walk, sip your warm tea, and smile at your achievements today.',
                icon: Icons.spa_rounded,
                iconColor: AppConstants.primaryTeal,
                backgroundColor: Color(0xFFE0F2F1),
              ),
              const SizedBox(height: 24),

              // Demo data reminder
              const Text(
                'Activity statistics are for demonstration and encouragement.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                  color: AppConstants.neutralTextMuted,
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
