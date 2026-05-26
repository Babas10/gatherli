// Lightweight user model used in the invitee picker for pickup game creation.

/// A user that can be invited to a pickup game.
class InvitableUser {
  final String uid;
  final String? displayName;
  final String? photoUrl;

  const InvitableUser({
    required this.uid,
    this.displayName,
    this.photoUrl,
  });

  String get displayNameOrFallback => displayName ?? 'Unknown player';

  @override
  bool operator ==(Object other) =>
      other is InvitableUser && other.uid == uid;

  @override
  int get hashCode => uid.hashCode;
}
