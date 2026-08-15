// Championship detail screen: header info, standings table, per-round matches,
// and an admin panel tab (visible to championship admins only).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/utils/date_picker_helper.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/section_tab_bar.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_standings_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_event.dart' hide LoadChampionships;
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_state.dart';
import 'package:play_with_me/app/play_with_me_app.dart';
import 'package:play_with_me/core/presentation/widgets/global_bottom_nav_bar.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/pages/match_detail_page.dart';
import 'package:play_with_me/features/championships/presentation/widgets/create_team_bottom_sheet.dart';
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
          bottomNavigationBar: GlobalBottomNavBar(
            selectedIndex: 4,
            onTabSelected: (index) {
              HomePage.onNavigateToTab?.call(index);
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
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
      final authState = context.read<AuthenticationBloc>().state;
      final currentUserId = authState is AuthenticationAuthenticated
          ? authState.user.uid
          : null;
      final isAdmin = currentUserId != null &&
          state.championship.adminIds.contains(currentUserId);
      final alreadyRegistered = currentUserId != null &&
          state.teams.any((t) => t.memberIds.contains(currentUserId));
      final genderAllowed = _genderAllowed(
        state.championship.genderCategory,
        state.currentUserGender,
      );
      final canRegister = currentUserId != null &&
          !alreadyRegistered &&
          genderAllowed &&
          state.championship.status == ChampionshipStatus.registration &&
          state.championship.isOpen;

      // Tab count: Standings + Matches + My Matches (if registered) + Admin (if admin)
      final myTeamId = currentUserId != null
          ? state.teams
              .where((t) => t.memberIds.contains(currentUserId))
              .map((t) => t.id)
              .firstOrNull
          : null;
      final tabCount =
          2 + (alreadyRegistered ? 1 : 0) + (isAdmin ? 1 : 0);

      return DefaultTabController(
        length: tabCount,
        child: Column(
          children: [
            _ChampionshipHeader(
              championship: state.championship,
              onRegister: canRegister
                  ? () => _openRegistration(context, state.championship.id,
                      currentUserId, l10n)
                  : null,
              genderBlockReason: !genderAllowed &&
                      state.championship.status ==
                          ChampionshipStatus.registration &&
                      !alreadyRegistered
                  ? _genderBlockMessage(
                      state.championship.genderCategory,
                      state.currentUserGender,
                      l10n,
                    )
                  : null,
              myTeam: alreadyRegistered
                  ? state.teams.where((t) =>
                      t.memberIds.contains(currentUserId)).firstOrNull
                  : null,
              onLeaveTeam: alreadyRegistered &&
                  state.championship.status == ChampionshipStatus.registration
                  ? () {
                      final myT = state.teams
                          .where((t) => t.memberIds.contains(currentUserId))
                          .firstOrNull;
                      if (myT != null) {
                        _confirmLeaveTeam(context, state.championship.id, myT.id, l10n);
                      }
                    }
                  : null,
              championTeamName: state.standings.isNotEmpty
                  ? state.standings
                      .reduce((a, b) => a.position < b.position ? a : b)
                      .teamName
                  : null,
              currentUserId: currentUserId,
              l10n: l10n,
            ),
            SectionTabBar(
              tabs: [
                AppTabItem(
                  icon: _isRegistrationPhase(state.championship.status)
                      ? Icons.group
                      : Icons.leaderboard,
                  label: _isRegistrationPhase(state.championship.status)
                      ? l10n.championshipDetailTeamsTab
                      : l10n.championshipDetailStandingsTab,
                ),
                AppTabItem(icon: Icons.sports_volleyball, label: l10n.championshipDetailMatchesTab),
                if (alreadyRegistered)
                  AppTabItem(icon: Icons.person, label: l10n.championshipMyMatchesTab),
                if (isAdmin) AppTabItem(icon: Icons.admin_panel_settings, label: l10n.adminPanelTabLabel),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  _StandingsTab(
                    championship: state.championship,
                    standings: state.standings,
                    teams: state.teams,
                    l10n: l10n,
                  ),
                  _MatchesTab(
                    championship: state.championship,
                    matches: state.currentRoundMatches,
                    standings: state.standings,
                    selectedRound: state.selectedRound,
                    myTeamId: myTeamId,
                    l10n: l10n,
                  ),
                  if (alreadyRegistered)
                    _MyMatchesTab(
                      championshipId: state.championship.id,
                      allMatches: state.allMatches,
                      teams: state.teams,
                      myTeamId: myTeamId ?? '',
                      currentUserId: currentUserId,
                      currentUserDisplayName:
                          (context.read<AuthenticationBloc>().state
                                  as AuthenticationAuthenticated)
                              .user
                              .displayName ?? '',
                      l10n: l10n,
                    ),
                  if (isAdmin)
                    _AdminTab(
                      championship: state.championship,
                      standings: state.standings,
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

  bool _isRegistrationPhase(ChampionshipStatus status) =>
      status == ChampionshipStatus.registration ||
      status == ChampionshipStatus.registrationClosed;

  /// Returns true if the user's gender is eligible for the championship.
  /// If no genderCategory is set on the championship, everyone is allowed.
  static bool _genderAllowed(
    ChampionshipGenderCategory? category,
    String? userGender,
  ) {
    if (category == null) return true;
    if (userGender == null || userGender == 'none') return false;
    return userGender == category.name;
  }

  /// Returns a localised reason message why registration is blocked by gender,
  /// or null if there is no gender restriction.
  static String? _genderBlockMessage(
    ChampionshipGenderCategory? category,
    String? userGender,
    AppLocalizations l10n,
  ) {
    if (category == null) return null;
    if (userGender == null || userGender == 'none') {
      return l10n.championshipGenderBlockNoGender;
    }
    return category == ChampionshipGenderCategory.male
        ? l10n.championshipGenderBlockMaleOnly
        : l10n.championshipGenderBlockFemaleOnly;
  }

  void _openRegistration(
    BuildContext context,
    String championshipId,
    String userId,
    AppLocalizations l10n,
  ) {
    final teamRegistrationBloc = sl<TeamRegistrationBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (sheetContext) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: teamRegistrationBloc),
          BlocProvider(create: (_) => sl<PartnerPickerBloc>()),
        ],
        child: BlocListener<TeamRegistrationBloc, TeamRegistrationState>(
          listener: (listenerCtx, state) {
            if (state is TeamCreated) {
              Navigator.of(sheetContext).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.teamRegisteredSuccess)),
              );
              context
                  .read<ChampionshipListBloc>()
                  .add(const LoadChampionships());
            } else if (state is TeamRegistrationError) {
              ScaffoldMessenger.of(sheetContext).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          child: CreateTeamBottomSheet(
            championshipId: championshipId,
            userId: userId,
          ),
        ),
      ),
    );
  }

  void _confirmLeaveTeam(
    BuildContext context,
    String championshipId,
    String teamId,
    AppLocalizations l10n,
  ) {
    final leaveBloc = sl<TeamRegistrationBloc>();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => BlocProvider.value(
        value: leaveBloc,
        child: BlocListener<TeamRegistrationBloc, TeamRegistrationState>(
          listener: (_, state) {
            if (state is TeamLeft) {
              Navigator.of(dialogCtx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(l10n.leaveTeamSuccess)),
              );
            } else if (state is TeamRegistrationError) {
              Navigator.of(dialogCtx).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.danger,
                ),
              );
            }
          },
          child: BlocBuilder<TeamRegistrationBloc, TeamRegistrationState>(
            builder: (builderCtx, state) => AlertDialog(
              title: Text(l10n.leaveTeamConfirmTitle),
              content: Text(l10n.leaveTeamConfirmBody),
              actions: [
                TextButton(
                  onPressed: state is TeamRegistrationSubmitting
                      ? null
                      : () => Navigator.of(dialogCtx).pop(),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: state is TeamRegistrationSubmitting
                      ? null
                      : () => leaveBloc.add(
                            LeaveTeam(
                              championshipId: championshipId,
                              teamId: teamId,
                            ),
                          ),
                  style:
                      TextButton.styleFrom(foregroundColor: AppColors.danger),
                  child: state is TeamRegistrationSubmitting
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.leaveTeam),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ============================================================================
// Championship header
// ============================================================================

class _ChampionshipHeader extends StatelessWidget {
  final ChampionshipModel championship;
  final VoidCallback? onRegister;
  final String? genderBlockReason;
  final ChampionshipTeamModel? myTeam;
  final VoidCallback? onLeaveTeam;
  final String? championTeamName;
  final String? currentUserId;
  final AppLocalizations l10n;

  const _ChampionshipHeader({
    required this.championship,
    required this.l10n,
    this.onRegister,
    this.genderBlockReason,
    this.myTeam,
    this.onLeaveTeam,
    this.championTeamName,
    this.currentUserId,
  });

  void _showTiebreakerDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.standingsTiebreakerTitle),
        content: Text(l10n.standingsTiebreakerBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(l10n.ok),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    _StatusBadge(championship: championship, l10n: l10n),
                    if (championship.genderCategory != null)
                      _GenderBadge(category: championship.genderCategory!, l10n: l10n),
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
              ),
              GestureDetector(
                onTap: () => _showTiebreakerDialog(context),
                child: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.info_outline,
                      size: 20, color: AppColors.textMuted),
                ),
              ),
            ],
          ),
          if (championship.status == ChampionshipStatus.completed) ...[
            const SizedBox(height: 10),
            _ChampionBanner(championTeamName: championTeamName, l10n: l10n),
          ],
          if (onRegister != null) ...[
            const SizedBox(height: 10),
            FilledButton.icon(
              onPressed: onRegister,
              icon: const Icon(Icons.how_to_reg_outlined, size: 18),
              label: Text(l10n.registerTeam),
            ),
          ],
          if (genderBlockReason != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Row(
              children: [
                const Icon(Icons.info_outline, size: 14, color: AppColors.textMuted),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    genderBlockReason!,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
                ),
              ],
            ),
          ],
          if (myTeam != null) ...[
            const SizedBox(height: 10),
            _MyTeamSection(
              team: myTeam!,
              championship: championship,
              onLeave: onLeaveTeam,
              currentUserId: currentUserId,
              l10n: l10n,
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          ],
        ),
      ),
    );
  }
}



