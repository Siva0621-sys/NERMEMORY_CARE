import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../services/app_state_notifier.dart';
import '../../services/progress_service.dart';
import '../../services/reminder_service.dart';

/// Screen 16: Accessibility and App Settings
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late final AppStateNotifier _appState;

  @override
  void initState() {
    super.initState();
    _appState = AppStateNotifier();
    _appState.addListener(_onStateChange);
  }

  @override
  void dispose() {
    _appState.removeListener(_onStateChange);
    super.dispose();
  }

  void _onStateChange() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Accessibility & Settings'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Accessibility Options Header
              const SectionHeader(
                title: 'Accessibility Controls',
                subtitle:
                    'Tailor the interface for visual comfort and readability',
                icon: Icons.accessibility_new_rounded,
              ),
              const SizedBox(height: 8),

              // Text Scaling Card
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Reading Font Size',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.neutralTextDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Increase typography scaling for easier reading on mobile screens.',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        Expanded(
                          child: _buildScaleChoice(
                            label: 'Normal (100%)',
                            option: TextScaleOption.normal,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildScaleChoice(
                            label: 'Large (120%)',
                            option: TextScaleOption.large,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: _buildScaleChoice(
                            label: 'Max (135%)',
                            option: TextScaleOption.extraLarge,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // High Contrast & Reduce Animation Toggles
              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    SwitchListTile(
                      title: const Text(
                        'High Contrast Mode',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: const Text(
                        'Enhance borders and background contrast for low vision.',
                      ),
                      value: _appState.isHighContrast,
                      activeThumbColor: AppConstants.primaryTeal,
                      onChanged: (val) => _appState.setHighContrast(val),
                    ),
                    const Divider(height: 1, indent: 16),
                    SwitchListTile(
                      title: const Text(
                        'Reduce Motion / Animations',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      subtitle: const Text(
                        'Minimize screen movement and decorative transitions.',
                      ),
                      value: _appState.reduceAnimations,
                      activeThumbColor: AppConstants.primaryTeal,
                      onChanged: (val) => _appState.setReduceAnimations(val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Multilingual Selection
              const SectionHeader(
                title: 'Language & Localization',
                subtitle:
                    'Culturally inclusive languages supported in prototype architecture',
                icon: Icons.translate_rounded,
              ),
              const SizedBox(height: 8),

              AppCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    _buildLanguageTile(
                      'English',
                      'Active Prototype Language',
                      'English',
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildLanguageTile(
                      'தமிழ் (Tamil)',
                      'Future Phase 2 Localization',
                      'Tamil',
                    ),
                    const Divider(height: 1, indent: 56),
                    _buildLanguageTile(
                      'Tanglish',
                      'Colloquial Conversational Voice',
                      'Tanglish',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Demo Reset Card
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFF3E0),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.restore_rounded,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    const SizedBox(width: 14),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Reset Prototype Demo Data',
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Restore default reminders and progress stats.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        ReminderService().resetToDemo();
                        ProgressService().resetToDemo();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sample demo data has been reset.'),
                          ),
                        );
                      },
                      child: const Text(
                        'Reset',
                        style: TextStyle(fontWeight: FontWeight.w700),
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

  Widget _buildScaleChoice({
    required String label,
    required TextScaleOption option,
  }) {
    final isSelected = _appState.textScale == option;
    return InkWell(
      onTap: () => _appState.setTextScale(option),
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppConstants.primaryTeal : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppConstants.primaryTealDark
                : AppConstants.cardBorderColor,
            width: isSelected ? 2 : 1.2,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: isSelected ? Colors.white : AppConstants.neutralTextDark,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageTile(String title, String subtitle, String value) {
    final isSelected = _appState.selectedLanguage == value;
    return ListTile(
      leading: Icon(
        isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: isSelected
            ? AppConstants.primaryTeal
            : AppConstants.neutralTextMuted,
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: isSelected
          ? Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: AppConstants.primaryTealLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Selected',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.primaryTealDark,
                ),
              ),
            )
          : null,
      onTap: () => _appState.setSelectedLanguage(value),
    );
  }
}
