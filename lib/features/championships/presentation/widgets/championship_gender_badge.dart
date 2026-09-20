// Single source of truth for ChampionshipGenderCategory -> label/color
// rendering, shared by championship_detail_page.dart and
// championship_list_page.dart (previously two independent, private
// `_GenderBadge` copies that also disagreed on rendering: one drew a bespoke
// Container+icon, the other used StatusBadge directly).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class ChampionshipGenderBadge extends StatelessWidget {
  final ChampionshipGenderCategory category;
  final AppLocalizations l10n;

  const ChampionshipGenderBadge({
    super.key,
    required this.category,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final label = category == ChampionshipGenderCategory.male
        ? l10n.championshipGenderMale
        : l10n.championshipGenderFemale;
    return StatusBadge(label: label, color: AppColors.info);
  }
}
