// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_count_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendRequestCountState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestCountState()';
}


}

/// @nodoc
class $FriendRequestCountStateCopyWith<$Res>  {
$FriendRequestCountStateCopyWith(FriendRequestCountState _, $Res Function(FriendRequestCountState) __);
}


/// Adds pattern-matching-related methods to [FriendRequestCountState].
extension FriendRequestCountStatePatterns on FriendRequestCountState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FriendRequestCountInitial value)?  initial,TResult Function( FriendRequestCountLoaded value)?  loaded,TResult Function( FriendRequestCountError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FriendRequestCountInitial() when initial != null:
return initial(_that);case FriendRequestCountLoaded() when loaded != null:
return loaded(_that);case FriendRequestCountError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FriendRequestCountInitial value)  initial,required TResult Function( FriendRequestCountLoaded value)  loaded,required TResult Function( FriendRequestCountError value)  error,}){
final _that = this;
switch (_that) {
case FriendRequestCountInitial():
return initial(_that);case FriendRequestCountLoaded():
return loaded(_that);case FriendRequestCountError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FriendRequestCountInitial value)?  initial,TResult? Function( FriendRequestCountLoaded value)?  loaded,TResult? Function( FriendRequestCountError value)?  error,}){
final _that = this;
switch (_that) {
case FriendRequestCountInitial() when initial != null:
return initial(_that);case FriendRequestCountLoaded() when loaded != null:
return loaded(_that);case FriendRequestCountError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( int count)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FriendRequestCountInitial() when initial != null:
return initial();case FriendRequestCountLoaded() when loaded != null:
return loaded(_that.count);case FriendRequestCountError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( int count)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case FriendRequestCountInitial():
return initial();case FriendRequestCountLoaded():
return loaded(_that.count);case FriendRequestCountError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( int count)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case FriendRequestCountInitial() when initial != null:
return initial();case FriendRequestCountLoaded() when loaded != null:
return loaded(_that.count);case FriendRequestCountError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FriendRequestCountInitial implements FriendRequestCountState {
  const FriendRequestCountInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestCountState.initial()';
}


}




/// @nodoc


class FriendRequestCountLoaded implements FriendRequestCountState {
  const FriendRequestCountLoaded({required this.count});
  

 final  int count;

/// Create a copy of FriendRequestCountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCountLoadedCopyWith<FriendRequestCountLoaded> get copyWith => _$FriendRequestCountLoadedCopyWithImpl<FriendRequestCountLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountLoaded&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode => Object.hash(runtimeType,count);

@override
String toString() {
  return 'FriendRequestCountState.loaded(count: $count)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCountLoadedCopyWith<$Res> implements $FriendRequestCountStateCopyWith<$Res> {
  factory $FriendRequestCountLoadedCopyWith(FriendRequestCountLoaded value, $Res Function(FriendRequestCountLoaded) _then) = _$FriendRequestCountLoadedCopyWithImpl;
@useResult
$Res call({
 int count
});




}
/// @nodoc
class _$FriendRequestCountLoadedCopyWithImpl<$Res>
    implements $FriendRequestCountLoadedCopyWith<$Res> {
  _$FriendRequestCountLoadedCopyWithImpl(this._self, this._then);

  final FriendRequestCountLoaded _self;
  final $Res Function(FriendRequestCountLoaded) _then;

/// Create a copy of FriendRequestCountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? count = null,}) {
  return _then(FriendRequestCountLoaded(
count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FriendRequestCountError implements FriendRequestCountState {
  const FriendRequestCountError({required this.message});
  

 final  String message;

/// Create a copy of FriendRequestCountState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCountErrorCopyWith<FriendRequestCountError> get copyWith => _$FriendRequestCountErrorCopyWithImpl<FriendRequestCountError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FriendRequestCountState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCountErrorCopyWith<$Res> implements $FriendRequestCountStateCopyWith<$Res> {
  factory $FriendRequestCountErrorCopyWith(FriendRequestCountError value, $Res Function(FriendRequestCountError) _then) = _$FriendRequestCountErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FriendRequestCountErrorCopyWithImpl<$Res>
    implements $FriendRequestCountErrorCopyWith<$Res> {
  _$FriendRequestCountErrorCopyWithImpl(this._self, this._then);

  final FriendRequestCountError _self;
  final $Res Function(FriendRequestCountError) _then;

/// Create a copy of FriendRequestCountState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FriendRequestCountError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
