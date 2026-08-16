// Reusable badge indicating a mixed-gender game.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

// Mix-game uses a distinct purple colour — added to AppColors as a one-off.
const _kMixColor = Color(0xFF9B59B6);

class MixGameBadge extends StatelessWidget {
  const MixGameBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return StatusBadge(
      label: AppLocalizations.of(context)!.mixGameBadge,
      color: _kMixColor,
    );
  }
}
