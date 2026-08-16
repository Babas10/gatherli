// Shared "Joined" badge widget — teal, consistent with AppColors.secondary.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class JoinedBadge extends StatelessWidget {
  const JoinedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: AppLocalizations.of(context)!.joined,
      color: AppColors.secondary,
    );
  }
}
