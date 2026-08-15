// Compact stat card widget for home screen glance-level statistics display.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';

/// A compact card widget for displaying a single statistic on the home screen.
///
/// This is a streamlined version of [StatCard] optimized for glance-level
/// statistics display with minimal space usage.
class CompactStatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData? icon;
  final Color? iconColor;
  final String? subLabel;
  final Color? subLabelColor;

  const CompactStatCard({
    super.key,
    required this.label,
    required this.value,
    this.icon,
    this.iconColor,
    this.subLabel,
    this.subLabelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label and icon row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Text(
                    label,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                      fontWeight: FontWeight.w500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (icon != null) ...[
                  const SizedBox(width: AppSpacing.xs),
                  Icon(
                    icon,
                    size: 16,
                    color: iconColor ?? theme.colorScheme.primary,
                  ),
                ],
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            // Value
            Text(
              value,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            // Sub-label (optional)
            if (subLabel != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subLabel!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color:
                      subLabelColor ??
                      theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
