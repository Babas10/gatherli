// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_to_head_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HeadToHeadState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HeadToHeadState()';
}


}

/// @nodoc
class $HeadToHeadStateCopyWith<$Res>  {
$HeadToHeadStateCopyWith(HeadToHeadState _, $Res Function(HeadToHeadState) __);
}


/// Adds pattern-matching-related methods to [HeadToHeadState].
extension HeadToHeadStatePatterns on HeadToHeadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( HeadToHeadInitial value)?  initial,TResult Function( HeadToHeadLoading value)?  loading,TResult Function( HeadToHeadLoaded value)?  loaded,TResult Function( HeadToHeadError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case HeadToHeadInitial() when initial != null:
return initial(_that);case HeadToHeadLoading() when loading != null:
return loading(_that);case HeadToHeadLoaded() when loaded != null:
return loaded(_that);case HeadToHeadError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( HeadToHeadInitial value)  initial,required TResult Function( HeadToHeadLoading value)  loading,required TResult Function( HeadToHeadLoaded value)  loaded,required TResult Function( HeadToHeadError value)  error,}){
final _that = this;
switch (_that) {
case HeadToHeadInitial():
return initial(_that);case HeadToHeadLoading():
return loading(_that);case HeadToHeadLoaded():
return loaded(_that);case HeadToHeadError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( HeadToHeadInitial value)?  initial,TResult? Function( HeadToHeadLoading value)?  loading,TResult? Function( HeadToHeadLoaded value)?  loaded,TResult? Function( HeadToHeadError value)?  error,}){
final _that = this;
switch (_that) {
case HeadToHeadInitial() when initial != null:
return initial(_that);case HeadToHeadLoading() when loading != null:
return loading(_that);case HeadToHeadLoaded() when loaded != null:
return loaded(_that);case HeadToHeadError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( HeadToHeadStats stats)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case HeadToHeadInitial() when initial != null:
return initial();case HeadToHeadLoading() when loading != null:
return loading();case HeadToHeadLoaded() when loaded != null:
return loaded(_that.stats);case HeadToHeadError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( HeadToHeadStats stats)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case HeadToHeadInitial():
return initial();case HeadToHeadLoading():
return loading();case HeadToHeadLoaded():
return loaded(_that.stats);case HeadToHeadError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( HeadToHeadStats stats)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case HeadToHeadInitial() when initial != null:
return initial();case HeadToHeadLoading() when loading != null:
return loading();case HeadToHeadLoaded() when loaded != null:
return loaded(_that.stats);case HeadToHeadError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class HeadToHeadInitial implements HeadToHeadState {
  const HeadToHeadInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HeadToHeadState.initial()';
}


}




/// @nodoc


class HeadToHeadLoading implements HeadToHeadState {
  const HeadToHeadLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HeadToHeadState.loading()';
}


}




/// @nodoc


class HeadToHeadLoaded implements HeadToHeadState {
  const HeadToHeadLoaded({required this.stats});
  

 final  HeadToHeadStats stats;

/// Create a copy of HeadToHeadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadLoadedCopyWith<HeadToHeadLoaded> get copyWith => _$HeadToHeadLoadedCopyWithImpl<HeadToHeadLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadLoaded&&(identical(other.stats, stats) || other.stats == stats));
}


@override
int get hashCode => Object.hash(runtimeType,stats);

@override
String toString() {
  return 'HeadToHeadState.loaded(stats: $stats)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadLoadedCopyWith<$Res> implements $HeadToHeadStateCopyWith<$Res> {
  factory $HeadToHeadLoadedCopyWith(HeadToHeadLoaded value, $Res Function(HeadToHeadLoaded) _then) = _$HeadToHeadLoadedCopyWithImpl;
@useResult
$Res call({
 HeadToHeadStats stats
});


$HeadToHeadStatsCopyWith<$Res> get stats;

}
/// @nodoc
class _$HeadToHeadLoadedCopyWithImpl<$Res>
    implements $HeadToHeadLoadedCopyWith<$Res> {
  _$HeadToHeadLoadedCopyWithImpl(this._self, this._then);

  final HeadToHeadLoaded _self;
  final $Res Function(HeadToHeadLoaded) _then;

/// Create a copy of HeadToHeadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,}) {
  return _then(HeadToHeadLoaded(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as HeadToHeadStats,
  ));
}

/// Create a copy of HeadToHeadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HeadToHeadStatsCopyWith<$Res> get stats {
  
  return $HeadToHeadStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}
}

/// @nodoc


class HeadToHeadError implements HeadToHeadState {
  const HeadToHeadError({required this.message});
  

 final  String message;

/// Create a copy of HeadToHeadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadErrorCopyWith<HeadToHeadError> get copyWith => _$HeadToHeadErrorCopyWithImpl<HeadToHeadError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'HeadToHeadState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadErrorCopyWith<$Res> implements $HeadToHeadStateCopyWith<$Res> {
  factory $HeadToHeadErrorCopyWith(HeadToHeadError value, $Res Function(HeadToHeadError) _then) = _$HeadToHeadErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$HeadToHeadErrorCopyWithImpl<$Res>
    implements $HeadToHeadErrorCopyWith<$Res> {
  _$HeadToHeadErrorCopyWithImpl(this._self, this._then);

  final HeadToHeadError _self;
  final $Res Function(HeadToHeadError) _then;

/// Create a copy of HeadToHeadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(HeadToHeadError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
