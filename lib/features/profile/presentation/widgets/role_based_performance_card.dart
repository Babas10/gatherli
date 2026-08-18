// Adaptability stats: 3 individual AccentCards — one per role (Carry, Balanced, Weak-Link).
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

// Gold accent bar, teal win rate text — consistent, minimal palette
const _kAccentBarColor = AppColors.primary;    // gold left bar
const _kWinRateColor = AppColors.secondary;    // teal win rate percentage

class RoleBasedPerformanceCard extends StatelessWidget {
  final UserModel user;

  const RoleBasedPerformanceCard({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final stats = user.roleBasedStats;
    final hasData = stats != null && stats.hasData;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.adaptabilityStats.toUpperCase(),
            style: AppTextStyles.sectionLabel,
          ),
          const SizedBox(height: AppSpacing.md),

          if (!hasData)
            _LockedCard(l10n: l10n)
          else ...[
            if (stats.carry.games > 0)
              _RoleCard(
                icon: Icons.emoji_events,
                accentColor: _kAccentBarColor,
                role: l10n.leadingTheTeam,
                description: l10n.whenHighestRated,
                stats: stats.carry,
              ),
            if (stats.balanced.games > 0)
              _RoleCard(
                icon: Icons.balance,
                accentColor: _kAccentBarColor,
                role: l10n.balancedTeams,
                description: l10n.whenSimilarlyRatedTeammates,
                stats: stats.balanced,
              ),
            if (stats.weakLink.games > 0)
              _RoleCard(
                icon: Icons.people,
                accentColor: _kAccentBarColor,
                role: l10n.playingWithStrongerPartners,
                description: l10n.whenMoreExperiencedTeammates,
                stats: stats.weakLink,
              ),
          ],

          const SizedBox(height: AppSpacing.xs),
        ],
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final IconData icon;
  final Color accentColor;
  final String role;
  final String description;
  final RoleStats stats;

  const _RoleCard({
    required this.icon,
    required this.accentColor,
    required this.role,
    required this.description,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      accentColor: accentColor,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: accentColor, size: 20),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: AppTextStyles.cardTitle.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTextStyles.caption,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  '${stats.recordString}  ·  ${stats.games} games',
                  style: AppTextStyles.caption,
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                stats.winRateString,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: _kWinRateColor,
                ),
              ),
              const Text(
                'win rate',
                style: TextStyle(fontSize: 11, color: AppColors.textMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _LockedCard extends StatelessWidget {
  final AppLocalizations l10n;

  const _LockedCard({required this.l10n});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(
              Icons.lock_outline,
              size: 28,
              color: AppColors.textMuted.withValues(alpha: 0.4),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.adaptabilityStatsLocked,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textMuted,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    l10n.playMoreGamesToSeeRoles,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textMuted.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
