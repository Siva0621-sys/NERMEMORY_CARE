import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/widgets/app_card.dart';
import '../models/activity_model.dart';

/// Timeline activity card for Caregiver daily summary
class DailyActivityCard extends StatelessWidget {
  final ActivityModel activity;
  final bool isLast;

  const DailyActivityCard({
    super.key,
    required this.activity,
    this.isLast = false,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Timeline indicator line and circle
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: activity.isCompleted
                      ? activity.iconColor.withValues(alpha: 0.15)
                      : Colors.grey.shade200,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: activity.isCompleted
                        ? activity.iconColor
                        : Colors.grey.shade400,
                    width: 2,
                  ),
                ),
                child: Icon(
                  activity.icon,
                  size: 16,
                  color: activity.isCompleted
                      ? activity.iconColor
                      : Colors.grey.shade600,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppConstants.cardBorderColor,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          // Content Card
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: AppCard(
                padding: const EdgeInsets.all(12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: AppConstants.secondaryCream,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  activity.periodLabel,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w700,
                                    color: AppConstants.neutralTextMuted,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                activity.time,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppConstants.primaryTeal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            activity.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            activity.subtitle,
                            style: const TextStyle(
                              fontSize: 12,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      activity.isCompleted
                          ? Icons.check_circle_rounded
                          : Icons.schedule_rounded,
                      size: 20,
                      color: activity.isCompleted
                          ? AppConstants.accentGreen
                          : AppConstants.gentleAmber,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
