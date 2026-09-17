import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/primary_button.dart';
import '../../services/app_state_notifier.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../patient/patient_home_screen.dart';
import 'mode_selection_screen.dart';

/// Attractive, commercial healthcare landing screen for NER MemoryCare
/// Designed to captivate SIH 2026 judges with modern aesthetics, interactive
/// feature cards, and instant 1-tap role access.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  int _selectedFeatureTab = 0;

  final List<Map<String, dynamic>> _features = [
    {
      'title': 'Cognitive Practice',
      'subtitle': 'Gentle matching & memory recall games using familiar North Eastern symbols.',
      'icon': Icons.psychology_rounded,
      'color': AppConstants.primaryTeal,
      'tag': 'Culturally Inclusive',
    },
    {
      'title': 'Daily Routines',
      'subtitle': 'Friendly reminders for morning walks, warm tea, medication, and family connection.',
      'icon': Icons.alarm_on_rounded,
      'color': const Color(0xFF1976D2),
      'tag': 'Zero Stress',
    },
    {
      'title': 'Caregiver Insights',
      'subtitle': 'Daily activity timelines, engagement streaks, and comforting real-time progress.',
      'icon': Icons.insights_rounded,
      'color': AppConstants.accentGreen,
      'tag': 'Family Support',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero).animate(
          CurvedAnimation(parent: _animController, curve: Curves.easeOutCubic),
        );

    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _navigateToRole(BuildContext context, UserMode mode) {
    AppStateNotifier().setUserMode(mode);
    if (mode == UserMode.elderly) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const PatientHomeScreen()),
      );
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => const CaregiverDashboard()),
      );
    }
  }

  void _navigateToModeSelection(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const ModeSelectionScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 16.0,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: size.height -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).padding.bottom -
                      32,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // --- 1. Top Govt / Hackathon Header Badge ---
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: AppConstants.cardBorderColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.03),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppConstants.accentGreen,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            'SIH 2026 • Problem Statement 26003',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                              letterSpacing: 0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      AppConstants.ministry,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- 2. Modern HealthTech Hero Section ---
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 24,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF00695C),
                            Color(0xFF00796B),
                            Color(0xFF00897B),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        boxShadow: [
                          BoxShadow(
                            color: AppConstants.primaryTeal.withValues(alpha: 0.35),
                            blurRadius: 24,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Floating Emblems & Aura
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.12),
                                ),
                              ),
                              Container(
                                width: 96,
                                height: 96,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white.withValues(alpha: 0.22),
                                ),
                              ),
                              Container(
                                width: 72,
                                height: 72,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Icon(
                                  Icons.spa_rounded,
                                  size: 42,
                                  color: AppConstants.primaryTeal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          // App Title
                          const Text(
                            AppConstants.appName,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                              letterSpacing: -0.6,
                            ),
                          ),
                          const SizedBox(height: 4),
                          // Subtitle Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Text(
                              'AI-Based Cognitive Gaming & Memory Assistance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                letterSpacing: 0.2,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // Calming Tagline
                          Text(
                            '“${AppConstants.appTagline}”',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withValues(alpha: 0.92),
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 16),
                          // Highlight Chips
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildHeroPill('🌿 North East Heritage'),
                              const SizedBox(width: 8),
                              _buildHeroPill('🧠 Calming Wellness'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- 3. Interactive Feature Tabs (Showcasing Solution) ---
                    Row(
                      children: List.generate(_features.length, (index) {
                        final isSelected = _selectedFeatureTab == index;
                        final item = _features[index];
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _selectedFeatureTab = index;
                                });
                              },
                              borderRadius: BorderRadius.circular(14),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white.withValues(alpha: 0.6),
                                  borderRadius: BorderRadius.circular(14),
                                  border: Border.all(
                                    color: isSelected
                                        ? (item['color'] as Color)
                                        : AppConstants.cardBorderColor,
                                    width: isSelected ? 2 : 1,
                                  ),
                                  boxShadow: isSelected
                                      ? [
                                          BoxShadow(
                                            color: Colors.black.withValues(alpha: 0.05),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ]
                                      : null,
                                ),
                                child: Column(
                                  children: [
                                    Icon(
                                      item['icon'] as IconData,
                                      size: 22,
                                      color: isSelected
                                          ? (item['color'] as Color)
                                          : AppConstants.neutralTextMuted,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      item['title'] as String,
                                      style: TextStyle(
                                        fontSize: 11,
                                        fontWeight: isSelected
                                            ? FontWeight.w800
                                            : FontWeight.w600,
                                        color: isSelected
                                            ? AppConstants.neutralTextDark
                                            : AppConstants.neutralTextMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 12),

                    // Active Feature Card Preview
                    AppCard(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (_features[_selectedFeatureTab]['color'] as Color)
                                  .withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              _features[_selectedFeatureTab]['icon'] as IconData,
                              size: 28,
                              color: _features[_selectedFeatureTab]['color'] as Color,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      _features[_selectedFeatureTab]['title'] as String,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w800,
                                        color: AppConstants.neutralTextDark,
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppConstants.primaryTealLight,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        _features[_selectedFeatureTab]['tag'] as String,
                                        style: const TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                          color: AppConstants.primaryTealDark,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  _features[_selectedFeatureTab]['subtitle'] as String,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: AppConstants.neutralTextMuted,
                                    height: 1.3,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // --- 4. 1-Tap Direct Role Launchers (Judge Favorites) ---
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Launch Demo Persona:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w800,
                          color: AppConstants.neutralTextDark,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),

                    Row(
                      children: [
                        // Elderly Persona Card
                        Expanded(
                          child: AppCard(
                            onTap: () => _navigateToRole(context, UserMode.elderly),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppConstants.accentGreenLight,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.person_rounded,
                                        size: 20,
                                        color: AppConstants.accentGreen,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16,
                                      color: AppConstants.neutralTextMuted,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Elderly User',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppConstants.neutralTextDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Patient "Meena" with large text & games.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppConstants.neutralTextMuted,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Caregiver Persona Card
                        Expanded(
                          child: AppCard(
                            onTap: () => _navigateToRole(context, UserMode.caregiver),
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppConstants.primaryTealLight,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: const Icon(
                                        Icons.people_rounded,
                                        size: 20,
                                        color: AppConstants.primaryTealDark,
                                      ),
                                    ),
                                    const Spacer(),
                                    const Icon(
                                      Icons.arrow_forward_rounded,
                                      size: 16,
                                      color: AppConstants.neutralTextMuted,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                const Text(
                                  'Caregiver View',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w800,
                                    color: AppConstants.neutralTextDark,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                const Text(
                                  'Care overview, stats & reminder control.',
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: AppConstants.neutralTextMuted,
                                    height: 1.2,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- 5. Primary CTA & Navigation ---
                    PrimaryButton(
                      label: 'Get Started • Select Role',
                      icon: Icons.rocket_launch_rounded,
                      isLarge: true,
                      onPressed: () => _navigateToModeSelection(context),
                    ),
                    const SizedBox(height: 16),

                    // Trust / Ethical MedTech Note
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppConstants.cardBorderColor),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.verified_user_outlined,
                            size: 18,
                            color: AppConstants.primaryTeal,
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Supportive Wellness & Cognitive Practice Prototype • 100% Offline Capable',
                              style: TextStyle(
                                fontSize: 10.5,
                                fontWeight: FontWeight.w600,
                                color: AppConstants.neutralTextMuted,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeroPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.25)),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
