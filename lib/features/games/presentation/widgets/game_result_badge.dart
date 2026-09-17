import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/core/data/models/game_model.dart';
import 'package:play_with_me/core/data/models/user_model.dart';

class GameResultBadge extends StatelessWidget {
  final GameResult result;
  final GameTeams? teams;
  final Map<String, UserModel>? players;
  final VoidCallback? onTap;

  const GameResultBadge({
    super.key,
    required this.result,
    this.teams,
    this.players,
    this.onTap,
  });

  String _getTeamName(String teamKey) {
    if (teams == null || players == null || players!.isEmpty) {
      return teamKey == 'teamA' ? 'Team A' : 'Team B';
    }

    final playerIds = teamKey == 'teamA'
        ? teams!.teamAPlayerIds
        : teams!.teamBPlayerIds;

    if (playerIds.isEmpty) {
      return teamKey == 'teamA' ? 'Team A' : 'Team B';
    }

    // Get player names (up to 2 for brevity)
    final names = playerIds.take(2).map((id) {
      final player = players![id];
      return player?.displayName ?? player?.email.split('@').first ?? 'Player';
    }).toList();

    if (names.isEmpty) {
      return teamKey == 'teamA' ? 'Team A' : 'Team B';
    }

    return names.join(' & ');
  }

  @override
  Widget build(BuildContext context) {
    final String scoreText;
    final IconData icon;
    final Color color;
    if (result.overallWinner != null) {
      final winnerName = _getTeamName(result.overallWinner!);
      scoreText = '$winnerName won ${result.scoreDescription}';
      icon = Icons.emoji_events;
      color = AppColors.success;
    } else {
      scoreText = 'Tie ${result.scoreDescription}';
      icon = Icons.handshake;
      color = AppColors.textMuted;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              scoreText,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
