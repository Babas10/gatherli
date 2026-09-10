import 'package:flutter/material.dart';
import 'package:play_with_me/core/presentation/widgets/empty_state.dart';
import 'package:play_with_me/core/domain/entities/friendship_entity.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import 'received_request_tile.dart';
import 'sent_request_tile.dart';

/// Widget for displaying friend requests (received and sent)
class FriendRequestsList extends StatelessWidget {
  final List<FriendshipEntity> receivedRequests;
  final List<FriendshipEntity> sentRequests;
  final Function(String friendshipId) onAcceptRequest;
  final Function(String friendshipId) onDeclineRequest;
  final Function(String friendshipId) onCancelRequest;

  const FriendRequestsList({
    super.key,
    required this.receivedRequests,
    required this.sentRequests,
    required this.onAcceptRequest,
    required this.onDeclineRequest,
    required this.onCancelRequest,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasReceivedRequests = receivedRequests.isNotEmpty;
    final hasSentRequests = sentRequests.isNotEmpty;

    if (!hasReceivedRequests && !hasSentRequests) {
      return EmptyState(
        icon: Icons.inbox_outlined,
        title: l10n.noPendingRequests,
      );
    }

    final items = <Widget>[
      if (hasReceivedRequests) ...[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            l10n.receivedRequests,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...receivedRequests.map(
          (request) => ReceivedRequestTile(
            request: request,
            onAccept: () => onAcceptRequest(request.id),
            onDecline: () => onDeclineRequest(request.id),
          ),
        ),
      ],
      if (hasReceivedRequests && hasSentRequests) const Divider(height: 32),
      if (hasSentRequests) ...[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            l10n.sentRequests,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
        ),
        ...sentRequests.map(
          (request) => SentRequestTile(
            request: request,
            onCancel: () => onCancelRequest(request.id),
          ),
        ),
      ],
      if (!hasReceivedRequests && hasSentRequests)
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'No pending requests to respond to',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ),
    ];

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 80),
      itemCount: items.length,
      itemBuilder: (context, index) => items[index],
    );
  }
}
