// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_deletion_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountDeletionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionState()';
}


}

/// @nodoc
class $AccountDeletionStateCopyWith<$Res>  {
$AccountDeletionStateCopyWith(AccountDeletionState _, $Res Function(AccountDeletionState) __);
}


/// Adds pattern-matching-related methods to [AccountDeletionState].
extension AccountDeletionStatePatterns on AccountDeletionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountDeletionInitial value)?  initial,TResult Function( AccountDeletionInProgress value)?  inProgress,TResult Function( AccountDeletionSuccess value)?  success,TResult Function( AccountDeletionFailure value)?  failure,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountDeletionInitial() when initial != null:
return initial(_that);case AccountDeletionInProgress() when inProgress != null:
return inProgress(_that);case AccountDeletionSuccess() when success != null:
return success(_that);case AccountDeletionFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountDeletionInitial value)  initial,required TResult Function( AccountDeletionInProgress value)  inProgress,required TResult Function( AccountDeletionSuccess value)  success,required TResult Function( AccountDeletionFailure value)  failure,}){
final _that = this;
switch (_that) {
case AccountDeletionInitial():
return initial(_that);case AccountDeletionInProgress():
return inProgress(_that);case AccountDeletionSuccess():
return success(_that);case AccountDeletionFailure():
return failure(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountDeletionInitial value)?  initial,TResult? Function( AccountDeletionInProgress value)?  inProgress,TResult? Function( AccountDeletionSuccess value)?  success,TResult? Function( AccountDeletionFailure value)?  failure,}){
final _that = this;
switch (_that) {
case AccountDeletionInitial() when initial != null:
return initial(_that);case AccountDeletionInProgress() when inProgress != null:
return inProgress(_that);case AccountDeletionSuccess() when success != null:
return success(_that);case AccountDeletionFailure() when failure != null:
return failure(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  inProgress,TResult Function()?  success,TResult Function( String message)?  failure,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountDeletionInitial() when initial != null:
return initial();case AccountDeletionInProgress() when inProgress != null:
return inProgress();case AccountDeletionSuccess() when success != null:
return success();case AccountDeletionFailure() when failure != null:
return failure(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  inProgress,required TResult Function()  success,required TResult Function( String message)  failure,}) {final _that = this;
switch (_that) {
case AccountDeletionInitial():
return initial();case AccountDeletionInProgress():
return inProgress();case AccountDeletionSuccess():
return success();case AccountDeletionFailure():
return failure(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  inProgress,TResult? Function()?  success,TResult? Function( String message)?  failure,}) {final _that = this;
switch (_that) {
case AccountDeletionInitial() when initial != null:
return initial();case AccountDeletionInProgress() when inProgress != null:
return inProgress();case AccountDeletionSuccess() when success != null:
return success();case AccountDeletionFailure() when failure != null:
return failure(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AccountDeletionInitial implements AccountDeletionState {
  const AccountDeletionInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionState.initial()';
}


}




/// @nodoc


class AccountDeletionInProgress implements AccountDeletionState {
  const AccountDeletionInProgress();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionInProgress);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionState.inProgress()';
}


}




/// @nodoc


class AccountDeletionSuccess implements AccountDeletionState {
  const AccountDeletionSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionState.success()';
}


}




/// @nodoc


class AccountDeletionFailure implements AccountDeletionState {
  const AccountDeletionFailure({required this.message});
  

 final  String message;

/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AccountDeletionFailureCopyWith<AccountDeletionFailure> get copyWith => _$AccountDeletionFailureCopyWithImpl<AccountDeletionFailure>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionFailure&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AccountDeletionState.failure(message: $message)';
}


}

/// @nodoc
abstract mixin class $AccountDeletionFailureCopyWith<$Res> implements $AccountDeletionStateCopyWith<$Res> {
  factory $AccountDeletionFailureCopyWith(AccountDeletionFailure value, $Res Function(AccountDeletionFailure) _then) = _$AccountDeletionFailureCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AccountDeletionFailureCopyWithImpl<$Res>
    implements $AccountDeletionFailureCopyWith<$Res> {
  _$AccountDeletionFailureCopyWithImpl(this._self, this._then);

  final AccountDeletionFailure _self;
  final $Res Function(AccountDeletionFailure) _then;

/// Create a copy of AccountDeletionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AccountDeletionFailure(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
