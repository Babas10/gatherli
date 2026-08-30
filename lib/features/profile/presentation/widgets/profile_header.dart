import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/utils/avatar_cache_sizing.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/profile/presentation/widgets/verification_badge.dart';

/// Header section of the profile page containing avatar, name, and email
class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(32),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        children: [
          // Avatar
          CircleAvatar(
            radius: 56,
            backgroundColor: AppColors.secondary,
            backgroundImage: user.photoUrl != null
                ? CachedNetworkImageProvider(
                    user.photoUrl!,
                    maxWidth: avatarCacheDimension(context, 112),
                    maxHeight: avatarCacheDimension(context, 112),
                  )
                : null,
            child: user.photoUrl == null
                ? const Icon(
                    Icons.person,
                    size: 56,
                    color: Colors.white,
                  )
                : null,
          ),
          const SizedBox(height: AppSpacing.lg),

          // Display name
          Text(
            user.displayNameOrEmail,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),

          // Email and verification badge
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  user.email,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.textMuted,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              VerificationBadge(isVerified: user.isEmailVerified),
            ],
          ),
        ],
      ),
    );
  }
}
