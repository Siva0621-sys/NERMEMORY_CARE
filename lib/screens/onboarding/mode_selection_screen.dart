import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../services/app_state_notifier.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../patient/patient_home_screen.dart';

/// Screen 2: Mode Selection (Elderly User vs Caregiver)
class ModeSelectionScreen extends StatelessWidget {
  const ModeSelectionScreen({super.key});

  void _selectMode(BuildContext context, UserMode mode) {
    AppStateNotifier().setUserMode(mode);
    if (mode == UserMode.caregiver) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const CaregiverDashboard()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const PatientHomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Select Mode'),
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Demo mode badge
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.primaryTealLight,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 16,
                      color: AppConstants.primaryTealDark,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Interactive Prototype • Switch anytime in app',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.primaryTealDark,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Who is using\nNER MemoryCare?',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  color: AppConstants.neutralTextDark,
                  letterSpacing: -0.5,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose a view to tailor the interface for patient comfort or caregiver insights.',
                style: TextStyle(
                  fontSize: 15,
                  color: AppConstants.neutralTextMuted,
                  height: 1.4,
                ),
              ),
              const SizedBox(height: 32),

              // Option 1: Elderly User (Patient: Meena)
              AppCard(
                onTap: () => _selectMode(context, UserMode.elderly),
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(22),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F5E9),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppConstants.accentGreen.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 38,
                        color: AppConstants.accentGreen,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Elderly User',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppConstants.neutralTextDark,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryTealLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Meena',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppConstants.primaryTealDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Enjoy simple games, daily reminders, and friendly voice activities.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.neutralTextMuted,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Text(
                                'Large text • Simple buttons',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.accentGreen,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 16,
                                color: AppConstants.accentGreen,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Option 2: Caregiver
              AppCard(
                onTap: () => _selectMode(context, UserMode.caregiver),
                padding: const EdgeInsets.all(22),
                color: Colors.white,
                child: Row(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: BoxDecoration(
                        color: AppConstants.primaryTealLight,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: AppConstants.primaryTeal.withValues(
                            alpha: 0.3,
                          ),
                        ),
                      ),
                      child: const Icon(
                        Icons.people_rounded,
                        size: 38,
                        color: AppConstants.primaryTealDark,
                      ),
                    ),
                    const SizedBox(width: 18),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Caregiver',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'Support your loved one, manage routines, and monitor cognitive activity trends.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.neutralTextMuted,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Row(
                            children: [
                              Text(
                                'Overview • Progress charts • Reminders',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.primaryTealDark,
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 16,
                                color: AppConstants.primaryTealDark,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),
              const Center(
                child: Text(
                  'Sample data is provided for testing and evaluation purposes.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.neutralTextMuted,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
