// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'invitation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InvitationModel {

 String get id; InvitationType get type; String get invitedBy; String get inviterName; String get invitedUserId; InvitationStatus get status;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get respondedAt;@NullableTimestampConverter() DateTime? get expiresAt;// Group context (set when type == group)
 String? get groupId; String? get groupName;// Game context (set when type == game)
 String? get gameId; String? get gameTitle;@NullableTimestampConverter() DateTime? get gameScheduledAt; String? get gameLocationName;
/// Create a copy of InvitationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InvitationModelCopyWith<InvitationModel> get copyWith => _$InvitationModelCopyWithImpl<InvitationModel>(this as InvitationModel, _$identity);

  /// Serializes this InvitationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InvitationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.inviterName, inviterName) || other.inviterName == inviterName)&&(identical(other.invitedUserId, invitedUserId) || other.invitedUserId == invitedUserId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.gameTitle, gameTitle) || other.gameTitle == gameTitle)&&(identical(other.gameScheduledAt, gameScheduledAt) || other.gameScheduledAt == gameScheduledAt)&&(identical(other.gameLocationName, gameLocationName) || other.gameLocationName == gameLocationName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,invitedBy,inviterName,invitedUserId,status,createdAt,respondedAt,expiresAt,groupId,groupName,gameId,gameTitle,gameScheduledAt,gameLocationName);

@override
String toString() {
  return 'InvitationModel(id: $id, type: $type, invitedBy: $invitedBy, inviterName: $inviterName, invitedUserId: $invitedUserId, status: $status, createdAt: $createdAt, respondedAt: $respondedAt, expiresAt: $expiresAt, groupId: $groupId, groupName: $groupName, gameId: $gameId, gameTitle: $gameTitle, gameScheduledAt: $gameScheduledAt, gameLocationName: $gameLocationName)';
}


}

