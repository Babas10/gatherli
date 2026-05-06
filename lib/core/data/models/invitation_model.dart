import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'invitation_model.freezed.dart';
part 'invitation_model.g.dart';

/// Type of invitation — determines which activity the invite is for.
enum InvitationType {
  @JsonValue('group')
  group,
  @JsonValue('game')
  game,
  @JsonValue('championship')
  championship,
}

/// Status of an invitation
enum InvitationStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('declined')
  declined,
  @JsonValue('expired')
  expired,
}

/// Unified invitation model covering group, game, and championship invitations.
///
/// Stored in the top-level `invitations/{id}` Firestore collection.
/// Created and mutated exclusively via Cloud Functions (Admin SDK).
///
/// Context fields (`groupId`, `gameId`, etc.) are nullable — only the fields
/// relevant to the invitation `type` are populated.
@freezed
class InvitationModel with _$InvitationModel {
  const factory InvitationModel({
    required String id,
    @Default(InvitationType.group) InvitationType type,
    required String invitedBy,
    required String inviterName,
    required String invitedUserId,
    @Default(InvitationStatus.pending) InvitationStatus status,
    @TimestampConverter() required DateTime createdAt,
    @NullableTimestampConverter() DateTime? respondedAt,
    @NullableTimestampConverter() DateTime? expiresAt,
    // Group context (set when type == group)
    String? groupId,
    String? groupName,
    // Game context (set when type == game)
    String? gameId,
    String? gameTitle,
    @NullableTimestampConverter() DateTime? gameScheduledAt,
    String? gameLocationName,
  }) = _InvitationModel;

  const InvitationModel._();

  factory InvitationModel.fromJson(Map<String, dynamic> json) =>
      _$InvitationModelFromJson(json);

  /// Factory constructor for creating from Firestore DocumentSnapshot
  factory InvitationModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return InvitationModel.fromJson({...data, 'id': doc.id});
  }

  /// Convert to Firestore-compatible map (excludes id since it's the document ID)
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Remove id as it's the document ID
    return json;
  }

  /// Check if invitation is still pending
  bool get isPending => status == InvitationStatus.pending;

  /// Check if invitation was accepted
  bool get isAccepted => status == InvitationStatus.accepted;

  /// Check if invitation was declined
  bool get isDeclined => status == InvitationStatus.declined;

  /// Check if invitation has expired
  bool get isExpired => status == InvitationStatus.expired;

  /// Whether this is a group invitation
  bool get isGroupInvitation => type == InvitationType.group;

  /// Whether this is a game invitation
  bool get isGameInvitation => type == InvitationType.game;

  /// Accept the invitation
  InvitationModel accept() {
    return copyWith(
      status: InvitationStatus.accepted,
      respondedAt: DateTime.now(),
    );
  }

  /// Decline the invitation
  InvitationModel decline() {
    return copyWith(
      status: InvitationStatus.declined,
      respondedAt: DateTime.now(),
    );
  }
}

