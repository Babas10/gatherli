// Manages loading and selection of invitable users for pickup game creation.
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/data/models/invitable_user.dart';
import '../../../../../core/domain/repositories/friend_repository.dart';
import '../../../../../core/domain/repositories/user_repository.dart';
import 'invitee_selection_event.dart';
import 'invitee_selection_state.dart';

class InviteeSelectionBloc
    extends Bloc<InviteeSelectionEvent, InviteeSelectionState> {
  final FriendRepository _friendRepository;
  final UserRepository _userRepository;

  InviteeSelectionBloc({
    required FriendRepository friendRepository,
    required UserRepository userRepository,
  })  : _friendRepository = friendRepository,
        _userRepository = userRepository,
        super(const InviteeSelectionInitial()) {
    on<LoadInvitees>(_onLoadInvitees);
    on<ToggleInvitee>(_onToggleInvitee);
    on<ToggleGroup>(_onToggleGroup);
  }

  Future<void> _onLoadInvitees(
    LoadInvitees event,
    Emitter<InviteeSelectionState> emit,
  ) async {
    emit(const InviteeSelectionLoading());
    try {
      // My Community: friends list (deduplicated).
      final friendEntities = await _friendRepository.getFriends(event.userId);
      final seenFriendIds = <String>{};
      final friends = <InvitableUser>[];
      for (final f in friendEntities) {
        if (seenFriendIds.add(f.uid)) {
          friends.add(InvitableUser(
            uid: f.uid,
            displayName: f.displayName,
            photoUrl: f.photoUrl,
          ));
        }
      }

      // Groups: one InvitableGroup per group with all its members (excl. self).
      final groups = <InvitableGroup>[];
      for (final entry in event.groups.entries) {
        final members = await _userRepository.getUsersInGroup(entry.key);
        final groupMembers = members
            .where((m) => m.uid != event.userId)
            .map((m) => InvitableUser(
                  uid: m.uid,
                  displayName: m.displayName,
                  photoUrl: m.photoUrl,
                ))
            .toList();
        if (groupMembers.isNotEmpty) {
          groups.add(InvitableGroup(
            id: entry.key,
            name: entry.value,
            members: groupMembers,
          ));
        }
      }

      emit(InviteeSelectionLoaded(friends: friends, groups: groups));
    } on FriendshipException catch (e) {
      emit(InviteeSelectionError(
        message: e.message,
        errorCode: e.code ?? 'LOAD_INVITEES_ERROR',
      ));
    } catch (e) {
      emit(InviteeSelectionError(
        message: 'Failed to load invitees: ${e.toString()}',
        errorCode: 'LOAD_INVITEES_ERROR',
      ));
    }
  }

  void _onToggleInvitee(
    ToggleInvitee event,
    Emitter<InviteeSelectionState> emit,
  ) {
    if (state is! InviteeSelectionLoaded) return;
    final current = state as InviteeSelectionLoaded;
    final newIds = Set<String>.from(current.selectedFriendIds);
    if (newIds.contains(event.uid)) {
      newIds.remove(event.uid);
    } else {
      newIds.add(event.uid);
    }
    emit(current.copyWith(selectedFriendIds: newIds));
  }

  void _onToggleGroup(
    ToggleGroup event,
    Emitter<InviteeSelectionState> emit,
  ) {
    if (state is! InviteeSelectionLoaded) return;
    final current = state as InviteeSelectionLoaded;
    final newGroupIds = Set<String>.from(current.selectedGroupIds);
    if (newGroupIds.contains(event.groupId)) {
      newGroupIds.remove(event.groupId);
    } else {
      newGroupIds.add(event.groupId);
    }
    emit(current.copyWith(selectedGroupIds: newGroupIds));
  }
}
