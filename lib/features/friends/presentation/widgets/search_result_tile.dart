import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Widget for displaying a search result with action button
class SearchResultTile extends StatelessWidget {
  final UserEntity? user;
  final bool isFriend;
  final bool hasPendingRequest;
  final String? requestDirection;
  final String searchedEmail;
  final VoidCallback? onSendRequest;
  final VoidCallback? onAcceptRequest;
  final bool isInvited;

  final bool isSelfSearch;

  const SearchResultTile({
    super.key,
    required this.user,
    required this.isFriend,
    required this.hasPendingRequest,
    this.requestDirection,
    required this.searchedEmail,
    this.isSelfSearch = false,
    this.isInvited = false,
    this.onSendRequest,
    this.onAcceptRequest,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    // Handle case where user searches for their own email
    if (user == null && isSelfSearch) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.info_outline,
                size: 48,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.cannotAddYourself,
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Handle case where no user was found
    if (user == null) {
      return Card(
        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Icon(
                Icons.person_search,
                size: 48,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.userNotFoundWithEmail(searchedEmail),
                style: theme.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.makeSureEmailCorrect,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // User was found - show the tile with appropriate action
    // At this point, user cannot be null
    final foundUser = user!;
    final photoUrl = foundUser.photoUrl;
    final displayName = foundUser.displayName;

    return ListTile(
      leading: UserAvatar(name: displayName ?? foundUser.email, photoUrl: photoUrl),
      title: Text(
        displayName ?? foundUser.email,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: displayName != null ? Text(foundUser.email) : null,
      trailing: _buildActionButton(context, l10n),
    );
  }

  Widget _buildActionButton(BuildContext context, AppLocalizations l10n) {
    // Request just sent — show green tick
    if (isInvited) {
      return const Icon(Icons.check_circle, color: AppColors.success, size: 28);
    }

    // Already friends
    if (isFriend) {
      return Chip(
        label: Text(l10n.friends, style: const TextStyle(fontSize: 12)),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        padding: EdgeInsets.zero,
      );
    }

    // Pending request sent
    if (hasPendingRequest && requestDirection == 'sent') {
      return Chip(
        label: Text(l10n.requestPending, style: const TextStyle(fontSize: 12)),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        padding: EdgeInsets.zero,
      );
    }

    // Pending request received - can accept
    if (hasPendingRequest && requestDirection == 'received') {
      return FilledButton(
        onPressed: onAcceptRequest,
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        child: Text(l10n.acceptRequest),
      );
    }

    // No connection - can send request
    return FilledButton(
      onPressed: onSendRequest,
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.avatarBackground,
        foregroundColor: AppColors.secondary,
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: Text(l10n.sendFriendRequest),
    );
  }

}
