// Widget for displaying a received friend request
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/domain/entities/friendship_entity.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class ReceivedRequestTile extends StatelessWidget {
  final FriendshipEntity request;
  final VoidCallback onAccept;
  final VoidCallback onDecline;

  const ReceivedRequestTile({
    super.key,
    required this.request,
    required this.onAccept,
    required this.onDecline,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AccentCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(name: request.initiatorName),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  request.initiatorName,
                  style: AppTextStyles.cardTitle,
                ),
                Text(
                  'Sent ${_formatDate(request.createdAt)}',
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Accept — teal outlined (consistent with app button style)
          OutlinedButton(
            onPressed: onAccept,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.success,
              side: const BorderSide(color: AppColors.success),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text(l10n.accept),
          ),
          const SizedBox(width: 6),
          // Decline — danger outlined
          OutlinedButton(
            onPressed: onDecline,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.danger,
              side: const BorderSide(color: AppColors.danger),
              padding: const EdgeInsets.symmetric(horizontal: 12),
            ),
            child: Text(l10n.decline),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) return "${date.day}/${date.month}/${date.year}";
    if (difference.inDays > 0) return "${difference.inDays}d ago";
    if (difference.inHours > 0) return "${difference.inHours}h ago";
    if (difference.inMinutes > 0) return "${difference.inMinutes}m ago";
    return "Just now";
  }
}
