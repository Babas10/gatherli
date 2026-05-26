// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_request_count_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendRequestCountEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestCountEvent()';
}


}

/// @nodoc
class $FriendRequestCountEventCopyWith<$Res>  {
$FriendRequestCountEventCopyWith(FriendRequestCountEvent _, $Res Function(FriendRequestCountEvent) __);
}


/// Adds pattern-matching-related methods to [FriendRequestCountEvent].
extension FriendRequestCountEventPatterns on FriendRequestCountEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FriendRequestCountStartListening value)?  startListening,TResult Function( FriendRequestCountStopListening value)?  stopListening,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FriendRequestCountStartListening() when startListening != null:
return startListening(_that);case FriendRequestCountStopListening() when stopListening != null:
return stopListening(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FriendRequestCountStartListening value)  startListening,required TResult Function( FriendRequestCountStopListening value)  stopListening,}){
final _that = this;
switch (_that) {
case FriendRequestCountStartListening():
return startListening(_that);case FriendRequestCountStopListening():
return stopListening(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FriendRequestCountStartListening value)?  startListening,TResult? Function( FriendRequestCountStopListening value)?  stopListening,}){
final _that = this;
switch (_that) {
case FriendRequestCountStartListening() when startListening != null:
return startListening(_that);case FriendRequestCountStopListening() when stopListening != null:
return stopListening(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId)?  startListening,TResult Function()?  stopListening,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FriendRequestCountStartListening() when startListening != null:
return startListening(_that.userId);case FriendRequestCountStopListening() when stopListening != null:
return stopListening();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId)  startListening,required TResult Function()  stopListening,}) {final _that = this;
switch (_that) {
case FriendRequestCountStartListening():
return startListening(_that.userId);case FriendRequestCountStopListening():
return stopListening();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId)?  startListening,TResult? Function()?  stopListening,}) {final _that = this;
switch (_that) {
case FriendRequestCountStartListening() when startListening != null:
return startListening(_that.userId);case FriendRequestCountStopListening() when stopListening != null:
return stopListening();case _:
  return null;

}
}

}

/// @nodoc


class FriendRequestCountStartListening implements FriendRequestCountEvent {
  const FriendRequestCountStartListening({required this.userId});
  

 final  String userId;

/// Create a copy of FriendRequestCountEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCountStartListeningCopyWith<FriendRequestCountStartListening> get copyWith => _$FriendRequestCountStartListeningCopyWithImpl<FriendRequestCountStartListening>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountStartListening&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'FriendRequestCountEvent.startListening(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCountStartListeningCopyWith<$Res> implements $FriendRequestCountEventCopyWith<$Res> {
  factory $FriendRequestCountStartListeningCopyWith(FriendRequestCountStartListening value, $Res Function(FriendRequestCountStartListening) _then) = _$FriendRequestCountStartListeningCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$FriendRequestCountStartListeningCopyWithImpl<$Res>
    implements $FriendRequestCountStartListeningCopyWith<$Res> {
  _$FriendRequestCountStartListeningCopyWithImpl(this._self, this._then);

  final FriendRequestCountStartListening _self;
  final $Res Function(FriendRequestCountStartListening) _then;

/// Create a copy of FriendRequestCountEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(FriendRequestCountStartListening(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendRequestCountStopListening implements FriendRequestCountEvent {
  const FriendRequestCountStopListening();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCountStopListening);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendRequestCountEvent.stopListening()';
}


}




// dart format on
