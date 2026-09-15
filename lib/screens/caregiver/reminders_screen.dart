import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/app_utils.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/primary_button.dart';
import '../../core/widgets/section_header.dart';
import '../../models/reminder_model.dart';
import '../../services/reminder_service.dart';
import '../../widgets/reminder_card.dart';

/// Full Caregiver reminders screen with add, edit, delete and toggle capabilities
class CaregiverRemindersScreen extends StatefulWidget {
  const CaregiverRemindersScreen({super.key});

  @override
  State<CaregiverRemindersScreen> createState() =>
      _CaregiverRemindersScreenState();
}

class _CaregiverRemindersScreenState extends State<CaregiverRemindersScreen> {
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

  void _showAddEditReminderDialog({ReminderModel? existing}) {
    final titleController = TextEditingController(text: existing?.title ?? '');
    TimeOfDay selectedTime =
        existing?.timeOfDay ?? const TimeOfDay(hour: 9, minute: 0);
    ReminderCategory selectedCategory =
        existing?.category ?? ReminderCategory.general;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: EdgeInsets.only(
                left: 20,
                right: 20,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        existing == null
                            ? 'Add Daily Reminder'
                            : 'Edit Reminder',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                          color: AppConstants.neutralTextDark,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(ctx),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Title Input
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      labelText: 'Reminder Title',
                      hintText: 'e.g. Afternoon Herbal Tea',
                      prefixIcon: Icon(Icons.edit_note_rounded),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Time Picker Selector
                  InkWell(
                    onTap: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: selectedTime,
                      );
                      if (picked != null) {
                        setModalState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppConstants.cardBorderColor),
                        borderRadius: BorderRadius.circular(
                          AppConstants.buttonRadius,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.access_time_rounded,
                                color: AppConstants.primaryTeal,
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Scheduled Time:',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            AppUtils.formatTimeOfDay(selectedTime),
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.primaryTealDark,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Category Dropdown
                  DropdownButtonFormField<ReminderCategory>(
                    initialValue: selectedCategory,
                    decoration: const InputDecoration(
                      labelText: 'Category',
                      prefixIcon: Icon(Icons.category_outlined),
                    ),
                    items: ReminderCategory.values.map((cat) {
                      return DropdownMenuItem(
                        value: cat,
                        child: Text(cat.name.toUpperCase()),
                      );
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) {
                        setModalState(() {
                          selectedCategory = val;
                        });
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  PrimaryButton(
                    label: existing == null
                        ? 'Save Reminder'
                        : 'Update Reminder',
                    icon: Icons.check_circle_outline,
                    onPressed: () {
                      final text = titleController.text.trim();
                      if (text.isEmpty) return;

                      final timeFormatted = AppUtils.formatTimeOfDay(
                        selectedTime,
                      );

                      if (existing == null) {
                        final newReminder = ReminderModel(
                          id: 'rem_${DateTime.now().millisecondsSinceEpoch}',
                          title: text,
                          time: timeFormatted,
                          timeOfDay: selectedTime,
                          category: selectedCategory,
                        );
                        _reminderService.addReminder(newReminder);
                      } else {
                        final updated = existing.copyWith(
                          title: text,
                          time: timeFormatted,
                          timeOfDay: selectedTime,
                          category: selectedCategory,
                        );
                        _reminderService.updateReminder(updated);
                      }
                      Navigator.pop(ctx);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _confirmDelete(ReminderModel reminder) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete Reminder?'),
        content: Text('Are you sure you want to remove "${reminder.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
            ),
            onPressed: () {
              _reminderService.deleteReminder(reminder.id);
              Navigator.pop(ctx);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reminders = _reminderService.reminders;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Care Reminders & Routines'),
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add_circle_outline,
              color: AppConstants.primaryTeal,
            ),
            tooltip: 'Add Reminder',
            onPressed: () => _showAddEditReminderDialog(),
          ),
        ],
      ),
      body: SafeArea(
        child: reminders.isEmpty
            ? EmptyState(
                icon: Icons.notifications_none_rounded,
                title: 'No Reminders Scheduled',
                description:
                    'Add daily reminders to help Meena maintain a soothing routine.',
                actionLabel: 'Add First Reminder',
                onActionPressed: () => _showAddEditReminderDialog(),
              )
            : ListView(
                padding: const EdgeInsets.all(AppConstants.paddingMedium),
                children: [
                  // Progress summary card
                  Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        AppConstants.cardRadius,
                      ),
                      border: Border.all(color: AppConstants.cardBorderColor),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '${_reminderService.totalCount}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppConstants.primaryTealDark,
                              ),
                            ),
                            const Text(
                              'Total Routines',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppConstants.neutralTextMuted,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: AppConstants.cardBorderColor,
                        ),
                        Column(
                          children: [
                            Text(
                              '${_reminderService.completedCount}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppConstants.accentGreen,
                              ),
                            ),
                            const Text(
                              'Completed Today',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppConstants.neutralTextMuted,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          height: 30,
                          width: 1,
                          color: AppConstants.cardBorderColor,
                        ),
                        Column(
                          children: [
                            Text(
                              '${_reminderService.pendingCount}',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: AppConstants.gentleAmber,
                              ),
                            ),
                            const Text(
                              'Upcoming',
                              style: TextStyle(
                                fontSize: 12,
                                color: AppConstants.neutralTextMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SectionHeader(
                    title: "Today's Schedule",
                    subtitle:
                        'Check off items as completed with your loved one',
                    icon: Icons.checklist_rounded,
                  ),
                  const SizedBox(height: 10),

                  ...reminders.map(
                    (reminder) => ReminderCard(
                      reminder: reminder,
                      onToggleComplete: (_) =>
                          _reminderService.toggleCompletion(reminder.id),
                      onToggleEnabled: (_) =>
                          _reminderService.toggleEnabled(reminder.id),
                      onEdit: () =>
                          _showAddEditReminderDialog(existing: reminder),
                      onDelete: () => _confirmDelete(reminder),
                    ),
                  ),

                  const SizedBox(height: 20),
                  Center(
                    child: OutlinedButton.icon(
                      onPressed: () => _showAddEditReminderDialog(),
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Add Another Reminder'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