// ── Champion banner (completed championships) ─────────────────────────────────

class _ChampionBanner extends StatelessWidget {
  final String? championTeamName;
  final AppLocalizations l10n;

  const _ChampionBanner({required this.l10n, this.championTeamName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFFD4A017)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Text('🏆', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.championshipChampionLabel,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF5C3900),
                  ),
                ),
                Text(
                  championTeamName ?? '—',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF3D2400),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── My Team section ───────────────────────────────────────────────────────────

class _MyTeamSection extends StatelessWidget {
  final ChampionshipTeamModel team;
  final ChampionshipModel championship;
  final VoidCallback? onLeave;
  final String? currentUserId;
  final AppLocalizations l10n;

  const _MyTeamSection({
    required this.team,
    required this.championship,
    required this.l10n,
    this.onLeave,
    this.currentUserId,
  });

  bool get _isRegistrationPhase =>
      championship.status == ChampionshipStatus.registration ||
      championship.status == ChampionshipStatus.registrationClosed;

  bool get _isCaptain => currentUserId != null && team.captainId == currentUserId;

  Future<void> _showRenameDialog(BuildContext context) async {
    final controller = TextEditingController(text: team.name);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.teamRenameTitle),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 30,
          decoration: InputDecoration(
            labelText: l10n.teamRenameLabel,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(false),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.of(dialogCtx).pop(true),
            child: Text(l10n.save),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;
    final newName = controller.text.trim();
    if (newName.length < 2 || newName == team.name) return;

    try {
      await sl<ChampionshipRepository>().renameTeam(
        championshipId: championship.id,
        teamId: team.id,
        newName: newName,
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.teamRenameSuccess)),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${l10n.teamRenameError}: $e'),
            backgroundColor: AppColors.danger,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final partnerCount = team.memberIds.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.35)),
      ),
      child: Row(
        children: [
          const Icon(Icons.group, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.myTeamSectionTitle,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        team.name,
                        style:
                            Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                      ),
                    ),
                    if (_isCaptain && _isRegistrationPhase) ...[
                      const SizedBox(width: AppSpacing.xs),
                      InkWell(
                        onTap: () => _showRenameDialog(context),
                        borderRadius: BorderRadius.circular(12),
                        child: const Padding(
                          padding: EdgeInsets.all(2),
                          child: Icon(Icons.edit_outlined,
                              size: 14, color: AppColors.primary),
                        ),
                      ),
                    ],
                  ],
                ),
                if (partnerCount > 1)
                  Text(
                    l10n.myTeamPartnerLabel(
                      team.memberIds.length == 2
                          ? 'Partner'
                          : '${partnerCount - 1} partners',
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textMuted,
                        ),
                  ),
              ],
            ),
          ),
          if (onLeave != null)
            TextButton.icon(
              onPressed: onLeave,
              icon: const Icon(Icons.exit_to_app_outlined, size: 16),
              label: Text(l10n.leaveTeam),
              style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            ),
        ],
      ),
    );
  }
}

