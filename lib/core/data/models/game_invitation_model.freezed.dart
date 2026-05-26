// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_invitation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameInvitationModel {

 String get id; String get gameId; String get groupId; String get inviteeId; String get inviterId; GameInvitationStatus get status;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;// Optional: when the invitation expires (set to game scheduledAt by CF)
@NullableTimestampConverter() DateTime? get expiresAt;
/// Create a copy of GameInvitationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameInvitationModelCopyWith<GameInvitationModel> get copyWith => _$GameInvitationModelCopyWithImpl<GameInvitationModel>(this as GameInvitationModel, _$identity);

  /// Serializes this GameInvitationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameInvitationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.inviterId, inviterId) || other.inviterId == inviterId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gameId,groupId,inviteeId,inviterId,status,createdAt,updatedAt,expiresAt);

@override
String toString() {
  return 'GameInvitationModel(id: $id, gameId: $gameId, groupId: $groupId, inviteeId: $inviteeId, inviterId: $inviterId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $GameInvitationModelCopyWith<$Res>  {
  factory $GameInvitationModelCopyWith(GameInvitationModel value, $Res Function(GameInvitationModel) _then) = _$GameInvitationModelCopyWithImpl;
@useResult
$Res call({
 String id, String gameId, String groupId, String inviteeId, String inviterId, GameInvitationStatus status,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt,@NullableTimestampConverter() DateTime? expiresAt
});




}
/// @nodoc
class _$GameInvitationModelCopyWithImpl<$Res>
    implements $GameInvitationModelCopyWith<$Res> {
  _$GameInvitationModelCopyWithImpl(this._self, this._then);

  final GameInvitationModel _self;
  final $Res Function(GameInvitationModel) _then;

/// Create a copy of GameInvitationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? gameId = null,Object? groupId = null,Object? inviteeId = null,Object? inviterId = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,inviterId: null == inviterId ? _self.inviterId : inviterId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameInvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameInvitationModel].
extension GameInvitationModelPatterns on GameInvitationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameInvitationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameInvitationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameInvitationModel value)  $default,){
final _that = this;
switch (_that) {
case _GameInvitationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameInvitationModel value)?  $default,){
final _that = this;
switch (_that) {
case _GameInvitationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String gameId,  String groupId,  String inviteeId,  String inviterId,  GameInvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameInvitationModel() when $default != null:
return $default(_that.id,_that.gameId,_that.groupId,_that.inviteeId,_that.inviterId,_that.status,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String gameId,  String groupId,  String inviteeId,  String inviterId,  GameInvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? expiresAt)  $default,) {final _that = this;
switch (_that) {
case _GameInvitationModel():
return $default(_that.id,_that.gameId,_that.groupId,_that.inviteeId,_that.inviterId,_that.status,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String gameId,  String groupId,  String inviteeId,  String inviterId,  GameInvitationStatus status, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _GameInvitationModel() when $default != null:
return $default(_that.id,_that.gameId,_that.groupId,_that.inviteeId,_that.inviterId,_that.status,_that.createdAt,_that.updatedAt,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameInvitationModel extends GameInvitationModel {
  const _GameInvitationModel({required this.id, required this.gameId, required this.groupId, required this.inviteeId, required this.inviterId, this.status = GameInvitationStatus.pending, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt, @NullableTimestampConverter() this.expiresAt}): super._();
  factory _GameInvitationModel.fromJson(Map<String, dynamic> json) => _$GameInvitationModelFromJson(json);

@override final  String id;
@override final  String gameId;
@override final  String groupId;
@override final  String inviteeId;
@override final  String inviterId;
@override@JsonKey() final  GameInvitationStatus status;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;
// Optional: when the invitation expires (set to game scheduledAt by CF)
@override@NullableTimestampConverter() final  DateTime? expiresAt;

/// Create a copy of GameInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameInvitationModelCopyWith<_GameInvitationModel> get copyWith => __$GameInvitationModelCopyWithImpl<_GameInvitationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameInvitationModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameInvitationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.inviteeId, inviteeId) || other.inviteeId == inviteeId)&&(identical(other.inviterId, inviterId) || other.inviterId == inviterId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,gameId,groupId,inviteeId,inviterId,status,createdAt,updatedAt,expiresAt);

@override
String toString() {
  return 'GameInvitationModel(id: $id, gameId: $gameId, groupId: $groupId, inviteeId: $inviteeId, inviterId: $inviterId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$GameInvitationModelCopyWith<$Res> implements $GameInvitationModelCopyWith<$Res> {
  factory _$GameInvitationModelCopyWith(_GameInvitationModel value, $Res Function(_GameInvitationModel) _then) = __$GameInvitationModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String gameId, String groupId, String inviteeId, String inviterId, GameInvitationStatus status,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt,@NullableTimestampConverter() DateTime? expiresAt
});




}
/// @nodoc
class __$GameInvitationModelCopyWithImpl<$Res>
    implements _$GameInvitationModelCopyWith<$Res> {
  __$GameInvitationModelCopyWithImpl(this._self, this._then);

  final _GameInvitationModel _self;
  final $Res Function(_GameInvitationModel) _then;

/// Create a copy of GameInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? gameId = null,Object? groupId = null,Object? inviteeId = null,Object? inviterId = null,Object? status = null,Object? createdAt = null,Object? updatedAt = freezed,Object? expiresAt = freezed,}) {
  return _then(_GameInvitationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,inviteeId: null == inviteeId ? _self.inviteeId : inviteeId // ignore: cast_nullable_to_non_nullable
as String,inviterId: null == inviterId ? _self.inviterId : inviterId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameInvitationStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
