// Single source of truth for TrainingStatus → color/label, shared by every
// widget that renders a training-session status badge.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/data/models/training_session_model.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

extension TrainingStatusStyle on TrainingStatus {
  Color get color {
    return switch (this) {
      TrainingStatus.scheduled => AppColors.info,
      TrainingStatus.completed => AppColors.textMuted,
      TrainingStatus.cancelled => AppColors.danger,
    };
  }

  String label(AppLocalizations l10n) {
    return switch (this) {
      TrainingStatus.scheduled => l10n.scheduled,
      TrainingStatus.completed => l10n.completed,
      TrainingStatus.cancelled => l10n.cancelled,
    };
  }
}
