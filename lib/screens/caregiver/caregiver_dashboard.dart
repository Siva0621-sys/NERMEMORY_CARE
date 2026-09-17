import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../core/widgets/stat_card.dart';
import '../../data/mock_data.dart';
import '../../services/app_state_notifier.dart';
import '../../services/progress_service.dart';
import '../../services/reminder_service.dart';
import '../../widgets/achievement_card.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/daily_activity_card.dart';
import '../../widgets/greeting_card.dart';
import '../../widgets/patient_avatar.dart';
import '../../widgets/voice_assistant_card.dart';
import '../patient/cognitive_games_screen.dart';
import '../patient/patient_home_screen.dart';
import 'caregiver_profile_screen.dart';
import 'patient_progress_screen.dart';
import 'reminders_screen.dart';

/// Caregiver Dashboard showcasing patient overview, stats, timeline, and quick actions
class CaregiverDashboard extends StatefulWidget {
  final int initialTabIndex;
  const CaregiverDashboard({super.key, this.initialTabIndex = 0});

  @override
  State<CaregiverDashboard> createState() => _CaregiverDashboardState();
}

class _CaregiverDashboardState extends State<CaregiverDashboard> {
  late int _currentTabIndex;
  late final ProgressService _progressService;
  late final ReminderService _reminderService;
  late final AppStateNotifier _appState;

  @override
  void initState() {
    super.initState();
    _currentTabIndex = widget.initialTabIndex;
    _progressService = ProgressService();
    _reminderService = ReminderService();
    _appState = AppStateNotifier();

    _progressService.addListener(_onStateUpdate);
    _reminderService.addListener(_onStateUpdate);
    _appState.addListener(_onStateUpdate);
  }

  @override
  void dispose() {
    _progressService.removeListener(_onStateUpdate);
    _reminderService.removeListener(_onStateUpdate);
    _appState.removeListener(_onStateUpdate);
    super.dispose();
  }

  void _onStateUpdate() {
    if (mounted) setState(() {});
  }

  void _switchToElderlyMode() {
    _appState.setUserMode(UserMode.elderly);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PatientHomeScreen()),
    );
  }

  Widget _buildHomeTab() {
    final progress = _progressService.progress;
    final patient = _appState.patient;
    final activities = MockData.initialActivities;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('NER MemoryCare'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_rounded),
            tooltip: 'Notifications',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Demo notification: Meena completed today’s morning walk.',
                  ),
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.swap_horiz_rounded,
              color: AppConstants.primaryTeal,
            ),
            tooltip: 'Switch to Elderly View',
            onPressed: _switchToElderlyMode,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Header Card
              GreetingCard(
                isCaregiver: true,
                onModeSwitch: _switchToElderlyMode,
              ),
              const SizedBox(height: 18),

              // Main Patient Card: Today's Care Overview
              AppCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PatientAvatar(
                          size: 56,
                          name: patient.name,
                          showStatusRing: true,
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    patient.name,
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                      color: AppConstants.neutralTextDark,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 8,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppConstants.primaryTealLight,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: const Text(
                                      'Demo Profile',
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        color: AppConstants.primaryTealDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 3),
                              const Text(
                                "Today's Care Overview",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.neutralTextMuted,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Last Activity: Everyday Objects (35m ago)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppConstants.accentGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppConstants.secondaryCream,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.sentiment_satisfied_alt_rounded,
                            size: 20,
                            color: AppConstants.primaryTeal,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Meena completed 3 cognitive games and is in good spirits today.',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppConstants.neutralTextDark,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Statistics Cards Grid
              const SectionHeader(
                title: 'Cognitive Engagement Stats',
                subtitle: 'Daily monitoring metrics for Meena',
                icon: Icons.bar_chart_rounded,
              ),
              const SizedBox(height: 8),

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
                    onTap: () => setState(() => _currentTabIndex = 1),
                  ),
                  StatCard(
                    label: 'Activity Time',
                    value: '${progress.totalActivityMinutes} min',
                    subtitle: 'Total',
                    icon: Icons.access_time_rounded,
                    iconColor: AppConstants.softBlue,
                    iconBgColor: AppConstants.softBlueLight,
                    onTap: () => setState(() => _currentTabIndex = 1),
                  ),
                  StatCard(
                    label: 'Game Accuracy',
                    value: '${progress.gameAccuracyPercentage}%',
                    subtitle: 'Average',
                    icon: Icons.task_alt_rounded,
                    iconColor: AppConstants.accentGreen,
                    iconBgColor: AppConstants.accentGreenLight,
                    onTap: () => setState(() => _currentTabIndex = 1),
                  ),
                  StatCard(
                    label: 'Current Streak',
                    value: '${progress.currentStreakDays} days',
                    subtitle: 'Consistent',
                    icon: Icons.local_fire_department_rounded,
                    iconColor: const Color(0xFFF57C00),
                    iconBgColor: const Color(0xFFFFF3E0),
                    onTap: () => setState(() => _currentTabIndex = 1),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Quick Actions
              const SectionHeader(
                title: 'Quick Actions',
                icon: Icons.flash_on_rounded,
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      label: 'View Progress',
                      icon: Icons.insights_rounded,
                      color: AppConstants.primaryTeal,
                      onTap: () => setState(() => _currentTabIndex = 1),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickActionButton(
                      label: 'Reminders',
                      icon: Icons.alarm_rounded,
                      color: const Color(0xFF1976D2),
                      onTap: () => setState(() => _currentTabIndex = 2),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: _buildQuickActionButton(
                      label: 'Patient Profile',
                      icon: Icons.badge_outlined,
                      color: const Color(0xFF7B1FA2),
                      onTap: () => setState(() => _currentTabIndex = 3),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _buildQuickActionButton(
                      label: 'Explore Games',
                      icon: Icons.sports_esports_outlined,
                      color: AppConstants.accentGreen,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const CognitiveGamesScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 22),

              // Daily Activity Timeline
              SectionHeader(
                title: 'Daily Activity Timeline',
                subtitle: "Meena's completed and scheduled steps today",
                icon: Icons.schedule_rounded,
                actionText: 'View All',
                onActionTap: () => setState(() => _currentTabIndex = 1),
              ),
              const SizedBox(height: 8),

              ...activities.asMap().entries.map((entry) {
                final idx = entry.key;
                final act = entry.value;
                return DailyActivityCard(
                  activity: act,
                  isLast: idx == activities.length - 1,
                );
              }),
              const SizedBox(height: 16),

              // Encouragement Card
              const AchievementCard(
                title: 'Every little moment of engagement matters.',
                subtitle:
                    'Keep encouraging and supporting your loved one. Gentle daily repetition maintains familiarity and comfort.',
                icon: Icons.volunteer_activism_rounded,
                iconColor: AppConstants.primaryTeal,
                backgroundColor: Color(0xFFE0F2F1),
              ),
              const SizedBox(height: 16),

              // Voice Assistant Preview Card
              const VoiceAssistantCard(isElderly: false),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppConstants.neutralTextDark,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget activeBody;
    switch (_currentTabIndex) {
      case 0:
        activeBody = _buildHomeTab();
        break;
      case 1:
        activeBody = const CaregiverProgressScreen();
        break;
      case 2:
        activeBody = const CaregiverRemindersScreen();
        break;
      case 3:
        activeBody = const CaregiverProfileScreen();
        break;
      default:
        activeBody = _buildHomeTab();
    }

    return Scaffold(
      body: activeBody,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentTabIndex,
        onTap: (idx) => setState(() => _currentTabIndex = idx),
        isElderly: false,
      ),
    );
  }
}
