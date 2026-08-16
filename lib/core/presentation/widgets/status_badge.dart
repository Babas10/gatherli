// Shared status badge pill — coloured border + tinted background + label text.
// Use this everywhere instead of inline Container + BoxDecoration badges.
// To change badge shape/size: edit this file.
// To change a colour: pass a different [color] or use a named constructor.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';

class StatusBadge extends StatelessWidget {
  final String label;
  final Color color;

  const StatusBadge({super.key, required this.label, required this.color});

  const StatusBadge.success(this.label, {super.key}) : color = AppColors.success;
  const StatusBadge.warning(this.label, {super.key}) : color = AppColors.warning;
  const StatusBadge.danger(this.label, {super.key})  : color = AppColors.danger;
  const StatusBadge.info(this.label, {super.key})    : color = AppColors.info;
  const StatusBadge.primary(this.label, {super.key}) : color = AppColors.primary;
  const StatusBadge.muted(this.label, {super.key})   : color = AppColors.textMuted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.badgeRadius),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Text(
        label,
        style: AppTextStyles.badgeLabel.copyWith(color: color),
      ),
    );
  }
}
