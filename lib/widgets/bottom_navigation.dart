import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

/// Reusable accessible bottom navigation bar for Caregiver and Elderly modes
class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  final bool isElderly;

  const AppBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
    this.isElderly = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isElderly) {
      // Larger, higher contrast NavigationBar for Elderly User
      return NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: onTap,
        height: 78,
        indicatorColor: AppConstants.primaryTealLight,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, size: 28),
            selectedIcon: Icon(
              Icons.home_rounded,
              size: 28,
              color: AppConstants.primaryTealDark,
            ),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.sports_esports_outlined, size: 28),
            selectedIcon: Icon(
              Icons.sports_esports_rounded,
              size: 28,
              color: AppConstants.primaryTealDark,
            ),
            label: 'Games',
          ),
          NavigationDestination(
            icon: Icon(Icons.alarm_outlined, size: 28),
            selectedIcon: Icon(
              Icons.alarm_rounded,
              size: 28,
              color: AppConstants.primaryTealDark,
            ),
            label: 'Reminders',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded, size: 28),
            selectedIcon: Icon(
              Icons.person_rounded,
              size: 28,
              color: AppConstants.primaryTealDark,
            ),
            label: 'Profile',
          ),
        ],
      );
    }

    // Caregiver Navigation Bar
    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      height: 68,
      indicatorColor: AppConstants.primaryTealLight,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.dashboard_outlined),
          selectedIcon: Icon(
            Icons.dashboard_rounded,
            color: AppConstants.primaryTealDark,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(Icons.insights_outlined),
          selectedIcon: Icon(
            Icons.insights_rounded,
            color: AppConstants.primaryTealDark,
          ),
          label: 'Progress',
        ),
        NavigationDestination(
          icon: Icon(Icons.calendar_today_outlined),
          selectedIcon: Icon(
            Icons.calendar_today_rounded,
            color: AppConstants.primaryTealDark,
          ),
          label: 'Reminders',
        ),
        NavigationDestination(
          icon: Icon(Icons.account_circle_outlined),
          selectedIcon: Icon(
            Icons.account_circle_rounded,
            color: AppConstants.primaryTealDark,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}
