// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserEntity {

 String get uid; String get email; String? get displayName; String? get photoUrl; bool get isEmailVerified; DateTime? get createdAt; DateTime? get lastSignInAt; List<String> get fcmTokens;// Social graph cache fields (Story 11.6)
 int get friendCount;
/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserEntityCopyWith<UserEntity> get copyWith => _$UserEntityCopyWithImpl<UserEntity>(this as UserEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSignInAt, lastSignInAt) || other.lastSignInAt == lastSignInAt)&&const DeepCollectionEquality().equals(other.fcmTokens, fcmTokens)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,isEmailVerified,createdAt,lastSignInAt,const DeepCollectionEquality().hash(fcmTokens),friendCount);

@override
String toString() {
  return 'UserEntity(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, isEmailVerified: $isEmailVerified, createdAt: $createdAt, lastSignInAt: $lastSignInAt, fcmTokens: $fcmTokens, friendCount: $friendCount)';
}


}

/// @nodoc
abstract mixin class $UserEntityCopyWith<$Res>  {
  factory $UserEntityCopyWith(UserEntity value, $Res Function(UserEntity) _then) = _$UserEntityCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, bool isEmailVerified, DateTime? createdAt, DateTime? lastSignInAt, List<String> fcmTokens, int friendCount
});




}
/// @nodoc
class _$UserEntityCopyWithImpl<$Res>
    implements $UserEntityCopyWith<$Res> {
  _$UserEntityCopyWithImpl(this._self, this._then);

  final UserEntity _self;
  final $Res Function(UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? isEmailVerified = null,Object? createdAt = freezed,Object? lastSignInAt = freezed,Object? fcmTokens = null,Object? friendCount = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInAt: freezed == lastSignInAt ? _self.lastSignInAt : lastSignInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmTokens: null == fcmTokens ? _self.fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as List<String>,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [UserEntity].
extension UserEntityPatterns on UserEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserEntity value)  $default,){
final _that = this;
switch (_that) {
case _UserEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserEntity value)?  $default,){
final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified,  DateTime? createdAt,  DateTime? lastSignInAt,  List<String> fcmTokens,  int friendCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.fcmTokens,_that.friendCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified,  DateTime? createdAt,  DateTime? lastSignInAt,  List<String> fcmTokens,  int friendCount)  $default,) {final _that = this;
switch (_that) {
case _UserEntity():
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.fcmTokens,_that.friendCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified,  DateTime? createdAt,  DateTime? lastSignInAt,  List<String> fcmTokens,  int friendCount)?  $default,) {final _that = this;
switch (_that) {
case _UserEntity() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.fcmTokens,_that.friendCount);case _:
  return null;

}
}

}

/// @nodoc


class _UserEntity extends UserEntity {
  const _UserEntity({required this.uid, required this.email, this.displayName, this.photoUrl, required this.isEmailVerified, this.createdAt, this.lastSignInAt, final  List<String> fcmTokens = const [], this.friendCount = 0}): _fcmTokens = fcmTokens,super._();
  

@override final  String uid;
@override final  String email;
@override final  String? displayName;
@override final  String? photoUrl;
@override final  bool isEmailVerified;
@override final  DateTime? createdAt;
@override final  DateTime? lastSignInAt;
 final  List<String> _fcmTokens;
@override@JsonKey() List<String> get fcmTokens {
  if (_fcmTokens is EqualUnmodifiableListView) return _fcmTokens;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fcmTokens);
}

// Social graph cache fields (Story 11.6)
@override@JsonKey() final  int friendCount;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserEntityCopyWith<_UserEntity> get copyWith => __$UserEntityCopyWithImpl<_UserEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserEntity&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSignInAt, lastSignInAt) || other.lastSignInAt == lastSignInAt)&&const DeepCollectionEquality().equals(other._fcmTokens, _fcmTokens)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount));
}


@override
int get hashCode => Object.hash(runtimeType,uid,email,displayName,photoUrl,isEmailVerified,createdAt,lastSignInAt,const DeepCollectionEquality().hash(_fcmTokens),friendCount);

@override
String toString() {
  return 'UserEntity(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, isEmailVerified: $isEmailVerified, createdAt: $createdAt, lastSignInAt: $lastSignInAt, fcmTokens: $fcmTokens, friendCount: $friendCount)';
}


}

/// @nodoc
abstract mixin class _$UserEntityCopyWith<$Res> implements $UserEntityCopyWith<$Res> {
  factory _$UserEntityCopyWith(_UserEntity value, $Res Function(_UserEntity) _then) = __$UserEntityCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, bool isEmailVerified, DateTime? createdAt, DateTime? lastSignInAt, List<String> fcmTokens, int friendCount
});




}
/// @nodoc
class __$UserEntityCopyWithImpl<$Res>
    implements _$UserEntityCopyWith<$Res> {
  __$UserEntityCopyWithImpl(this._self, this._then);

  final _UserEntity _self;
  final $Res Function(_UserEntity) _then;

/// Create a copy of UserEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? isEmailVerified = null,Object? createdAt = freezed,Object? lastSignInAt = freezed,Object? fcmTokens = null,Object? friendCount = null,}) {
  return _then(_UserEntity(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInAt: freezed == lastSignInAt ? _self.lastSignInAt : lastSignInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,fcmTokens: null == fcmTokens ? _self._fcmTokens : fcmTokens // ignore: cast_nullable_to_non_nullable
as List<String>,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
