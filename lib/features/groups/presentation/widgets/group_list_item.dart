// Widget displaying a single group in the list with name, member count, and photo
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/presentation/widgets/group_avatar.dart';
import 'package:play_with_me/core/data/models/group_model.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class GroupListItem extends StatelessWidget {
  final GroupModel group;
  final VoidCallback onTap;

  const GroupListItem({super.key, required this.group, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AccentCard(
      onTap: onTap,
      child: Row(
            children: [
              // Group photo or default icon
              _buildGroupPhoto(),
              const SizedBox(width: AppSpacing.lg),

              // Group info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      group.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (group.description != null) ...[
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        group.description!,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        Icon(
                          Icons.people,
                          size: 16,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: AppSpacing.xs),
                        Text(
                          l10n.memberCount(group.memberCount),
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                        ),
                        const SizedBox(width: AppSpacing.lg),
                        if (group.privacy != GroupPrivacy.private) ...[
                          Icon(
                            group.privacy == GroupPrivacy.public
                                ? Icons.public
                                : Icons.lock_outline,
                            size: 16,
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          const SizedBox(width: AppSpacing.xs),
                          Text(
                            _getPrivacyLabel(context, group.privacy),
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.secondary,
                                ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron icon
              Icon(
                Icons.chevron_right,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
      ),
    );
  }

  Widget _buildGroupPhoto() {
    return GroupAvatar(name: group.name, photoUrl: group.photoUrl, radius: 28);
  }




  String _getPrivacyLabel(BuildContext context, GroupPrivacy privacy) {
    final l10n = AppLocalizations.of(context)!;
    switch (privacy) {
      case GroupPrivacy.public:
        return l10n.publicGroup;
      case GroupPrivacy.private:
        return l10n.privateGroup;
      case GroupPrivacy.inviteOnly:
        return l10n.inviteOnlyGroup;
    }
  }
}
