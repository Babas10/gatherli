// States for InviteeSelectionBloc used in pickup game creation.
import '../../../../../core/data/models/invitable_user.dart';
import '../../../../../core/presentation/bloc/base_bloc_state.dart';

abstract class InviteeSelectionState extends BaseBlocState {
  const InviteeSelectionState();
}

class InviteeSelectionInitial extends InviteeSelectionState
    implements InitialState {
  const InviteeSelectionInitial();
}

class InviteeSelectionLoading extends InviteeSelectionState
    implements LoadingState {
  const InviteeSelectionLoading();
}

class InviteeSelectionLoaded extends InviteeSelectionState {
  final List<InvitableUser> allUsers;
  final Set<String> selectedIds;

  const InviteeSelectionLoaded({
    required this.allUsers,
    required this.selectedIds,
  });

  List<InvitableUser> get selectedUsers =>
      allUsers.where((u) => selectedIds.contains(u.uid)).toList();

  InviteeSelectionLoaded copyWith({
    List<InvitableUser>? allUsers,
    Set<String>? selectedIds,
  }) {
    return InviteeSelectionLoaded(
      allUsers: allUsers ?? this.allUsers,
      selectedIds: selectedIds ?? this.selectedIds,
    );
  }

  @override
  List<Object?> get props => [allUsers, selectedIds];
}

class InviteeSelectionError extends InviteeSelectionState implements ErrorState {
  @override
  final String message;
  @override
  final String? errorCode;
  @override
  final bool isRetryable;

  const InviteeSelectionError({
    required this.message,
    this.errorCode,
    this.isRetryable = true,
  });

  @override
  List<Object?> get props => [message, errorCode, isRetryable];
}
