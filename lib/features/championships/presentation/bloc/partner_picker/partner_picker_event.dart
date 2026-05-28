// Events for PartnerPickerBloc used in championship team registration.
import 'package:equatable/equatable.dart';

abstract class PartnerPickerEvent extends Equatable {
  const PartnerPickerEvent();

  @override
  List<Object?> get props => [];
}

/// Load the current user's friends as selectable partners.
class LoadPartners extends PartnerPickerEvent {
  final String userId;

  const LoadPartners(this.userId);

  @override
  List<Object?> get props => [userId];
}

/// Select a single partner (radio selection — deselects any previous choice).
class SelectPartner extends PartnerPickerEvent {
  final String? uid; // null = deselect

  const SelectPartner(this.uid);

  @override
  List<Object?> get props => [uid];
}
