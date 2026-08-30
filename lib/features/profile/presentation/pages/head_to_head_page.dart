// Head-to-head rivalry screen showing comprehensive opponent statistics.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/utils/avatar_cache_sizing.dart';
import 'package:play_with_me/core/theme/play_with_me_app_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/data/models/head_to_head_stats.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/domain/repositories/user_repository.dart';
import 'package:play_with_me/features/profile/presentation/bloc/head_to_head/head_to_head_bloc.dart';
import 'package:play_with_me/features/profile/presentation/bloc/head_to_head/head_to_head_event.dart';
import 'package:play_with_me/features/profile/presentation/bloc/head_to_head/head_to_head_state.dart';

class HeadToHeadPage extends StatelessWidget {
  final String userId;
  final String opponentId;

  const HeadToHeadPage({
    super.key,
    required this.userId,
    required this.opponentId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HeadToHeadBloc(userRepository: sl<UserRepository>())
        ..add(
          HeadToHeadEvent.loadHeadToHead(
            userId: userId,
            opponentId: opponentId,
          ),
        ),
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackground,
        appBar: PlayWithMeAppBar.build(context: context, title: 'Head-to-Head'),
        body: BlocBuilder<HeadToHeadBloc, HeadToHeadState>(
          builder: (context, state) {
            return state.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const Center(child: CircularProgressIndicator()),
              loaded: (stats) => _buildLoadedView(context, stats),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 40,
                      color: AppColors.danger,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 13),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildLoadedView(BuildContext context, HeadToHeadStats stats) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOpponentHeader(context, stats),
          const SizedBox(height: AppSpacing.lg),
          _buildSection(
            context,
            label: 'RIVALRY',
            child: _buildRivalryContent(context, stats),
          ),
          _buildSection(
            context,
            label: 'HEAD-TO-HEAD RECORD',
            child: _buildRecordContent(context, stats),
          ),
          _buildSection(
            context,
            label: 'POINT DIFFERENTIAL',
            child: _buildPointDifferentialContent(context, stats),
          ),
          _buildSection(
            context,
            label: 'MATCHUP MARGINS',
            child: _buildMarginsContent(context, stats),
          ),
          _buildSection(
            context,
            label: 'RECENT MATCHUPS',
            child: _buildRecentMatchupsContent(context, stats),
          ),
        ],
      ),
    );
  }

  /// Gray uppercase label + white card — matches homepage/stats pattern.
  Widget _buildSection(
    BuildContext context, {
    required String label,
    required Widget child,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.sectionLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          Card(
            margin: EdgeInsets.zero,
            child: Padding(padding: const EdgeInsets.all(16), child: child),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildOpponentHeader(BuildContext context, HeadToHeadStats stats) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
                backgroundImage: stats.opponentPhotoUrl != null
                    ? CachedNetworkImageProvider(
                        stats.opponentPhotoUrl!,
                        maxWidth: avatarCacheDimension(context, 60),
                        maxHeight: avatarCacheDimension(context, 60),
                      )
                    : null,
                child: stats.opponentPhotoUrl == null
                    ? const Icon(
                        Icons.person,
                        size: 30,
                        color: AppColors.secondary,
                      )
                    : null,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      stats.opponentDisplayName,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    if (stats.opponentName != null &&
                        stats.opponentEmail != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        stats.opponentEmail!,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRivalryContent(BuildContext context, HeadToHeadStats stats) {
    return Column(
      children: [
        Text(
          stats.rivalryIntensity,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: AppColors.secondary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 6),
        Text(
          stats.matchupAdvantage,
          style: TextStyle(
            fontSize: 13,
            color: AppColors.textMuted.withValues(alpha: 0.8),
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildRecordContent(BuildContext context, HeadToHeadStats stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(
          'Matchups',
          stats.gamesPlayed.toString(),
          AppColors.secondary,
        ),
        _buildStatColumn(
          'Win Rate',
          '${stats.winRate.toStringAsFixed(1)}%',
          stats.winRate >= 50 ? AppColors.success : AppColors.danger,
        ),
        _buildStatColumn('Record', stats.recordString, AppColors.secondary),
      ],
    );
  }

  Widget _buildPointDifferentialContent(
    BuildContext context,
    HeadToHeadStats stats,
  ) {
    final isPositive = stats.avgPointDifferential >= 0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(
          'Avg Per Game',
          stats.formattedPointDifferential,
          isPositive ? AppColors.success : AppColors.danger,
        ),
        _buildStatColumn(
          'Points For',
          stats.avgPointsScored.toStringAsFixed(1),
          AppColors.secondary,
        ),
        _buildStatColumn(
          'Points Against',
          stats.avgPointsAllowed.toStringAsFixed(1),
          AppColors.secondary,
        ),
      ],
    );
  }

  Widget _buildMarginsContent(BuildContext context, HeadToHeadStats stats) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn(
          'Biggest Win',
          '+${stats.largestVictoryMargin}',
          AppColors.success,
        ),
        _buildStatColumn(
          'Worst Loss',
          '-${stats.largestDefeatMargin}',
          AppColors.danger,
        ),
        _buildStatColumn(
          'ELO vs Them',
          stats.formattedEloChange,
          stats.eloChange >= 0 ? AppColors.success : AppColors.danger,
        ),
      ],
    );
  }

  Widget _buildRecentMatchupsContent(
    BuildContext context,
    HeadToHeadStats stats,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (stats.currentStreak.abs() > 0) ...[
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: stats.isOnWinningStreak
                    ? AppColors.success.withValues(alpha: 0.1)
                    : AppColors.danger.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${stats.currentStreak.abs()} ${stats.isOnWinningStreak ? "W" : "L"} Streak',
                style: TextStyle(
                  fontSize: 12,
                  color: stats.isOnWinningStreak ? AppColors.success : AppColors.danger,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        if (stats.recentMatchups.isEmpty)
          Text(
            'No recent matchups',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textMuted.withValues(alpha: 0.7),
            ),
          )
        else
          ...stats.recentMatchups.map((matchup) => _buildMatchupTile(matchup)),
      ],
    );
  }

  Widget _buildMatchupTile(HeadToHeadGameResult matchup) {
    final resultColor = matchup.won ? AppColors.success : AppColors.danger;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: resultColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: resultColor.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: resultColor.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                matchup.resultLetter,
                style: TextStyle(
                  fontSize: 14,
                  color: resultColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      matchup.scoreDisplay,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '(${matchup.formattedPointDifferential})',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textMuted.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  'ELO: ${matchup.formattedEloChange}',
                  style: TextStyle(
                    fontSize: 11,
                    color: matchup.eloChange >= 0 ? AppColors.success : AppColors.danger,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// Stat column: large value + small label below.
  Widget _buildStatColumn(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: AppTextStyles.tinyCaption,
        ),
      ],
    );
  }
}
