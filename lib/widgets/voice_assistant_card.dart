import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';
import '../core/widgets/app_card.dart';

/// Voice Assistant preview card for simulated AI voice assistance
class VoiceAssistantCard extends StatefulWidget {
  final bool isElderly;

  const VoiceAssistantCard({super.key, this.isElderly = false});

  @override
  State<VoiceAssistantCard> createState() => _VoiceAssistantCardState();
}

class _VoiceAssistantCardState extends State<VoiceAssistantCard> {
  bool _isPlaying = false;
  String _simulatedResponse = '';

  void _runVoiceDemo() {
    setState(() {
      _isPlaying = true;
      _simulatedResponse = 'Listening...';
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      if (mounted) {
        setState(() {
          _simulatedResponse =
              '“Hello Meena! Would you like to play a memory game today?”';
          _isPlaying = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: const Color(0xFFF0FDF4), // Gentle soft green/teal surface
      borderColor: AppConstants.accentGreen.withValues(alpha: 0.3),
      padding: EdgeInsets.all(widget.isElderly ? 20 : 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppConstants.accentGreen.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.record_voice_over_rounded,
                  size: widget.isElderly ? 32 : 24,
                  color: AppConstants.accentGreen,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Talk to NER MemoryCare',
                      style: TextStyle(
                        fontSize: widget.isElderly ? 18 : 16,
                        fontWeight: FontWeight.w700,
                        color: AppConstants.neutralTextDark,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Voice support coming soon (Prototype)',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppConstants.neutralTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (_simulatedResponse.isNotEmpty) ...[
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppConstants.accentGreen.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    _isPlaying
                        ? Icons.graphic_eq_rounded
                        : Icons.assistant_rounded,
                    color: AppConstants.accentGreen,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _simulatedResponse,
                      style: TextStyle(
                        fontSize: widget.isElderly ? 15 : 13,
                        fontWeight: FontWeight.w600,
                        color: AppConstants.neutralTextDark,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              OutlinedButton.icon(
                onPressed: _isPlaying ? null : _runVoiceDemo,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppConstants.accentGreen,
                  side: const BorderSide(
                    color: AppConstants.accentGreen,
                    width: 1.5,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.isElderly ? 20 : 16,
                    vertical: widget.isElderly ? 12 : 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppConstants.buttonRadius,
                    ),
                  ),
                ),
                icon: Icon(
                  _isPlaying ? Icons.hourglass_top_rounded : Icons.mic_rounded,
                  size: widget.isElderly ? 22 : 18,
                ),
                label: Text(
                  _isPlaying ? 'Simulating...' : 'Try Voice Demo',
                  style: TextStyle(
                    fontSize: widget.isElderly ? 15 : 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
