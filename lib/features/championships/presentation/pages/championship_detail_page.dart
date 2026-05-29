// Championship detail screen: header info, standings table, and per-round matches.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class ChampionshipDetailPage extends StatelessWidget {
  final String championshipId;

  const ChampionshipDetailPage({super.key, required this.championshipId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ChampionshipDetailBloc>()
        ..add(LoadChampionshipDetail(championshipId)),
      child: const _ChampionshipDetailView(),
    );
  }
}

class _ChampionshipDetailView extends StatelessWidget {
  const _ChampionshipDetailView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<ChampionshipDetailBloc, ChampionshipDetailState>(
      builder: (context, state) {
        final title = state is ChampionshipDetailLoaded
            ? state.championship.title
            : l10n.championshipsTitle;

        return Scaffold(
          appBar: AppBar(title: Text(title)),
          body: _buildBody(context, state, l10n),
        );
      },
    );
  }

  Widget _buildBody(
    BuildContext context,
    ChampionshipDetailState state,
    AppLocalizations l10n,
  ) {
    if (state is ChampionshipDetailLoading ||
        state is ChampionshipDetailInitial) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state is ChampionshipDetailError) {
      return Center(child: Text(state.message));
    }

    if (state is ChampionshipDetailLoaded) {
      return DefaultTabController(
        length: 2,
        child: Column(
          children: [
            _ChampionshipHeader(championship: state.championship),
            TabBar(
              tabs: [
                Tab(text: l10n.championshipDetailStandingsTab),
                Tab(text: l10n.championshipDetailMatchesTab),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _StandingsTab(
                    standings: state.standings,
                    l10n: l10n,
                  ),
                  _MatchesTab(
                    championship: state.championship,
                    matches: state.currentRoundMatches,
                    standings: state.standings,
                    selectedRound: state.selectedRound,
                    l10n: l10n,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// ============================================================================
// Championship header
// ============================================================================

class _ChampionshipHeader extends StatelessWidget {
  final ChampionshipModel championship;

  const _ChampionshipHeader({required this.championship});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          _StatusBadge(championship: championship, l10n: l10n),
          if (championship.country != null)
            _InfoChip(
              icon: Icons.location_on_outlined,
              label: [championship.region, championship.country]
                  .whereType<String>()
                  .join(', '),
            ),
          _InfoChip(
            icon: Icons.group,
            label: l10n.championshipTeamCountOf(
              championship.teamsCount,
              championship.maxTeams,
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.textMuted),
        const SizedBox(width: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final ChampionshipModel championship;
  final AppLocalizations l10n;

  const _StatusBadge({required this.championship, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (championship.status) {
      ChampionshipStatus.registration => (
          l10n.championshipStatusBadgeRegistration,
          Colors.green,
        ),
      ChampionshipStatus.registrationClosed => (
          l10n.championshipStatusBadgeClosed,
          Colors.orange,
        ),
      ChampionshipStatus.active => (
          l10n.championshipStatusBadgeActive(
            championship.currentRound,
            championship.totalRounds,
          ),
          AppColors.primary,
        ),
      ChampionshipStatus.completed => (
          l10n.championshipStatusBadgeCompleted,
          AppColors.textMuted,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }
}

// ============================================================================
// Standings tab
// ============================================================================

class _StandingsTab extends StatelessWidget {
  final List<ChampionshipStandingsModel> standings;
  final AppLocalizations l10n;

  const _StandingsTab({required this.standings, required this.l10n});

  @override
  Widget build(BuildContext context) {
    if (standings.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.championshipDetailNoStandings,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Table(
          columnWidths: const {
            0: FixedColumnWidth(32), // #
            1: FlexColumnWidth(), // Team
            2: FixedColumnWidth(32), // P
            3: FixedColumnWidth(40), // Pts
            4: FixedColumnWidth(32), // W
            5: FixedColumnWidth(32), // L
            6: FixedColumnWidth(40), // SR
          },
          children: [
            _headerRow(context),
            ...standings.map((s) => _standingsRow(context, s)),
          ],
        ),
      ),
    );
  }

  TableRow _headerRow(BuildContext context) {
    final style = Theme.of(context).textTheme.labelSmall?.copyWith(
          color: AppColors.textMuted,
          fontWeight: FontWeight.w600,
        );
    return TableRow(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: AppColors.textMuted.withValues(alpha: 0.3),
          ),
        ),
      ),
      children: [
        _cell(l10n.championshipDetailColPosition, style),
        _cell(l10n.championshipDetailColTeam, style, align: TextAlign.left),
        _cell(l10n.championshipDetailColPlayed, style),
        _cell(l10n.championshipDetailColPoints, style),
        _cell(l10n.championshipDetailColWins, style),
        _cell(l10n.championshipDetailColLosses, style),
        _cell(l10n.championshipDetailColSetRatio, style),
      ],
    );
  }

  TableRow _standingsRow(
      BuildContext context, ChampionshipStandingsModel row) {
    final baseStyle = Theme.of(context).textTheme.bodySmall;
    final boldStyle = baseStyle?.copyWith(fontWeight: FontWeight.w600);

    final sr = row.setRatio;
    final srText = sr > 0 ? '+$sr' : '$sr';

    return TableRow(
      children: [
        _cell('${row.position}', baseStyle?.copyWith(color: AppColors.textMuted)),
        _cell(row.teamName, boldStyle, align: TextAlign.left),
        _cell('${row.played}', baseStyle),
        _cell('${row.points}', boldStyle?.copyWith(color: AppColors.primary)),
        _cell('${row.wins20 + row.wins21}', baseStyle),
        _cell('${row.losses12 + row.losses02}', baseStyle),
        _cell(
          srText,
          baseStyle?.copyWith(color: sr >= 0 ? Colors.green : Colors.red),
        ),
      ],
    );
  }

  Widget _cell(String text, TextStyle? style,
      {TextAlign align = TextAlign.center}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Text(text, style: style, textAlign: align, maxLines: 1),
    );
  }
}

// ============================================================================
// Matches tab
// ============================================================================

class _MatchesTab extends StatelessWidget {
  final ChampionshipModel championship;
  final List<ChampionshipMatchModel> matches;
  final List<ChampionshipStandingsModel> standings;
  final int selectedRound;
  final AppLocalizations l10n;

  const _MatchesTab({
    required this.championship,
    required this.matches,
    required this.standings,
    required this.selectedRound,
    required this.l10n,
  });

  String _teamName(String teamId) {
    try {
      return standings.firstWhere((s) => s.teamId == teamId).teamName;
    } catch (_) {
      return teamId;
    }
  }

  @override
  Widget build(BuildContext context) {
    final totalRounds = championship.totalRounds;

    return Column(
      children: [
        // Round selector
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.chevron_left),
                onPressed: selectedRound > 1
                    ? () => context.read<ChampionshipDetailBloc>().add(
                          ChangeDetailRound(selectedRound - 1),
                        )
                    : null,
              ),
              Text(
                l10n.championshipDetailRound(selectedRound),
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: selectedRound < totalRounds
                    ? () => context.read<ChampionshipDetailBloc>().add(
                          ChangeDetailRound(selectedRound + 1),
                        )
                    : null,
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        // Match list
        Expanded(
          child: matches.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: Text(
                      l10n.championshipDetailNoMatchesForRound,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppColors.textMuted,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                )
              : ListView.separated(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  itemCount: matches.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 8),
                  itemBuilder: (_, i) => _MatchCard(
                    match: matches[i],
                    teamAName: _teamName(matches[i].teamAId),
                    teamBName: _teamName(matches[i].teamBId),
                    l10n: l10n,
                  ),
                ),
        ),
      ],
    );
  }
}

// ============================================================================
// Match card
// ============================================================================

class _MatchCard extends StatelessWidget {
  final ChampionshipMatchModel match;
  final String teamAName;
  final String teamBName;
  final AppLocalizations l10n;

  const _MatchCard({
    required this.match,
    required this.teamAName,
    required this.teamBName,
    required this.l10n,
  });

  String _statusLabel() {
    return switch (match.status) {
      ChampionshipMatchStatus.pending => l10n.championshipMatchStatusPending,
      ChampionshipMatchStatus.scheduled => l10n.championshipMatchStatusPending,
      ChampionshipMatchStatus.played => l10n.championshipMatchStatusPlayed,
      ChampionshipMatchStatus.disputed =>
        l10n.championshipMatchStatusDisputed,
      ChampionshipMatchStatus.adminDecided =>
        l10n.championshipMatchStatusAdminDecided,
      ChampionshipMatchStatus.verified => l10n.championshipMatchStatusVerified,
    };
  }

  Color _statusColor() {
    return switch (match.status) {
      ChampionshipMatchStatus.pending => AppColors.textMuted,
      ChampionshipMatchStatus.scheduled => AppColors.textMuted,
      ChampionshipMatchStatus.played => Colors.blue,
      ChampionshipMatchStatus.disputed => Colors.orange,
      ChampionshipMatchStatus.adminDecided => Colors.purple,
      ChampionshipMatchStatus.verified => Colors.green,
    };
  }

  String _setScores() {
    final result = match.result;
    if (result == null) return '';
    return result.sets
        .map((s) => '${s.teamAPoints}-${s.teamBPoints}')
        .join('  ');
  }

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    final color = _statusColor();

    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    teamAName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: result?.winner == 'teamA'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    l10n.championshipMatchVs,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ),
                Expanded(
                  child: Text(
                    teamBName,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: result?.winner == 'teamB'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                    textAlign: TextAlign.right,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                if (result != null) ...[
                  Text(
                    _setScores(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                  const Spacer(),
                ],
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: color.withValues(alpha: 0.4)),
                  ),
                  child: Text(
                    _statusLabel(),
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
