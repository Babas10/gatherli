// Partners card showing best partner statistics.
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_text_styles.dart';
import 'package:play_with_me/core/data/models/teammate_stats.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/features/profile/presentation/pages/partner_detail_page.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

/// Best partner section: gray background, gray section label, white card.
///
/// Shows the partner with the highest win rate (minimum 5 games threshold).
/// Tap opens PartnerDetailPage for full breakdown.
class PartnersCard extends StatelessWidget {
  final List<TeammateStats> teammateStats;

  const PartnersCard({super.key, required this.teammateStats});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bestPartner = _findBestPartner();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section label — uppercase, muted, letter-spaced
          Text(
            l10n.bestPartner.toUpperCase(),
            style: AppTextStyles.sectionLabel,
          ),
          const SizedBox(height: AppSpacing.md),
          // White card
          Card(
            margin: EdgeInsets.zero,
            child: InkWell(
              onTap: bestPartner != null
                  ? () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PartnerDetailPage(
                          userId: FirebaseAuth.instance.currentUser?.uid ?? '',
                          partnerId: bestPartner.userId,
                        ),
                      ),
                    )
                  : null,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: bestPartner != null
                    ? _buildPartnerInfo(context, bestPartner)
                    : _buildEmptyState(context),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }

  Widget _buildPartnerInfo(BuildContext context, _PartnerData partner) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final winRate = (partner.gamesWon / partner.gamesPlayed * 100)
        .toStringAsFixed(1);

    return Row(
      children: [
        // Partner avatar
        CircleAvatar(
          radius: 28,
          backgroundColor: AppColors.secondary.withValues(alpha: 0.1),
          child: const Icon(Icons.person, size: 28, color: AppColors.secondary),
        ),
        const SizedBox(width: AppSpacing.lg),
        // Partner stats
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                partner.displayName,
                style: AppTextStyles.cardTitle,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.winRatePercent(winRate),
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.success,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.winsLossesGames(
                  partner.gamesWon,
                  partner.gamesPlayed - partner.gamesWon,
                  partner.gamesPlayed,
                ),
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ),
        // Win rate badge + arrow
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: AppColors.success.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.trending_up, size: 14, color: AppColors.success),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    '$winRate%',
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.success,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Icon(
              Icons.arrow_forward_ios,
              size: 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Row(
      children: [
        Icon(
          Icons.people_outline,
          size: 32,
          color: AppColors.textMuted.withValues(alpha: 0.35),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.noPartnerDataYet,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textMuted,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                l10n.playGamesWithTeammate,
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textMuted.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _PartnerData? _findBestPartner() {
    if (teammateStats.isEmpty) return null;
    const minGames = 5;
    _PartnerData? best;
    double bestWinRate = -1;
    for (final ts in teammateStats) {
      if (ts.gamesPlayed < minGames) continue;
      final winRate = ts.gamesWon / ts.gamesPlayed;
      if (winRate > bestWinRate ||
          (winRate == bestWinRate && best != null && ts.gamesPlayed > best.gamesPlayed)) {
        bestWinRate = winRate;
        best = _PartnerData(
          userId: ts.userId,
          displayName: ts.teammateName ?? ts.userId.substring(0, 5),
          gamesWon: ts.gamesWon,
          gamesPlayed: ts.gamesPlayed,
        );
      }
    }
    return best;
  }
}

class _PartnerData {
  final String userId;
  final String displayName;
  final int gamesWon;
  final int gamesPlayed;

  _PartnerData({
    required this.userId,
    required this.displayName,
    required this.gamesWon,
    required this.gamesPlayed,
  });
}
