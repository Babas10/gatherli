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
  /// Friends from My Community (individually selectable).
  final List<InvitableUser> friends;
  /// Groups the user belongs to (selectable as a whole).
  final List<InvitableGroup> groups;
  /// UIDs of individually selected friends.
  final Set<String> selectedFriendIds;
  /// IDs of groups whose members are all invited.
  final Set<String> selectedGroupIds;

  const InviteeSelectionLoaded({
    required this.friends,
    required this.groups,
    this.selectedFriendIds = const {},
    this.selectedGroupIds = const {},
  });

  /// All user IDs to invite: individually selected friends + every member of
  /// every selected group (deduped via Set).
  Set<String> get selectedIds {
    final ids = Set<String>.from(selectedFriendIds);
    for (final g in groups.where((g) => selectedGroupIds.contains(g.id))) {
      ids.addAll(g.members.map((m) => m.uid));
    }
    return ids;
  }

  InviteeSelectionLoaded copyWith({
    List<InvitableUser>? friends,
    List<InvitableGroup>? groups,
    Set<String>? selectedFriendIds,
    Set<String>? selectedGroupIds,
  }) {
    return InviteeSelectionLoaded(
      friends: friends ?? this.friends,
      groups: groups ?? this.groups,
      selectedFriendIds: selectedFriendIds ?? this.selectedFriendIds,
      selectedGroupIds: selectedGroupIds ?? this.selectedGroupIds,
    );
  }

  @override
  List<Object?> get props =>
      [friends, groups, selectedFriendIds, selectedGroupIds];
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
