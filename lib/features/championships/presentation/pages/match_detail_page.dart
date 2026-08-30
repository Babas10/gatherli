// Match detail screen: coordination chat, schedule proposal, and result
// submission / verification for a single championship match.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/utils/activity_link_url_builder.dart';
import 'package:play_with_me/core/utils/share_helper.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_state.dart';
import 'package:play_with_me/features/championships/presentation/widgets/match_chat_section.dart';
import 'package:play_with_me/features/championships/presentation/widgets/match_result_entry_widget.dart';
import 'package:play_with_me/features/championships/presentation/widgets/match_verification_widget.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/presentation/widgets/global_bottom_nav_bar.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class MatchDetailPage extends StatelessWidget {
  final String championshipId;
  final String matchId;
  final String currentUserId;
  final String currentUserDisplayName;

  const MatchDetailPage({
    super.key,
    required this.championshipId,
    required this.matchId,
    required this.currentUserId,
    required this.currentUserDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MatchDetailBloc>()
        ..add(LoadMatchDetail(
          championshipId: championshipId,
          matchId: matchId,
          currentUserId: currentUserId,
        )),
      child: _MatchDetailView(
        currentUserId: currentUserId,
        currentUserDisplayName: currentUserDisplayName,
      ),
    );
  }
}

class _MatchDetailView extends StatelessWidget {
  final String currentUserId;
  final String currentUserDisplayName;

