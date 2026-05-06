// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

InvitationModel _$InvitationModelFromJson(Map<String, dynamic> json) {
  return _InvitationModel.fromJson(json);
}

/// @nodoc
mixin _$InvitationModel {
  String get id => throw _privateConstructorUsedError;
  InvitationType get type => throw _privateConstructorUsedError;
  String get invitedBy => throw _privateConstructorUsedError;
  String get inviterName => throw _privateConstructorUsedError;
  String get invitedUserId => throw _privateConstructorUsedError;
  InvitationStatus get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get respondedAt => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get expiresAt => throw _privateConstructorUsedError; // Group context (set when type == group)
  String? get groupId => throw _privateConstructorUsedError;
  String? get groupName =>
      throw _privateConstructorUsedError; // Game context (set when type == game)
  String? get gameId => throw _privateConstructorUsedError;
  String? get gameTitle => throw _privateConstructorUsedError;
  @NullableTimestampConverter()
  DateTime? get gameScheduledAt => throw _privateConstructorUsedError;
  String? get gameLocationName => throw _privateConstructorUsedError;

  /// Serializes this InvitationModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $InvitationModelCopyWith<InvitationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InvitationModelCopyWith<$Res> {
  factory $InvitationModelCopyWith(
    InvitationModel value,
    $Res Function(InvitationModel) then,
  ) = _$InvitationModelCopyWithImpl<$Res, InvitationModel>;
  @useResult
  $Res call({
    String id,
    InvitationType type,
    String invitedBy,
    String inviterName,
    String invitedUserId,
    InvitationStatus status,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? respondedAt,
    @NullableTimestampConverter() DateTime? expiresAt,
    String? groupId,
    String? groupName,
    String? gameId,
    String? gameTitle,
    @NullableTimestampConverter() DateTime? gameScheduledAt,
    String? gameLocationName,
  });
}

/// @nodoc
class _$InvitationModelCopyWithImpl<$Res, $Val extends InvitationModel>
    implements $InvitationModelCopyWith<$Res> {
  _$InvitationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? invitedBy = null,
    Object? inviterName = null,
    Object? invitedUserId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
    Object? expiresAt = freezed,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? gameId = freezed,
    Object? gameTitle = freezed,
    Object? gameScheduledAt = freezed,
    Object? gameLocationName = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as InvitationType,
            invitedBy: null == invitedBy
                ? _value.invitedBy
                : invitedBy // ignore: cast_nullable_to_non_nullable
                      as String,
            inviterName: null == inviterName
                ? _value.inviterName
                : inviterName // ignore: cast_nullable_to_non_nullable
                      as String,
            invitedUserId: null == invitedUserId
                ? _value.invitedUserId
                : invitedUserId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as InvitationStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            respondedAt: freezed == respondedAt
                ? _value.respondedAt
                : respondedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            expiresAt: freezed == expiresAt
                ? _value.expiresAt
                : expiresAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            groupId: freezed == groupId
                ? _value.groupId
                : groupId // ignore: cast_nullable_to_non_nullable
                      as String?,
            groupName: freezed == groupName
                ? _value.groupName
                : groupName // ignore: cast_nullable_to_non_nullable
                      as String?,
            gameId: freezed == gameId
                ? _value.gameId
                : gameId // ignore: cast_nullable_to_non_nullable
                      as String?,
            gameTitle: freezed == gameTitle
                ? _value.gameTitle
                : gameTitle // ignore: cast_nullable_to_non_nullable
                      as String?,
            gameScheduledAt: freezed == gameScheduledAt
                ? _value.gameScheduledAt
                : gameScheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            gameLocationName: freezed == gameLocationName
                ? _value.gameLocationName
                : gameLocationName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$InvitationModelImplCopyWith<$Res>
    implements $InvitationModelCopyWith<$Res> {
  factory _$$InvitationModelImplCopyWith(
    _$InvitationModelImpl value,
    $Res Function(_$InvitationModelImpl) then,
  ) = __$$InvitationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    InvitationType type,
    String invitedBy,
    String inviterName,
    String invitedUserId,
    InvitationStatus status,
    @TimestampConverter() DateTime createdAt,
    @NullableTimestampConverter() DateTime? respondedAt,
    @NullableTimestampConverter() DateTime? expiresAt,
    String? groupId,
    String? groupName,
    String? gameId,
    String? gameTitle,
    @NullableTimestampConverter() DateTime? gameScheduledAt,
    String? gameLocationName,
  });
}

