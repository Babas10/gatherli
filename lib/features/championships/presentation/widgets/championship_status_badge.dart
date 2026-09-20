// Single source of truth for ChampionshipStatus -> label/color rendering,
// shared by championship_detail_page.dart and championship_list_page.dart
// (previously two independent, private `_StatusBadge` copies).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Renders a championship's status pill. Needs the full [championship] (not
/// just its status) because the "active" label interpolates the current and
/// total round numbers.
class ChampionshipStatusBadge extends StatelessWidget {
  final ChampionshipModel championship;
  final AppLocalizations l10n;

  const ChampionshipStatusBadge({
    super.key,
    required this.championship,
    required this.l10n,
  });

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
