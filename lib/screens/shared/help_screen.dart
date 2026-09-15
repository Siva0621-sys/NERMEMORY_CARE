import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';

/// Screen for app walkthrough, game instructions, and caregiver tips
class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Help & User Guide'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Welcome Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE0F2F1), Color(0xFFB2DFDB)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  border: Border.all(
                    color: AppConstants.primaryTeal.withValues(alpha: 0.2),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline_rounded,
                      color: AppConstants.primaryTealDark,
                      size: 36,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Using NER MemoryCare',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: AppConstants.neutralTextDark,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Simple activities built to encourage, not to test.',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppConstants.neutralTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Game Guides
              const SectionHeader(
                title: 'How to Play the Games',
                subtitle: 'Gentle instructions for patients and caregivers',
                icon: Icons.sports_esports_rounded,
              ),
              const SizedBox(height: 8),

              _buildGuideCard(
                icon: Icons.grid_view_rounded,
                iconColor: AppConstants.primaryTeal,
                title: 'Memory Match',
                description:
                    'Tap cards one by one. Find two matching symbols from North Eastern culture (Tea Leaf, Hornbill, Orchid, Bamboo). Take as much time as needed.',
              ),
              _buildGuideCard(
                icon: Icons.photo_library_rounded,
                iconColor: AppConstants.softBlue,
                title: 'Remember the Picture',
                description:
                    'A soothing picture is shown for a few seconds. When it hides, choose the picture you just saw. This strengthens short-term visual recall.',
              ),
              _buildGuideCard(
                icon: Icons.coffee_rounded,
                iconColor: AppConstants.accentGreen,
                title: 'Everyday Objects',
                description:
                    'Recognize everyday household items like a tea cup, a wall clock, or a favorite chair. This promotes daily object orientation and confidence.',
              ),

              const SizedBox(height: 20),

              // Caregiver Tips
              const SectionHeader(
                title: 'Gentle Caregiver Tips',
                subtitle: 'Fostering reassurance and a calm environment',
                icon: Icons.favorite_border_rounded,
              ),
              const SizedBox(height: 8),

              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTipItem(
                      number: '1',
                      tip:
                          'Celebrate participation, not perfection. Every tap is meaningful cognitive engagement.',
                    ),
                    const Divider(height: 20),
                    _buildTipItem(
                      number: '2',
                      tip:
                          'Play together at a predictable time each day, such as after morning tea.',
                    ),
                    const Divider(height: 20),
                    _buildTipItem(
                      number: '3',
                      tip:
                          'If Meena feels tired or confused, pause gently. A calm environment always comes first.',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Non-medical Note
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppConstants.cardBorderColor),
                ),
                child: const Text(
                  AppConstants.medicalDisclaimer,
                  style: TextStyle(
                    fontSize: 12,
                    color: AppConstants.neutralTextMuted,
                    height: 1.4,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGuideCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String description,
  }) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: iconColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.neutralTextDark,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppConstants.neutralTextMuted,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTipItem({required String number, required String tip}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: AppConstants.primaryTealLight,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Text(
              number,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: AppConstants.primaryTealDark,
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            tip,
            style: const TextStyle(
              fontSize: 13,
              color: AppConstants.neutralTextDark,
              height: 1.35,
            ),
          ),
        ),
      ],
    );
  }
}
