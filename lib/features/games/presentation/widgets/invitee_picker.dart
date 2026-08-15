// Tabbed invitee picker: "My Community" (friends) and "Groups" tabs.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/presentation/widgets/accent_card.dart';
import 'package:play_with_me/core/presentation/widgets/group_avatar.dart';
import 'package:play_with_me/core/presentation/widgets/user_avatar.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../bloc/invitee_selection/invitee_selection_bloc.dart';
import '../bloc/invitee_selection/invitee_selection_event.dart';
import '../bloc/invitee_selection/invitee_selection_state.dart';

/// Full-height tabbed picker. Must be placed inside an [Expanded] or a widget
/// with a bounded height constraint.
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
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.danger),
            ),
          );
        }
        if (state is InviteeSelectionLoaded) {
          return DefaultTabController(
            length: 2,
            child: Column(
              children: [
                TabBar(
                  tabs: [
                    Tab(text: l10n.myCommunity),
                    Tab(text: l10n.groups),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _FriendsTab(state: state),
                      _GroupsTab(state: state),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

// ── My Community tab ────────────────────────────────────────────────────────

class _FriendsTab extends StatelessWidget {
  final InviteeSelectionLoaded state;
  const _FriendsTab({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (state.friends.isEmpty) {
      return Center(
        child: Text(
          l10n.noUsersToInvite,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.friends.length,
      itemBuilder: (context, i) {
        final user = state.friends[i];
        return _InviteeRow(
          user: user,
          isSelected: state.selectedFriendIds.contains(user.uid),
          onTap: () =>
              context.read<InviteeSelectionBloc>().add(ToggleInvitee(uid: user.uid)),
        );
      },
    );
  }
}

// ── Groups tab ───────────────────────────────────────────────────────────────

class _GroupsTab extends StatelessWidget {
  final InviteeSelectionLoaded state;
  const _GroupsTab({required this.state});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (state.groups.isEmpty) {
      return Center(
        child: Text(
          l10n.noGroupsToInvite,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: AppColors.textMuted),
          textAlign: TextAlign.center,
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: state.groups.length,
      itemBuilder: (context, i) {
        final group = state.groups[i];
        final isSelected = state.selectedGroupIds.contains(group.id);
        return _GroupRow(
          group: group,
          isSelected: isSelected,
          onTap: () => context
              .read<InviteeSelectionBloc>()
              .add(ToggleGroup(groupId: group.id)),
        );
      },
    );
  }
}

// ── Row widgets ──────────────────────────────────────────────────────────────

class _InviteeRow extends StatelessWidget {
  final InvitableUser user;
  final bool isSelected;
  final VoidCallback onTap;

  const _InviteeRow({
    required this.user,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AccentCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          UserAvatar(name: user.displayNameOrFallback, photoUrl: user.photoUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user.displayNameOrFallback,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),

              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: (_) => onTap(),
            activeColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

class _GroupRow extends StatelessWidget {
  final InvitableGroup group;
  final bool isSelected;
  final VoidCallback onTap;

  const _GroupRow({
    required this.group,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AccentCard(
      onTap: onTap,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          GroupAvatar(name: group.name, radius: 22),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  group.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
                Text(
                  l10n.groupMembersCount(group.members.length),
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
          Checkbox(
            value: isSelected,
            onChanged: (_) => onTap(),
            activeColor: AppColors.secondary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ),
    );
  }
}

