// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendshipEntity {

 String get id; String get initiatorId; String get recipientId; String get initiatorName; String get recipientName; FriendshipStatus get status; DateTime get createdAt; DateTime get updatedAt;
/// Create a copy of FriendshipEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendshipEntityCopyWith<FriendshipEntity> get copyWith => _$FriendshipEntityCopyWithImpl<FriendshipEntity>(this as FriendshipEntity, _$identity);

  /// Serializes this FriendshipEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendshipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.initiatorName, initiatorName) || other.initiatorName == initiatorName)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initiatorId,recipientId,initiatorName,recipientName,status,createdAt,updatedAt);

@override
String toString() {
  return 'FriendshipEntity(id: $id, initiatorId: $initiatorId, recipientId: $recipientId, initiatorName: $initiatorName, recipientName: $recipientName, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $FriendshipEntityCopyWith<$Res>  {
  factory $FriendshipEntityCopyWith(FriendshipEntity value, $Res Function(FriendshipEntity) _then) = _$FriendshipEntityCopyWithImpl;
@useResult
$Res call({
 String id, String initiatorId, String recipientId, String initiatorName, String recipientName, FriendshipStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class _$FriendshipEntityCopyWithImpl<$Res>
    implements $FriendshipEntityCopyWith<$Res> {
  _$FriendshipEntityCopyWithImpl(this._self, this._then);

  final FriendshipEntity _self;
  final $Res Function(FriendshipEntity) _then;

/// Create a copy of FriendshipEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? initiatorId = null,Object? recipientId = null,Object? initiatorName = null,Object? recipientName = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,initiatorName: null == initiatorName ? _self.initiatorName : initiatorName // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendshipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendshipEntity].
extension FriendshipEntityPatterns on FriendshipEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendshipEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendshipEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendshipEntity value)  $default,){
final _that = this;
switch (_that) {
case _FriendshipEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendshipEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FriendshipEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String initiatorId,  String recipientId,  String initiatorName,  String recipientName,  FriendshipStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendshipEntity() when $default != null:
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.initiatorName,_that.recipientName,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String initiatorId,  String recipientId,  String initiatorName,  String recipientName,  FriendshipStatus status,  DateTime createdAt,  DateTime updatedAt)  $default,) {final _that = this;
switch (_that) {
case _FriendshipEntity():
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.initiatorName,_that.recipientName,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String initiatorId,  String recipientId,  String initiatorName,  String recipientName,  FriendshipStatus status,  DateTime createdAt,  DateTime updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _FriendshipEntity() when $default != null:
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.initiatorName,_that.recipientName,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendshipEntity implements FriendshipEntity {
  const _FriendshipEntity({required this.id, required this.initiatorId, required this.recipientId, required this.initiatorName, required this.recipientName, required this.status, required this.createdAt, required this.updatedAt});
  factory _FriendshipEntity.fromJson(Map<String, dynamic> json) => _$FriendshipEntityFromJson(json);

@override final  String id;
@override final  String initiatorId;
@override final  String recipientId;
@override final  String initiatorName;
@override final  String recipientName;
@override final  FriendshipStatus status;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;

/// Create a copy of FriendshipEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendshipEntityCopyWith<_FriendshipEntity> get copyWith => __$FriendshipEntityCopyWithImpl<_FriendshipEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendshipEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendshipEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.initiatorName, initiatorName) || other.initiatorName == initiatorName)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initiatorId,recipientId,initiatorName,recipientName,status,createdAt,updatedAt);

@override
String toString() {
  return 'FriendshipEntity(id: $id, initiatorId: $initiatorId, recipientId: $recipientId, initiatorName: $initiatorName, recipientName: $recipientName, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$FriendshipEntityCopyWith<$Res> implements $FriendshipEntityCopyWith<$Res> {
  factory _$FriendshipEntityCopyWith(_FriendshipEntity value, $Res Function(_FriendshipEntity) _then) = __$FriendshipEntityCopyWithImpl;
@override @useResult
$Res call({
 String id, String initiatorId, String recipientId, String initiatorName, String recipientName, FriendshipStatus status, DateTime createdAt, DateTime updatedAt
});




}
/// @nodoc
class __$FriendshipEntityCopyWithImpl<$Res>
    implements _$FriendshipEntityCopyWith<$Res> {
  __$FriendshipEntityCopyWithImpl(this._self, this._then);

  final _FriendshipEntity _self;
  final $Res Function(_FriendshipEntity) _then;

/// Create a copy of FriendshipEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? initiatorId = null,Object? recipientId = null,Object? initiatorName = null,Object? recipientName = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_FriendshipEntity(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,initiatorName: null == initiatorName ? _self.initiatorName : initiatorName // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendshipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