  const _MatchDetailView({
    required this.currentUserId,
    required this.currentUserDisplayName,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(title: Text(l10n.matchDetailTitle)),
      bottomNavigationBar: GlobalBottomNavBar(
        selectedIndex: 4,
        onTabSelected: (index) {
          HomePage.onNavigateToTab?.call(index);
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: BlocBuilder<MatchDetailBloc, MatchDetailState>(
        builder: (context, state) {
          if (state is MatchDetailLoading || state is MatchDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MatchDetailError) {
            return Center(child: Text(state.message));
          }

          if (state is MatchDetailLoaded) {
            return _MatchDetailBody(
              state: state,
              currentUserId: currentUserId,
              currentUserDisplayName: currentUserDisplayName,
              l10n: l10n,
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ============================================================================
// Body
// ============================================================================

class _MatchDetailBody extends StatelessWidget {
  final MatchDetailLoaded state;
  final String currentUserId;
  final String currentUserDisplayName;
  final AppLocalizations l10n;

  const _MatchDetailBody({
    required this.state,
    required this.currentUserId,
    required this.currentUserDisplayName,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final match = state.match;

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _MatchHeaderCard(
            match: match,
            teamA: state.teamA,
            teamB: state.teamB,
            l10n: l10n,
          ),
          const SizedBox(height: AppSpacing.sm),
          OutlinedButton.icon(
            onPressed: () => copyLinkToClipboard(
              context,
              ActivityLinkUrlBuilder.forChampionshipMatch(
                championshipId: state.championshipId,
                matchId: match.id,
              ),
              l10n,
            ),
            icon: const Icon(Icons.copy, size: 18),
            label: Text(l10n.copyLink),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.secondary,
              side: const BorderSide(color: AppColors.secondary),
            ),
          ),
          if (match.status == ChampionshipMatchStatus.disputed) ...[
            const SizedBox(height: AppSpacing.md),
            _DisputedStateSection(match: match, l10n: l10n),
          ],
          // Proposer: show waiting banner while opponent hasn't confirmed yet.
          if (_isWaitingForConfirmation(match, state)) ...[
            const SizedBox(height: AppSpacing.md),
            _ScheduleWaitingSection(match: match, l10n: l10n),
          ],
          // Opponent: show accept / reject UI when a schedule is pending.
          if (_isAwaitingMyConfirmation(match, state)) ...[
            const SizedBox(height: AppSpacing.md),
            _ScheduleConfirmationSection(state: state, l10n: l10n),
          ],
          if (_canProposeSchedule(match, state)) ...[
            const SizedBox(height: AppSpacing.md),
            _ProposeScheduleSection(
              state: state,
              l10n: l10n,
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          MatchChatSection(
            championshipId: state.championshipId,
            matchId: match.id,
            currentUserId: currentUserId,
            currentUserDisplayName: currentUserDisplayName,
            isTeamMember: state.isTeamMember,
            currentTeamId: state.myTeamId,
          ),
          const SizedBox(height: AppSpacing.lg),
          _ResultSection(
            state: state,
            l10n: l10n,
          ),
        ],
      ),
    );
  }

  /// True when the current user proposed the current schedule and is waiting
  /// for the opposing team to accept or reject it.
  bool _isWaitingForConfirmation(
      ChampionshipMatchModel match, MatchDetailLoaded state) {
    return state.isTeamMember &&
        match.scheduledByTeamId != null &&
        match.scheduledByTeamId == state.myTeamId;
  }

  /// True when the opposing team proposed a schedule and the current user
  /// (opposing team member) can accept or reject it.
  bool _isAwaitingMyConfirmation(
      ChampionshipMatchModel match, MatchDetailLoaded state) {
    return state.isTeamMember &&
        match.scheduledByTeamId != null &&
        match.scheduledByTeamId != state.myTeamId;
  }

  /// True when the current user may propose (or re-propose) a schedule.
  /// The proposer is hidden from the form while awaiting confirmation.
  bool _canProposeSchedule(
      ChampionshipMatchModel match, MatchDetailLoaded state) {
    final isProposer = match.scheduledByTeamId != null &&
        match.scheduledByTeamId == state.myTeamId;
    return state.isTeamMember &&
        (match.status == ChampionshipMatchStatus.pending ||
            match.status == ChampionshipMatchStatus.scheduled) &&
        !isProposer;
  }
}

// ============================================================================
// Match header card
// ============================================================================

class _MatchHeaderCard extends StatelessWidget {
  final ChampionshipMatchModel match;
  final ChampionshipTeamModel teamA;
  final ChampionshipTeamModel teamB;
  final AppLocalizations l10n;

  const _MatchHeaderCard({
    required this.match,
    required this.teamA,
    required this.teamB,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    final color = _statusColor();

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Teams row
            Row(
              children: [
                Expanded(
                  child: Text(
                    teamA.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: result?.winner == 'teamA'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    l10n.championshipMatchVs,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ),
                Expanded(
                  child: Text(
                    teamB.name,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: result?.winner == 'teamB'
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            // Set scores if result exists
            if (result != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                result.sets
                    .map((s) => '${s.teamAPoints}–${s.teamBPoints}')
                    .join('  '),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            // Status badge
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: color.withValues(alpha: 0.4)),
              ),
              child: Text(
                _statusLabel(l10n),
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: color,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            // Scheduled date
            if (match.scheduledAt != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.event, size: 14, color: AppColors.textMuted),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    l10n.matchDetailScheduledAt(
                      DateFormat('d MMM yyyy · HH:mm')
                          .format(match.scheduledAt!),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ),
              if (match.location != null) ...[
                const SizedBox(height: AppSpacing.xs),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on_outlined,
                        size: 14, color: AppColors.textMuted),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      match.location!,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ],
            ],
            // Deadline
            const SizedBox(height: AppSpacing.sm),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.schedule, size: 14,
                    color: AppColors.textMuted),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  l10n.championshipDeadlineLabel(
                    DateFormat('d MMM yyyy').format(match.deadline),
                  ),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _statusLabel(AppLocalizations l10n) {
    return switch (match.status) {
      ChampionshipMatchStatus.pending => l10n.championshipMatchStatusPending,
      ChampionshipMatchStatus.scheduled =>
        l10n.championshipMatchStatusScheduled,
      ChampionshipMatchStatus.played => l10n.championshipMatchStatusPlayed,
      ChampionshipMatchStatus.disputed =>
        l10n.championshipMatchStatusDisputed,
      ChampionshipMatchStatus.adminDecided =>
        l10n.championshipMatchStatusAdminDecided,
      ChampionshipMatchStatus.verified =>
        l10n.championshipMatchStatusVerified,
    };
  }

  Color _statusColor() {
    return switch (match.status) {
      ChampionshipMatchStatus.pending => AppColors.textMuted,
      ChampionshipMatchStatus.scheduled => AppColors.info,
      ChampionshipMatchStatus.played => AppColors.warning,
      ChampionshipMatchStatus.disputed => Colors.deepOrange,
      ChampionshipMatchStatus.adminDecided => Colors.purple,
      ChampionshipMatchStatus.verified => AppColors.success,
    };
  }
}

// ============================================================================
// Propose schedule section
// ============================================================================

class _ProposeScheduleSection extends StatefulWidget {
  final MatchDetailLoaded state;
  final AppLocalizations l10n;

  const _ProposeScheduleSection({required this.state, required this.l10n});

  @override
  State<_ProposeScheduleSection> createState() =>
      _ProposeScheduleSectionState();
}

class _ProposeScheduleSectionState extends State<_ProposeScheduleSection> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) setState(() => _selectedTime = picked);
  }

  void _confirm(BuildContext context) {
    final date = _selectedDate;
    final time = _selectedTime;
    if (date == null || time == null) return;

    final scheduledAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    final location = _locationController.text.trim();

    context.read<MatchDetailBloc>().add(ProposeSchedule(
          scheduledAt: scheduledAt,
          location: location.isEmpty ? null : location,
        ));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;
    final state = widget.state;
    final isProposing = state.isProposingSchedule;

    final dateStr = _selectedDate != null
        ? DateFormat('d MMM yyyy').format(_selectedDate!)
        : '—';
    final timeStr = _selectedTime != null
        ? _selectedTime!.format(context)
        : '—';
    final canConfirm = _selectedDate != null && _selectedTime != null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.matchDetailProposeSchedule,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        isProposing ? null : () => _pickDate(context),
                    icon: const Icon(Icons.calendar_today, size: 16),
                    label: Text(
                        '${l10n.matchDetailProposeDateLabel}: $dateStr'),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed:
                        isProposing ? null : () => _pickTime(context),
                    icon: const Icon(Icons.access_time, size: 16),
                    label: Text(
                        '${l10n.matchDetailProposeTimeLabel}: $timeStr'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            TextField(
              controller: _locationController,
              enabled: !isProposing,
              decoration: InputDecoration(
                labelText: l10n.matchDetailProposeLocationLabel,
                border: const OutlineInputBorder(),
                isDense: true,
              ),
            ),
            if (state.scheduleError != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                state.scheduleError!,
                style:
                    const TextStyle(color: AppColors.danger, fontSize: 13),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed:
                    (isProposing || !canConfirm)
                        ? null
                        : () => _confirm(context),
                child: isProposing
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(l10n.matchDetailProposeConfirm),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// Result section — role-aware
// ============================================================================

class _ResultSection extends StatelessWidget {
  final MatchDetailLoaded state;
  final AppLocalizations l10n;

  const _ResultSection({required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final match = state.match;
    final teamA = state.teamA;
    final teamB = state.teamB;

    switch (match.status) {
      case ChampionshipMatchStatus.pending:
      case ChampionshipMatchStatus.scheduled:
        if (!state.isTeamMember) return const SizedBox.shrink();
        return MatchResultEntryWidget(
          championshipId: state.championshipId,
          matchId: match.id,
          teamAName: teamA.name,
          teamBName: teamB.name,
        );

      case ChampionshipMatchStatus.played:
        final submittedByTeamId = match.submittedByTeamId;
        final myTeamId = state.myTeamId;

        if (!state.isTeamMember) return const SizedBox.shrink();

        // The opposing team (not the submitter) verifies.
        if (submittedByTeamId != null && myTeamId != submittedByTeamId) {
          final submittingTeamName = submittedByTeamId == match.teamAId
              ? teamA.name
              : teamB.name;
          return MatchVerificationWidget(
            championshipId: state.championshipId,
            matchId: match.id,
            submittingTeamName: submittingTeamName,
          );
        }

        // The submitter sees an awaiting message.
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.hourglass_top,
                    color: AppColors.warning, size: 40),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.submitResultAwaitingVerification,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );

      case ChampionshipMatchStatus.verified:
        return _ResultSummaryCard(
          match: match,
          teamA: teamA,
          teamB: teamB,
          icon: Icons.check_circle,
          iconColor: AppColors.success,
          message: l10n.verifyResultVerified,
        );

      case ChampionshipMatchStatus.disputed:
        return _ResultSummaryCard(
          match: match,
          teamA: teamA,
          teamB: teamB,
          icon: Icons.gavel,
          iconColor: AppColors.warning,
          message: l10n.verifyResultDisputed,
        );

      case ChampionshipMatchStatus.adminDecided:
        return _ResultSummaryCard(
          match: match,
          teamA: teamA,
          teamB: teamB,
          icon: Icons.gavel,
          iconColor: Colors.purple,
          message: l10n.championshipMatchStatusAdminDecided,
        );
    }
  }
}

class _ResultSummaryCard extends StatelessWidget {
  final ChampionshipMatchModel match;
  final ChampionshipTeamModel teamA;
  final ChampionshipTeamModel teamB;
  final IconData icon;
  final Color iconColor;
  final String message;

  const _ResultSummaryCard({
    required this.match,
    required this.teamA,
    required this.teamB,
    required this.icon,
    required this.iconColor,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 40),
            const SizedBox(height: AppSpacing.md),
            if (result != null) ...[
              Text(
                result.sets
                    .map((s) => '${s.teamAPoints}–${s.teamBPoints}')
                    .join('  '),
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                result.winner == 'teamA' ? teamA.name : teamB.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
              ),
              const SizedBox(height: AppSpacing.md),
            ],
            Text(
              message,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}


// ============================================================================
// Schedule waiting section — shown to the proposer (Story 30.20)
// ============================================================================

class _ScheduleWaitingSection extends StatelessWidget {
  final ChampionshipMatchModel match;
  final AppLocalizations l10n;

  const _ScheduleWaitingSection({required this.match, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final scheduledAt = match.scheduledAt;
    final dateTimeStr = scheduledAt != null
        ? DateFormat('d MMM yyyy · HH:mm').format(scheduledAt)
        : '';

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
        border:
            Border.all(color: AppColors.secondary.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          const SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.secondary,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.matchScheduleWaitingTitle,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                if (dateTimeStr.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    l10n.matchScheduleWaitingBody(dateTimeStr),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// Schedule confirmation section — shown to the opposing team (Story 30.20)
// ============================================================================

class _ScheduleConfirmationSection extends StatelessWidget {
  final MatchDetailLoaded state;
  final AppLocalizations l10n;

  const _ScheduleConfirmationSection(
      {required this.state, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final match = state.match;
    final scheduledAt = match.scheduledAt;
    final proposingTeamId = match.scheduledByTeamId;

    final proposingTeamName = proposingTeamId == match.teamAId
        ? state.teamA.name
        : state.teamB.name;

    final dateTimeStr = scheduledAt != null
        ? DateFormat('d MMM yyyy · HH:mm').format(scheduledAt)
        : '';

    final locationStr = match.location;

    final isAccepting = state.isAcceptingSchedule;
    final isRejecting = state.isRejectingSchedule;
    final isBusy = isAccepting || isRejecting;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.event_available,
                    size: 18, color: AppColors.secondary),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  l10n.matchScheduleConfirmTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.matchScheduleConfirmBody(proposingTeamName, dateTimeStr),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            if (locationStr != null && locationStr.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Row(
                children: [
                  const Icon(Icons.location_on_outlined,
                      size: 14, color: AppColors.textMuted),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    locationStr,
                    style:
                        Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.textMuted,
                            ),
                  ),
                ],
              ),
            ],
            if (state.scheduleConfirmError != null) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                state.scheduleConfirmError!,
                style: const TextStyle(color: AppColors.danger, fontSize: 13),
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: isBusy
                        ? null
                        : () => context
                            .read<MatchDetailBloc>()
                            .add(const RejectSchedule()),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.danger,
                      side: const BorderSide(color: AppColors.danger),
                    ),
                    child: isRejecting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.danger,
                            ),
                          )
                        : Text(l10n.matchScheduleRejectButton),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton(
                    onPressed: isBusy
                        ? null
                        : () => context
                            .read<MatchDetailBloc>()
                            .add(const AcceptSchedule()),
                    child: isAccepting
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.matchScheduleAcceptButton),
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

// ============================================================================
// Disputed state section (Story 30.23)
// ============================================================================

class _DisputedStateSection extends StatelessWidget {
  final ChampionshipMatchModel match;
  final AppLocalizations l10n;

  const _DisputedStateSection({required this.match, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final result = match.result;
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.warning.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.warning_amber_outlined,
                  color: AppColors.warning, size: 18),
              const SizedBox(width: 6),
              Text(
                l10n.matchDisputedTitle,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: AppColors.warning,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            l10n.matchDisputedExplanation,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: AppColors.warning),
          ),
          if (result != null) ...[
            const SizedBox(height: 10),
            Text(
              result.sets
                  .map((s) => '${s.teamAPoints} – ${s.teamBPoints}')
                  .join('   '),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.warning,
                    fontWeight: FontWeight.w600,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}
