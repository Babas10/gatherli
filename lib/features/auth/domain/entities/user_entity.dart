import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_entity.freezed.dart';

@freezed
class UserEntity with _$UserEntity {
  const factory UserEntity({
    required String uid,
    required String email,
    String? displayName,
    String? photoUrl,
    required bool isEmailVerified,
    DateTime? createdAt,
    DateTime? lastSignInAt,
    @Default([]) List<String> fcmTokens,
    // Social graph cache fields (Story 11.6)
    @Default(0) int friendCount,
  }) = _UserEntity;

  const UserEntity._();

  /// Check if the user has a complete profile
  bool get hasCompleteProfile => displayName != null && displayName!.isNotEmpty;

  /// Get display name or fallback to email
  String get displayNameOrEmail => displayName ?? email;
}
