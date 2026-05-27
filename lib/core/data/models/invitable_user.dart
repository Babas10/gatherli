// Lightweight models used in the invitee picker for pickup game creation.

/// A user that can be individually invited.
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

/// A group whose members can all be invited at once.
class InvitableGroup {
  final String id;
  final String name;
  final List<InvitableUser> members;

  const InvitableGroup({
    required this.id,
    required this.name,
    required this.members,
  });
}
