// Compact game list tile used in MyGamesPage (Story 28.11).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/data/models/my_game_item.dart';
import 'package:play_with_me/features/games/presentation/widgets/game_status_style.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class MyGameTile extends StatelessWidget {
  final MyGameItem item;
  final VoidCallback onTap;

  const MyGameTile({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AccentCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _effectiveStatus(item.status, item.scheduledAt).color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: AppTextStyles.cardTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${_formatDate(context, item.scheduledAt)}  ·  ${item.locationName}',
                      style: AppTextStyles.cardSubtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (item.groupName.isNotEmpty) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.groupName,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textMuted,
                          fontStyle: FontStyle.italic,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              item.isGroupGame
                  ? _OpenBadge(l10n: l10n)
                  : _StatusBadge(
                      status: _effectiveStatus(item.status, item.scheduledAt),
                      l10n: l10n,
                    ),
              const Icon(Icons.chevron_right, size: 18, color: AppColors.textMuted),
            ],
      ),
    );
  }

  /// Treats past-scheduled games as verification to prompt result entry.
  GameStatus _effectiveStatus(GameStatus status, DateTime scheduledAt) {
    if (status == GameStatus.scheduled &&
        scheduledAt.isBefore(DateTime.now())) {
      return GameStatus.verification;
    }
    return status;
  }

  String _formatDate(BuildContext context, DateTime dateTime) {
    final l10n = AppLocalizations.of(context)!;
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final gameDate = DateTime(dateTime.year, dateTime.month, dateTime.day);

    String dayString;
    if (gameDate == today) {
      dayString = l10n.today;
    } else if (gameDate == tomorrow) {
      dayString = l10n.tomorrow;
    } else {
      dayString = DateFormat('EEE, MMM d').format(dateTime);
    }
    return '$dayString ${DateFormat('h:mm a').format(dateTime)}';
  }
}

class _StatusBadge extends StatelessWidget {
  final GameStatus status;
  final AppLocalizations l10n;

  const _StatusBadge({required this.status, required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: StatusBadge(label: status.label(l10n), color: status.color),
    );
  }
}

/// Badge shown on un-joined group games — invites the user to join.
class _OpenBadge extends StatelessWidget {
  final AppLocalizations l10n;
  const _OpenBadge({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4),
      child: StatusBadge.success(l10n.open),
    );
  }
}
