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
  }

  Future<void> _onLoadInvitees(
    LoadInvitees event,
    Emitter<InviteeSelectionState> emit,
  ) async {
    emit(const InviteeSelectionLoading());
    try {
      // Load friends from My Community (deduplicated by uid, friends come first).
      final friends = await _friendRepository.getFriends(event.userId);
      final seen = <String>{};
      final users = <InvitableUser>[];

      for (final friend in friends) {
        if (seen.add(friend.uid)) {
          users.add(
            InvitableUser(
              uid: friend.uid,
              displayName: friend.displayName,
              photoUrl: friend.photoUrl,
            ),
          );
        }
      }

      // Load members from each group, skipping duplicates and current user.
      for (final groupId in event.groupIds) {
        final members = await _userRepository.getUsersInGroup(groupId);
        for (final member in members) {
          if (member.uid != event.userId && seen.add(member.uid)) {
            users.add(
              InvitableUser(
                uid: member.uid,
                displayName: member.displayName,
                photoUrl: member.photoUrl,
              ),
            );
          }
        }
      }

      emit(InviteeSelectionLoaded(allUsers: users, selectedIds: const {}));
    } on FriendshipException catch (e) {
      emit(
        InviteeSelectionError(
          message: e.message,
          errorCode: e.code ?? 'LOAD_INVITEES_ERROR',
        ),
      );
    } catch (e) {
      emit(
        InviteeSelectionError(
          message: 'Failed to load invitees: ${e.toString()}',
          errorCode: 'LOAD_INVITEES_ERROR',
        ),
      );
    }
  }

  void _onToggleInvitee(
    ToggleInvitee event,
    Emitter<InviteeSelectionState> emit,
  ) {
    if (state is! InviteeSelectionLoaded) return;
    final current = state as InviteeSelectionLoaded;
    final newSelected = Set<String>.from(current.selectedIds);
    if (newSelected.contains(event.uid)) {
      newSelected.remove(event.uid);
    } else {
      newSelected.add(event.uid);
    }
    emit(current.copyWith(selectedIds: newSelected));
  }
}
