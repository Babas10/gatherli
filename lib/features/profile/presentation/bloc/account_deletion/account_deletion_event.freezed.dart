// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'account_deletion_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AccountDeletionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionEvent()';
}


}

/// @nodoc
class $AccountDeletionEventCopyWith<$Res>  {
$AccountDeletionEventCopyWith(AccountDeletionEvent _, $Res Function(AccountDeletionEvent) __);
}


/// Adds pattern-matching-related methods to [AccountDeletionEvent].
extension AccountDeletionEventPatterns on AccountDeletionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AccountDeletionRequested value)?  deleteRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AccountDeletionRequested() when deleteRequested != null:
return deleteRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AccountDeletionRequested value)  deleteRequested,}){
final _that = this;
switch (_that) {
case AccountDeletionRequested():
return deleteRequested(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AccountDeletionRequested value)?  deleteRequested,}){
final _that = this;
switch (_that) {
case AccountDeletionRequested() when deleteRequested != null:
return deleteRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  deleteRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AccountDeletionRequested() when deleteRequested != null:
return deleteRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  deleteRequested,}) {final _that = this;
switch (_that) {
case AccountDeletionRequested():
return deleteRequested();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  deleteRequested,}) {final _that = this;
switch (_that) {
case AccountDeletionRequested() when deleteRequested != null:
return deleteRequested();case _:
  return null;

}
}

}

/// @nodoc


class AccountDeletionRequested implements AccountDeletionEvent {
  const AccountDeletionRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AccountDeletionRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AccountDeletionEvent.deleteRequested()';
}


}




// dart format on
