// Shared user avatar — gold background, teal initials, optional photo.
// Use this everywhere a circular user avatar is needed so the style is
// defined once and consistent across the whole app.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';

class UserAvatar extends StatelessWidget {
  /// Display name or email — used to generate the initials fallback.
  final String name;

  /// Optional photo URL. If null or empty, initials are shown instead.
  final String? photoUrl;

  /// Radius of the circle. Defaults to 22 (standard list tile size).
  final double radius;

  const UserAvatar({
    super.key,
    required this.name,
    this.photoUrl,
    this.radius = 22,
  });

  String _initials() {
    final trimmed = name.trim();
    if (trimmed.isEmpty) return '?';
    final parts = trimmed.split(RegExp(r'\s+'));
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return trimmed[0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final hasPhoto = photoUrl != null && photoUrl!.isNotEmpty;
    return CircleAvatar(
      radius: radius,
      backgroundColor: AppColors.avatarBackground,
      backgroundImage: hasPhoto ? NetworkImage(photoUrl!) : null,
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
