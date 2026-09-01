// Lists championships in two tabs: Active (registration/active) and Completed.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_state.dart';
import 'package:play_with_me/features/championships/presentation/pages/championship_detail_page.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class ChampionshipListPage extends StatelessWidget {
  const ChampionshipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _ChampionshipListView();
  }
}

class _ChampionshipListView extends StatefulWidget {
  const _ChampionshipListView();

  @override
  State<_ChampionshipListView> createState() => _ChampionshipListViewState();
}

class _ChampionshipListViewState extends State<_ChampionshipListView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _onTap(BuildContext context, ChampionshipModel championship) async {
    final deleted = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) =>
            ChampionshipDetailPage(championshipId: championship.id),
      ),
    );
    if (deleted == true && context.mounted) {
      final l10n = AppLocalizations.of(context)!;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l10n.deleteChampionshipSuccess),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        // ── Tab bar ──────────────────────────────────────────────────────────
        Container(
          color: Colors.white,
          child: TabBar(
            controller: _tabController,
            labelColor: AppColors.secondary,
            unselectedLabelColor: AppColors.textMuted,
            indicatorColor: AppColors.secondary,
            tabs: [
              Tab(text: l10n.championshipTabActive),
              Tab(text: l10n.championshipTabCompleted),
            ],
          ),
        ),
        // ── Tab content ──────────────────────────────────────────────────────
        Expanded(
          child: BlocBuilder<ChampionshipListBloc, ChampionshipListState>(
            buildWhen: (prev, curr) => prev.runtimeType != curr.runtimeType ||
                (prev is ChampionshipListLoaded && curr is ChampionshipListLoaded &&
                 prev.championships != curr.championships),
            builder: (context, state) {
              if (state is ChampionshipListLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is ChampionshipListError) {
                return Center(child: Text(state.message));
              }
              if (state is ChampionshipListLoaded) {
                final all = state.championships;
                final active = all
                    .where((c) => c.status != ChampionshipStatus.completed)
                    .toList();
                final completed = all
                    .where((c) => c.status == ChampionshipStatus.completed)
                    .toList();

                return TabBarView(
                  controller: _tabController,
                  children: [
                    _ChampionshipList(
                      items: active,
                      emptyLabel: l10n.championshipNoResults,
                      onTap: (c) => _onTap(context, c),
                    ),
                    _ChampionshipList(
                      items: completed,
                      emptyLabel: l10n.championshipNoCompletedYet,
                      onTap: (c) => _onTap(context, c),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ],
    );
  }
}

class _ChampionshipList extends StatelessWidget {
  final List<ChampionshipModel> items;
  final String emptyLabel;
  final void Function(ChampionshipModel) onTap;

  const _ChampionshipList({
    required this.items,
    required this.emptyLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            emptyLabel,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(color: AppColors.textMuted),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return RefreshIndicator(
      color: AppColors.secondary,
      onRefresh: () async {
        // The BLoC stream refreshes automatically; just trigger a re-listen.
        await Future.delayed(const Duration(milliseconds: 300));
      },
      child: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: items.length,
        itemBuilder: (_, i) => ChampionshipCard(
          championship: items[i],
          onTap: () => onTap(items[i]),
        ),
      ),
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

    return AccentCard(
      onTap: onTap,
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
                  const SizedBox(width: AppSpacing.sm),
                  if (championship.genderCategory != null) ...[
                    _GenderBadge(
                      category: championship.genderCategory!,
                      l10n: l10n,
                    ),
                    const SizedBox(width: 6),
                  ],
                  _StatusBadge(championship: championship, l10n: l10n),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                children: [
                  const Icon(Icons.group, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: AppSpacing.xs),
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
                const SizedBox(height: AppSpacing.xs),
                Row(
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: AppSpacing.xs),
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
                const SizedBox(height: AppSpacing.sm),
                _DeadlineRow(championship: championship, l10n: l10n),
              ],
            ],
      ),
    );
  }
}

// ── Gender badge ─────────────────────────────────────────────────────────────

class _GenderBadge extends StatelessWidget {
  final ChampionshipGenderCategory category;
  final AppLocalizations l10n;

  const _GenderBadge({required this.category, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final label = category == ChampionshipGenderCategory.male
        ? l10n.championshipGenderMale
        : l10n.championshipGenderFemale;
    const color = AppColors.info;
    return StatusBadge(label: label, color: color);
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
          AppColors.primary,
        ),
      ChampionshipStatus.registrationClosed => (
          l10n.championshipStatusBadgeClosed,
          AppColors.warning,
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

    return StatusBadge(label: label, color: color);
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
      color = daysLeft <= 3 ? AppColors.danger : AppColors.textMuted;
    } else {
      text = l10n.championshipDeadlineLabel(DateFormat.yMMMd().format(deadline));
      color = AppColors.textMuted;
    }

    return Row(
      children: [
        Icon(Icons.schedule, size: 14, color: color),
        const SizedBox(width: AppSpacing.xs),
        Text(
          text,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
        ),
      ],
    );
  }
}
