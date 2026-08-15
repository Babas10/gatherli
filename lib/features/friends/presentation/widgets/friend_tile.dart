import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';

/// Widget for displaying a friend in the friends list
class FriendTile extends StatelessWidget {
  final UserEntity friend;
  final VoidCallback onRemove;
  final VoidCallback? onTap;

  const FriendTile({
    super.key,
    required this.friend,
    required this.onRemove,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          UserAvatar(name: friend.displayNameOrEmail, photoUrl: friend.photoUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  friend.displayName ?? friend.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                if (friend.displayName != null)
                  Text(
                    friend.email,
                    style: const TextStyle(
                      fontSize: 13,
                      color: AppColors.textMuted,
                    ),
                  ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline, color: AppColors.textMuted),
            tooltip: 'Remove friend',
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }

}
