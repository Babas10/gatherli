// Widget for entering and submitting a championship match result.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../bloc/result_submission/result_submission_bloc.dart';
import '../bloc/result_submission/result_submission_event.dart';
import '../bloc/result_submission/result_submission_state.dart';

class MatchResultEntryWidget extends StatelessWidget {
  final String championshipId;
  final String matchId;
  final String teamAName;
  final String teamBName;
  final ChampionshipRepository? championshipRepository;

  const MatchResultEntryWidget({
    super.key,
    required this.championshipId,
    required this.matchId,
    required this.teamAName,
    required this.teamBName,
    this.championshipRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResultSubmissionBloc(
        championshipRepository:
            championshipRepository ?? sl<ChampionshipRepository>(),
      ),
      child: _MatchResultEntryView(
        championshipId: championshipId,
        matchId: matchId,
        teamAName: teamAName,
        teamBName: teamBName,
      ),
    );
  }
}

class _MatchResultEntryView extends StatefulWidget {
  final String championshipId;
  final String matchId;
  final String teamAName;
  final String teamBName;

  const _MatchResultEntryView({
    required this.championshipId,
    required this.matchId,
    required this.teamAName,
    required this.teamBName,
  });

  @override
  State<_MatchResultEntryView> createState() => _MatchResultEntryViewState();
}

class _MatchResultEntryViewState extends State<_MatchResultEntryView> {
  // Controllers for set 1, set 2 (always present), and optional set 3
  final _set1TeamA = TextEditingController();
  final _set1TeamB = TextEditingController();
  final _set2TeamA = TextEditingController();
  final _set2TeamB = TextEditingController();
  final _set3TeamA = TextEditingController();
  final _set3TeamB = TextEditingController();

  bool _hasSet3 = false;
  String? _validationError;

  @override
  void dispose() {
    _set1TeamA.dispose();
    _set1TeamB.dispose();
    _set2TeamA.dispose();
    _set2TeamB.dispose();
    _set3TeamA.dispose();
    _set3TeamB.dispose();
    super.dispose();
  }

  int? _parse(TextEditingController c) => int.tryParse(c.text.trim());

  /// Builds and validates the sets from the form inputs.
  /// Returns the list on success, or sets [_validationError] and returns null.
  List<MatchSetScore>? _buildSets(AppLocalizations l10n) {
    final s1a = _parse(_set1TeamA);
    final s1b = _parse(_set1TeamB);
    final s2a = _parse(_set2TeamA);
    final s2b = _parse(_set2TeamB);

    if (s1a == null || s1b == null || s2a == null || s2b == null) {
      return null;
    }

    final sets = [
      MatchSetScore(teamAPoints: s1a, teamBPoints: s1b, setNumber: 1),
      MatchSetScore(teamAPoints: s2a, teamBPoints: s2b, setNumber: 2),
    ];

    if (_hasSet3) {
      final s3a = _parse(_set3TeamA);
      final s3b = _parse(_set3TeamB);
      if (s3a == null || s3b == null) return null;
      sets.add(MatchSetScore(teamAPoints: s3a, teamBPoints: s3b, setNumber: 3));
    }

    // Local validation using the existing MatchSetScore.isValid logic
    for (final set in sets) {
      final isDecider = set.setNumber == 3;
      if (!set.isValid(isDeciderSet: isDecider)) {
        setState(() => _validationError =
            '${l10n.submitResultInvalidSetScore} (${l10n.submitResultSet(set.setNumber)})');
        return null;
      }
    }

    // Validate a winner exists with 2 sets
    final teamAWins = sets.where((s) => s.teamAPoints > s.teamBPoints).length;
    final teamBWins = sets.where((s) => s.teamBPoints > s.teamAPoints).length;
    if (teamAWins != 2 && teamBWins != 2) {
      setState(() => _validationError = l10n.submitResultNoWinner);
      return null;
    }

    setState(() => _validationError = null);
    return sets;
  }

  void _submit(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final sets = _buildSets(l10n);
    if (sets == null) return;

    context.read<ResultSubmissionBloc>().add(
      SubmitMatchResult(
        championshipId: widget.championshipId,
        matchId: widget.matchId,
        sets: sets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<ResultSubmissionBloc, ResultSubmissionState>(
      listener: (context, state) {
        if (state is ResultSubmissionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is ResultSubmissionSuccess) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.check_circle, color: Colors.green, size: 48),
                const SizedBox(height: 12),
                Text(
                  l10n.submitResultAwaitingVerification,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        }

        final isSubmitting = state is ResultSubmissionSubmitting;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.submitResultTitle,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondary,
                ),
              ),
              const SizedBox(height: 16),
              // Column headers
              _TeamHeader(
                teamAName: widget.teamAName,
                teamBName: widget.teamBName,
              ),
              const SizedBox(height: 8),
              // Set 1
              _SetRow(
                label: l10n.submitResultSet(1),
                controllerA: _set1TeamA,
                controllerB: _set1TeamB,
                enabled: !isSubmitting,
              ),
              const SizedBox(height: 8),
              // Set 2
              _SetRow(
                label: l10n.submitResultSet(2),
                controllerA: _set2TeamA,
                controllerB: _set2TeamB,
                enabled: !isSubmitting,
              ),
              // Set 3 toggle
              const SizedBox(height: 8),
              if (_hasSet3) ...[
                _SetRow(
                  label: l10n.submitResultSet(3),
                  controllerA: _set3TeamA,
                  controllerB: _set3TeamB,
                  enabled: !isSubmitting,
                ),
                const SizedBox(height: 4),
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () => setState(() {
                            _hasSet3 = false;
                            _set3TeamA.clear();
                            _set3TeamB.clear();
                          }),
                  child: Text(l10n.submitResultRemoveSet3),
                ),
              ] else
                TextButton(
                  onPressed: isSubmitting
                      ? null
                      : () => setState(() => _hasSet3 = true),
                  child: Text(l10n.submitResultAddSet3),
                ),
              // Validation error
              if (_validationError != null) ...[
                const SizedBox(height: 8),
                Text(
                  _validationError!,
                  style: const TextStyle(color: Colors.red, fontSize: 13),
                ),
              ],
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: isSubmitting ? null : () => _submit(context),
                  child: isSubmitting
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(l10n.submitResultSubmitButton),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TeamHeader extends StatelessWidget {
  final String teamAName;
  final String teamBName;

  const _TeamHeader({required this.teamAName, required this.teamBName});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 64),
        Expanded(
          child: Text(
            teamAName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            teamBName,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

class _SetRow extends StatelessWidget {
  final String label;
  final TextEditingController controllerA;
  final TextEditingController controllerB;
  final bool enabled;

  const _SetRow({
    required this.label,
    required this.controllerA,
    required this.controllerB,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 56,
          child: Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _PointsInput(controller: controllerA, enabled: enabled),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('–', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: _PointsInput(controller: controllerB, enabled: enabled),
        ),
      ],
    );
  }
}

class _PointsInput extends StatelessWidget {
  final TextEditingController controller;
  final bool enabled;

  const _PointsInput({required this.controller, required this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      enabled: enabled,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      textAlign: TextAlign.center,
      decoration: InputDecoration(
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 10,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.divider),
        ),
      ),
    );
  }
}
