import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Large, accessible button with optional leading/trailing icon and high contrast support
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isSecondary;
  final bool isLarge;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isSecondary = false,
    this.isLarge = false,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final minHeight = isLarge ? 64.0 : 54.0;
    final fontSize = isLarge ? 18.0 : 16.0;

    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: isLarge ? 26 : 22),
          const SizedBox(width: 10),
        ],
        Text(
          label,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.3,
          ),
        ),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor:
          backgroundColor ??
          (isSecondary
              ? AppConstants.primaryTealLight
              : theme.colorScheme.primary),
      foregroundColor:
          foregroundColor ??
          (isSecondary
              ? AppConstants.primaryTealDark
              : theme.colorScheme.onPrimary),
      minimumSize: Size(width ?? double.infinity, minHeight),
      elevation: isSecondary ? 0 : 2,
      shadowColor: theme.colorScheme.primary.withValues(alpha: 0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.buttonRadius),
        side: isSecondary
            ? BorderSide(color: AppConstants.primaryTeal.withValues(alpha: 0.3))
            : BorderSide.none,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    );

    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        style: buttonStyle,
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}
