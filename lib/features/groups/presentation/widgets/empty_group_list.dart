// Widget displayed when user has no groups, encouraging them to create their first group
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/empty_state.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class EmptyGroupList extends StatelessWidget {
  const EmptyGroupList({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return EmptyState(
      icon: Icons.groups_outlined,
      title: l10n.noGroupsYet,
      message: '${l10n.noGroupsMessage}\n${l10n.useCreateGroupButton}',
    );
  }
}