/// @nodoc
abstract mixin class $InvitationModelCopyWith<$Res>  {
  factory $InvitationModelCopyWith(InvitationModel value, $Res Function(InvitationModel) _then) = _$InvitationModelCopyWithImpl;
@useResult
$Res call({
 String id, InvitationType type, String invitedBy, String inviterName, String invitedUserId, InvitationStatus status,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? respondedAt,@NullableTimestampConverter() DateTime? expiresAt, String? groupId, String? groupName, String? gameId, String? gameTitle,@NullableTimestampConverter() DateTime? gameScheduledAt, String? gameLocationName
});




}
/// @nodoc
class _$InvitationModelCopyWithImpl<$Res>
    implements $InvitationModelCopyWith<$Res> {
  _$InvitationModelCopyWithImpl(this._self, this._then);

  final InvitationModel _self;
  final $Res Function(InvitationModel) _then;

/// Create a copy of InvitationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? invitedBy = null,Object? inviterName = null,Object? invitedUserId = null,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,Object? expiresAt = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? gameId = freezed,Object? gameTitle = freezed,Object? gameScheduledAt = freezed,Object? gameLocationName = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InvitationType,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,inviterName: null == inviterName ? _self.inviterName : inviterName // ignore: cast_nullable_to_non_nullable
as String,invitedUserId: null == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,gameId: freezed == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String?,gameTitle: freezed == gameTitle ? _self.gameTitle : gameTitle // ignore: cast_nullable_to_non_nullable
as String?,gameScheduledAt: freezed == gameScheduledAt ? _self.gameScheduledAt : gameScheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gameLocationName: freezed == gameLocationName ? _self.gameLocationName : gameLocationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InvitationModel].
extension InvitationModelPatterns on InvitationModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InvitationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InvitationModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InvitationModel value)  $default,){
final _that = this;
switch (_that) {
case _InvitationModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InvitationModel value)?  $default,){
final _that = this;
switch (_that) {
case _InvitationModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  InvitationType type,  String invitedBy,  String inviterName,  String invitedUserId,  InvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? expiresAt,  String? groupId,  String? groupName,  String? gameId,  String? gameTitle, @NullableTimestampConverter()  DateTime? gameScheduledAt,  String? gameLocationName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InvitationModel() when $default != null:
return $default(_that.id,_that.type,_that.invitedBy,_that.inviterName,_that.invitedUserId,_that.status,_that.createdAt,_that.respondedAt,_that.expiresAt,_that.groupId,_that.groupName,_that.gameId,_that.gameTitle,_that.gameScheduledAt,_that.gameLocationName);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  InvitationType type,  String invitedBy,  String inviterName,  String invitedUserId,  InvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? expiresAt,  String? groupId,  String? groupName,  String? gameId,  String? gameTitle, @NullableTimestampConverter()  DateTime? gameScheduledAt,  String? gameLocationName)  $default,) {final _that = this;
switch (_that) {
case _InvitationModel():
return $default(_that.id,_that.type,_that.invitedBy,_that.inviterName,_that.invitedUserId,_that.status,_that.createdAt,_that.respondedAt,_that.expiresAt,_that.groupId,_that.groupName,_that.gameId,_that.gameTitle,_that.gameScheduledAt,_that.gameLocationName);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  InvitationType type,  String invitedBy,  String inviterName,  String invitedUserId,  InvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? respondedAt, @NullableTimestampConverter()  DateTime? expiresAt,  String? groupId,  String? groupName,  String? gameId,  String? gameTitle, @NullableTimestampConverter()  DateTime? gameScheduledAt,  String? gameLocationName)?  $default,) {final _that = this;
switch (_that) {
case _InvitationModel() when $default != null:
return $default(_that.id,_that.type,_that.invitedBy,_that.inviterName,_that.invitedUserId,_that.status,_that.createdAt,_that.respondedAt,_that.expiresAt,_that.groupId,_that.groupName,_that.gameId,_that.gameTitle,_that.gameScheduledAt,_that.gameLocationName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InvitationModel extends InvitationModel {
  const _InvitationModel({required this.id, this.type = InvitationType.group, required this.invitedBy, required this.inviterName, required this.invitedUserId, this.status = InvitationStatus.pending, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.respondedAt, @NullableTimestampConverter() this.expiresAt, this.groupId, this.groupName, this.gameId, this.gameTitle, @NullableTimestampConverter() this.gameScheduledAt, this.gameLocationName}): super._();
  factory _InvitationModel.fromJson(Map<String, dynamic> json) => _$InvitationModelFromJson(json);

@override final  String id;
@override@JsonKey() final  InvitationType type;
@override final  String invitedBy;
@override final  String inviterName;
@override final  String invitedUserId;
@override@JsonKey() final  InvitationStatus status;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? respondedAt;
@override@NullableTimestampConverter() final  DateTime? expiresAt;
// Group context (set when type == group)
@override final  String? groupId;
@override final  String? groupName;
// Game context (set when type == game)
@override final  String? gameId;
@override final  String? gameTitle;
@override@NullableTimestampConverter() final  DateTime? gameScheduledAt;
@override final  String? gameLocationName;

/// Create a copy of InvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InvitationModelCopyWith<_InvitationModel> get copyWith => __$InvitationModelCopyWithImpl<_InvitationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InvitationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InvitationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.invitedBy, invitedBy) || other.invitedBy == invitedBy)&&(identical(other.inviterName, inviterName) || other.inviterName == inviterName)&&(identical(other.invitedUserId, invitedUserId) || other.invitedUserId == invitedUserId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.respondedAt, respondedAt) || other.respondedAt == respondedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.groupName, groupName) || other.groupName == groupName)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.gameTitle, gameTitle) || other.gameTitle == gameTitle)&&(identical(other.gameScheduledAt, gameScheduledAt) || other.gameScheduledAt == gameScheduledAt)&&(identical(other.gameLocationName, gameLocationName) || other.gameLocationName == gameLocationName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,invitedBy,inviterName,invitedUserId,status,createdAt,respondedAt,expiresAt,groupId,groupName,gameId,gameTitle,gameScheduledAt,gameLocationName);

@override
String toString() {
  return 'InvitationModel(id: $id, type: $type, invitedBy: $invitedBy, inviterName: $inviterName, invitedUserId: $invitedUserId, status: $status, createdAt: $createdAt, respondedAt: $respondedAt, expiresAt: $expiresAt, groupId: $groupId, groupName: $groupName, gameId: $gameId, gameTitle: $gameTitle, gameScheduledAt: $gameScheduledAt, gameLocationName: $gameLocationName)';
}


}

/// @nodoc
abstract mixin class _$InvitationModelCopyWith<$Res> implements $InvitationModelCopyWith<$Res> {
  factory _$InvitationModelCopyWith(_InvitationModel value, $Res Function(_InvitationModel) _then) = __$InvitationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, InvitationType type, String invitedBy, String inviterName, String invitedUserId, InvitationStatus status,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? respondedAt,@NullableTimestampConverter() DateTime? expiresAt, String? groupId, String? groupName, String? gameId, String? gameTitle,@NullableTimestampConverter() DateTime? gameScheduledAt, String? gameLocationName
});




}
/// @nodoc
class __$InvitationModelCopyWithImpl<$Res>
    implements _$InvitationModelCopyWith<$Res> {
  __$InvitationModelCopyWithImpl(this._self, this._then);

  final _InvitationModel _self;
  final $Res Function(_InvitationModel) _then;

/// Create a copy of InvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? invitedBy = null,Object? inviterName = null,Object? invitedUserId = null,Object? status = null,Object? createdAt = null,Object? respondedAt = freezed,Object? expiresAt = freezed,Object? groupId = freezed,Object? groupName = freezed,Object? gameId = freezed,Object? gameTitle = freezed,Object? gameScheduledAt = freezed,Object? gameLocationName = freezed,}) {
  return _then(_InvitationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as InvitationType,invitedBy: null == invitedBy ? _self.invitedBy : invitedBy // ignore: cast_nullable_to_non_nullable
as String,inviterName: null == inviterName ? _self.inviterName : inviterName // ignore: cast_nullable_to_non_nullable
as String,invitedUserId: null == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as InvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,respondedAt: freezed == respondedAt ? _self.respondedAt : respondedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,groupName: freezed == groupName ? _self.groupName : groupName // ignore: cast_nullable_to_non_nullable
as String?,gameId: freezed == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String?,gameTitle: freezed == gameTitle ? _self.gameTitle : gameTitle // ignore: cast_nullable_to_non_nullable
as String?,gameScheduledAt: freezed == gameScheduledAt ? _self.gameScheduledAt : gameScheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,gameLocationName: freezed == gameLocationName ? _self.gameLocationName : gameLocationName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
