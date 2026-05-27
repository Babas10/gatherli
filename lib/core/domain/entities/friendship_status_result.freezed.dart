// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_status_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FriendshipStatusResult {

 bool get isFriend; bool get hasPendingRequest; String? get requestDirection;// 'sent' | 'received'
 String? get friendshipId;
/// Create a copy of FriendshipStatusResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendshipStatusResultCopyWith<FriendshipStatusResult> get copyWith => _$FriendshipStatusResultCopyWithImpl<FriendshipStatusResult>(this as FriendshipStatusResult, _$identity);

  /// Serializes this FriendshipStatusResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendshipStatusResult&&(identical(other.isFriend, isFriend) || other.isFriend == isFriend)&&(identical(other.hasPendingRequest, hasPendingRequest) || other.hasPendingRequest == hasPendingRequest)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFriend,hasPendingRequest,requestDirection,friendshipId);

@override
String toString() {
  return 'FriendshipStatusResult(isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, requestDirection: $requestDirection, friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class $FriendshipStatusResultCopyWith<$Res>  {
  factory $FriendshipStatusResultCopyWith(FriendshipStatusResult value, $Res Function(FriendshipStatusResult) _then) = _$FriendshipStatusResultCopyWithImpl;
@useResult
$Res call({
 bool isFriend, bool hasPendingRequest, String? requestDirection, String? friendshipId
});




}
/// @nodoc
class _$FriendshipStatusResultCopyWithImpl<$Res>
    implements $FriendshipStatusResultCopyWith<$Res> {
  _$FriendshipStatusResultCopyWithImpl(this._self, this._then);

  final FriendshipStatusResult _self;
  final $Res Function(FriendshipStatusResult) _then;

/// Create a copy of FriendshipStatusResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isFriend = null,Object? hasPendingRequest = null,Object? requestDirection = freezed,Object? friendshipId = freezed,}) {
  return _then(_self.copyWith(
isFriend: null == isFriend ? _self.isFriend : isFriend // ignore: cast_nullable_to_non_nullable
as bool,hasPendingRequest: null == hasPendingRequest ? _self.hasPendingRequest : hasPendingRequest // ignore: cast_nullable_to_non_nullable
as bool,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [FriendshipStatusResult].
extension FriendshipStatusResultPatterns on FriendshipStatusResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FriendshipStatusResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FriendshipStatusResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FriendshipStatusResult value)  $default,){
final _that = this;
switch (_that) {
case _FriendshipStatusResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FriendshipStatusResult value)?  $default,){
final _that = this;
switch (_that) {
case _FriendshipStatusResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String? friendshipId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FriendshipStatusResult() when $default != null:
return $default(_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.friendshipId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String? friendshipId)  $default,) {final _that = this;
switch (_that) {
case _FriendshipStatusResult():
return $default(_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.friendshipId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String? friendshipId)?  $default,) {final _that = this;
switch (_that) {
case _FriendshipStatusResult() when $default != null:
return $default(_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.friendshipId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FriendshipStatusResult implements FriendshipStatusResult {
  const _FriendshipStatusResult({required this.isFriend, required this.hasPendingRequest, this.requestDirection, this.friendshipId});
  factory _FriendshipStatusResult.fromJson(Map<String, dynamic> json) => _$FriendshipStatusResultFromJson(json);

@override final  bool isFriend;
@override final  bool hasPendingRequest;
@override final  String? requestDirection;
// 'sent' | 'received'
@override final  String? friendshipId;

/// Create a copy of FriendshipStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FriendshipStatusResultCopyWith<_FriendshipStatusResult> get copyWith => __$FriendshipStatusResultCopyWithImpl<_FriendshipStatusResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FriendshipStatusResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FriendshipStatusResult&&(identical(other.isFriend, isFriend) || other.isFriend == isFriend)&&(identical(other.hasPendingRequest, hasPendingRequest) || other.hasPendingRequest == hasPendingRequest)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,isFriend,hasPendingRequest,requestDirection,friendshipId);

@override
String toString() {
  return 'FriendshipStatusResult(isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, requestDirection: $requestDirection, friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class _$FriendshipStatusResultCopyWith<$Res> implements $FriendshipStatusResultCopyWith<$Res> {
  factory _$FriendshipStatusResultCopyWith(_FriendshipStatusResult value, $Res Function(_FriendshipStatusResult) _then) = __$FriendshipStatusResultCopyWithImpl;
@override @useResult
$Res call({
 bool isFriend, bool hasPendingRequest, String? requestDirection, String? friendshipId
});




}
/// @nodoc
class __$FriendshipStatusResultCopyWithImpl<$Res>
    implements _$FriendshipStatusResultCopyWith<$Res> {
  __$FriendshipStatusResultCopyWithImpl(this._self, this._then);

  final _FriendshipStatusResult _self;
  final $Res Function(_FriendshipStatusResult) _then;

/// Create a copy of FriendshipStatusResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isFriend = null,Object? hasPendingRequest = null,Object? requestDirection = freezed,Object? friendshipId = freezed,}) {
  return _then(_FriendshipStatusResult(
isFriend: null == isFriend ? _self.isFriend : isFriend // ignore: cast_nullable_to_non_nullable
as bool,hasPendingRequest: null == hasPendingRequest ? _self.hasPendingRequest : hasPendingRequest // ignore: cast_nullable_to_non_nullable
as bool,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,friendshipId: freezed == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
