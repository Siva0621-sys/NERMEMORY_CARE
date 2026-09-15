import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/widgets/app_card.dart';
import '../models/reminder_model.dart';

/// Reminder card with completion checkbox, time badge, and action callbacks
class ReminderCard extends StatelessWidget {
  final ReminderModel reminder;
  final ValueChanged<bool?> onToggleComplete;
  final ValueChanged<bool>? onToggleEnabled;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isElderlyView;

  const ReminderCard({
    super.key,
    required this.reminder,
    required this.onToggleComplete,
    this.onToggleEnabled,
    this.onEdit,
    this.onDelete,
    this.isElderlyView = false,
  });

  @override
  Widget build(BuildContext context) {
    final categoryColor = reminder.categoryColor;

    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(
        horizontal: isElderlyView ? 18 : 14,
        vertical: isElderlyView ? 16 : 12,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Checkbox for completion
          Transform.scale(
            scale: isElderlyView ? 1.4 : 1.1,
            child: Checkbox(
              value: reminder.isCompleted,
              activeColor: AppConstants.accentGreen,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onChanged: onToggleComplete,
            ),
          ),
          const SizedBox(width: 10),
          // Category Icon
          Container(
            padding: EdgeInsets.all(isElderlyView ? 12 : 9),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              reminder.icon,
              size: isElderlyView ? 28 : 22,
              color: categoryColor,
            ),
          ),
          const SizedBox(width: 14),
          // Reminder text & time
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  reminder.title,
                  style: TextStyle(
                    fontSize: isElderlyView ? 18 : 15,
                    fontWeight: FontWeight.w700,
                    color: reminder.isCompleted
                        ? AppConstants.neutralTextMuted
                        : AppConstants.neutralTextDark,
                    decoration: reminder.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: isElderlyView ? 16 : 13,
                      color: AppConstants.neutralTextMuted,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      reminder.time,
                      style: TextStyle(
                        fontSize: isElderlyView ? 14 : 12,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.primaryTeal,
                      ),
                    ),
                    if (!isElderlyView) ...[
                      const SizedBox(width: 8),
                      Text(
                        '• ${reminder.categoryName}',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppConstants.neutralTextMuted,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          ),
          // Actions for caregiver view
          if (!isElderlyView) ...[
            if (onEdit != null)
              IconButton(
                icon: const Icon(Icons.edit_outlined, size: 20),
                color: AppConstants.neutralTextMuted,
                onPressed: onEdit,
                tooltip: 'Edit Reminder',
              ),
            if (onDelete != null)
              IconButton(
                icon: const Icon(Icons.delete_outline, size: 20),
                color: const Color(0xFFC62828),
                onPressed: onDelete,
                tooltip: 'Delete Reminder',
              ),
          ],
        ],
      ),
    );
  }
}
