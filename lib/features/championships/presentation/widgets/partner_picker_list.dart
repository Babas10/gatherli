// Single-select list of friends for choosing a championship partner.
import 'package:flutter/material.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/l10n/app_localizations.dart';

class PartnerPickerList extends StatelessWidget {
  final List<InvitableUser> friends;
  final String? selectedPartnerId;
  final ValueChanged<String?> onPartnerSelected;

  const PartnerPickerList({
    super.key,
    required this.friends,
    required this.selectedPartnerId,
    required this.onPartnerSelected,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (friends.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Text(
          l10n.noFriendsForPartner,
          style: Theme.of(context).textTheme.bodyMedium,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: friends.length,
      itemBuilder: (context, index) {
        final friend = friends[index];
        final isSelected = friend.uid == selectedPartnerId;

        return ListTile(
          leading: CircleAvatar(
            backgroundImage: friend.photoUrl != null
                ? NetworkImage(friend.photoUrl!)
                : null,
            child: friend.photoUrl == null
                ? Text(friend.displayNameOrFallback[0].toUpperCase())
                : null,
          ),
          title: Text(friend.displayNameOrFallback),
          trailing: isSelected
              ? Icon(Icons.radio_button_checked,
                  color: Theme.of(context).colorScheme.primary)
              : const Icon(Icons.radio_button_unchecked),
          onTap: () => onPartnerSelected(isSelected ? null : friend.uid),
        );
      },
    );
  }
}