/// @nodoc
class __$$InvitationModelImplCopyWithImpl<$Res>
    extends _$InvitationModelCopyWithImpl<$Res, _$InvitationModelImpl>
    implements _$$InvitationModelImplCopyWith<$Res> {
  __$$InvitationModelImplCopyWithImpl(
    _$InvitationModelImpl _value,
    $Res Function(_$InvitationModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? invitedBy = null,
    Object? inviterName = null,
    Object? invitedUserId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? respondedAt = freezed,
    Object? expiresAt = freezed,
    Object? groupId = freezed,
    Object? groupName = freezed,
    Object? gameId = freezed,
    Object? gameTitle = freezed,
    Object? gameScheduledAt = freezed,
    Object? gameLocationName = freezed,
  }) {
    return _then(
      _$InvitationModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as InvitationType,
        invitedBy: null == invitedBy
            ? _value.invitedBy
            : invitedBy // ignore: cast_nullable_to_non_nullable
                  as String,
        inviterName: null == inviterName
            ? _value.inviterName
            : inviterName // ignore: cast_nullable_to_non_nullable
                  as String,
        invitedUserId: null == invitedUserId
            ? _value.invitedUserId
            : invitedUserId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as InvitationStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        respondedAt: freezed == respondedAt
            ? _value.respondedAt
            : respondedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        expiresAt: freezed == expiresAt
            ? _value.expiresAt
            : expiresAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        groupId: freezed == groupId
            ? _value.groupId
            : groupId // ignore: cast_nullable_to_non_nullable
                  as String?,
        groupName: freezed == groupName
            ? _value.groupName
            : groupName // ignore: cast_nullable_to_non_nullable
                  as String?,
        gameId: freezed == gameId
            ? _value.gameId
            : gameId // ignore: cast_nullable_to_non_nullable
                  as String?,
        gameTitle: freezed == gameTitle
            ? _value.gameTitle
            : gameTitle // ignore: cast_nullable_to_non_nullable
                  as String?,
        gameScheduledAt: freezed == gameScheduledAt
            ? _value.gameScheduledAt
            : gameScheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        gameLocationName: freezed == gameLocationName
            ? _value.gameLocationName
            : gameLocationName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$InvitationModelImpl extends _InvitationModel {
  const _$InvitationModelImpl({
    required this.id,
    this.type = InvitationType.group,
    required this.invitedBy,
    required this.inviterName,
    required this.invitedUserId,
    this.status = InvitationStatus.pending,
    @TimestampConverter() required this.createdAt,
    @NullableTimestampConverter() this.respondedAt,
    @NullableTimestampConverter() this.expiresAt,
    this.groupId,
    this.groupName,
    this.gameId,
    this.gameTitle,
    @NullableTimestampConverter() this.gameScheduledAt,
    this.gameLocationName,
  }) : super._();

  factory _$InvitationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$InvitationModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey()
  final InvitationType type;
  @override
  final String invitedBy;
  @override
  final String inviterName;
  @override
  final String invitedUserId;
  @override
  @JsonKey()
  final InvitationStatus status;
  @override
  @TimestampConverter()
  final DateTime createdAt;
  @override
  @NullableTimestampConverter()
  final DateTime? respondedAt;
  @override
  @NullableTimestampConverter()
  final DateTime? expiresAt;
  // Group context (set when type == group)
  @override
  final String? groupId;
  @override
  final String? groupName;
  // Game context (set when type == game)
  @override
  final String? gameId;
  @override
  final String? gameTitle;
  @override
  @NullableTimestampConverter()
  final DateTime? gameScheduledAt;
  @override
  final String? gameLocationName;

  @override
  String toString() {
    return 'InvitationModel(id: $id, type: $type, invitedBy: $invitedBy, inviterName: $inviterName, invitedUserId: $invitedUserId, status: $status, createdAt: $createdAt, respondedAt: $respondedAt, expiresAt: $expiresAt, groupId: $groupId, groupName: $groupName, gameId: $gameId, gameTitle: $gameTitle, gameScheduledAt: $gameScheduledAt, gameLocationName: $gameLocationName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InvitationModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.invitedBy, invitedBy) ||
                other.invitedBy == invitedBy) &&
            (identical(other.inviterName, inviterName) ||
                other.inviterName == inviterName) &&
            (identical(other.invitedUserId, invitedUserId) ||
                other.invitedUserId == invitedUserId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.respondedAt, respondedAt) ||
                other.respondedAt == respondedAt) &&
            (identical(other.expiresAt, expiresAt) ||
                other.expiresAt == expiresAt) &&
            (identical(other.groupId, groupId) || other.groupId == groupId) &&
            (identical(other.groupName, groupName) ||
                other.groupName == groupName) &&
            (identical(other.gameId, gameId) || other.gameId == gameId) &&
            (identical(other.gameTitle, gameTitle) ||
                other.gameTitle == gameTitle) &&
            (identical(other.gameScheduledAt, gameScheduledAt) ||
                other.gameScheduledAt == gameScheduledAt) &&
            (identical(other.gameLocationName, gameLocationName) ||
                other.gameLocationName == gameLocationName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    type,
    invitedBy,
    inviterName,
    invitedUserId,
    status,
    createdAt,
    respondedAt,
    expiresAt,
    groupId,
    groupName,
    gameId,
    gameTitle,
    gameScheduledAt,
    gameLocationName,
  );

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      __$$InvitationModelImplCopyWithImpl<_$InvitationModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$InvitationModelImplToJson(this);
  }
}

abstract class _InvitationModel extends InvitationModel {
  const factory _InvitationModel({
    required final String id,
    final InvitationType type,
    required final String invitedBy,
    required final String inviterName,
    required final String invitedUserId,
    final InvitationStatus status,
    @TimestampConverter() required final DateTime createdAt,
    @NullableTimestampConverter() final DateTime? respondedAt,
    @NullableTimestampConverter() final DateTime? expiresAt,
    final String? groupId,
    final String? groupName,
    final String? gameId,
    final String? gameTitle,
    @NullableTimestampConverter() final DateTime? gameScheduledAt,
    final String? gameLocationName,
  }) = _$InvitationModelImpl;
  const _InvitationModel._() : super._();

  factory _InvitationModel.fromJson(Map<String, dynamic> json) =
      _$InvitationModelImpl.fromJson;

  @override
  String get id;
  @override
  InvitationType get type;
  @override
  String get invitedBy;
  @override
  String get inviterName;
  @override
  String get invitedUserId;
  @override
  InvitationStatus get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;
  @override
  @NullableTimestampConverter()
  DateTime? get respondedAt;
  @override
  @NullableTimestampConverter()
  DateTime? get expiresAt; // Group context (set when type == group)
  @override
  String? get groupId;
  @override
  String? get groupName; // Game context (set when type == game)
  @override
  String? get gameId;
  @override
  String? get gameTitle;
  @override
  @NullableTimestampConverter()
  DateTime? get gameScheduledAt;
  @override
  String? get gameLocationName;

  /// Create a copy of InvitationModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$InvitationModelImplCopyWith<_$InvitationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
