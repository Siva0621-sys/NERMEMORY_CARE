import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/section_header.dart';
import '../../services/reminder_service.dart';
import '../../widgets/reminder_card.dart';

/// Simplified, high-contrast reminders screen designed specifically for Elderly Users
class PatientRemindersScreen extends StatefulWidget {
  const PatientRemindersScreen({super.key});

  @override
  State<PatientRemindersScreen> createState() => _PatientRemindersScreenState();
}

class _PatientRemindersScreenState extends State<PatientRemindersScreen> {
  late final ReminderService _reminderService;

  @override
  void initState() {
    super.initState();
    _reminderService = ReminderService();
    _reminderService.addListener(_onChanged);
  }

  @override
  void dispose() {
    _reminderService.removeListener(_onChanged);
    super.dispose();
  }

  void _onChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderService.reminders
        .where((r) => r.isEnabled)
        .toList();

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('My Daily Reminders'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: reminders.isEmpty
            ? const EmptyState(
                icon: Icons.check_circle_outline_rounded,
                title: 'All done for today!',
                description: 'You have completed all scheduled activities.',
              )
            : ListView(
                padding: const EdgeInsets.all(AppConstants.paddingLarge),
                children: [
                  // Friendly reminder greeting
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F5E9),
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardRadius,
                      ),
                      border: Border.all(
                        color: AppConstants.accentGreen.withValues(alpha: 0.3),
                      ),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.spa_rounded,
                          color: AppConstants.accentGreen,
                          size: 36,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Text(
                            'Here are your gentle activities for today. Tap the box when completed!',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.neutralTextDark,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  const SectionHeader(
                    title: "Today's Checklist",
                    icon: Icons.checklist_rounded,
                  ),
                  const SizedBox(height: 8),

                  ...reminders.map(
                    (reminder) => ReminderCard(
                      reminder: reminder,
                      isElderlyView: true,
                      onToggleComplete: (_) {
                        _reminderService.toggleCompletion(reminder.id);
                        if (!reminder.isCompleted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Great job completing "${reminder.title}"! 🌸',
                              ),
                              backgroundColor: AppConstants.accentGreen,
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ),

                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppConstants.cardBorderColor),
                    ),
                    child: const Column(
                      children: [
                        Icon(
                          Icons.favorite_rounded,
                          color: Color(0xFFE91E63),
                          size: 30,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Your caregiver is always here to support you.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppConstants.neutralTextDark,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
