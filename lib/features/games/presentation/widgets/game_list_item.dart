import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/presentation/widgets/joined_badge.dart';
import 'package:play_with_me/core/presentation/widgets/mix_game_badge.dart';
import 'package:play_with_me/core/presentation/widgets/status_badge.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'set_scores_display.dart';

class GameListItem extends StatelessWidget {
  final GameModel game;
  final String userId;
  final bool isPast;
  final VoidCallback onTap;

  const GameListItem({
    super.key,
    required this.game,
    required this.userId,
    this.isPast = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isCompletedWithResult =
        game.status == GameStatus.completed && game.result != null;
    final isCancelled = game.status == GameStatus.cancelled;
    final isVerification = game.status == GameStatus.verification;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      elevation: 1,
      color: AppColors.cardBackground,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title row with game badge
              Row(
                children: [
                  // Game icon to distinguish from training sessions
                  Icon(
                    Icons.sports_volleyball,
                    size: 20,
                    color: isCancelled ? AppColors.textMuted : AppColors.secondary,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      game.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isCancelled
                            ? AppColors.textMuted
                            : AppColors.secondary,
                        decoration: isCancelled
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                  ),
                  if (game.gameGenderType == GameGenderType.mix) ...[
                    const MixGameBadge(),
                    const SizedBox(width: 6),
                  ],
                  if (isVerification)
                    _buildVerificationBadge(context)
                  else if (isCancelled)
                    _buildCancelledBadge(context)
                  else
                    _buildTypeBadge(context),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _buildInfoRow(
                context,
                Icons.calendar_today,
                _formatDateTime(context, game.scheduledAt),
                isCancelled ? AppColors.textMuted : AppColors.secondary,
              ),
              const SizedBox(height: AppSpacing.sm),
              _buildInfoRow(
                context,
                Icons.location_on,
                game.location.name,
                isCancelled ? AppColors.textMuted : AppColors.secondary,
              ),
              const SizedBox(height: AppSpacing.md),
              if (isCompletedWithResult) ...[
                const Divider(),
                const SizedBox(height: AppSpacing.sm),
                SetScoresDisplay(result: game.result!),
              ] else if (!isCancelled) ...[
                _buildPlayerCountBarWithBadge(context),
              ],
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String text,
    Color iconColor,
  ) {
    return Row(
      children: [
        Icon(icon, size: 16, color: iconColor),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: AppColors.onSurface,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVerificationBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StatusBadge.warning(l10n.pendingVerification);
  }

  Widget _buildTypeBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StatusBadge(label: l10n.gameLabel, color: AppColors.secondary);
  }

  Widget _buildCancelledBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return StatusBadge.muted(l10n.cancelled);
  }

  Widget? _buildStatusBadge(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isPlayer = game.isPlayer(userId);
    final isOnWaitlist = game.isOnWaitlist(userId);

    if (isPlayer) {
      return const JoinedBadge();
    }

    if (isOnWaitlist) {
      return StatusBadge.warning(l10n.onWaitlist);
    }

    if (game.isFull && !game.allowWaitlist) {
      return StatusBadge.danger(l10n.full);
    }

    return null;
  }

  Widget _buildPlayerCountBarWithBadge(BuildContext context) {
    final progress = game.currentPlayerCount / game.maxPlayers;
    final statusBadge = _buildStatusBadge(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${game.currentPlayerCount}/${game.maxPlayers} players',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (game.waitlistCount > 0)
                    Text(
                      '${game.waitlistCount} waitlisted',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xs),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 6,
                  backgroundColor: AppColors.divider,
                  valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              ),
            ],
          ),
        ),
        if (statusBadge != null) ...[const SizedBox(width: AppSpacing.md), statusBadge],
      ],
    );
  }

  String _formatDateTime(BuildContext context, DateTime dateTime) {
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

    final timeString = DateFormat('h:mm a').format(dateTime);
    return '$dayString • $timeString';
  }
}
