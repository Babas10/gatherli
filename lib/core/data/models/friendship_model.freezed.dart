// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendshipModel {

 String get id; String get initiatorId; String get recipientId; FriendshipStatus get status;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get updatedAt; String get initiatorName; String get recipientName;
/// Create a copy of FriendshipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendshipModelCopyWith<FriendshipModel> get copyWith => _$FriendshipModelCopyWithImpl<FriendshipModel>(this as FriendshipModel, _$identity);

  /// Serializes this FriendshipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendshipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.initiatorName, initiatorName) || other.initiatorName == initiatorName)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initiatorId,recipientId,status,createdAt,updatedAt,initiatorName,recipientName);

@override
String toString() {
  return 'FriendshipModel(id: $id, initiatorId: $initiatorId, recipientId: $recipientId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, initiatorName: $initiatorName, recipientName: $recipientName)';
}


}

/// @nodoc
abstract mixin class $FriendshipModelCopyWith<$Res>  {
  factory $FriendshipModelCopyWith(FriendshipModel value, $Res Function(FriendshipModel) _then) = _$FriendshipModelCopyWithImpl;
@useResult
$Res call({
 String id, String initiatorId, String recipientId, FriendshipStatus status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String initiatorName, String recipientName
});




}
/// @nodoc
class _$FriendshipModelCopyWithImpl<$Res>
    implements $FriendshipModelCopyWith<$Res> {
  _$FriendshipModelCopyWithImpl(this._self, this._then);

  final FriendshipModel _self;
  final $Res Function(FriendshipModel) _then;

/// Create a copy of FriendshipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? initiatorId = null,Object? recipientId = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? initiatorName = null,Object? recipientName = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendshipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,initiatorName: null == initiatorName ? _self.initiatorName : initiatorName // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendshipModel].
extension FriendshipModelPatterns on FriendshipModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendshipModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendshipModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendshipModel value)  $default,){
final _that = this;
switch (_that) {
case _FriendshipModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendshipModel value)?  $default,){
final _that = this;
switch (_that) {
case _FriendshipModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String initiatorId,  String recipientId,  FriendshipStatus status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String initiatorName,  String recipientName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendshipModel() when $default != null:
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.status,_that.createdAt,_that.updatedAt,_that.initiatorName,_that.recipientName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String initiatorId,  String recipientId,  FriendshipStatus status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String initiatorName,  String recipientName)  $default,) {final _that = this;
switch (_that) {
case _FriendshipModel():
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.status,_that.createdAt,_that.updatedAt,_that.initiatorName,_that.recipientName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String initiatorId,  String recipientId,  FriendshipStatus status, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime updatedAt,  String initiatorName,  String recipientName)?  $default,) {final _that = this;
switch (_that) {
case _FriendshipModel() when $default != null:
return $default(_that.id,_that.initiatorId,_that.recipientId,_that.status,_that.createdAt,_that.updatedAt,_that.initiatorName,_that.recipientName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendshipModel extends FriendshipModel {
  const _FriendshipModel({required this.id, required this.initiatorId, required this.recipientId, required this.status, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.updatedAt, required this.initiatorName, required this.recipientName}): super._();
  factory _FriendshipModel.fromJson(Map<String, dynamic> json) => _$FriendshipModelFromJson(json);

@override final  String id;
@override final  String initiatorId;
@override final  String recipientId;
@override final  FriendshipStatus status;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime updatedAt;
@override final  String initiatorName;
@override final  String recipientName;

/// Create a copy of FriendshipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendshipModelCopyWith<_FriendshipModel> get copyWith => __$FriendshipModelCopyWithImpl<_FriendshipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendshipModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendshipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.initiatorId, initiatorId) || other.initiatorId == initiatorId)&&(identical(other.recipientId, recipientId) || other.recipientId == recipientId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.initiatorName, initiatorName) || other.initiatorName == initiatorName)&&(identical(other.recipientName, recipientName) || other.recipientName == recipientName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,initiatorId,recipientId,status,createdAt,updatedAt,initiatorName,recipientName);

@override
String toString() {
  return 'FriendshipModel(id: $id, initiatorId: $initiatorId, recipientId: $recipientId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, initiatorName: $initiatorName, recipientName: $recipientName)';
}


}

/// @nodoc
abstract mixin class _$FriendshipModelCopyWith<$Res> implements $FriendshipModelCopyWith<$Res> {
  factory _$FriendshipModelCopyWith(_FriendshipModel value, $Res Function(_FriendshipModel) _then) = __$FriendshipModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String initiatorId, String recipientId, FriendshipStatus status,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime updatedAt, String initiatorName, String recipientName
});




}
/// @nodoc
class __$FriendshipModelCopyWithImpl<$Res>
    implements _$FriendshipModelCopyWith<$Res> {
  __$FriendshipModelCopyWithImpl(this._self, this._then);

  final _FriendshipModel _self;
  final $Res Function(_FriendshipModel) _then;

/// Create a copy of FriendshipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? initiatorId = null,Object? recipientId = null,Object? status = null,Object? createdAt = null,Object? updatedAt = null,Object? initiatorName = null,Object? recipientName = null,}) {
  return _then(_FriendshipModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,initiatorId: null == initiatorId ? _self.initiatorId : initiatorId // ignore: cast_nullable_to_non_nullable
as String,recipientId: null == recipientId ? _self.recipientId : recipientId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendshipStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,initiatorName: null == initiatorName ? _self.initiatorName : initiatorName // ignore: cast_nullable_to_non_nullable
as String,recipientName: null == recipientName ? _self.recipientName : recipientName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
