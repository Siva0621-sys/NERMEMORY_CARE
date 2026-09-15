import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/app_card.dart';
import '../../core/widgets/section_header.dart';
import '../../services/app_state_notifier.dart';

/// Screen displaying essential emergency contacts and simulated quick-call actions
class EmergencyInfoScreen extends StatelessWidget {
  const EmergencyInfoScreen({super.key});

  void _simulateCall(BuildContext context, String contactName, String number) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            const Icon(Icons.phone_in_talk_rounded, color: Color(0xFFC62828)),
            const SizedBox(width: 8),
            Text('Calling $contactName'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Simulating phone call to: $number',
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            const Text(
              '(In production, this triggers native direct telephone dialing for patient safety).',
              style: TextStyle(
                fontSize: 12,
                color: AppConstants.neutralTextMuted,
              ),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
            ),
            onPressed: () => Navigator.pop(ctx),
            child: const Text(
              'End Call Demo',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final patient = AppStateNotifier().patient;

    return Scaffold(
      backgroundColor: AppConstants.secondaryCream,
      appBar: AppBar(
        title: const Text('Emergency & Medical Contacts'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingLarge),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Emergency Highlight Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFEBEE),
                  borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                  border: Border.all(color: const Color(0xFFEF9A9A)),
                ),
                child: const Row(
                  children: [
                    Icon(
                      Icons.health_and_safety_rounded,
                      color: Color(0xFFC62828),
                      size: 36,
                    ),
                    SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Quick Emergency Help',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: Color(0xFFB71C1C),
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Tap any contact to quickly connect in case of urgency.',
                            style: TextStyle(
                              fontSize: 13,
                              color: Color(0xFF7F0000),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Patient Safety Card
              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Patient: ${patient.name}',
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: AppConstants.neutralTextDark,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: AppConstants.primaryTealLight,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text(
                            'Blood Group: B+',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppConstants.primaryTealDark,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Location: ${patient.location}',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Allergies: None known • Supportive Dementia Routine',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Contact Actions
              const SectionHeader(
                title: 'Primary Contacts',
                icon: Icons.contacts_rounded,
              ),
              const SizedBox(height: 8),

              _buildContactItem(
                context: context,
                title: 'Aarav (Primary Caregiver / Son)',
                number: patient.emergencyPhone,
                icon: Icons.person_pin_rounded,
                color: AppConstants.primaryTeal,
              ),
              _buildContactItem(
                context: context,
                title: 'Dr. H. Sharma (Neurologist / Elder Care)',
                number: '+91 98765 12345',
                icon: Icons.medical_services_rounded,
                color: AppConstants.accentGreen,
              ),
              _buildContactItem(
                context: context,
                title: 'Elder Line (Senior Citizen National Helpline)',
                number: '14567',
                icon: Icons.support_agent_rounded,
                color: const Color(0xFF1976D2),
              ),
              _buildContactItem(
                context: context,
                title: 'National Emergency Response System',
                number: '112',
                icon: Icons.emergency_rounded,
                color: const Color(0xFFC62828),
              ),
              _buildContactItem(
                context: context,
                title: 'Ambulance Helpline',
                number: '108',
                icon: Icons.local_hospital_rounded,
                color: const Color(0xFFE65100),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required String title,
    required String number,
    required IconData icon,
    required Color color,
  }) {
    return AppCard(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppConstants.neutralTextDark,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  number,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(Icons.phone_in_talk_rounded, color: color),
            onPressed: () => _simulateCall(context, title, number),
            tooltip: 'Call $number',
          ),
        ],
      ),
    );
  }
}
