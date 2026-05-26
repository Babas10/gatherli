import 'package:freezed_annotation/freezed_annotation.dart';

part 'partner_detail_event.freezed.dart';

@freezed
abstract class PartnerDetailEvent with _$PartnerDetailEvent {
  const factory PartnerDetailEvent.loadPartnerDetails({
    required String userId,
    required String partnerId,
  }) = LoadPartnerDetails;
}
