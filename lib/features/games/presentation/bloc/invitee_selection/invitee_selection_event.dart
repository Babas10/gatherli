// Events for InviteeSelectionBloc used in pickup game creation.
import '../../../../../core/presentation/bloc/base_bloc_event.dart';

abstract class InviteeSelectionEvent extends BaseBlocEvent {
  const InviteeSelectionEvent();
}

/// Load invitable users: friends from My Community and members of the given groups.
/// [groups] maps groupId → groupName so the picker can label each group section.
class LoadInvitees extends InviteeSelectionEvent {
  final String userId;
  final Map<String, String> groups;

  const LoadInvitees({required this.userId, this.groups = const {}});

  @override
  List<Object?> get props => [userId, groups];
}

/// Toggle selection of an individual friend.
class ToggleInvitee extends InviteeSelectionEvent {
  final String uid;

  const ToggleInvitee({required this.uid});

  @override
  List<Object?> get props => [uid];
}

/// Toggle selection of an entire group (invites / un-invites all its members).
class ToggleGroup extends InviteeSelectionEvent {
  final String groupId;

  const ToggleGroup({required this.groupId});

  @override
  List<Object?> get props => [groupId];
}
