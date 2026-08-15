// Widget for displaying a single group member with their role
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/data/models/user_model.dart';

class MemberListItem extends StatelessWidget {
  final UserModel user;
  final bool isAdmin;

  const MemberListItem({super.key, required this.user, this.isAdmin = false});

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: EdgeInsets.zero,
      child: ListTile(
      leading: UserAvatar(name: user.displayName ?? user.email, photoUrl: user.photoUrl),      title: Text(
        user.displayName ?? user.email,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: null,
      trailing: isAdmin
          ? Chip(
              label: const Text('Admin', style: TextStyle(fontSize: 12)),
              backgroundColor: AppColors.primary.withValues(alpha: 0.25),
              labelStyle: const TextStyle(
                color: AppColors.secondary,
                fontWeight: FontWeight.bold,
              ),
              padding: EdgeInsets.zero,
            )
          : null,
    ),
    );
  }

}
