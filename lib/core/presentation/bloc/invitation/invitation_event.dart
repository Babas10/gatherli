import '../base_bloc_event.dart';

abstract class InvitationEvent extends BaseBlocEvent {
  const InvitationEvent();
}

class SendInvitation extends InvitationEvent {
  final String groupId;
  final String invitedUserId;

  const SendInvitation({
    required this.groupId,
    required this.invitedUserId,
  });

  @override
  List<Object?> get props => [groupId, invitedUserId];
}

class LoadPendingInvitations extends InvitationEvent {
  final String userId;

  const LoadPendingInvitations({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class LoadInvitations extends InvitationEvent {
  final String userId;

  const LoadInvitations({required this.userId});

  @override
  List<Object?> get props => [userId];
}

class AcceptInvitation extends InvitationEvent {
  final String userId;
  final String invitationId;

  const AcceptInvitation({required this.userId, required this.invitationId});

  @override
  List<Object?> get props => [userId, invitationId];
}

class DeclineInvitation extends InvitationEvent {
  final String userId;
  final String invitationId;

  const DeclineInvitation({required this.userId, required this.invitationId});

  @override
  List<Object?> get props => [userId, invitationId];
}

class DeleteInvitation extends InvitationEvent {
  final String userId;
  final String invitationId;

  const DeleteInvitation({required this.userId, required this.invitationId});

  @override
  List<Object?> get props => [userId, invitationId];
}
