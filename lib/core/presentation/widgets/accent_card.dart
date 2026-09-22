// Reusable card with a gold left accent bar — the standard card style across
// all listing pages (home, championships, games, community, groups).
//
// Uses IntrinsicHeight + Row so the bar reliably stretches to the card height
// in any layout context (ListView, Column, etc.).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

class AccentCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;

  /// Padding applied to the card content (excludes the 6px accent bar).
  final EdgeInsetsGeometry contentPadding;

  /// Outer margin of the card.
  final EdgeInsetsGeometry margin;

  /// Colour of the left accent bar. Defaults to AppColors.primary (gold).
  final Color accentColor;

  /// Background colour of the card body. Defaults to AppColors.cardBackground.
  /// Override for status-tinted cards (e.g. cancelled/completed states).
  final Color backgroundColor;

  /// Material elevation of the card. Defaults to 1 (the standard list-item
  /// shadow). Use 0 for flat, densely-stacked cards (e.g. a bottom sheet list).
  final double elevation;

  const AccentCard({
    super.key,
    required this.child,
    this.onTap,
    this.contentPadding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.lg,
      vertical: AppSpacing.lg,
    ),
    this.margin = const EdgeInsets.only(bottom: AppSpacing.md),
    this.accentColor = AppColors.primary,
    this.backgroundColor = AppColors.cardBackground,
    this.elevation = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        clipBehavior: Clip.antiAlias,
        elevation: elevation,
        shadowColor: AppColors.shadow,
        child: InkWell(
          onTap: onTap,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Gold accent bar — stretches to full card height via IntrinsicHeight
                Container(width: 6, color: accentColor),
                // Card content
                Expanded(
                  child: Padding(padding: contentPadding, child: child),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
