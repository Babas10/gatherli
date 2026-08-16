// Widget for displaying a single invitation with accept/decline actions
import 'package:flutter/material.dart';
import 'package:play_with_me/core/theme/app_spacing.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'package:play_with_me/core/data/models/invitation_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class InvitationTile extends StatelessWidget {
  final InvitationModel invitation;
  final VoidCallback onAccept;
  final VoidCallback onDecline;
  final bool isLoading;

  const InvitationTile({
    super.key,
    required this.invitation,
    required this.onAccept,
    required this.onDecline,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Group name
            Text(
              invitation.groupName ?? invitation.gameTitle ?? '',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.sm),

            // Inviter info
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  AppLocalizations.of(
                    context,
                  )!.invitedBy(invitation.inviterName),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),

            // Time ago
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 16,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  timeago.format(invitation.createdAt),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Decline button
                OutlinedButton(
                  onPressed: isLoading ? null : onDecline,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.secondary,
                    side: const BorderSide(color: AppColors.secondary),
                  ),
                  child: Text(AppLocalizations.of(context)!.decline),
                ),
                const SizedBox(width: AppSpacing.sm),

                // Accept button
                FilledButton(
                  onPressed: isLoading ? null : onAccept,
                  // No style override — gold comes from AppTheme.filledButtonTheme
                  child: isLoading
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(AppLocalizations.of(context)!.accept),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
