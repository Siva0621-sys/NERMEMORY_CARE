import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../services/progress_service.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/progress_chart.dart';

/// Caregiver screen displaying cognitive activity progress and trends
class CaregiverProgressScreen extends StatefulWidget {
  const CaregiverProgressScreen({super.key});

  @override
  State<CaregiverProgressScreen> createState() =>
      _CaregiverProgressScreenState();
}

class _CaregiverProgressScreenState extends State<CaregiverProgressScreen> {
  late final ProgressService _progressService;

  @override
  void initState() {
    super.initState();
    _progressService = ProgressService();
    _progressService.addListener(_onProgressChanged);
  }

  @override
  void dispose() {
    _progressService.removeListener(_onProgressChanged);
    super.dispose();
  }

  void _onProgressChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final progress = _progressService.progress;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Activity Progress'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Summary Metrics Grid
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 1.35,
                children: [
                  StatCard(
                    label: 'Games Completed',
                    value: '${progress.gamesCompleted}',
                    subtitle: 'Today',
                    icon: Icons.sports_esports_rounded,
                    iconColor: AppConstants.primaryTeal,
                    iconBgColor: AppConstants.primaryTealLight,
                  ),
                  StatCard(
                    label: 'Activity Time',
                    value: '${progress.totalActivityMinutes}m',
                    subtitle: 'Active',
                    icon: Icons.timer_rounded,
                    iconColor: AppConstants.softBlue,
                    iconBgColor: AppConstants.softBlueLight,
                  ),
                  StatCard(
                    label: 'Game Accuracy',
                    value: '${progress.gameAccuracyPercentage}%',
                    subtitle: 'Average',
                    icon: Icons.check_circle_outline_rounded,
                    iconColor: AppConstants.accentGreen,
                    iconBgColor: AppConstants.accentGreenLight,
                  ),
                  StatCard(
                    label: 'Current Streak',
                    value: '${progress.currentStreakDays} Days',
                    subtitle: 'Consistent',
                    icon: Icons.local_fire_department_rounded,
                    iconColor: const Color(0xFFF57C00),
                    iconBgColor: const Color(0xFFFFF3E0),
                  ),
                ],
              ),
              const SizedBox(height: 18),

              // Weekly Progress Chart Card
              AppCard(
                padding: const EdgeInsets.all(18),
                child: ProgressChart(records: progress.weeklyHistory),
              ),
              const SizedBox(height: 18),

              // Encouraging Message
              const AchievementCard(
                title: '7-Day Cognitive Engagement Streak!',
                subtitle:
                    'Meena has practiced daily memory routines for a full week. Consistent engagement brings comfort and structure.',
                icon: Icons.emoji_events_rounded,
                iconColor: Color(0xFFF57C00),
                backgroundColor: Color(0xFFFFF8E1),
                badgeText: 'Milestone',
              ),
              const SizedBox(height: 20),

              // Recent Game Results Section
              const SectionHeader(
                title: 'Recent Game Sessions',
                subtitle: 'Recorded practice sessions for today',
                icon: Icons.history_rounded,
              ),
              const SizedBox(height: 8),

              if (progress.recentSessions.isEmpty)
                const AppCard(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text('No games played yet today.'),
                    ),
                  ),
                )
              else
                ...progress.recentSessions.map(
                  (session) => AppCard(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppConstants.primaryTealLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.psychology_rounded,
                            color: AppConstants.primaryTealDark,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                session.gameTitle,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w700,
                                  color: AppConstants.neutralTextDark,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${session.timestamp} • Duration: ${(session.durationSeconds / 60).toStringAsFixed(1)}m',
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.neutralTextMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${session.accuracyPercentage}%',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w800,
                                color: AppConstants.accentGreen,
                              ),
                            ),
                            const Text(
                              'Accuracy',
                              style: TextStyle(
                                fontSize: 11,
                                color: AppConstants.neutralTextMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),

              // Non-medical Disclaimer (Required by MedTech guidelines)
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppConstants.cardBorderColor),
                ),
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.shield_outlined,
                      size: 20,
                      color: AppConstants.neutralTextMuted,
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        AppConstants.medicalDisclaimer,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppConstants.neutralTextMuted,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
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
