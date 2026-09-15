import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Reusable elevated card using Material to ensure ink splashes, ListTiles,
/// and tap interactions work perfectly without assertion errors.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Color? borderColor;
  final double? borderRadius;
  final VoidCallback? onTap;
  final double elevation;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.color,
    this.borderColor,
    this.borderRadius,
    this.onTap,
    this.elevation = 0,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveBorderRadius = BorderRadius.circular(
      borderRadius ?? AppConstants.cardRadius,
    );
    final effectiveColor =
        color ?? (isDark ? AppConstants.highContrastSurface : Colors.white);
    final effectiveBorderColor =
        borderColor ??
        (isDark
            ? AppConstants.highContrastYellow
            : AppConstants.cardBorderColor);

    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        color: effectiveColor,
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: effectiveBorderRadius,
          side: BorderSide(
            color: effectiveBorderColor,
            width: isDark ? 2 : 1.2,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          borderRadius: effectiveBorderRadius,
          child: Padding(
            padding: padding ?? const EdgeInsets.all(AppConstants.paddingMedium),
            child: child,
          ),
        ),
      ),
    );
  }
}
