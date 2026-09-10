// Single source of truth for ChampionshipMatchStatus → color/label, shared by
// every widget that renders a match-status pill or icon.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

extension ChampionshipMatchStatusStyle on ChampionshipMatchStatus {
  Color get color {
    return switch (this) {
      ChampionshipMatchStatus.pending => AppColors.textMuted,
      ChampionshipMatchStatus.scheduled => AppColors.info,
      ChampionshipMatchStatus.played => AppColors.warning,
      ChampionshipMatchStatus.disputed => AppColors.danger,
      ChampionshipMatchStatus.adminDecided => AppColors.adminAction,
      ChampionshipMatchStatus.verified => AppColors.success,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      ChampionshipMatchStatus.pending => l10n.championshipMatchStatusPending,
      ChampionshipMatchStatus.scheduled =>
        l10n.championshipMatchStatusScheduled,
      ChampionshipMatchStatus.played => l10n.championshipMatchStatusPlayed,
      ChampionshipMatchStatus.disputed =>
        l10n.championshipMatchStatusDisputed,
      ChampionshipMatchStatus.adminDecided =>
        l10n.championshipMatchStatusAdminDecided,
      ChampionshipMatchStatus.verified => l10n.championshipMatchStatusVerified,
    };
  }
}
