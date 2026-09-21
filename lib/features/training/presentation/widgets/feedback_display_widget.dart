import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/presentation/widgets/empty_state.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

import '../../../../core/domain/repositories/training_feedback_repository.dart';
import '../../../../core/services/service_locator.dart';
import '../bloc/feedback/training_feedback_bloc.dart';
import '../bloc/feedback/training_feedback_event.dart';
import '../bloc/feedback/training_feedback_state.dart';
import '../pages/training_session_feedback_page.dart';
import 'feedback_list_item.dart';
import 'feedback_summary_card.dart';
import 'package:play_with_me/core/presentation/widgets/app_page_route.dart';

/// Displays feedback for a training session
/// Shows aggregated statistics and individual feedback entries
/// Provides option to submit feedback if user hasn't done so
class FeedbackDisplayWidget extends StatefulWidget {
  final String trainingSessionId;
  final String sessionTitle;

  const FeedbackDisplayWidget({
    super.key,
    required this.trainingSessionId,
    required this.sessionTitle,
  });

  @override
  State<FeedbackDisplayWidget> createState() => _FeedbackDisplayWidgetState();
}

class _FeedbackDisplayWidgetState extends State<FeedbackDisplayWidget> {
  @override
  void initState() {
    super.initState();
    // Load aggregated feedback when widget is created
    context.read<TrainingFeedbackBloc>().add(
      LoadAggregatedFeedback(widget.trainingSessionId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrainingFeedbackBloc, TrainingFeedbackState>(
      builder: (context, state) {
        // Loading state
        if (state is LoadingAggregatedFeedback) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (state is FeedbackError) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: AppSpacing.iconXxl,
                    color: AppColors.danger,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    'Error loading feedback',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  FilledButton.icon(
                    onPressed: () {
                      context.read<TrainingFeedbackBloc>().add(
                        LoadAggregatedFeedback(widget.trainingSessionId),
                      );
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          );
        }

        // Loaded state
        if (state is AggregatedFeedbackLoaded) {
          final aggregation = state.aggregation;
          final hasUserSubmitted = state.hasUserSubmitted;

          // No feedback yet
          if (aggregation.totalCount == 0) {
            return _buildEmptyState(context, hasUserSubmitted);
          }

          // Display feedback
          return _buildFeedbackDisplay(context, aggregation, hasUserSubmitted);
        }

        // Initial/unknown state - show loading
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, bool hasUserSubmitted) {
    return EmptyState(
      icon: Icons.feedback_outlined,
      title: 'No Feedback Yet',
      message: hasUserSubmitted
          ? 'You have submitted feedback, but no other participants have provided feedback yet.'
          : 'Be the first to provide feedback for this training session!',
      action: hasUserSubmitted
          ? null
          : FilledButton.icon(
              onPressed: () => _navigateToSubmitFeedback(context),
              icon: const Icon(Icons.rate_review),
              label: const Text('Submit Feedback'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xxl,
                  vertical: AppSpacing.lg,
                ),
              ),
            ),
    );
  }

  Widget _buildFeedbackDisplay(
    BuildContext context,
    FeedbackAggregation aggregation,
    bool hasUserSubmitted,
  ) {
    return CustomScrollView(
      slivers: [
        // Summary card
        SliverToBoxAdapter(
          child: FeedbackSummaryCard(aggregation: aggregation),
        ),

        // Submit feedback prompt (if user hasn't submitted)
        if (!hasUserSubmitted)
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.sm,
              ),
              child: Card(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Row(
                    children: [
                      Icon(
                        Icons.rate_review,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: Text(
                          'Share your thoughts about this session',
                          style: TextStyle(
                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => _navigateToSubmitFeedback(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primary,
                          foregroundColor: Theme.of(
                            context,
                          ).colorScheme.onPrimary,
                        ),
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

        // Section header — uppercase gray label matching homepage/stats page style
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.xl,
              AppSpacing.lg,
              AppSpacing.sm,
            ),
            child: Row(
              children: [
                const Text(
                  'INDIVIDUAL FEEDBACK',
                  style: AppTextStyles.sectionLabel,
                ),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: AppSpacing.xs,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.inputRadius),
                  ),
                  child: Text(
                    '${aggregation.totalCount}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Individual feedback list
        SliverToBoxAdapter(
          child: StreamBuilder<List<dynamic>>(
            stream: sl<TrainingFeedbackRepository>().getFeedbackListStream(
              widget.trainingSessionId,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(AppSpacing.xxl),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const SizedBox.shrink();
              }

              final feedbackList = snapshot.data!;
              return Column(
                children: feedbackList.map((feedback) {
                  return FeedbackListItem(feedback: feedback);
                }).toList(),
              );
            },
          ),
        ),

        // Bottom padding
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
      ],
    );
  }

  void _navigateToSubmitFeedback(BuildContext context) {
    // Capture bloc reference before async gap
    final feedbackBloc = context.read<TrainingFeedbackBloc>();

    Navigator.push(
      context,
      AppPageRoute.detail(
        builder: (context) => BlocProvider(
          create: (context) => sl<TrainingFeedbackBloc>(),
          child: TrainingSessionFeedbackPage(
            trainingSessionId: widget.trainingSessionId,
            sessionTitle: widget.sessionTitle,
          ),
        ),
      ),
    ).then((_) {
      // Reload feedback after returning from submission page
      if (mounted) {
        feedbackBloc.add(LoadAggregatedFeedback(widget.trainingSessionId));
      }
    });
  }
}