class _GenderBadge extends StatelessWidget {
  final ChampionshipGenderCategory category;
  final AppLocalizations l10n;

  const _GenderBadge({required this.category, required this.l10n});

  @override
  Widget build(BuildContext context) {
    final label = category == ChampionshipGenderCategory.male
        ? l10n.championshipGenderMale
        : l10n.championshipGenderFemale;
    const color = AppColors.info; // blue accent — neutral gender indicator
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.person_outline, size: 12, color: color),
          const SizedBox(width: 3),
          Text(
            label,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
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
        const SizedBox(width: AppSpacing.xs),
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

// ============================================================================
// Standings tab
// ============================================================================

class _StandingsTab extends StatelessWidget {
  final ChampionshipModel championship;
  final List<ChampionshipStandingsModel> standings;
  final List<ChampionshipTeamModel> teams;
  final AppLocalizations l10n;

  const _StandingsTab({
    required this.championship,
    required this.standings,
    required this.teams,
    required this.l10n,
  });

  bool get _isRegistrationPhase =>
      championship.status == ChampionshipStatus.registration ||
      championship.status == ChampionshipStatus.registrationClosed;

  @override
  Widget build(BuildContext context) {
    if (_isRegistrationPhase) {
      return _buildTeamsList(context);
    }
    return _buildStandingsTable(context);
  }

  Widget _buildTeamsList(BuildContext context) {
    if (teams.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Text(
            l10n.championshipDetailNoTeamsYet,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: teams.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, i) => _TeamCard(team: teams[i], position: i + 1),
    );
  }

  Widget _buildStandingsTable(BuildContext context) {
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
      padding: const EdgeInsets.all(12),
      child: Card(
        margin: EdgeInsets.zero,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

            Table(
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
          ],
          ),
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
    final isChampion = row.position == 1 &&
        championship.status == ChampionshipStatus.completed;
    final baseStyle = Theme.of(context).textTheme.bodySmall;
    final boldStyle = baseStyle?.copyWith(fontWeight: FontWeight.w600);
    final champStyle = baseStyle?.copyWith(
      fontWeight: FontWeight.w700,
      color: const Color(0xFFB8860B),
    );

    final sr = row.setRatio;
    final srText = sr > 0 ? '+$sr' : '$sr';

    // ── Story 30.24: expanded win/loss breakdown ─────────────────────────────
    final winsText = '${row.wins20 + row.wins21}';
    final winsDetail = row.wins20 > 0 || row.wins21 > 0
        ? ' (${row.wins20}+${row.wins21})'
        : '';
    final lossText = '${row.losses12 + row.losses02}';

    return TableRow(
      decoration: isChampion
          ? BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.18),
              border: const Border(
                left: BorderSide(color: AppColors.primary, width: 3),
              ),
            )
          : null,
      children: [
        _cell('${row.position}',
            isChampion ? champStyle : baseStyle?.copyWith(color: AppColors.textMuted)),
        _cell(row.teamName, isChampion ? champStyle : boldStyle,
            align: TextAlign.left),
        _cell('${row.played}', baseStyle),
        _cell('${row.points}',
            isChampion
                ? champStyle?.copyWith(color: const Color(0xFFB8860B))
                : boldStyle?.copyWith(color: AppColors.primary)),
        _cell('$winsText$winsDetail', isChampion ? champStyle : baseStyle),
        _cell(lossText, baseStyle),
        _cell(
          srText,
          baseStyle?.copyWith(color: sr >= 0 ? AppColors.success : AppColors.danger),
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

// ── Team card (registration phase) ───────────────────────────────────────────

class _TeamCard extends StatelessWidget {
  final ChampionshipTeamModel team;
  final int position;

  const _TeamCard({required this.team, required this.position});

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      margin: EdgeInsets.zero,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Text(
            '$position',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              team.name,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          const Icon(Icons.people_outline, size: 16, color: AppColors.textMuted),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '${team.memberIds.length}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
        ],
      ),
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
  final String? myTeamId;
  final AppLocalizations l10n;

  const _MatchesTab({
    required this.championship,
    required this.matches,
    required this.standings,
    required this.selectedRound,
    required this.l10n,
    this.myTeamId,
  });

  void _navigateToMatch(BuildContext context, ChampionshipMatchModel match) {
    final authState = context.read<AuthenticationBloc>().state;
    if (authState is! AuthenticationAuthenticated) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MatchDetailPage(
          championshipId: championship.id,
          matchId: match.id,
          currentUserId: authState.user.uid,
          currentUserDisplayName:
              authState.user.displayName ?? authState.user.email,
        ),
      ),
    );
  }

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
        Card(
          margin: const EdgeInsets.fromLTRB(16, 8, 16, 0),
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
        const SizedBox(height: AppSpacing.sm),
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
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (ctx, i) => _MatchCard(
                    match: matches[i],
                    teamAName: _teamName(matches[i].teamAId),
                    teamBName: _teamName(matches[i].teamBId),
                    isMyMatch: myTeamId != null &&
                        (matches[i].teamAId == myTeamId ||
                            matches[i].teamBId == myTeamId),
                    l10n: l10n,
                    onTap: () => _navigateToMatch(ctx, matches[i]),
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
  final bool isMyMatch;
  final AppLocalizations l10n;
  final VoidCallback? onTap;

  const _MatchCard({
    required this.match,
    required this.teamAName,
    required this.teamBName,
    required this.l10n,
    this.isMyMatch = false,
    this.onTap,
  });

  String _statusLabel() {
    return switch (match.status) {
      ChampionshipMatchStatus.pending => l10n.championshipMatchStatusPending,
      ChampionshipMatchStatus.scheduled => l10n.championshipMatchStatusScheduled,
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
      ChampionshipMatchStatus.scheduled => AppColors.secondary,
      ChampionshipMatchStatus.played => AppColors.info,
      ChampionshipMatchStatus.disputed => AppColors.warning,
      ChampionshipMatchStatus.adminDecided => Colors.purple,
      ChampionshipMatchStatus.verified => AppColors.success,
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isMyMatch
            ? const BorderSide(color: AppColors.primary, width: 2)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isMyMatch) ...[
              Text(
                l10n.championshipMyMatch,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w700,
                    ),
              ),
              const SizedBox(height: AppSpacing.xs),
            ],
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
                ] else if (match.scheduledAt != null) ...[
                  const Icon(Icons.schedule, size: 12, color: AppColors.secondary),
                  const SizedBox(width: 3),
                  Text(
                    DateFormat.yMMMd().add_Hm().format(match.scheduledAt!),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.secondary,
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
      ),
    );
  }
}

// ============================================================================
// Admin tab
// ============================================================================

class _AdminTab extends StatelessWidget {
  final ChampionshipModel championship;
  final List<ChampionshipStandingsModel> standings;
  final AppLocalizations l10n;

  const _AdminTab({
    required this.championship,
    required this.standings,
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
    return BlocProvider(
      create: (_) => sl<AdminPanelBloc>()
        ..add(LoadAdminPanel(championship.id)),
      child: BlocConsumer<AdminPanelBloc, AdminPanelState>(
        listener: (context, state) {
          if (state is AdminPanelLoaded && state.lastDecidedMatchId != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.adminPanelDecisionSuccess)),
            );
          }
          if (state is AdminPanelLoaded && state.matchesGenerated != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.startChampionshipSuccess(state.matchesGenerated!)),
              ),
            );
          }
          if (state is AdminPanelLoaded && state.startError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.startError!),
                backgroundColor: AppColors.danger,
              ),
            );
          }
          if (state is AdminPanelLoaded && state.isCompleted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.completeChampionshipSuccess)),
            );
          }
          if (state is AdminPanelLoaded && state.completeError != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.completeError!),
                backgroundColor: AppColors.danger,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AdminPanelLoading || state is AdminPanelInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is AdminPanelError) {
            return Center(child: Text(state.message));
          }

          if (state is AdminPanelLoaded) {
            return Column(
              children: [
                // ── Start / Complete actions ──────────────────────────────
                _AdminActions(
                  championship: championship,
                  state: state,
                  l10n: l10n,
                  onStart: () => _showStartDialog(context),
                  onComplete: () => _showCompleteDialog(context),
                  onEdit: () => _showEditDialog(context, state),
                ),
                // ── Matches needing attention ─────────────────────────────
                Expanded(
                  child: state.matches.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(32),
                            child: Text(
                              l10n.adminPanelNoMatchesNeedingAttention,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: AppColors.textMuted),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          itemCount: state.matches.length,
                          separatorBuilder: (_, __) =>
                              const SizedBox(height: AppSpacing.sm),
                          itemBuilder: (ctx, i) {
                            final match = state.matches[i];
                            return _AdminMatchCard(
                              match: match,
                              teamAName: _teamName(match.teamAId),
                              teamBName: _teamName(match.teamBId),
                              l10n: l10n,
                              onDecide: () =>
                                  _showDecisionSheet(ctx, match),
                            );
                          },
                        ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showStartDialog(BuildContext context) {
    final adminBloc = context.read<AdminPanelBloc>();
    DateTime selectedDate = DateTime.now();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text(l10n.startChampionshipConfirmTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.startChampionshipConfirmBody),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.startChampionshipStartDateLabel,
                style: Theme.of(ctx).textTheme.labelMedium,
              ),
              const SizedBox(height: 6),
              OutlinedButton.icon(
                onPressed: () async {
                  final picked = await showAppStyledDatePicker(
                    context: ctx,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setDialogState(() => selectedDate = picked);
                  }
                },
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: Text(DateFormat.yMMMd().format(selectedDate)),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                Navigator.of(dialogCtx).pop();
                adminBloc.add(StartChampionship(
                  championshipId: championship.id,
                  startDate: selectedDate,
                ));
              },
              child: Text(l10n.startChampionshipButton),
            ),
          ],
        ),
      ),
    );
  }

  void _showCompleteDialog(BuildContext context) {
    final adminBloc = context.read<AdminPanelBloc>();

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => AlertDialog(
        title: Text(l10n.completeChampionshipConfirmTitle),
        content: Text(l10n.completeChampionshipConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogCtx).pop(),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogCtx).pop();
              adminBloc.add(
                  CompleteChampionship(championshipId: championship.id));
            },
            child: Text(l10n.completeChampionshipButton),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, AdminPanelLoaded state) {
    final adminBloc = context.read<AdminPanelBloc>();
    final titleController =
        TextEditingController(text: championship.title);
    DateTime? newDeadline;

    showDialog<void>(
      context: context,
      builder: (dialogCtx) => StatefulBuilder(
        builder: (dialogCtx, setDialogState) => AlertDialog(
          title: Text(l10n.editChampionshipTitle),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  labelText: l10n.championshipCreateTitleLabel,
                ),
                maxLength: 100,
              ),
              const SizedBox(height: AppSpacing.sm),
              OutlinedButton.icon(
                icon: const Icon(Icons.calendar_today_outlined, size: 16),
                label: Text(
                  newDeadline != null
                      ? DateFormat('d MMM yyyy').format(newDeadline!)
                      : l10n.editChampionshipChangeDeadline,
                ),
                onPressed: () async {
                  final picked = await showAppStyledDatePicker(
                    context: dialogCtx,
                    initialDate: newDeadline ??
                        championship.registrationDeadline.add(
                          const Duration(days: 1),
                        ),
                    firstDate:
                        DateTime.now().add(const Duration(days: 1)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) {
                    setDialogState(() => newDeadline = picked);
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(dialogCtx).pop(),
              child: Text(l10n.cancel),
            ),
            FilledButton(
              onPressed: () {
                final newTitle = titleController.text.trim();
                if (newTitle.length < 3) return;
                Navigator.of(dialogCtx).pop();
                adminBloc.add(EditChampionship(
                  championshipId: championship.id,
                  title: newTitle != championship.title ? newTitle : null,
                  registrationDeadline: newDeadline,
                ));
              },
              child: Text(l10n.save),
            ),
          ],
        ),
      ),
    );
  }

  void _showDecisionSheet(BuildContext context, ChampionshipMatchModel match) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider.value(
        value: context.read<AdminPanelBloc>(),
        child: _DecisionSheet(
          match: match,
          teamAName: standings
              .where((s) => s.teamId == match.teamAId)
              .map((s) => s.teamName)
              .firstOrNull ?? match.teamAId,
          teamBName: standings
              .where((s) => s.teamId == match.teamBId)
              .map((s) => s.teamName)
              .firstOrNull ?? match.teamBId,
          l10n: l10n,
        ),
      ),
    );
  }
}


