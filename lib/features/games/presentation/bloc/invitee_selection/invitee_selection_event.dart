// Events for InviteeSelectionBloc used in pickup game creation.
import '../../../../../core/presentation/bloc/base_bloc_event.dart';

abstract class InviteeSelectionEvent extends BaseBlocEvent {
  const InviteeSelectionEvent();
}

/// Load invitable users: friends from My Community and members of the given groups.
class LoadInvitees extends InviteeSelectionEvent {
  final String userId;
  final List<String> groupIds;

  const LoadInvitees({required this.userId, this.groupIds = const []});

  @override
  List<Object?> get props => [userId, groupIds];
}

/// Toggle selection of a user by their uid.
class ToggleInvitee extends InviteeSelectionEvent {
  final String uid;

  const ToggleInvitee({required this.uid});

  @override
  List<Object?> get props => [uid];
}
