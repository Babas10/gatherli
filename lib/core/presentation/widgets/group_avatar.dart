// Group avatar circle — same gold/teal palette as UserAvatar.
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/utils/avatar_cache_sizing.dart';

class GroupAvatar extends StatelessWidget {
  final String name;
  final String? photoUrl;
  final double radius;

  const GroupAvatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.radius = 28,
  });

  String _initials() {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.isEmpty || name.isEmpty) return '?';
    if (parts.length >= 2) return (parts[0][0] + parts[1][0]).toUpperCase();
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;
    final cacheDimension = avatarCacheDimension(context, radius * 2);
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.avatarBackground,
      backgroundImage: hasPhoto
          ? CachedNetworkImageProvider(
              photoUrl!,
              maxWidth: cacheDimension,
              maxHeight: cacheDimension,
            )
          : null,
      child: hasPhoto
          ? null
          : Text(
              _initials(),
              style: TextStyle(
                fontSize: radius * 0.68,
                fontWeight: FontWeight.bold,
                color: AppColors.avatarForeground,
              ),
            ),
    );
  }
}
