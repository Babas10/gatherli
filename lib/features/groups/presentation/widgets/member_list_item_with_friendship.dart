// Widget for displaying group member with friendship status and add friend button
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/groups/presentation/widgets/member_action_menu.dart';

/// Displays a group member with their friendship status and action buttons
class MemberListItemWithFriendship extends StatelessWidget {
  final UserModel user;
  final bool isAdmin;
  final bool isCreator;
  final bool isCurrentUser;
  final String currentUserId;
  final bool isFriend;
  final FriendRequestStatus requestStatus;
  final VoidCallback? onRefresh;
  final Function(String targetUserId)? onSendFriendRequest;
  final bool isCurrentUserAdmin;
  final bool canDemote;
  final Function(MemberAction action)? onMemberAction;

  const MemberListItemWithFriendship({
    super.key,
    required this.user,
    required this.isAdmin,
    required this.isCreator,
    required this.isCurrentUser,
    required this.currentUserId,
    required this.isFriend,
    required this.requestStatus,
    this.onRefresh,
    this.onSendFriendRequest,
    this.isCurrentUserAdmin = false,
    this.canDemote = true,
    this.onMemberAction,
  });

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          UserAvatar(name: user.fullDisplayName, photoUrl: user.photoUrl),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Row(
        children: [
          Flexible(
            child: Text(
              user.fullDisplayName,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                color: AppColors.secondary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (isCurrentUser) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              '(You)',
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
          if (isAdmin) ...[
            const SizedBox(width: AppSpacing.sm),
            const Chip(
              label: Text('Admin', style: TextStyle(fontSize: 12)),
              backgroundColor: AppColors.avatarBackground,
              labelStyle: TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.zero,
            ),
          ],
          if (isCreator) ...[
            const SizedBox(width: AppSpacing.sm),
            const Icon(Icons.star, size: 16, color: AppColors.warning),
          ],
          ],
            ),
          ),
          if (!isCurrentUser)
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildFriendshipStatus(context),
                ],
              ),
            ),
          if (!isCurrentUser && _buildTrailingWidget(context) != null)
            _buildTrailingWidget(context)!,
        ],
      ),
    );
  }

  Widget _buildFriendshipStatus(BuildContext context) {
    if (isFriend) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check_circle, size: 16, color: AppColors.success),
          SizedBox(width: AppSpacing.xs),
          Text(
            'Friend',
            style: TextStyle(color: AppColors.success, fontSize: 12),
          ),
        ],
      );
    }

    if (requestStatus == FriendRequestStatus.sentByMe) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.schedule, size: 16, color: AppColors.warning),
          SizedBox(width: AppSpacing.xs),
          Text(
            'Request Sent',
            style: TextStyle(color: AppColors.warning, fontSize: 12),
          ),
        ],
      );
    }

    if (requestStatus == FriendRequestStatus.receivedFromThem) {
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.person_add, size: 16, color: AppColors.info),
          SizedBox(width: AppSpacing.xs),
          Text(
            'Wants to be friends',
            style: TextStyle(color: AppColors.info, fontSize: 12),
          ),
        ],
      );
    }

    return Text(
      'Not in Community',
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSurfaceVariant,
        fontSize: 12,
      ),
    );
  }

  Widget? _buildTrailingWidget(BuildContext context) {
    // Admin action menu takes priority when viewer is an admin.
    // For non-community members, show both the add-friend button and the
    // admin menu so admins can take either action.
    if (isCurrentUserAdmin && onMemberAction != null) {
      if (!isFriend &&
          requestStatus == FriendRequestStatus.none &&
          onSendFriendRequest != null) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.person_add_outlined),
              onPressed: () => _sendFriendRequest(context),
              tooltip: 'Add to Community',
              color: Theme.of(context).colorScheme.primary,
              iconSize: 20,
            ),
            MemberActionMenu(
              isCurrentUserAdmin: isCurrentUserAdmin,
              isTargetUserAdmin: isAdmin,
              isTargetUserCreator: isCreator,
              canDemote: canDemote,
              onActionSelected: onMemberAction!,
            ),
          ],
        );
      }
      return MemberActionMenu(
        isCurrentUserAdmin: isCurrentUserAdmin,
        isTargetUserAdmin: isAdmin,
        isTargetUserCreator: isCreator,
        canDemote: canDemote,
        onActionSelected: onMemberAction!,
      );
    }

    if (isFriend) {
      return null; // Already friends, no action needed
    }

    if (requestStatus == FriendRequestStatus.sentByMe) {
      return const Chip(
        label: Text('Pending'),
        backgroundColor: AppColors.warning,
        labelStyle: TextStyle(color: AppColors.warning, fontSize: 11),
      );
    }

    if (requestStatus == FriendRequestStatus.receivedFromThem) {
      return const SizedBox.shrink();
    }

    // Not in community - show add button
    return IconButton(
      icon: const Icon(Icons.person_add_outlined),
      onPressed: () => _sendFriendRequest(context),
      tooltip: 'Add to Community',
      color: Theme.of(context).colorScheme.primary,
      iconSize: 24,
    );
  }

  void _sendFriendRequest(BuildContext context) {
    if (onSendFriendRequest != null) {
      onSendFriendRequest!(user.uid);
    }
  }
}
