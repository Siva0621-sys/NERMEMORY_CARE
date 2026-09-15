import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../services/app_state_notifier.dart';
import '../../widgets/patient_avatar.dart';
import '../onboarding/mode_selection_screen.dart';
import '../patient/patient_home_screen.dart';
import '../shared/emergency_info_screen.dart';
import '../shared/help_screen.dart';
import '../shared/settings_screen.dart';

/// Caregiver Profile & Settings Screen
class CaregiverProfileScreen extends StatefulWidget {
  const CaregiverProfileScreen({super.key});

  @override
  State<CaregiverProfileScreen> createState() => _CaregiverProfileScreenState();
}

class _CaregiverProfileScreenState extends State<CaregiverProfileScreen> {
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

  Widget _buildLanguageOption(
    BuildContext ctx,
    String label,
    String sub,
    String value,
  ) {
    final isSelected = _appState.selectedLanguage == value;
    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected
            ? AppConstants.primaryTeal
            : AppConstants.neutralTextMuted,
      ),
      title: Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(sub, style: const TextStyle(fontSize: 12)),
      onTap: () {
        _appState.setSelectedLanguage(value);
        Navigator.pop(ctx);
      },
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Preferred Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption(
              ctx,
              'English (Active)',
              'Fully implemented prototype',
              'English',
            ),
            _buildLanguageOption(
              ctx,
              'தமிழ் (Tamil)',
              'Ready for Phase 2 localization',
              'Tamil',
            ),
            _buildLanguageOption(
              ctx,
              'Tanglish',
              'Friendly conversational voice',
              'Tanglish',
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = _appState.patient;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Caregiver & Patient Profile'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Patient profile banner
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    PatientAvatar(
                      size: 64,
                      name: patient.name,
                      showStatusRing: true,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                patient.name,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w800,
                                  color: AppConstants.neutralTextDark,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 3,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.primaryTealLight,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  patient.status,
                                  style: const TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    color: AppConstants.primaryTealDark,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            patient.location,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Caregiver: ${patient.caregiverName}',
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: AppConstants.primaryTeal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Switch Mode Quick Action
              AppCard(
                color: const Color(0xFFE0F2F1),
                borderColor: AppConstants.primaryTeal.withValues(alpha: 0.3),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(
                      Icons.swap_horiz_rounded,
                      size: 32,
                      color: AppConstants.primaryTealDark,
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Switch to Elderly View',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          Text(
                            'Experience the simplified, large-touch interface for Meena.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryTeal,
                        minimumSize: const Size(90, 42),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                      ),
                      onPressed: () {
                        _appState.setUserMode(UserMode.elderly);
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(
                            builder: (_) => const PatientHomeScreen(),
                          ),
                          (route) => false,
                        );
                      },
                      child: const Text(
                        'Switch',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Preference & Settings List
              const SectionHeader(
                title: 'Preferences & Support',
                icon: Icons.tune_rounded,
              ),
              const SizedBox(height: 8),

              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(
                        Icons.language_rounded,
                        color: AppConstants.primaryTeal,
                      ),
                      title: const Text('Preferred Language'),
                      subtitle: Text(_appState.selectedLanguage),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: _showLanguageDialog,
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(
                        Icons.accessibility_new_rounded,
                        color: AppConstants.primaryTeal,
                      ),
                      title: const Text('Accessibility Controls'),
                      subtitle: const Text('Text scaling & high contrast mode'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(
                        Icons.contact_phone_outlined,
                        color: AppConstants.accentGreen,
                      ),
                      title: const Text('Emergency & Doctor Contacts'),
                      subtitle: Text(patient.doctorContact),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const EmergencyInfoScreen(),
                          ),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56),
                    ListTile(
                      leading: const Icon(
                        Icons.help_outline_rounded,
                        color: AppConstants.primaryTeal,
                      ),
                      title: const Text('Help & App Guide'),
                      subtitle: const Text('Guidance for caregivers & games'),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const HelpScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // About & Hackathon Info Card
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppConstants.primaryTeal,
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'About NER MemoryCare',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: AppConstants.neutralTextDark,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Smart India Hackathon 2026 • Problem Statement 26003\n'
                      'Theme: MedTech / BioTech / HealthTech\n'
                      'Organization: Ministry of Development of North Eastern Region (MDoNER)\n'
                      'Version: 1.0.0 (Phase 1 Prototype)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppConstants.neutralTextMuted,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => const ModeSelectionScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  icon: const Icon(Icons.logout_rounded, size: 18),
                  label: const Text('Change Role Selection'),
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
