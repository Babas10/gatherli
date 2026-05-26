// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_search_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserSearchResult {

 UserEntity? get user; bool get isFriend; bool get hasPendingRequest; String? get requestDirection;
/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSearchResultCopyWith<UserSearchResult> get copyWith => _$UserSearchResultCopyWithImpl<UserSearchResult>(this as UserSearchResult, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSearchResult&&(identical(other.user, user) || other.user == user)&&(identical(other.isFriend, isFriend) || other.isFriend == isFriend)&&(identical(other.hasPendingRequest, hasPendingRequest) || other.hasPendingRequest == hasPendingRequest)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}


@override
int get hashCode => Object.hash(runtimeType,user,isFriend,hasPendingRequest,requestDirection);

@override
String toString() {
  return 'UserSearchResult(user: $user, isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class $UserSearchResultCopyWith<$Res>  {
  factory $UserSearchResultCopyWith(UserSearchResult value, $Res Function(UserSearchResult) _then) = _$UserSearchResultCopyWithImpl;
@useResult
$Res call({
 UserEntity? user, bool isFriend, bool hasPendingRequest, String? requestDirection
});


$UserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class _$UserSearchResultCopyWithImpl<$Res>
    implements $UserSearchResultCopyWith<$Res> {
  _$UserSearchResultCopyWithImpl(this._self, this._then);

  final UserSearchResult _self;
  final $Res Function(UserSearchResult) _then;

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = freezed,Object? isFriend = null,Object? hasPendingRequest = null,Object? requestDirection = freezed,}) {
  return _then(_self.copyWith(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,isFriend: null == isFriend ? _self.isFriend : isFriend // ignore: cast_nullable_to_non_nullable
as bool,hasPendingRequest: null == hasPendingRequest ? _self.hasPendingRequest : hasPendingRequest // ignore: cast_nullable_to_non_nullable
as bool,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserSearchResult].
extension UserSearchResultPatterns on UserSearchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSearchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSearchResult value)  $default,){
final _that = this;
switch (_that) {
case _UserSearchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSearchResult value)?  $default,){
final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
return $default(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection)  $default,) {final _that = this;
switch (_that) {
case _UserSearchResult():
return $default(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection)?  $default,) {final _that = this;
switch (_that) {
case _UserSearchResult() when $default != null:
return $default(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection);case _:
  return null;

}
}

}

/// @nodoc


class _UserSearchResult implements UserSearchResult {
  const _UserSearchResult({this.user, required this.isFriend, required this.hasPendingRequest, this.requestDirection});
  

@override final  UserEntity? user;
@override final  bool isFriend;
@override final  bool hasPendingRequest;
@override final  String? requestDirection;

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSearchResultCopyWith<_UserSearchResult> get copyWith => __$UserSearchResultCopyWithImpl<_UserSearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSearchResult&&(identical(other.user, user) || other.user == user)&&(identical(other.isFriend, isFriend) || other.isFriend == isFriend)&&(identical(other.hasPendingRequest, hasPendingRequest) || other.hasPendingRequest == hasPendingRequest)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection));
}


@override
int get hashCode => Object.hash(runtimeType,user,isFriend,hasPendingRequest,requestDirection);

@override
String toString() {
  return 'UserSearchResult(user: $user, isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, requestDirection: $requestDirection)';
}


}

/// @nodoc
abstract mixin class _$UserSearchResultCopyWith<$Res> implements $UserSearchResultCopyWith<$Res> {
  factory _$UserSearchResultCopyWith(_UserSearchResult value, $Res Function(_UserSearchResult) _then) = __$UserSearchResultCopyWithImpl;
@override @useResult
$Res call({
 UserEntity? user, bool isFriend, bool hasPendingRequest, String? requestDirection
});


@override $UserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class __$UserSearchResultCopyWithImpl<$Res>
    implements _$UserSearchResultCopyWith<$Res> {
  __$UserSearchResultCopyWithImpl(this._self, this._then);

  final _UserSearchResult _self;
  final $Res Function(_UserSearchResult) _then;

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? isFriend = null,Object? hasPendingRequest = null,Object? requestDirection = freezed,}) {
  return _then(_UserSearchResult(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,isFriend: null == isFriend ? _self.isFriend : isFriend // ignore: cast_nullable_to_non_nullable
as bool,hasPendingRequest: null == hasPendingRequest ? _self.hasPendingRequest : hasPendingRequest // ignore: cast_nullable_to_non_nullable
as bool,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of UserSearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