// ── Admin actions panel ───────────────────────────────────────────────────────

class _AdminActions extends StatelessWidget {
  final ChampionshipModel championship;
  final AdminPanelLoaded state;
  final AppLocalizations l10n;
  final VoidCallback onStart;
  final VoidCallback onComplete;
  final VoidCallback onEdit;

  const _AdminActions({
    required this.championship,
    required this.state,
    required this.l10n,
    required this.onStart,
    required this.onComplete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final canStart =
        championship.status == ChampionshipStatus.registrationClosed &&
            !state.isStarting;
    final canComplete = championship.status == ChampionshipStatus.active &&
        !state.isCompleting;
    final canEdit = championship.status == ChampionshipStatus.registration ||
        championship.status == ChampionshipStatus.registrationClosed;

    if (!canStart && !canComplete && !canEdit) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (canStart || state.isStarting)
            FilledButton.icon(
              onPressed: state.isStarting ? null : onStart,
              icon: state.isStarting
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow_outlined),
              label: Text(l10n.startChampionshipButton),
            ),
          if (canComplete || state.isCompleting) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: state.isCompleting ? null : onComplete,
              icon: state.isCompleting
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.check_circle_outline),
              label: Text(l10n.completeChampionshipButton),
            ),
          ],
          if (canEdit) ...[
            const SizedBox(height: AppSpacing.sm),
            OutlinedButton.icon(
              onPressed: state.isEditing ? null : onEdit,
              icon: state.isEditing
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.edit_outlined),
              label: Text(l10n.editChampionshipButton),
            ),
          ],
          if (state.editError != null) ...[
            const SizedBox(height: 6),
            Text(
              state.editError!,
              style: const TextStyle(color: AppColors.danger, fontSize: 13),
            ),
          ],
          const SizedBox(height: AppSpacing.sm),
          const Divider(height: 1),
        ],
      ),
    );
  }
}

