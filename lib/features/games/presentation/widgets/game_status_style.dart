// Single source of truth for GameStatus → color/label, shared by every
// widget that renders a game-status badge or dot indicator.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

extension GameStatusStyle on GameStatus {
  Color get color {
    return switch (this) {
      GameStatus.scheduled => AppColors.info,
      GameStatus.inProgress => AppColors.success,
      GameStatus.verification => AppColors.warning,
      GameStatus.completed => AppColors.textMuted,
      GameStatus.cancelled => AppColors.danger,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      GameStatus.scheduled => l10n.scheduled,
      GameStatus.inProgress => l10n.gameLiveStatus,
      GameStatus.verification => l10n.verification,
      GameStatus.completed => l10n.completed,
      GameStatus.cancelled => l10n.cancelled,
    };
  }
}
