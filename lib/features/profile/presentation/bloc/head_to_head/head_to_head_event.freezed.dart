// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_to_head_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeadToHeadEvent {

 String get userId; String get opponentId;
/// Create a copy of HeadToHeadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadEventCopyWith<HeadToHeadEvent> get copyWith => _$HeadToHeadEventCopyWithImpl<HeadToHeadEvent>(this as HeadToHeadEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadEvent&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,opponentId);

@override
String toString() {
  return 'HeadToHeadEvent(userId: $userId, opponentId: $opponentId)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadEventCopyWith<$Res>  {
  factory $HeadToHeadEventCopyWith(HeadToHeadEvent value, $Res Function(HeadToHeadEvent) _then) = _$HeadToHeadEventCopyWithImpl;
@useResult
$Res call({
 String userId, String opponentId
});




}
/// @nodoc
class _$HeadToHeadEventCopyWithImpl<$Res>
    implements $HeadToHeadEventCopyWith<$Res> {
  _$HeadToHeadEventCopyWithImpl(this._self, this._then);

  final HeadToHeadEvent _self;
  final $Res Function(HeadToHeadEvent) _then;

/// Create a copy of HeadToHeadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? opponentId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadToHeadEvent].
extension HeadToHeadEventPatterns on HeadToHeadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadHeadToHead value)?  loadHeadToHead,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadHeadToHead() when loadHeadToHead != null:
return loadHeadToHead(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadHeadToHead value)  loadHeadToHead,}){
final _that = this;
switch (_that) {
case LoadHeadToHead():
return loadHeadToHead(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadHeadToHead value)?  loadHeadToHead,}){
final _that = this;
switch (_that) {
case LoadHeadToHead() when loadHeadToHead != null:
return loadHeadToHead(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  String opponentId)?  loadHeadToHead,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadHeadToHead() when loadHeadToHead != null:
return loadHeadToHead(_that.userId,_that.opponentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  String opponentId)  loadHeadToHead,}) {final _that = this;
switch (_that) {
case LoadHeadToHead():
return loadHeadToHead(_that.userId,_that.opponentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  String opponentId)?  loadHeadToHead,}) {final _that = this;
switch (_that) {
case LoadHeadToHead() when loadHeadToHead != null:
return loadHeadToHead(_that.userId,_that.opponentId);case _:
  return null;

}
}

}

/// @nodoc


class LoadHeadToHead implements HeadToHeadEvent {
  const LoadHeadToHead({required this.userId, required this.opponentId});
  

@override final  String userId;
@override final  String opponentId;

/// Create a copy of HeadToHeadEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadHeadToHeadCopyWith<LoadHeadToHead> get copyWith => _$LoadHeadToHeadCopyWithImpl<LoadHeadToHead>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadHeadToHead&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,opponentId);

@override
String toString() {
  return 'HeadToHeadEvent.loadHeadToHead(userId: $userId, opponentId: $opponentId)';
}


}

/// @nodoc
abstract mixin class $LoadHeadToHeadCopyWith<$Res> implements $HeadToHeadEventCopyWith<$Res> {
  factory $LoadHeadToHeadCopyWith(LoadHeadToHead value, $Res Function(LoadHeadToHead) _then) = _$LoadHeadToHeadCopyWithImpl;
@override @useResult
$Res call({
 String userId, String opponentId
});




}
/// @nodoc
class _$LoadHeadToHeadCopyWithImpl<$Res>
    implements $LoadHeadToHeadCopyWith<$Res> {
  _$LoadHeadToHeadCopyWithImpl(this._self, this._then);

  final LoadHeadToHead _self;
  final $Res Function(LoadHeadToHead) _then;

/// Create a copy of HeadToHeadEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? opponentId = null,}) {
  return _then(LoadHeadToHead(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
