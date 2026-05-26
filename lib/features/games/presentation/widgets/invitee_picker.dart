// Widget for selecting users to invite to a pickup game.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../bloc/invitee_selection/invitee_selection_bloc.dart';
import '../bloc/invitee_selection/invitee_selection_event.dart';
import '../bloc/invitee_selection/invitee_selection_state.dart';

class InviteePicker extends StatelessWidget {
  const InviteePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<InviteeSelectionBloc, InviteeSelectionState>(
      builder: (context, state) {
        if (state is InviteeSelectionLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is InviteeSelectionError) {
          return Center(
            child: Text(
              state.message,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.danger,
              ),
            ),
          );
        }

        if (state is InviteeSelectionLoaded) {
          if (state.allUsers.isEmpty) {
            return Center(
              child: Text(
                l10n.noUsersToInvite,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppColors.textMuted,
                ),
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.allUsers.length,
            itemBuilder: (context, index) {
              final user = state.allUsers[index];
              return _InviteeRow(
                user: user,
                isSelected: state.selectedIds.contains(user.uid),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}

class _InviteeRow extends StatelessWidget {
  final InvitableUser user;
  final bool isSelected;

  const _InviteeRow({required this.user, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      value: isSelected,
      onChanged: (_) {
        context.read<InviteeSelectionBloc>().add(
          ToggleInvitee(uid: user.uid),
        );
      },
      title: Text(user.displayNameOrFallback),
      secondary: CircleAvatar(
        backgroundColor: AppColors.secondary.withValues(alpha: 0.2),
        backgroundImage:
            user.photoUrl != null ? NetworkImage(user.photoUrl!) : null,
        child: user.photoUrl == null
            ? Text(
                (user.displayName?.isNotEmpty == true)
                    ? user.displayName![0].toUpperCase()
                    : '?',
                style: const TextStyle(
                  color: AppColors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              )
            : null,
      ),
      activeColor: AppColors.secondary,
      controlAffinity: ListTileControlAffinity.trailing,
    );
  }
}
