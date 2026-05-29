// Widget for the opposing team to verify or dispute a submitted championship match result.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../bloc/match_verification/match_verification_bloc.dart';
import '../bloc/match_verification/match_verification_event.dart';
import '../bloc/match_verification/match_verification_state.dart';

class MatchVerificationWidget extends StatelessWidget {
  final String championshipId;
  final String matchId;

  /// Name of the team that submitted the result (shown in the header).
  final String submittingTeamName;

  final ChampionshipRepository? championshipRepository;

  const MatchVerificationWidget({
    super.key,
    required this.championshipId,
    required this.matchId,
    required this.submittingTeamName,
    this.championshipRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchVerificationBloc(
        championshipRepository:
            championshipRepository ?? sl<ChampionshipRepository>(),
      ),
      child: _MatchVerificationView(
        championshipId: championshipId,
        matchId: matchId,
        submittingTeamName: submittingTeamName,
      ),
    );
  }
}

class _MatchVerificationView extends StatefulWidget {
  final String championshipId;
  final String matchId;
  final String submittingTeamName;

  const _MatchVerificationView({
    required this.championshipId,
    required this.matchId,
    required this.submittingTeamName,
  });

  @override
  State<_MatchVerificationView> createState() => _MatchVerificationViewState();
}

class _MatchVerificationViewState extends State<_MatchVerificationView> {
  bool _showDisputeForm = false;
  final _reasonController = TextEditingController();
  String? _reasonError;

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _onVerify(BuildContext context) {
    context.read<MatchVerificationBloc>().add(
          VerifyMatchResult(
            championshipId: widget.championshipId,
            matchId: widget.matchId,
          ),
        );
  }

  void _onDispute(BuildContext context, AppLocalizations l10n) {
    final reason = _reasonController.text.trim();
    if (reason.isEmpty) {
      setState(() => _reasonError = l10n.verifyResultDisputeReasonRequired);
      return;
    }
    setState(() => _reasonError = null);
    context.read<MatchVerificationBloc>().add(
          DisputeMatchResult(
            championshipId: widget.championshipId,
            matchId: widget.matchId,
            reason: reason,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocConsumer<MatchVerificationBloc, MatchVerificationState>(
      listener: (context, state) {
        if (state is MatchVerificationError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        if (state is MatchVerificationVerified) {
          return _StatusCard(
            icon: Icons.check_circle,
            iconColor: Colors.green,
            message: l10n.verifyResultVerified,
          );
        }

        if (state is MatchVerificationDisputed) {
          return _StatusCard(
            icon: Icons.gavel,
            iconColor: Colors.orange,
            message: l10n.verifyResultDisputed,
          );
        }

        final isLoading = state is MatchVerificationLoading;

        return Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  l10n.verifyResultTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondary,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.verifyResultSubmittedBy(widget.submittingTeamName),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textMuted,
                      ),
                ),
                const SizedBox(height: 16),
                if (!_showDisputeForm) ...[
                  Row(
                    children: [
                      Expanded(
                        child: FilledButton.icon(
                          onPressed: isLoading ? null : () => _onVerify(context),
                          icon: const Icon(Icons.check, size: 18),
                          label: Text(l10n.verifyResultConfirmButton),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isLoading
                              ? null
                              : () => setState(() => _showDisputeForm = true),
                          icon: const Icon(Icons.flag_outlined, size: 18),
                          label: Text(l10n.verifyResultDisputeButton),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.orange,
                            side: const BorderSide(color: Colors.orange),
                          ),
                        ),
                      ),
                    ],
                  ),
                ] else ...[
                  Text(
                    l10n.verifyResultDisputeReasonLabel,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: _reasonController,
                    enabled: !isLoading,
                    minLines: 3,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: l10n.verifyResultDisputeReasonHint,
                      errorText: _reasonError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      TextButton(
                        onPressed: isLoading
                            ? null
                            : () => setState(() {
                                  _showDisputeForm = false;
                                  _reasonError = null;
                                }),
                        child: Text(l10n.cancel),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: FilledButton(
                          onPressed: isLoading
                              ? null
                              : () => _onDispute(context, l10n),
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  height: 18,
                                  width: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(l10n.verifyResultDisputeButton),
                        ),
                      ),
                    ],
                  ),
                ],
                if (isLoading && !_showDisputeForm)
                  const Padding(
                    padding: EdgeInsets.only(top: 12),
                    child: Center(child: CircularProgressIndicator()),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _StatusCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String message;

  const _StatusCard({
    required this.icon,
    required this.iconColor,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: iconColor, size: 48),
            const SizedBox(height: 12),
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