// ── Admin match card ──────────────────────────────────────────────────────────

class _AdminMatchCard extends StatelessWidget {
  final ChampionshipMatchModel match;
  final String teamAName;
  final String teamBName;
  final AppLocalizations l10n;
  final VoidCallback onDecide;

  const _AdminMatchCard({
    required this.match,
    required this.teamAName,
    required this.teamBName,
    required this.l10n,
    required this.onDecide,
  });

  @override
  Widget build(BuildContext context) {
    final isDisputed = match.status == ChampionshipMatchStatus.disputed;
    final badgeLabel =
        isDisputed ? l10n.adminPanelMatchDisputed : l10n.adminPanelMatchOverdue;
    final badgeColor = isDisputed ? AppColors.warning : AppColors.danger;

    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onDecide,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$teamAName  vs  $teamBName',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      'Round ${match.round}',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: AppColors.textMuted,
                          ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: badgeColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: badgeColor.withValues(alpha: 0.4)),
                ),
                child: Text(
                  badgeLabel,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: badgeColor,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.chevron_right, color: AppColors.textMuted),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Decision bottom sheet ─────────────────────────────────────────────────────

class _DecisionSheet extends StatefulWidget {
  final ChampionshipMatchModel match;
  final String teamAName;
  final String teamBName;
  final AppLocalizations l10n;

