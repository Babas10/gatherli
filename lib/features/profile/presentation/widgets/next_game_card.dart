// Card displaying the next upcoming game on the homepage.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

// Golden Hour theme colors

/// A card widget that displays the user's next upcoming game.
///
/// Shows key information:
/// - Title with RSVP status badge
/// - Date/time and location
/// - Player count progress bar
///
/// Filled state: white card with orange left accent bar
/// Empty state: dashed border container with centered icon
class NextGameCard extends StatelessWidget {
  final GameModel? game;
  final String userId;
  final VoidCallback? onTap;

  const NextGameCard({
    super.key,
    required this.game,
    required this.userId,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (game != null) {
      return _buildFilledCard(context, l10n);
    }
    return _buildEmptyCard(context, l10n);
  }

  Widget _buildFilledCard(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.shadow,
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Orange accent bar on the left
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 6, color: AppColors.primary),
                ),
                // Card content
                Padding(
                  padding: const EdgeInsets.fromLTRB(22, 20, 16, 20),
                  child: _buildGameContent(context, l10n),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyCard(BuildContext context, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: CustomPaint(
          painter: _DashedBorderPainter(),
          child: SizedBox(
            height: 110,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.sports_volleyball,
                    size: 36,
                    color: AppColors.textMuted.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    l10n.noGamesScheduled,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textMuted.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGameContent(BuildContext context, AppLocalizations l10n) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Title + RSVP badge
        Row(
          children: [
            Expanded(
              child: Text(
                game!.title,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: AppColors.onSurface,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _buildRsvpBadge(context, l10n),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Date/time + Location
        Row(
          children: [
            const Icon(Icons.calendar_today, size: 14, color: AppColors.textMuted),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                _formatDateTime(context, game!.scheduledAt),
                style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 15),
            const Icon(Icons.location_on, size: 14, color: AppColors.textMuted),
            const SizedBox(width: AppSpacing.xs),
            Expanded(
              child: Text(
                game!.location.name,
                style: const TextStyle(fontSize: 14, color: AppColors.textMuted),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        // Player count bar in gray container
        _buildPlayerBar(context),
      ],
    );
  }

  Widget _buildRsvpBadge(BuildContext context, AppLocalizations l10n) {
    final isPlayer = game!.isPlayer(userId);
    final isOnWaitlist = game!.isOnWaitlist(userId);

    if (isPlayer) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          l10n.joined,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      );
    }

    if (isOnWaitlist) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.warning.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.warning, width: 0.5),
        ),
        child: Text(
          l10n.onWaitlist,
          style: const TextStyle(
            color: AppColors.warning,
            fontWeight: FontWeight.w600,
            fontSize: 11,
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Join',
        style: TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
          fontSize: 11,
        ),
      ),
    );
  }

  Widget _buildPlayerBar(BuildContext context) {
    final progress = game!.currentPlayerCount / game!.maxPlayers;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            '${game!.currentPlayerCount}/${game!.maxPlayers}',
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(3),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 5,
                backgroundColor: AppColors.divider,
                valueColor: AlwaysStoppedAnimation<Color>(
                  game!.currentPlayerCount >= game!.minPlayers
                      ? AppColors.primary
                      : AppColors.primary,
                ),
              ),
            ),
          ),
          if (game!.waitlistCount > 0) ...[
            const SizedBox(width: 6),
            Text(
              '+${game!.waitlistCount}',
              style: AppTextStyles.caption,
            ),
          ],
        ],
      ),
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
    return '$dayString $timeString';
  }
}

/// Paints a dashed rounded rectangle border for empty states.
class _DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.divider
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(16),
        ),
      );

    final dashPath = Path();
    for (final metric in path.computeMetrics()) {
      double distance = 0;
      while (distance < metric.length) {
        final end = (distance + 8).clamp(0.0, metric.length);
        dashPath.addPath(metric.extractPath(distance, end), Offset.zero);
        distance += 16;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
