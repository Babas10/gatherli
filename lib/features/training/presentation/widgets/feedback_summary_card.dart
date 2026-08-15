import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

import '../../../../core/domain/repositories/training_feedback_repository.dart';

/// Displays aggregated feedback statistics for a training session.
/// Follows the homepage gray-label / white-card pattern.
class FeedbackSummaryCard extends StatelessWidget {
  final FeedbackAggregation aggregation;

  const FeedbackSummaryCard({super.key, required this.aggregation});

  @override
  Widget build(BuildContext context) {
    if (aggregation.totalCount == 0) {
      return const SizedBox.shrink();
    }

    final overallAverage = aggregation.overallAverage;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Section label — uppercase, muted, letter-spaced
          const Text(
            'FEEDBACK SUMMARY',
            style: AppTextStyles.sectionLabel,
          ),
          const SizedBox(height: AppSpacing.md),

          // Overall rating card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      overallAverage.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                    ),
                    _buildStarRating(overallAverage),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Based on ${aggregation.totalCount} ${aggregation.totalCount == 1 ? 'rating' : 'ratings'}',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: AppColors.textMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),

          // Category ratings card
          Card(
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildCategoryRating(
                    context,
                    'Exercises Quality',
                    Icons.fitness_center,
                    aggregation.averageExercisesQuality,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildCategoryRating(
                    context,
                    'Training Intensity',
                    Icons.local_fire_department,
                    aggregation.averageTrainingIntensity,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildCategoryRating(
                    context,
                    'Coaching Clarity',
                    Icons.school,
                    aggregation.averageCoachingClarity,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildStarRating(double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        final starValue = index + 1;
        IconData icon;

        if (rating >= starValue) {
          icon = Icons.star;
        } else if (rating >= starValue - 0.5) {
          icon = Icons.star_half;
        } else {
          icon = Icons.star_border;
        }

        return Icon(icon, color: AppColors.primary, size: 32);
      }),
    );
  }

  Widget _buildCategoryRating(
    BuildContext context,
    String label,
    IconData icon,
    double rating,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.secondary),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: rating / 5,
                      minHeight: 8,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        AppColors.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  SizedBox(
                    width: 40,
                    child: Text(
                      rating.toStringAsFixed(1),
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
