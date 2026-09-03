import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
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

    return AccentCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(name: request.recipientName),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(request.recipientName, style: AppTextStyles.cardTitle),
                Text(
                  'Sent ${_formatDate(request.createdAt)}',
                  style: AppTextStyles.cardSubtitle,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          StatusBadge.muted(l10n.pending),
          const SizedBox(width: AppSpacing.sm),
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.cancel),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);
    if (difference.inDays > 7) return '${date.day}/${date.month}/${date.year}';
    if (difference.inDays > 0) return '${difference.inDays}d ago';
    if (difference.inHours > 0) return '${difference.inHours}h ago';
    if (difference.inMinutes > 0) return '${difference.inMinutes}m ago';
    return 'Just now';
  }

}