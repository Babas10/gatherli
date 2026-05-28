// States for PartnerPickerBloc used in championship team registration.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';

abstract class PartnerPickerState extends Equatable {
  const PartnerPickerState();

  @override
  List<Object?> get props => [];
}

class PartnerPickerInitial extends PartnerPickerState {
  const PartnerPickerInitial();
}

class PartnerPickerLoading extends PartnerPickerState {
  const PartnerPickerLoading();
}

class PartnerPickerLoaded extends PartnerPickerState {
  final List<InvitableUser> friends;
  final String? selectedPartnerId;

  const PartnerPickerLoaded({
    required this.friends,
    this.selectedPartnerId,
  });

  PartnerPickerLoaded copyWith({
    List<InvitableUser>? friends,
    String? Function()? selectedPartnerId,
  }) {
    return PartnerPickerLoaded(
      friends: friends ?? this.friends,
      selectedPartnerId: selectedPartnerId != null
          ? selectedPartnerId()
          : this.selectedPartnerId,
    );
  }

  @override
  List<Object?> get props => [friends, selectedPartnerId];
}

class PartnerPickerError extends PartnerPickerState {
  final String message;
  final String? errorCode;

  const PartnerPickerError({required this.message, this.errorCode});

  @override
  List<Object?> get props => [message, errorCode];
}
