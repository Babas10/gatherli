// Loads the user's friends and manages single-select partner picking for team registration.
// Only imports FriendRepository — intentional per championship architecture rules.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'partner_picker_event.dart';
import 'partner_picker_state.dart';

class PartnerPickerBloc extends Bloc<PartnerPickerEvent, PartnerPickerState> {
  final FriendRepository _friendRepository;

  PartnerPickerBloc({required FriendRepository friendRepository})
      : _friendRepository = friendRepository,
        super(const PartnerPickerInitial()) {
    on<LoadPartners>(_onLoadPartners);
    on<SelectPartner>(_onSelectPartner);
  }

  Future<void> _onLoadPartners(
    LoadPartners event,
    Emitter<PartnerPickerState> emit,
  ) async {
    emit(const PartnerPickerLoading());
    try {
      final friendEntities = await _friendRepository.getFriends(event.userId);
      final seenIds = <String>{};
      final friends = <InvitableUser>[];
      for (final f in friendEntities) {
        if (seenIds.add(f.uid)) {
          friends.add(InvitableUser(
            uid: f.uid,
            displayName: f.displayName,
            photoUrl: f.photoUrl,
          ));
        }
      }
      emit(PartnerPickerLoaded(friends: friends));
    } on FriendshipException catch (e) {
      emit(PartnerPickerError(
        message: e.message,
        errorCode: e.code ?? 'LOAD_PARTNERS_ERROR',
      ));
    } catch (e) {
      emit(PartnerPickerError(
        message: 'Failed to load partners: ${e.toString()}',
        errorCode: 'LOAD_PARTNERS_ERROR',
      ));
    }
  }

  void _onSelectPartner(
    SelectPartner event,
    Emitter<PartnerPickerState> emit,
  ) {
    if (state is! PartnerPickerLoaded) return;
    final current = state as PartnerPickerLoaded;
    // Tapping the already-selected partner deselects it.
    final newId =
        event.uid == current.selectedPartnerId ? null : event.uid;
    emit(current.copyWith(selectedPartnerId: () => newId));
  }
}
