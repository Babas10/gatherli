// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailVerificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationEvent()';
}


}

/// @nodoc
class $EmailVerificationEventCopyWith<$Res>  {
$EmailVerificationEventCopyWith(EmailVerificationEvent _, $Res Function(EmailVerificationEvent) __);
}


/// Adds pattern-matching-related methods to [EmailVerificationEvent].
extension EmailVerificationEventPatterns on EmailVerificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmailVerificationCheckStatus value)?  checkStatus,TResult Function( EmailVerificationSendEmail value)?  sendVerificationEmail,TResult Function( EmailVerificationRefreshStatus value)?  refreshStatus,TResult Function( EmailVerificationResetError value)?  resetError,TResult Function( EmailVerificationAuthStateChanged value)?  authStateChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmailVerificationCheckStatus() when checkStatus != null:
return checkStatus(_that);case EmailVerificationSendEmail() when sendVerificationEmail != null:
return sendVerificationEmail(_that);case EmailVerificationRefreshStatus() when refreshStatus != null:
return refreshStatus(_that);case EmailVerificationResetError() when resetError != null:
return resetError(_that);case EmailVerificationAuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmailVerificationCheckStatus value)  checkStatus,required TResult Function( EmailVerificationSendEmail value)  sendVerificationEmail,required TResult Function( EmailVerificationRefreshStatus value)  refreshStatus,required TResult Function( EmailVerificationResetError value)  resetError,required TResult Function( EmailVerificationAuthStateChanged value)  authStateChanged,}){
final _that = this;
switch (_that) {
case EmailVerificationCheckStatus():
return checkStatus(_that);case EmailVerificationSendEmail():
return sendVerificationEmail(_that);case EmailVerificationRefreshStatus():
return refreshStatus(_that);case EmailVerificationResetError():
return resetError(_that);case EmailVerificationAuthStateChanged():
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmailVerificationCheckStatus value)?  checkStatus,TResult? Function( EmailVerificationSendEmail value)?  sendVerificationEmail,TResult? Function( EmailVerificationRefreshStatus value)?  refreshStatus,TResult? Function( EmailVerificationResetError value)?  resetError,TResult? Function( EmailVerificationAuthStateChanged value)?  authStateChanged,}){
final _that = this;
switch (_that) {
case EmailVerificationCheckStatus() when checkStatus != null:
return checkStatus(_that);case EmailVerificationSendEmail() when sendVerificationEmail != null:
return sendVerificationEmail(_that);case EmailVerificationRefreshStatus() when refreshStatus != null:
return refreshStatus(_that);case EmailVerificationResetError() when resetError != null:
return resetError(_that);case EmailVerificationAuthStateChanged() when authStateChanged != null:
return authStateChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  checkStatus,TResult Function()?  sendVerificationEmail,TResult Function()?  refreshStatus,TResult Function()?  resetError,TResult Function( bool isVerified,  DateTime? verifiedAt)?  authStateChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmailVerificationCheckStatus() when checkStatus != null:
return checkStatus();case EmailVerificationSendEmail() when sendVerificationEmail != null:
return sendVerificationEmail();case EmailVerificationRefreshStatus() when refreshStatus != null:
return refreshStatus();case EmailVerificationResetError() when resetError != null:
return resetError();case EmailVerificationAuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.isVerified,_that.verifiedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  checkStatus,required TResult Function()  sendVerificationEmail,required TResult Function()  refreshStatus,required TResult Function()  resetError,required TResult Function( bool isVerified,  DateTime? verifiedAt)  authStateChanged,}) {final _that = this;
switch (_that) {
case EmailVerificationCheckStatus():
return checkStatus();case EmailVerificationSendEmail():
return sendVerificationEmail();case EmailVerificationRefreshStatus():
return refreshStatus();case EmailVerificationResetError():
return resetError();case EmailVerificationAuthStateChanged():
return authStateChanged(_that.isVerified,_that.verifiedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  checkStatus,TResult? Function()?  sendVerificationEmail,TResult? Function()?  refreshStatus,TResult? Function()?  resetError,TResult? Function( bool isVerified,  DateTime? verifiedAt)?  authStateChanged,}) {final _that = this;
switch (_that) {
case EmailVerificationCheckStatus() when checkStatus != null:
return checkStatus();case EmailVerificationSendEmail() when sendVerificationEmail != null:
return sendVerificationEmail();case EmailVerificationRefreshStatus() when refreshStatus != null:
return refreshStatus();case EmailVerificationResetError() when resetError != null:
return resetError();case EmailVerificationAuthStateChanged() when authStateChanged != null:
return authStateChanged(_that.isVerified,_that.verifiedAt);case _:
  return null;

}
}

}

/// @nodoc


class EmailVerificationCheckStatus implements EmailVerificationEvent {
  const EmailVerificationCheckStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationCheckStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationEvent.checkStatus()';
}


}




/// @nodoc


class EmailVerificationSendEmail implements EmailVerificationEvent {
  const EmailVerificationSendEmail();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationSendEmail);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationEvent.sendVerificationEmail()';
}


}




/// @nodoc


class EmailVerificationRefreshStatus implements EmailVerificationEvent {
  const EmailVerificationRefreshStatus();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationRefreshStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationEvent.refreshStatus()';
}


}




/// @nodoc


class EmailVerificationResetError implements EmailVerificationEvent {
  const EmailVerificationResetError();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationResetError);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationEvent.resetError()';
}


}




/// @nodoc


class EmailVerificationAuthStateChanged implements EmailVerificationEvent {
  const EmailVerificationAuthStateChanged({required this.isVerified, this.verifiedAt});
  

 final  bool isVerified;
 final  DateTime? verifiedAt;

/// Create a copy of EmailVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationAuthStateChangedCopyWith<EmailVerificationAuthStateChanged> get copyWith => _$EmailVerificationAuthStateChangedCopyWithImpl<EmailVerificationAuthStateChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationAuthStateChanged&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,isVerified,verifiedAt);

@override
String toString() {
  return 'EmailVerificationEvent.authStateChanged(isVerified: $isVerified, verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationAuthStateChangedCopyWith<$Res> implements $EmailVerificationEventCopyWith<$Res> {
  factory $EmailVerificationAuthStateChangedCopyWith(EmailVerificationAuthStateChanged value, $Res Function(EmailVerificationAuthStateChanged) _then) = _$EmailVerificationAuthStateChangedCopyWithImpl;
@useResult
$Res call({
 bool isVerified, DateTime? verifiedAt
});




}
/// @nodoc
class _$EmailVerificationAuthStateChangedCopyWithImpl<$Res>
    implements $EmailVerificationAuthStateChangedCopyWith<$Res> {
  _$EmailVerificationAuthStateChangedCopyWithImpl(this._self, this._then);

  final EmailVerificationAuthStateChanged _self;
  final $Res Function(EmailVerificationAuthStateChanged) _then;

/// Create a copy of EmailVerificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isVerified = null,Object? verifiedAt = freezed,}) {
  return _then(EmailVerificationAuthStateChanged(
isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
