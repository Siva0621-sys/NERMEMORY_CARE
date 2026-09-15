import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/primary_button.dart';
import '../../services/app_state_notifier.dart';
import '../../widgets/patient_avatar.dart';
import '../caregiver/caregiver_dashboard.dart';
import '../onboarding/mode_selection_screen.dart';
import '../shared/emergency_info_screen.dart';
import '../shared/help_screen.dart';

/// Simplified profile screen for Elderly User with large buttons and accessibility controls
class PatientProfileScreen extends StatefulWidget {
  const PatientProfileScreen({super.key});

  @override
  State<PatientProfileScreen> createState() => _PatientProfileScreenState();
}

class _PatientProfileScreenState extends State<PatientProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    final patient = _appState.patient;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('My Profile & Help'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Avatar & Name Card
              AppCard(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    PatientAvatar(
                      size: 80,
                      name: patient.name,
                      showStatusRing: true,
                    ),
                    const SizedBox(height: 14),
                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                        color: AppConstants.neutralTextDark,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient.location,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppConstants.primaryTealLight,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        'Caregiver: ${patient.caregiverName}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppConstants.primaryTealDark,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Emergency Assistance Big Button
              PrimaryButton(
                label: 'Emergency & Doctor Call',
                icon: Icons.phone_in_talk_rounded,
                isLarge: true,
                backgroundColor: const Color(0xFFC62828),
                foregroundColor: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const EmergencyInfoScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // How to Play & Help Card
              AppCard(
                onTap: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (_) => const HelpScreen()));
                },
                padding: const EdgeInsets.all(20),
                child: const Row(
                  children: [
                    Icon(
                      Icons.help_center_rounded,
                      size: 36,
                      color: AppConstants.primaryTeal,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'How to Play & Guide',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Simple instructions on playing memory games.',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.chevron_right, size: 28),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Text Size Accessibility Controls
              AppCard(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.format_size_rounded,
                          color: AppConstants.primaryTeal,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Text Size for Reading',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: AppConstants.neutralTextDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: _buildTextSizeButton(
                            label: 'Normal',
                            scale: TextScaleOption.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildTextSizeButton(
                            label: 'Large',
                            scale: TextScaleOption.large,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildTextSizeButton(
                            label: 'Extra Large',
                            scale: TextScaleOption.extraLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Switch to Caregiver View Button
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 54),
                  side: const BorderSide(
                    color: AppConstants.primaryTeal,
                    width: 2,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.buttonRadius,
                    ),
                  ),
                ),
                onPressed: () {
                  _appState.setUserMode(UserMode.caregiver);
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const CaregiverDashboard(),
                    ),
                    (route) => false,
                  );
                },
                icon: const Icon(Icons.swap_horiz_rounded),
                label: const Text(
                  'Switch to Caregiver Dashboard',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => const ModeSelectionScreen(),
                    ),
                    (route) => false,
                  );
                },
                child: const Text('Change Mode Selection'),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextSizeButton({
    required String label,
    required TextScaleOption scale,
  }) {
    final isSelected = _appState.textScale == scale;
    return InkWell(
      onTap: () => _appState.setTextScale(scale),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryTeal : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppConstants.primaryTealDark
                : AppConstants.cardBorderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppConstants.neutralTextDark,
            ),
          ),
        ),
      ),
    );
  }
}
