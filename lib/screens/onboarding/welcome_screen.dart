import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../services/app_state_notifier.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../patient/cognitive_games_screen.dart';
import '../patient/patient_home_screen.dart';
import 'mode_selection_screen.dart';

/// Commercial Healthcare Landing & Showcase Screen for NER MEMORY CARE
/// SIH 2026 Problem Statement 26003 (MDoNER)
///
/// Implements the exact 3-phone presentation layout requested from reference
/// image media_1789645142804.jpg with responsive split-screen hero layout
/// and fully interactive live mockups.
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
        Tween<Offset>(begin: const Offset(0, 0.04), end: Offset.zero).animate(
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

  void _navigateToGames(BuildContext context) {
    AppStateNotifier().setUserMode(UserMode.elderly);
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const CognitiveGamesScreen()),
    );
  }

  void _navigateToReminders(BuildContext context) {
    AppStateNotifier().setUserMode(UserMode.caregiver);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CaregiverDashboard(initialTabIndex: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF3B82F6), // Vibrant healthcare blue
              Color(0xFF60A5FA), // Sky blue
              Color(0xFF93C5FD), // Soft daylight cyan
              Color(0xFFBAE6FD), // Light periwinkle
            ],
            stops: [0.0, 0.35, 0.70, 1.0],
          ),
        ),
        child: SafeArea(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: SlideTransition(
              position: _slideAnimation,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 980;

                  if (isWide) {
                    // Desktop / Landscape / SIH Judge presentation view
                    return Row(
                      children: [
                        // Left Hero Content
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 48.0,
                              vertical: 36.0,
                            ),
                            child: _buildHeroContent(context, isWide: true),
                          ),
                        ),
                        // Right Phones Showcase
                        Expanded(
                          flex: 6,
                          child: Center(
                            child: SingleChildScrollView(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                                vertical: 24.0,
                              ),
                              child: _buildThreePhonesMockup(context, isWide: true),
                            ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    // Mobile / Portrait View
                    return SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _buildHeroContent(context, isWide: false),
                          const SizedBox(height: 24),
                          // Scaled container for phones so it never overflows
                          _buildThreePhonesMockup(context, isWide: false),
                          const SizedBox(height: 24),
                          _buildMobileActionFooter(context),
                          const SizedBox(height: 16),
                        ],
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 1. LEFT HERO CONTENT
  // ---------------------------------------------------------------------------
  Widget _buildHeroContent(BuildContext context, {required bool isWide}) {
    return Column(
      crossAxisAlignment:
          isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Govt & Hackathon Badges
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇮🇳', style: TextStyle(fontSize: 13)),
                  SizedBox(width: 6),
                  Text(
                    'Smart India Hackathon 2026',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.22),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.35),
                ),
              ),
              child: const Text(
                'PS ID: 26003 • MedTech',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Ministry Tagline
        Text(
          AppConstants.ministry.toUpperCase(),
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.9),
            fontSize: 12,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.1,
          ),
        ),
        const SizedBox(height: 10),

        // Exact App Name in All-Caps
        Text(
          AppConstants.appName,
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: isWide ? 44 : 34,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
            height: 1.1,
            shadows: [
              Shadow(
                color: Colors.black.withValues(alpha: 0.18),
                blurRadius: 16,
                offset: const Offset(0, 4),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),

        // Subtitle matching reference format & SIH problem statement
        Text(
          'All-in-One Cognitive Care & Memory Solution: Games, Routines, Caregivers—Anytime, Anywhere.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.95),
            fontSize: isWide ? 17 : 15,
            fontWeight: FontWeight.w600,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 12),

        // Specific SIH Problem Statement Description
        Text(
          'AI-Based Cognitive Gaming & Memory Assistance Platform for Elderly Dementia Patients in North Eastern Region (NER). Culturally inclusive digital therapeutics tailored for remote and rural communities.',
          textAlign: isWide ? TextAlign.left : TextAlign.center,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 13,
            height: 1.4,
          ),
        ),
        const SizedBox(height: 20),

        // Feature Highlight Pills
        Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          children: [
            _buildFeaturePill(Icons.psychology_rounded, 'Assam Tea & NER Games'),
            _buildFeaturePill(Icons.alarm_on_rounded, 'Voice Routine Alerts'),
            _buildFeaturePill(Icons.insights_rounded, 'Caregiver Tracking'),
            _buildFeaturePill(Icons.offline_pin_rounded, '100% Offline Ready'),
          ],
        ),
        const SizedBox(height: 28),

        // Action Buttons Row
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: isWide ? WrapAlignment.start : WrapAlignment.center,
          children: [
            // Primary Launch Button
            ElevatedButton.icon(
              onPressed: () => _navigateToModeSelection(context),
              icon: const Icon(Icons.rocket_launch_rounded, size: 18),
              label: const Text(
                'Get Started • Enter Platform →',
                style: TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF1D4ED8),
                elevation: 5,
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            // Quick 1-Tap Elderly Persona
            OutlinedButton.icon(
              onPressed: () => _navigateToRole(context, UserMode.elderly),
              icon: const Icon(Icons.person_rounded, size: 17),
              label: const Text(
                'Elderly Mode',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            // Quick 1-Tap Caregiver Persona
            OutlinedButton.icon(
              onPressed: () => _navigateToRole(context, UserMode.caregiver),
              icon: const Icon(Icons.people_alt_rounded, size: 17),
              label: const Text(
                'Caregiver View',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white,
                side: const BorderSide(color: Colors.white, width: 1.5),
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFeaturePill(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.white),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 2. THREE PHONES SHOWCASE COMPOSITION (Exact replica of user reference image)
  // ---------------------------------------------------------------------------
  Widget _buildThreePhonesMockup(BuildContext context, {required bool isWide}) {
    const double phoneWidth = 230;
    const double phoneHeight = 470;

    final stackWidget = SizedBox(
      height: 520,
      width: 680,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // -------------------------------------------------------------------
          // PHONE 1 (LEFT): Tilted Splash Screen with Underlined Brand & Floating Icons
          // -------------------------------------------------------------------
          Positioned(
            left: 20,
            top: 25,
            child: Transform.rotate(
              angle: -0.10, // ~ -6 degrees tilt
              child: _buildDeviceFrame(
                width: phoneWidth,
                height: phoneHeight,
                child: _buildPhone1Splash(context),
              ),
            ),
          ),

          // -------------------------------------------------------------------
          // PHONE 3 (RIGHT): Tilted Role Login / Authentication Screen
          // -------------------------------------------------------------------
          Positioned(
            right: 20,
            top: 25,
            child: Transform.rotate(
              angle: 0.10, // ~ +6 degrees tilt
              child: _buildDeviceFrame(
                width: phoneWidth,
                height: phoneHeight,
                child: _buildPhone3Login(context),
              ),
            ),
          ),

          // -------------------------------------------------------------------
          // PHONE 2 (CENTER): Upright, Prominent Interactive App Dashboard
          // -------------------------------------------------------------------
          Positioned(
            top: 10,
            child: _buildDeviceFrame(
              width: 250,
              height: 500,
              isProminent: true,
              child: _buildPhone2Dashboard(context),
            ),
          ),
        ],
      ),
    );

    // If on narrow/mobile screen, scale down smoothly so it fits completely without scroll/overflow
    return FittedBox(
      fit: BoxFit.scaleDown,
      child: stackWidget,
    );
  }

  // Realistic Smartphone Device Bezel
  Widget _buildDeviceFrame({
    required double width,
    required double height,
    required Widget child,
    bool isProminent = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Sleek midnight bezel
        borderRadius: BorderRadius.circular(38),
        border: Border.all(
          color: isProminent
              ? const Color(0xFF334155)
              : const Color(0xFF1E293B),
          width: 6.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isProminent ? 0.35 : 0.22),
            blurRadius: isProminent ? 32 : 20,
            offset: Offset(0, isProminent ? 14 : 8),
            spreadRadius: isProminent ? 2 : 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(31),
        child: Stack(
          children: [
            // Screen Content
            Positioned.fill(child: child),

            // Top Status Bar with Dynamic Island Notch
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 32,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Time
                    const Text(
                      '9:41',
                      style: TextStyle(
                        fontSize: 10.5,
                        fontWeight: FontWeight.w800,
                        color: Colors.black87,
                      ),
                    ),
                    // Centered Dynamic Island pill
                    Container(
                      width: 58,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            margin: const EdgeInsets.only(right: 5),
                            decoration: const BoxDecoration(
                              color: Color(0xFF1E293B),
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Wifi & Battery Icons
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi, size: 11, color: Colors.black87),
                        SizedBox(width: 3),
                        Icon(Icons.battery_full, size: 12, color: Colors.black87),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PHONE 1 CONTENT: Splash Screen with Underlined Brand & Floating Icons
  // ---------------------------------------------------------------------------
  Widget _buildPhone1Splash(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF2563EB),
            Color(0xFF3B82F6),
            Color(0xFF60A5FA),
            Color(0xFF38BDF8),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Subtle radial glow
          Positioned(
            top: 100,
            left: 20,
            right: 20,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.12),
              ),
            ),
          ),

          // Centered Brand Title & Underline
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 40),
                const Text(
                  'NER MEMORY CARE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.8,
                  ),
                ),
                const SizedBox(height: 5),
                // Exact Underline from reference image
                Container(
                  width: 90,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(2),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.5),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'SIH 2026 • MDoNER',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 9.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),

          // Floating Healthcare & Cognitive Symbols (Exact motif from reference)
          Positioned(
            left: 12,
            right: 12,
            bottom: 20,
            child: SizedBox(
              height: 170,
              child: Stack(
                children: [
                  _buildFloatingIcon(Icons.psychology_outlined, 20, 24, 0.85, 24),
                  _buildFloatingIcon(Icons.medication_outlined, 75, 10, 0.75, 20),
                  _buildFloatingIcon(Icons.eco_outlined, 140, 28, 0.9, 22),
                  _buildFloatingIcon(Icons.medical_services_outlined, 25, 75, 0.8, 22),
                  _buildFloatingIcon(Icons.favorite_border_rounded, 80, 70, 0.95, 26),
                  _buildFloatingIcon(Icons.alarm_on_outlined, 145, 80, 0.8, 20),
                  _buildFloatingIcon(Icons.healing_outlined, 45, 125, 0.7, 18),
                  _buildFloatingIcon(Icons.spa_outlined, 115, 125, 0.85, 22),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingIcon(
    IconData icon,
    double left,
    double top,
    double opacity,
    double size,
  ) {
    return Positioned(
      left: left,
      top: top,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.15),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withValues(alpha: opacity * 0.5),
            width: 1.2,
          ),
        ),
        child: Icon(
          icon,
          size: size,
          color: Colors.white.withValues(alpha: opacity),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PHONE 2 CONTENT: Interactive App Dashboard
  // ---------------------------------------------------------------------------
  Widget _buildPhone2Dashboard(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 36, left: 12, right: 12, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Avatar, "Hi Meena", Bell, Gear
          Row(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF97316),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(width: 8),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi Meena',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Text(
                      'Guwahati, Assam',
                      style: TextStyle(
                        fontSize: 9,
                        color: Color(0xFF64748B),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              // Bell Notification
              Stack(
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    size: 19,
                    color: Color(0xFF334155),
                  ),
                  Positioned(
                    right: 1,
                    top: 1,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEF4444),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 6),
              const Icon(
                Icons.settings_outlined,
                size: 18,
                color: Color(0xFF334155),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Category Pills Row (Matches reference "My Appointment", "My Medicine")
          Row(
            children: [
              Expanded(
                child: InkWell(
                  onTap: () => _navigateToGames(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF6FF),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFBFDBFE)),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.sports_esports_outlined,
                            size: 13,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Memory Games',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1D4ED8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                child: InkWell(
                  onTap: () => _navigateToReminders(context),
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFECFDF5),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: const Color(0xFFA7F3D0)),
                    ),
                    child: const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.alarm_on_rounded,
                            size: 13,
                            color: Color(0xFF059669),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Daily Routine',
                            style: TextStyle(
                              fontSize: 9.5,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF047857),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 9),

          // Search Field (Matches reference "Search Hospital")
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: const Row(
              children: [
                Icon(
                  Icons.search_rounded,
                  size: 15,
                  color: Color(0xFF64748B),
                ),
                SizedBox(width: 6),
                Expanded(
                  child: Text(
                    'Search Games & Routines...',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 9.5,
                      color: Color(0xFF94A3B8),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 9),

          // CARD 1: Cognitive Practice & Games (Matches reference blue/purple card)
          Container(
            height: 105,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6366F1), Color(0xFF4F46E5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF6366F1).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.psychology_rounded,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cognitive Practice & Games',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Assam Tea & Picture Recall',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 8.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _navigateToGames(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF00E5FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'Play Games →',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFF0F172A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // CARD 2: Daily Routine & Medicine (Matches reference teal card)
          Container(
            height: 105,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF06B6D4), Color(0xFF0891B2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF06B6D4).withValues(alpha: 0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.medication_liquid_rounded,
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Daily Routine & Care Alert',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10.5,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Assam Tea, Walk & BP Pills',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 8.5,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: () => _navigateToReminders(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF10B981),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Text(
                            'View Schedule →',
                            style: TextStyle(
                              fontSize: 9,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),

          // Bottom Navigation Bar (Matches reference bottom bar with center scanner)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFF1F5F9))),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Icon(Icons.home_rounded, size: 18, color: Color(0xFF2563EB)),
                const Icon(Icons.sports_esports_rounded,
                    size: 17, color: Color(0xFF94A3B8)),
                Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: Color(0xFF2563EB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.qr_code_scanner_rounded,
                    size: 15,
                    color: Colors.white,
                  ),
                ),
                const Icon(Icons.calendar_today_rounded,
                    size: 16, color: Color(0xFF94A3B8)),
                const Icon(Icons.people_alt_rounded,
                    size: 17, color: Color(0xFF94A3B8)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // PHONE 3 CONTENT: Role Login & Authentication Screen
  // ---------------------------------------------------------------------------
  Widget _buildPhone3Login(BuildContext context) {
    return Container(
      color: const Color(0xFF3B82F6),
      child: Stack(
        children: [
          // Top Half: Brand Logo
          Positioned(
            top: 42,
            left: 0,
            right: 0,
            child: Column(
              children: [
                const Text(
                  'NER MEMORY CARE',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Dementia Care • MDoNER',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.8),
                    fontSize: 9,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Bottom Half: White Login Card (Matches reference image bottom sheet)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: 100,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Log in',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1D4ED8),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Option 1: Elderly Mode
                  InkWell(
                    onTap: () => _navigateToRole(context, UserMode.elderly),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.person_rounded,
                            size: 16,
                            color: Color(0xFF10B981),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Elderly User (Meena)',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Large text & audio',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.check_circle_rounded,
                              size: 14, color: Color(0xFF10B981)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Option 2: Caregiver Mode
                  InkWell(
                    onTap: () => _navigateToRole(context, UserMode.caregiver),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF8FAFC),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.people_alt_rounded,
                            size: 16,
                            color: Color(0xFF2563EB),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Caregiver / Doctor',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF0F172A),
                                  ),
                                ),
                                Text(
                                  'Insights & reminders',
                                  style: TextStyle(
                                    fontSize: 8,
                                    color: Color(0xFF64748B),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios_rounded,
                              size: 11, color: Color(0xFF94A3B8)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Enter Platform Button
                  InkWell(
                    onTap: () => _navigateToModeSelection(context),
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Enter Platform',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_rounded,
                            size: 15,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),

                  // Quick connect with social/govt IDs
                  Center(
                    child: Column(
                      children: [
                        const Text(
                          'connect with',
                          style: TextStyle(
                            fontSize: 9,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildSocialBadge('ABHA', const Color(0xFF0284C7)),
                            const SizedBox(width: 8),
                            _buildSocialBadge('G', const Color(0xFFEA4335)),
                            const SizedBox(width: 8),
                            _buildSocialBadge('OTP', const Color(0xFF10B981)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialBadge(String text, Color color) {
    return Container(
      width: 26,
      height: 26,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            fontSize: 8.5,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // 3. MOBILE ACTION FOOTER
  // ---------------------------------------------------------------------------
  Widget _buildMobileActionFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          const Text(
            'Experience NER Memory Care Demo:',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => _navigateToRole(context, UserMode.elderly),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1D4ED8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Elderly Mode',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => _navigateToRole(context, UserMode.caregiver),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: const Text(
                    'Caregiver View',
                    style: TextStyle(fontWeight: FontWeight.w800),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
