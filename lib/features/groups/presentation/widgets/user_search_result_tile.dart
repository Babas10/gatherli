// Widget for displaying a user search result with invite action
import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/data/models/user_model.dart';

class UserSearchResultTile extends StatelessWidget {
  final UserModel user;
  final bool isAlreadyMember;
  final bool isAlreadyInvited;
  final VoidCallback onInvite;

  const UserSearchResultTile({
    super.key,
    required this.user,
    required this.isAlreadyMember,
    required this.isAlreadyInvited,
    required this.onInvite,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: UserAvatar(name: user.displayName ?? user.email, photoUrl: user.photoUrl),
      title: Text(
        user.displayName ?? user.email,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: user.displayName != null ? Text(user.email) : null,
      trailing: _buildTrailing(context),
    );
  }

  Widget _buildTrailing(BuildContext context) {
    if (isAlreadyMember) {
      return Chip(
        label: const Text('Member', style: TextStyle(fontSize: 12)),
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        padding: EdgeInsets.zero,
      );
    }

    if (isAlreadyInvited) {
      return Chip(
        label: const Text('Invited', style: TextStyle(fontSize: 12)),
        backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondaryContainer,
        ),
        padding: EdgeInsets.zero,
      );
    }

    return FilledButton(
      onPressed: onInvite,
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: const Text('Invite'),
    );
  }
}
