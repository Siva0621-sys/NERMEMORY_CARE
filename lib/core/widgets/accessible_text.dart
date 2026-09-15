import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// Text widget that adapts to accessibility settings and guarantees high readability
class AccessibleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final double? height;
  final bool isHighContrast;

  const AccessibleText(
    this.text, {
    super.key,
    this.fontSize = 16.0,
    this.fontWeight = FontWeight.w400,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.height,
    this.isHighContrast = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color effectiveColor =
        color ??
        (isDark
            ? AppConstants.highContrastWhite
            : AppConstants.neutralTextDark);
    if (isHighContrast) {
      effectiveColor = isDark ? AppConstants.highContrastYellow : Colors.black;
    }

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: effectiveColor,
        height: height ?? 1.3,
      ),
    );
  }
}
