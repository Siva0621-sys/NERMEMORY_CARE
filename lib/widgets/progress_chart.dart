import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../models/progress_model.dart';

/// Accessible weekly cognitive activity bar chart
class ProgressChart extends StatelessWidget {
  final List<DailyActivityRecord> records;
  final double maxHeight;

  const ProgressChart({
    super.key,
    required this.records,
    this.maxHeight = 160.0,
  });

  @override
  Widget build(BuildContext context) {
    // Find max minutes for relative bar height calculation
    int maxMinutes = 25;
    for (final r in records) {
      if (r.minutes > maxMinutes) maxMinutes = r.minutes;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Weekly Activity (Minutes)',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                color: AppConstants.neutralTextDark,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: AppConstants.primaryTealLight,
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'Demo Data',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: AppConstants.primaryTealDark,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: maxHeight,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: records.map((record) {
              final barHeightRatio = (record.minutes / maxMinutes).clamp(
                0.12,
                1.0,
              );
              final isToday = record.isToday;

              return Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${record.minutes}m',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: isToday
                              ? FontWeight.w800
                              : FontWeight.w600,
                          color: isToday
                              ? AppConstants.primaryTeal
                              : AppConstants.neutralTextMuted,
                        ),
                      ),
                      const SizedBox(height: 6),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        height: (maxHeight - 48) * barHeightRatio,
                        decoration: BoxDecoration(
                          color: isToday
                              ? AppConstants.primaryTeal
                              : AppConstants.primaryTeal.withValues(
                                  alpha: 0.35,
                                ),
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(8),
                          ),
                          border: isToday
                              ? Border.all(
                                  color: AppConstants.primaryTealDark,
                                  width: 1.5,
                                )
                              : null,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: isToday
                            ? const BoxDecoration(
                                color: AppConstants.primaryTealLight,
                                shape: BoxShape.circle,
                              )
                            : null,
                        child: Text(
                          record.shortDay,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isToday
                                ? FontWeight.w800
                                : FontWeight.w600,
                            color: isToday
                                ? AppConstants.primaryTealDark
                                : AppConstants.neutralTextDark,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
