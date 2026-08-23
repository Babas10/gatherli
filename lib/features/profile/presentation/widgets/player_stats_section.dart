import 'package:flutter/material.dart';
import 'package:play_with_me/core/data/models/teammate_stats.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:play_with_me/features/profile/presentation/bloc/player_stats/player_stats_bloc.dart';
import 'package:play_with_me/features/profile/presentation/bloc/player_stats/player_stats_state.dart';
import 'package:play_with_me/features/profile/presentation/widgets/elo_history_chart.dart';
import 'package:play_with_me/features/profile/presentation/widgets/stat_card.dart';

class PlayerStatsSection extends StatelessWidget {
  const PlayerStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<PlayerStatsBloc, PlayerStatsState>(
      buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType,
      builder: (context, state) {
        if (state is PlayerStatsLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is PlayerStatsError) {
          return Center(child: Text(l10n.error(state.message)));
        }

        if (state is PlayerStatsLoaded) {
          final user = state.user;
          final history = state.history;
          final teammateStats = state.teammateStats;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ),
                child: Text(
                  l10n.performanceStats,
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),

              // ELO History Chart
              Container(
                height: 200,
                padding: const EdgeInsets.all(16.0),
                child: EloHistoryChart(
                  history: history,
                  currentRating: user.eloRating,
                ),
              ),

              // Stats Grid
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 12.0,
                crossAxisSpacing: 12.0,
                children: [
                  StatCard(
                    label: l10n.eloRatingLabel,
                    value: user.eloRating.toStringAsFixed(0),
                    subLabel: l10n.peak(user.eloPeak.toStringAsFixed(0)),
                    icon: Icons.show_chart,
                    iconColor: AppColors.info,
                  ),
                  StatCard(
                    label: l10n.winRate,
                    value: '${(user.winRate * 100).toStringAsFixed(1)}%',
                    subLabel: l10n.winsLosses(user.gamesWon, user.gamesLost),
                    icon: Icons.pie_chart,
                    iconColor: AppColors.success,
                  ),
                  StatCard(
                    label: l10n.streakLabel,
                    value: user.streakValue.toString(),
                    subLabel: user.isOnWinningStreak
                        ? l10n.winning
                        : (user.isOnLosingStreak
                              ? l10n.losingStreak
                              : l10n.noStreak),
                    icon: Icons.local_fire_department,
                    iconColor: user.isOnWinningStreak
                        ? AppColors.warning
                        : Colors.grey,
                  ),
                  StatCard(
                    label: l10n.gamesPlayedLabel,
                    value: user.gamesPlayed.toString(),
                    icon: Icons.sports_volleyball,
                    iconColor: AppColors.warning,
                  ),
                ],
              ),

              // Best Teammate (Optional, if data exists)
              if (teammateStats.isNotEmpty)
                _BestTeammateCard(teammateStats: teammateStats),
            ],
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _BestTeammateCard extends StatelessWidget {
  final List<TeammateStats> teammateStats;

  const _BestTeammateCard({required this.teammateStats});

  @override
  Widget build(BuildContext context) {
    if (teammateStats.isEmpty) return const SizedBox.shrink();
    final best = teammateStats.reduce(
      (a, b) => a.gamesWon >= b.gamesWon ? a : b,
    );
    final winRate = best.gamesPlayed > 0
        ? (best.gamesWon / best.gamesPlayed * 100).toStringAsFixed(1)
        : '0.0';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Card(
        child: ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(AppLocalizations.of(context)!.bestTeammate),
          subtitle: Text(
            '${best.teammateName ?? best.userId.substring(0, 5)} • '
            '${best.gamesWon} wins ($winRate%)',
          ),
          trailing: const Icon(Icons.star, color: AppColors.warning),
        ),
      ),
    );
  }
}
