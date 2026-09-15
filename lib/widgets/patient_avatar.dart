import 'package:flutter/material.dart';
import '../core/constants/app_constants.dart';

/// Friendly patient avatar widget with gentle status ring
class PatientAvatar extends StatelessWidget {
  final double size;
  final String name;
  final bool showStatusRing;
  final Color? ringColor;

  const PatientAvatar({
    super.key,
    this.size = 50.0,
    required this.name,
    this.showStatusRing = false,
    this.ringColor,
  });

  @override
  Widget build(BuildContext context) {
    final initials = name.trim().isNotEmpty
        ? name.trim().split(' ').map((e) => e[0]).take(2).join()
        : 'M';

    final avatarContent = Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [Color(0xFF80CBC4), Color(0xFF00796B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Text(
          initials,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.42,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );

    if (!showStatusRing) return avatarContent;

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: size + 6,
          height: size + 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ringColor ?? const Color(0xFF80CBC4),
              width: 2.5,
            ),
          ),
        ),
        avatarContent,
        Positioned(
          bottom: 1,
          right: 1,
          child: Container(
            width: size * 0.28,
            height: size * 0.28,
            decoration: BoxDecoration(
              color: AppConstants.accentGreen,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
