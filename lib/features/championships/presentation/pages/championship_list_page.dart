// Lists all championships with status filtering. Entry point to the championships section.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class ChampionshipListPage extends StatelessWidget {
  const ChampionshipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<ChampionshipListBloc>()..add(const LoadChampionships()),
      child: const _ChampionshipListView(),
    );
  }
}

class _ChampionshipListView extends StatelessWidget {
  const _ChampionshipListView();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        _FilterRow(l10n: l10n),
        Expanded(
          child: BlocBuilder<ChampionshipListBloc, ChampionshipListState>(
            builder: (context, state) {
              if (state is ChampionshipListLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state is ChampionshipListError) {
                return Center(child: Text(state.message));
              }

              if (state is ChampionshipListLoaded) {
                final items = state.championships;
                if (items.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Text(
                        l10n.championshipNoResults,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: AppColors.textMuted,
                            ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                  itemCount: items.length,
                  itemBuilder: (_, i) => ChampionshipCard(
                    championship: items[i],
                    onTap: () => _onTap(context, items[i]),
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }

  void _onTap(BuildContext context, ChampionshipModel championship) {
    // Navigation to Championship Detail (Story 30.10)
    // Placeholder until detail screen is implemented
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(championship.title)),
    );
  }
}

// ============================================================================
// Filter row
// ============================================================================

class _FilterRow extends StatelessWidget {
  final AppLocalizations l10n;

  const _FilterRow({required this.l10n});

  static const _filters = <String?>[null, 'registration', 'active', 'completed'];

  String _label(AppLocalizations l10n, String? filter) {
    switch (filter) {
      case null:
        return l10n.championshipFilterAll;
      case 'registration':
        return l10n.championshipFilterRegistration;
      case 'active':
        return l10n.championshipFilterActive;
      case 'completed':
        return l10n.championshipFilterCompleted;
      default:
        return filter;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChampionshipListBloc, ChampionshipListState>(
      buildWhen: (prev, curr) =>
          curr is ChampionshipListLoaded || prev is ChampionshipListLoaded,
      builder: (context, state) {
        final activeFilter =
            state is ChampionshipListLoaded ? state.activeFilter : null;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Row(
            children: _filters
                .map(
                  (filter) => Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: FilterChip(
                      label: Text(_label(l10n, filter)),
                      selected: activeFilter == filter,
                      onSelected: (_) => context
                          .read<ChampionshipListBloc>()
                          .add(FilterChampionships(status: filter)),
                      selectedColor:
                          AppColors.primary.withValues(alpha: 0.15),
                      checkmarkColor: AppColors.primary,
                      labelStyle: TextStyle(
                        color: activeFilter == filter
                            ? AppColors.primary
                            : AppColors.textMuted,
                        fontWeight: activeFilter == filter
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        );
      },
    );
  }
}

// ============================================================================
// Championship card
// ============================================================================

class ChampionshipCard extends StatelessWidget {
  final ChampionshipModel championship;
  final VoidCallback? onTap;

  const ChampionshipCard({
    super.key,
    required this.championship,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      championship.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  _StatusBadge(championship: championship, l10n: l10n),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.group, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(
                    l10n.championshipTeamCountOf(
                      championship.teamsCount,
                      championship.maxTeams,
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ),
              if (championship.country != null ||
                  championship.region != null) ...[
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: 4),
                    Text(
                      [championship.region, championship.country]
                          .whereType<String>()
                          .join(', '),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ],
              if (championship.status == ChampionshipStatus.registration ||
                  championship.status ==
                      ChampionshipStatus.registrationClosed) ...[
                const SizedBox(height: 8),
                _DeadlineRow(championship: championship, l10n: l10n),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Status badge ─────────────────────────────────────────────────────────────

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

// ── Deadline row ─────────────────────────────────────────────────────────────

class _DeadlineRow extends StatelessWidget {
  final ChampionshipModel championship;
  final AppLocalizations l10n;

  const _DeadlineRow({required this.championship, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final deadline = championship.registrationDeadline;
    final daysLeft = deadline.difference(now).inDays;

    final String text;
    final Color color;

    if (daysLeft > 0) {
      text = l10n.championshipDeadlineCountdown(daysLeft);
      color = daysLeft <= 3 ? Colors.red : AppColors.textMuted;
    } else {
      text = l10n.championshipDeadlineLabel(DateFormat.yMMMd().format(deadline));
      color = AppColors.textMuted;
    }

    return Row(
      children: [
        Icon(Icons.schedule, size: 14, color: color),
        const SizedBox(width: 4),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
