import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/primary_button.dart';
import '../../services/app_state_notifier.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/greeting_card.dart';
import '../../widgets/voice_assistant_card.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../shared/help_screen.dart';
import 'cognitive_games_screen.dart';
import 'patient_profile_screen.dart';
import 'patient_progress_screen.dart';
import 'patient_reminders_screen.dart';

/// Screen 9: Elderly User Home Screen designed for high accessibility and calmness
class PatientHomeScreen extends StatefulWidget {
  const PatientHomeScreen({super.key});

  @override
  State<PatientHomeScreen> createState() => _PatientHomeScreenState();
}

class _PatientHomeScreenState extends State<PatientHomeScreen> {
  int _currentTabIndex = 0;
  late final AppStateNotifier _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppStateNotifier();
    _appState.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _appState.removeListener(_onStateChanged);
    super.dispose();
  }

  void _onStateChanged() {
    if (mounted) setState(() {});
  }

  void _switchToCaregiver() {
    _appState.setUserMode(UserMode.caregiver);
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const CaregiverDashboard()),
    );
  }

  Widget _buildHomeTab() {
    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('NER MemoryCare'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.swap_horiz_rounded,
              color: AppConstants.primaryTeal,
            ),
            tooltip: 'Switch to Caregiver Dashboard',
            onPressed: _switchToCaregiver,
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Greeting Card
              GreetingCard(
                isCaregiver: false,
                onModeSwitch: _switchToCaregiver,
              ),
              const SizedBox(height: 20),

              // Main Action: Big "Play a Game" Button
              PrimaryButton(
                label: 'Play a Game',
                icon: Icons.play_circle_filled_rounded,
                isLarge: true,
                onPressed: () {
                  setState(() => _currentTabIndex = 1);
                },
              ),
              const SizedBox(height: 16),

              // Friendly Reassuring Message Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFF8E1), // Soft warm amber
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  border: Border.all(
                    color: const Color(0xFFFFD54F).withValues(alpha: 0.5),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.spa_rounded, color: Color(0xFFF57C00), size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Take your time. You are doing great today.',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFFE65100),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // 4 Large Accessible Activity Tiles (2x2 Grid)
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Today's Activities",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppConstants.neutralTextDark,
                    letterSpacing: -0.3,
                  ),
                ),
              ),
              const SizedBox(height: 14),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 1.05,
                children: [
                  // Tile 1: Memory Games
                  _buildAccessibleTile(
                    title: 'Memory Games',
                    subtitle: 'Play & match',
                    icon: Icons.sports_esports_rounded,
                    color: AppConstants.primaryTeal,
                    bgColor: AppConstants.primaryTealLight,
                    onTap: () => setState(() => _currentTabIndex = 1),
                  ),
                  // Tile 2: Daily Reminders
                  _buildAccessibleTile(
                    title: 'Daily Reminders',
                    subtitle: 'Walk, tea & calls',
                    icon: Icons.alarm_rounded,
                    color: const Color(0xFF1976D2),
                    bgColor: const Color(0xFFE3F2FD),
                    onTap: () => setState(() => _currentTabIndex = 2),
                  ),
                  // Tile 3: My Progress
                  _buildAccessibleTile(
                    title: 'My Stars',
                    subtitle: 'See your streak',
                    icon: Icons.star_rounded,
                    color: const Color(0xFFF57C00),
                    bgColor: const Color(0xFFFFF3E0),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PatientProgressScreen(),
                        ),
                      );
                    },
                  ),
                  // Tile 4: Help & Support
                  _buildAccessibleTile(
                    title: 'Help & Guide',
                    subtitle: 'Simple instructions',
                    icon: Icons.help_outline_rounded,
                    color: AppConstants.accentGreen,
                    bgColor: AppConstants.accentGreenLight,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (_) => const HelpScreen()),
                      );
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Interactive Voice Assistant UI Card
              const VoiceAssistantCard(isElderly: true),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibleTile({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color bgColor,
    required VoidCallback onTap,
  }) {
    return AppCard(
      onTap: onTap,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, size: 36, color: color),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppConstants.neutralTextDark,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              color: AppConstants.neutralTextMuted,
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
        activeBody = const CognitiveGamesScreen(isElderlyView: true);
        break;
      case 2:
        activeBody = const PatientRemindersScreen();
        break;
      case 3:
        activeBody = const PatientProfileScreen();
        break;
      default:
        activeBody = _buildHomeTab();
    }

    return Scaffold(
      body: activeBody,
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: _currentTabIndex,
        onTap: (idx) => setState(() => _currentTabIndex = idx),
        isElderly: true,
      ),
    );
  }
}
