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
    if (result.overallWinner != null) {
      final winnerName = _getTeamName(result.overallWinner!);
      scoreText = '$winnerName won ${result.scoreDescription}';
    } else {
      scoreText = 'Tie ${result.scoreDescription}';
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.success,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.success),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, size: 16, color: AppColors.success),
            const SizedBox(width: AppSpacing.xs),
            Text(
              scoreText,
              style: const TextStyle(
                color: AppColors.success,
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
