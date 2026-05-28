// Displays open championships with team registration/leave actions.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/features/championships/data/models/championship_team_model.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/team_registration/team_registration_state.dart';
import 'package:play_with_me/features/championships/presentation/widgets/create_team_bottom_sheet.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';

class ChampionshipRegistrationPage extends StatefulWidget {
  final String userId;

  const ChampionshipRegistrationPage({super.key, required this.userId});

  @override
  State<ChampionshipRegistrationPage> createState() =>
      _ChampionshipRegistrationPageState();
}

class _ChampionshipRegistrationPageState
    extends State<ChampionshipRegistrationPage> {
  /// Tracks each championship's team for the current user (loaded on demand).
  final Map<String, ChampionshipTeamModel?> _myTeams = {};

  @override
  void initState() {
    super.initState();
    context
        .read<TeamRegistrationBloc>()
        .add(LoadChampionships(widget.userId));
  }

  void _openCreateTeamSheet(
      BuildContext context, String championshipId) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => MultiBlocProvider(
        providers: [
          BlocProvider.value(
              value: context.read<TeamRegistrationBloc>()),
          BlocProvider(
            create: (_) => GetIt.instance<PartnerPickerBloc>(),
          ),
        ],
        child: CreateTeamBottomSheet(
          championshipId: championshipId,
          userId: widget.userId,
        ),
      ),
    );
  }

  Future<void> _confirmLeave(
      BuildContext context, String championshipId, String teamId) async {
    final l10n = AppLocalizations.of(context)!;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(l10n.leaveTeamConfirmTitle),
        content: Text(l10n.leaveTeamConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.leaveTeam),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      context.read<TeamRegistrationBloc>().add(
            LeaveTeam(championshipId: championshipId, teamId: teamId),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.championshipsTitle)),
      body: BlocConsumer<TeamRegistrationBloc, TeamRegistrationState>(
        listener: (context, state) {
          if (state is TeamCreated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.teamRegisteredSuccess)),
            );
            Navigator.of(context).pop(); // close bottom sheet
            // Reload
            context
                .read<TeamRegistrationBloc>()
                .add(LoadChampionships(widget.userId));
          } else if (state is TeamLeft) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(l10n.teamLeftSuccess)),
            );
            context
                .read<TeamRegistrationBloc>()
                .add(LoadChampionships(widget.userId));
          } else if (state is TeamRegistrationError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is TeamRegistrationLoading ||
              state is TeamRegistrationSubmitting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is TeamRegistrationLoaded) {
            if (state.championships.isEmpty) {
              return Center(
                child: Text(l10n.championshipOpenRegistration),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.championships.length,
              itemBuilder: (context, index) {
                final champ = state.championships[index];
                final myTeam = _myTeams[champ.id];
                return _ChampionshipCard(
                  championship: champ,
                  myTeam: myTeam,
                  userId: widget.userId,
                  onRegister: () => _openCreateTeamSheet(context, champ.id),
                  onLeave: (teamId) =>
                      _confirmLeave(context, champ.id, teamId),
                );
              },
            );
          }

          if (state is TeamRegistrationError) {
            return Center(child: Text(state.message));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

class _ChampionshipCard extends StatelessWidget {
  final ChampionshipModel championship;
  final ChampionshipTeamModel? myTeam;
  final String userId;
  final VoidCallback onRegister;
  final ValueChanged<String> onLeave;

  const _ChampionshipCard({
    required this.championship,
    required this.myTeam,
    required this.userId,
    required this.onRegister,
    required this.onLeave,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final deadlineFormatted =
        DateFormat.yMMMd().format(championship.registrationDeadline);

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              championship.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(l10n.championshipTeamsCount(championship.teamsCount)),
            Text(l10n.championshipSlotsLeft(championship.availableSlots)),
            Text(l10n.championshipDeadlineLabel(deadlineFormatted)),
            const SizedBox(height: 12),
            if (myTeam != null) ...[
              Text(
                l10n.yourTeam,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              Text(myTeam!.name),
              const SizedBox(height: 8),
              OutlinedButton(
                onPressed: () => onLeave(myTeam!.id),
                child: Text(l10n.leaveTeam),
              ),
            ] else if (championship.isOpen) ...[
              FilledButton(
                onPressed: onRegister,
                child: Text(l10n.registerTeam),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
