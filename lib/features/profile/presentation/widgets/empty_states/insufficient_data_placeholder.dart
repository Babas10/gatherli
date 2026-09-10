// Empty state placeholder for users with no game data.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';

/// A friendly empty state widget for users who haven't played any games yet.
///
/// Shows an encouraging message and clear unlock criteria.
/// Avoids misleading zeros or complex calculations.
class EmptyStatsPlaceholder extends StatelessWidget {
  final String title;
  final String message;
  final String? unlockMessage;
  final IconData icon;

  const EmptyStatsPlaceholder({
    super.key,
    this.title = 'No Stats Yet',
    this.message = 'Start playing games to see your statistics!',
    this.unlockMessage,
    this.icon = Icons.insert_chart_outlined,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 48.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon
            Icon(
              icon,
              size: 64,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Title
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.md),
            // Message
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            // Unlock message (if provided)
            if (unlockMessage != null) ...[
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.primary.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.lock_outline,
                      size: 16,
                      color: AppColors.secondary,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Flexible(
                      child: Text(
                        unlockMessage!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Variant for insufficient data scenarios (e.g., "Play more games to unlock").
///
/// Enhanced in Story 302.7 to support progress tracking and custom messages.
class InsufficientDataPlaceholder extends StatelessWidget {
  final String featureName;
  final String requirement;
  final IconData icon;
  final String? currentProgress;
  final String? message;

  const InsufficientDataPlaceholder({
    super.key,
    required this.featureName,
    required this.requirement,
    this.icon = Icons.info_outline,
    this.currentProgress,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0, horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: AppColors.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              featureName,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              requirement,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.textMuted,
              ),
              textAlign: TextAlign.center,
            ),
            if (currentProgress != null) ...[
              const SizedBox(height: AppSpacing.md),
              Text(
                currentProgress!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
            if (message != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                message!,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
