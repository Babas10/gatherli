// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_invite_link_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupInviteLinkModel {

 String get id; String get token; String get createdBy;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get expiresAt; bool get revoked; int? get usageLimit; int get usageCount; String get groupId; String get inviteType;
/// Create a copy of GroupInviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupInviteLinkModelCopyWith<GroupInviteLinkModel> get copyWith => _$GroupInviteLinkModelCopyWithImpl<GroupInviteLinkModel>(this as GroupInviteLinkModel, _$identity);

  /// Serializes this GroupInviteLinkModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupInviteLinkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.inviteType, inviteType) || other.inviteType == inviteType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,createdBy,createdAt,expiresAt,revoked,usageLimit,usageCount,groupId,inviteType);

@override
String toString() {
  return 'GroupInviteLinkModel(id: $id, token: $token, createdBy: $createdBy, createdAt: $createdAt, expiresAt: $expiresAt, revoked: $revoked, usageLimit: $usageLimit, usageCount: $usageCount, groupId: $groupId, inviteType: $inviteType)';
}


}

/// @nodoc
abstract mixin class $GroupInviteLinkModelCopyWith<$Res>  {
  factory $GroupInviteLinkModelCopyWith(GroupInviteLinkModel value, $Res Function(GroupInviteLinkModel) _then) = _$GroupInviteLinkModelCopyWithImpl;
@useResult
$Res call({
 String id, String token, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? expiresAt, bool revoked, int? usageLimit, int usageCount, String groupId, String inviteType
});




}
/// @nodoc
class _$GroupInviteLinkModelCopyWithImpl<$Res>
    implements $GroupInviteLinkModelCopyWith<$Res> {
  _$GroupInviteLinkModelCopyWithImpl(this._self, this._then);

  final GroupInviteLinkModel _self;
  final $Res Function(GroupInviteLinkModel) _then;

/// Create a copy of GroupInviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? token = null,Object? createdBy = null,Object? createdAt = null,Object? expiresAt = freezed,Object? revoked = null,Object? usageLimit = freezed,Object? usageCount = null,Object? groupId = null,Object? inviteType = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,usageLimit: freezed == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int?,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,inviteType: null == inviteType ? _self.inviteType : inviteType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupInviteLinkModel].
extension GroupInviteLinkModelPatterns on GroupInviteLinkModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupInviteLinkModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupInviteLinkModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupInviteLinkModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupInviteLinkModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupInviteLinkModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupInviteLinkModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String token,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? expiresAt,  bool revoked,  int? usageLimit,  int usageCount,  String groupId,  String inviteType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupInviteLinkModel() when $default != null:
return $default(_that.id,_that.token,_that.createdBy,_that.createdAt,_that.expiresAt,_that.revoked,_that.usageLimit,_that.usageCount,_that.groupId,_that.inviteType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String token,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? expiresAt,  bool revoked,  int? usageLimit,  int usageCount,  String groupId,  String inviteType)  $default,) {final _that = this;
switch (_that) {
case _GroupInviteLinkModel():
return $default(_that.id,_that.token,_that.createdBy,_that.createdAt,_that.expiresAt,_that.revoked,_that.usageLimit,_that.usageCount,_that.groupId,_that.inviteType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String token,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? expiresAt,  bool revoked,  int? usageLimit,  int usageCount,  String groupId,  String inviteType)?  $default,) {final _that = this;
switch (_that) {
case _GroupInviteLinkModel() when $default != null:
return $default(_that.id,_that.token,_that.createdBy,_that.createdAt,_that.expiresAt,_that.revoked,_that.usageLimit,_that.usageCount,_that.groupId,_that.inviteType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupInviteLinkModel extends GroupInviteLinkModel {
  const _GroupInviteLinkModel({required this.id, required this.token, required this.createdBy, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.expiresAt, this.revoked = false, this.usageLimit, this.usageCount = 0, required this.groupId, this.inviteType = 'group_link'}): super._();
  factory _GroupInviteLinkModel.fromJson(Map<String, dynamic> json) => _$GroupInviteLinkModelFromJson(json);

@override final  String id;
@override final  String token;
@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? expiresAt;
@override@JsonKey() final  bool revoked;
@override final  int? usageLimit;
@override@JsonKey() final  int usageCount;
@override final  String groupId;
@override@JsonKey() final  String inviteType;

/// Create a copy of GroupInviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupInviteLinkModelCopyWith<_GroupInviteLinkModel> get copyWith => __$GroupInviteLinkModelCopyWithImpl<_GroupInviteLinkModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupInviteLinkModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupInviteLinkModel&&(identical(other.id, id) || other.id == id)&&(identical(other.token, token) || other.token == token)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.revoked, revoked) || other.revoked == revoked)&&(identical(other.usageLimit, usageLimit) || other.usageLimit == usageLimit)&&(identical(other.usageCount, usageCount) || other.usageCount == usageCount)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.inviteType, inviteType) || other.inviteType == inviteType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,token,createdBy,createdAt,expiresAt,revoked,usageLimit,usageCount,groupId,inviteType);

@override
String toString() {
  return 'GroupInviteLinkModel(id: $id, token: $token, createdBy: $createdBy, createdAt: $createdAt, expiresAt: $expiresAt, revoked: $revoked, usageLimit: $usageLimit, usageCount: $usageCount, groupId: $groupId, inviteType: $inviteType)';
}


}

/// @nodoc
abstract mixin class _$GroupInviteLinkModelCopyWith<$Res> implements $GroupInviteLinkModelCopyWith<$Res> {
  factory _$GroupInviteLinkModelCopyWith(_GroupInviteLinkModel value, $Res Function(_GroupInviteLinkModel) _then) = __$GroupInviteLinkModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String token, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? expiresAt, bool revoked, int? usageLimit, int usageCount, String groupId, String inviteType
});




}
/// @nodoc
class __$GroupInviteLinkModelCopyWithImpl<$Res>
    implements _$GroupInviteLinkModelCopyWith<$Res> {
  __$GroupInviteLinkModelCopyWithImpl(this._self, this._then);

  final _GroupInviteLinkModel _self;
  final $Res Function(_GroupInviteLinkModel) _then;

/// Create a copy of GroupInviteLinkModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? token = null,Object? createdBy = null,Object? createdAt = null,Object? expiresAt = freezed,Object? revoked = null,Object? usageLimit = freezed,Object? usageCount = null,Object? groupId = null,Object? inviteType = null,}) {
  return _then(_GroupInviteLinkModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,token: null == token ? _self.token : token // ignore: cast_nullable_to_non_nullable
as String,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,revoked: null == revoked ? _self.revoked : revoked // ignore: cast_nullable_to_non_nullable
as bool,usageLimit: freezed == usageLimit ? _self.usageLimit : usageLimit // ignore: cast_nullable_to_non_nullable
as int?,usageCount: null == usageCount ? _self.usageCount : usageCount // ignore: cast_nullable_to_non_nullable
as int,groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,inviteType: null == inviteType ? _self.inviteType : inviteType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