  const _DecisionSheet({
    required this.match,
    required this.teamAName,
    required this.teamBName,
    required this.l10n,
  });

  @override
  State<_DecisionSheet> createState() => _DecisionSheetState();
}

class _DecisionSheetState extends State<_DecisionSheet> {
  String _decision = 'cancel';
  String? _winnerId;
  final _notesController = TextEditingController();
  String? _validationError;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _submit() {
    final notes = _notesController.text.trim();
    if (notes.isEmpty) {
      setState(
          () => _validationError = widget.l10n.adminPanelDecisionErrorNotesRequired);
      return;
    }
    if (_decision == 'award_walkover' && _winnerId == null) {
      setState(
          () => _validationError = widget.l10n.adminPanelDecisionErrorWinnerRequired);
      return;
    }
    setState(() => _validationError = null);

    context.read<AdminPanelBloc>().add(
          DecideMatch(
            matchId: widget.match.id,
            decision: _decision,
            winnerId: _winnerId,
            notes: notes,
          ),
        );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = widget.l10n;

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adminPanelDecisionTitle,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${widget.teamAName}  vs  ${widget.teamBName}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.textMuted,
                ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Decision radio buttons
          RadioListTile<String>(
            title: Text(l10n.adminPanelDecisionSetResult),
            value: 'set_result',
            groupValue: _decision,
            onChanged: (v) => setState(() => _decision = v!),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<String>(
            title: Text(l10n.adminPanelDecisionAwardWalkover),
            value: 'award_walkover',
            groupValue: _decision,
            onChanged: (v) => setState(() => _decision = v!),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
          RadioListTile<String>(
            title: Text(l10n.adminPanelDecisionCancel),
            value: 'cancel',
            groupValue: _decision,
            onChanged: (v) => setState(() => _decision = v!),
            dense: true,
            contentPadding: EdgeInsets.zero,
          ),
          if (_decision == 'award_walkover') ...[
            const SizedBox(height: AppSpacing.sm),
            Text(l10n.adminPanelDecisionWinnerLabel,
                style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(widget.teamAName,
                        style: Theme.of(context).textTheme.bodySmall),
                    value: widget.match.teamAId,
                    groupValue: _winnerId,
                    onChanged: (v) => setState(() => _winnerId = v),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
                Expanded(
                  child: RadioListTile<String>(
                    title: Text(widget.teamBName,
                        style: Theme.of(context).textTheme.bodySmall),
                    value: widget.match.teamBId,
                    groupValue: _winnerId,
                    onChanged: (v) => setState(() => _winnerId = v),
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _notesController,
            decoration: InputDecoration(
              labelText: l10n.adminPanelDecisionNotesLabel,
              hintText: l10n.adminPanelDecisionNotesHint,
              border: const OutlineInputBorder(),
            ),
            minLines: 2,
            maxLines: 4,
          ),
          if (_validationError != null) ...[
            const SizedBox(height: 6),
            Text(
              _validationError!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          BlocBuilder<AdminPanelBloc, AdminPanelState>(
            builder: (context, state) {
              final isDeciding =
                  state is AdminPanelLoaded && state.isDeciding;
              final serverError =
                  state is AdminPanelLoaded ? state.decisionError : null;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (serverError != null) ...[
                    Text(
                      serverError,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.error,
                          ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                  FilledButton(
                    onPressed: isDeciding ? null : _submit,
                    child: isDeciding
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(l10n.adminPanelDecisionConfirm),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// My Matches tab (Story 30.26) — shows only the current user's team's matches
// ============================================================================

class _MyMatchesTab extends StatelessWidget {
  final String championshipId;
  final List<ChampionshipMatchModel> allMatches;
  final List<ChampionshipTeamModel> teams;
  final String myTeamId;
  final String currentUserId;
  final String currentUserDisplayName;
  final AppLocalizations l10n;

  const _MyMatchesTab({
    required this.championshipId,
    required this.allMatches,
    required this.teams,
    required this.myTeamId,
    required this.currentUserId,
    required this.currentUserDisplayName,
    required this.l10n,
  });

  String _teamName(String teamId) {
    try {
      return teams.firstWhere((t) => t.id == teamId).name;
    } catch (_) {
      return teamId;
    }
  }

  Color _statusColor(ChampionshipMatchStatus status) {
    return switch (status) {
      ChampionshipMatchStatus.pending => AppColors.textMuted,
      ChampionshipMatchStatus.scheduled => AppColors.info,
      ChampionshipMatchStatus.played => AppColors.warning,
      ChampionshipMatchStatus.disputed => Colors.deepOrange,
      ChampionshipMatchStatus.adminDecided => Colors.purple,
      ChampionshipMatchStatus.verified => AppColors.success,
    };
  }

  String _statusLabel(ChampionshipMatchStatus status) {
    return switch (status) {
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

  @override
  Widget build(BuildContext context) {
    final myMatches = allMatches
        .where((m) => m.teamAId == myTeamId || m.teamBId == myTeamId)
        .toList()
      ..sort((a, b) => a.round.compareTo(b.round));

    if (myMatches.isEmpty) {
      return Center(
        child: Text(
          l10n.championshipMyMatchesEmpty,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.textMuted),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      itemCount: myMatches.length,
      itemBuilder: (context, index) {
        final match = myMatches[index];
        final opponentId =
            match.teamAId == myTeamId ? match.teamBId : match.teamAId;
        final opponentName = _teamName(opponentId);
        final statusColor = _statusColor(match.status);
        final statusLabel = _statusLabel(match.status);

        return Card(
          margin: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MatchDetailPage(
                  championshipId: championshipId,
                  matchId: match.id,
                  currentUserId: currentUserId,
                  currentUserDisplayName: currentUserDisplayName,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  // Round badge
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        'R${match.round}',
                        style:
                            Theme.of(context).textTheme.labelMedium?.copyWith(
                                  color: AppColors.secondary,
                                  fontWeight: FontWeight.w700,
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  // Opponent + scheduled date
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.championshipMyMatchesVs(opponentName),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(fontWeight: FontWeight.w600),
                        ),
                        if (match.scheduledAt != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            DateFormat('d MMM · HH:mm')
                                .format(match.scheduledAt!),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                        if (match.result != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            match.result!.sets
                                .map((s) =>
                                    '${s.teamAPoints}–${s.teamBPoints}')
                                .join('  '),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(color: AppColors.textMuted),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // Status badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.10),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                          color: statusColor.withValues(alpha: 0.4)),
                    ),
                    child: Text(
                      statusLabel,
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  const Icon(Icons.chevron_right,
                      size: 18, color: AppColors.textMuted),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
