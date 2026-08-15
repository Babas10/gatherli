import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/domain/entities/friendship_entity.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Widget for displaying a sent friend request
class SentRequestTile extends StatelessWidget {
  final FriendshipEntity request;
  final VoidCallback onCancel;

  const SentRequestTile({
    super.key,
    required this.request,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return ListTile(
      leading: UserAvatar(name: request.recipientName),
      title: Text(
        request.recipientName,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        'Sent ${_formatDate(request.createdAt)}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Chip(
            label: Text(l10n.pending, style: const TextStyle(fontSize: 12)),
            backgroundColor: Theme.of(context).colorScheme.secondaryContainer,
            labelStyle: TextStyle(
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            padding: EdgeInsets.zero,
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: onCancel, child: Text(l10n.cancel)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) return '\${date.day}/\${date.month}/\${date.year}';
    if (difference.inDays > 0) return '\${difference.inDays}d ago';
    if (difference.inHours > 0) return '\${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '\${difference.inMinutes}m ago';
    return 'Just now';
  }

}