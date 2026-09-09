import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/empty_state.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'friend_tile.dart';

/// Widget for displaying a list of friends
class FriendsList extends StatelessWidget {
  final List<UserEntity> friends;
  final Function(String friendshipId) onRemoveFriend;
  final Function(UserEntity friend)? onFriendTap;

  const FriendsList({
    super.key,
    required this.friends,
    required this.onRemoveFriend,
    this.onFriendTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (friends.isEmpty) {
      return EmptyState(
        icon: Icons.people_outline,
        title: l10n.noFriendsYet,
        message: l10n.searchForFriends,
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        return FriendTile(
          friend: friend,
          onRemove: () => _showRemoveConfirmation(context, friend),
          onTap: onFriendTap != null ? () => onFriendTap!(friend) : null,
        );
      },
    );
  }

  void _showRemoveConfirmation(BuildContext context, UserEntity friend) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.removeFriend),
        content: Text(
          l10n.removeFriendConfirmation(friend.displayName ?? friend.email),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(l10n.cancel),
          ),
          OutlinedButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Note: We need the friendshipId, but we only have the UserEntity
              // This will need to be passed differently or stored in the entity
              // For now, we'll use the uid as a placeholder
              onRemoveFriend(friend.uid);
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
            ),
            child: Text(l10n.remove),
          ),
        ],
      ),
    );
  }
}
