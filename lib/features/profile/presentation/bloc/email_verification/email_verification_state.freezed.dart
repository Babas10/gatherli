// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EmailVerificationState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationState()';
}


}

/// @nodoc
class $EmailVerificationStateCopyWith<$Res>  {
$EmailVerificationStateCopyWith(EmailVerificationState _, $Res Function(EmailVerificationState) __);
}


/// Adds pattern-matching-related methods to [EmailVerificationState].
extension EmailVerificationStatePatterns on EmailVerificationState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EmailVerificationInitial value)?  initial,TResult Function( EmailVerificationLoading value)?  loading,TResult Function( EmailVerificationVerified value)?  verified,TResult Function( EmailVerificationPending value)?  pending,TResult Function( EmailVerificationError value)?  error,TResult Function( EmailVerificationEmailSent value)?  emailSent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EmailVerificationInitial() when initial != null:
return initial(_that);case EmailVerificationLoading() when loading != null:
return loading(_that);case EmailVerificationVerified() when verified != null:
return verified(_that);case EmailVerificationPending() when pending != null:
return pending(_that);case EmailVerificationError() when error != null:
return error(_that);case EmailVerificationEmailSent() when emailSent != null:
return emailSent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EmailVerificationInitial value)  initial,required TResult Function( EmailVerificationLoading value)  loading,required TResult Function( EmailVerificationVerified value)  verified,required TResult Function( EmailVerificationPending value)  pending,required TResult Function( EmailVerificationError value)  error,required TResult Function( EmailVerificationEmailSent value)  emailSent,}){
final _that = this;
switch (_that) {
case EmailVerificationInitial():
return initial(_that);case EmailVerificationLoading():
return loading(_that);case EmailVerificationVerified():
return verified(_that);case EmailVerificationPending():
return pending(_that);case EmailVerificationError():
return error(_that);case EmailVerificationEmailSent():
return emailSent(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EmailVerificationInitial value)?  initial,TResult? Function( EmailVerificationLoading value)?  loading,TResult? Function( EmailVerificationVerified value)?  verified,TResult? Function( EmailVerificationPending value)?  pending,TResult? Function( EmailVerificationError value)?  error,TResult? Function( EmailVerificationEmailSent value)?  emailSent,}){
final _that = this;
switch (_that) {
case EmailVerificationInitial() when initial != null:
return initial(_that);case EmailVerificationLoading() when loading != null:
return loading(_that);case EmailVerificationVerified() when verified != null:
return verified(_that);case EmailVerificationPending() when pending != null:
return pending(_that);case EmailVerificationError() when error != null:
return error(_that);case EmailVerificationEmailSent() when emailSent != null:
return emailSent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DateTime? verifiedAt)?  verified,TResult Function( String email,  bool emailSent,  DateTime? lastSentAt,  int resendCooldownSeconds)?  pending,TResult Function( String message,  String? email,  bool? wasVerified)?  error,TResult Function( String email,  DateTime sentAt,  int resendCooldownSeconds)?  emailSent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EmailVerificationInitial() when initial != null:
return initial();case EmailVerificationLoading() when loading != null:
return loading();case EmailVerificationVerified() when verified != null:
return verified(_that.verifiedAt);case EmailVerificationPending() when pending != null:
return pending(_that.email,_that.emailSent,_that.lastSentAt,_that.resendCooldownSeconds);case EmailVerificationError() when error != null:
return error(_that.message,_that.email,_that.wasVerified);case EmailVerificationEmailSent() when emailSent != null:
return emailSent(_that.email,_that.sentAt,_that.resendCooldownSeconds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DateTime? verifiedAt)  verified,required TResult Function( String email,  bool emailSent,  DateTime? lastSentAt,  int resendCooldownSeconds)  pending,required TResult Function( String message,  String? email,  bool? wasVerified)  error,required TResult Function( String email,  DateTime sentAt,  int resendCooldownSeconds)  emailSent,}) {final _that = this;
switch (_that) {
case EmailVerificationInitial():
return initial();case EmailVerificationLoading():
return loading();case EmailVerificationVerified():
return verified(_that.verifiedAt);case EmailVerificationPending():
return pending(_that.email,_that.emailSent,_that.lastSentAt,_that.resendCooldownSeconds);case EmailVerificationError():
return error(_that.message,_that.email,_that.wasVerified);case EmailVerificationEmailSent():
return emailSent(_that.email,_that.sentAt,_that.resendCooldownSeconds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DateTime? verifiedAt)?  verified,TResult? Function( String email,  bool emailSent,  DateTime? lastSentAt,  int resendCooldownSeconds)?  pending,TResult? Function( String message,  String? email,  bool? wasVerified)?  error,TResult? Function( String email,  DateTime sentAt,  int resendCooldownSeconds)?  emailSent,}) {final _that = this;
switch (_that) {
case EmailVerificationInitial() when initial != null:
return initial();case EmailVerificationLoading() when loading != null:
return loading();case EmailVerificationVerified() when verified != null:
return verified(_that.verifiedAt);case EmailVerificationPending() when pending != null:
return pending(_that.email,_that.emailSent,_that.lastSentAt,_that.resendCooldownSeconds);case EmailVerificationError() when error != null:
return error(_that.message,_that.email,_that.wasVerified);case EmailVerificationEmailSent() when emailSent != null:
return emailSent(_that.email,_that.sentAt,_that.resendCooldownSeconds);case _:
  return null;

}
}

}

/// @nodoc


class EmailVerificationInitial implements EmailVerificationState {
  const EmailVerificationInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationState.initial()';
}


}




/// @nodoc


class EmailVerificationLoading implements EmailVerificationState {
  const EmailVerificationLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EmailVerificationState.loading()';
}


}




/// @nodoc


class EmailVerificationVerified implements EmailVerificationState {
  const EmailVerificationVerified({required this.verifiedAt});
  

 final  DateTime? verifiedAt;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationVerifiedCopyWith<EmailVerificationVerified> get copyWith => _$EmailVerificationVerifiedCopyWithImpl<EmailVerificationVerified>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationVerified&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt));
}


@override
int get hashCode => Object.hash(runtimeType,verifiedAt);

@override
String toString() {
  return 'EmailVerificationState.verified(verifiedAt: $verifiedAt)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationVerifiedCopyWith<$Res> implements $EmailVerificationStateCopyWith<$Res> {
  factory $EmailVerificationVerifiedCopyWith(EmailVerificationVerified value, $Res Function(EmailVerificationVerified) _then) = _$EmailVerificationVerifiedCopyWithImpl;
@useResult
$Res call({
 DateTime? verifiedAt
});




}
/// @nodoc
class _$EmailVerificationVerifiedCopyWithImpl<$Res>
    implements $EmailVerificationVerifiedCopyWith<$Res> {
  _$EmailVerificationVerifiedCopyWithImpl(this._self, this._then);

  final EmailVerificationVerified _self;
  final $Res Function(EmailVerificationVerified) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? verifiedAt = freezed,}) {
  return _then(EmailVerificationVerified(
verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class EmailVerificationPending implements EmailVerificationState {
  const EmailVerificationPending({required this.email, required this.emailSent, required this.lastSentAt, required this.resendCooldownSeconds});
  

 final  String email;
 final  bool emailSent;
 final  DateTime? lastSentAt;
 final  int resendCooldownSeconds;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationPendingCopyWith<EmailVerificationPending> get copyWith => _$EmailVerificationPendingCopyWithImpl<EmailVerificationPending>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationPending&&(identical(other.email, email) || other.email == email)&&(identical(other.emailSent, emailSent) || other.emailSent == emailSent)&&(identical(other.lastSentAt, lastSentAt) || other.lastSentAt == lastSentAt)&&(identical(other.resendCooldownSeconds, resendCooldownSeconds) || other.resendCooldownSeconds == resendCooldownSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,email,emailSent,lastSentAt,resendCooldownSeconds);

@override
String toString() {
  return 'EmailVerificationState.pending(email: $email, emailSent: $emailSent, lastSentAt: $lastSentAt, resendCooldownSeconds: $resendCooldownSeconds)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationPendingCopyWith<$Res> implements $EmailVerificationStateCopyWith<$Res> {
  factory $EmailVerificationPendingCopyWith(EmailVerificationPending value, $Res Function(EmailVerificationPending) _then) = _$EmailVerificationPendingCopyWithImpl;
@useResult
$Res call({
 String email, bool emailSent, DateTime? lastSentAt, int resendCooldownSeconds
});




}
/// @nodoc
class _$EmailVerificationPendingCopyWithImpl<$Res>
    implements $EmailVerificationPendingCopyWith<$Res> {
  _$EmailVerificationPendingCopyWithImpl(this._self, this._then);

  final EmailVerificationPending _self;
  final $Res Function(EmailVerificationPending) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? emailSent = null,Object? lastSentAt = freezed,Object? resendCooldownSeconds = null,}) {
  return _then(EmailVerificationPending(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,emailSent: null == emailSent ? _self.emailSent : emailSent // ignore: cast_nullable_to_non_nullable
as bool,lastSentAt: freezed == lastSentAt ? _self.lastSentAt : lastSentAt // ignore: cast_nullable_to_non_nullable
as DateTime?,resendCooldownSeconds: null == resendCooldownSeconds ? _self.resendCooldownSeconds : resendCooldownSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class EmailVerificationError implements EmailVerificationState {
  const EmailVerificationError({required this.message, this.email, this.wasVerified});
  

 final  String message;
 final  String? email;
 final  bool? wasVerified;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationErrorCopyWith<EmailVerificationError> get copyWith => _$EmailVerificationErrorCopyWithImpl<EmailVerificationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationError&&(identical(other.message, message) || other.message == message)&&(identical(other.email, email) || other.email == email)&&(identical(other.wasVerified, wasVerified) || other.wasVerified == wasVerified));
}


@override
int get hashCode => Object.hash(runtimeType,message,email,wasVerified);

@override
String toString() {
  return 'EmailVerificationState.error(message: $message, email: $email, wasVerified: $wasVerified)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationErrorCopyWith<$Res> implements $EmailVerificationStateCopyWith<$Res> {
  factory $EmailVerificationErrorCopyWith(EmailVerificationError value, $Res Function(EmailVerificationError) _then) = _$EmailVerificationErrorCopyWithImpl;
@useResult
$Res call({
 String message, String? email, bool? wasVerified
});




}
/// @nodoc
class _$EmailVerificationErrorCopyWithImpl<$Res>
    implements $EmailVerificationErrorCopyWith<$Res> {
  _$EmailVerificationErrorCopyWithImpl(this._self, this._then);

  final EmailVerificationError _self;
  final $Res Function(EmailVerificationError) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? email = freezed,Object? wasVerified = freezed,}) {
  return _then(EmailVerificationError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,wasVerified: freezed == wasVerified ? _self.wasVerified : wasVerified // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

/// @nodoc


class EmailVerificationEmailSent implements EmailVerificationState {
  const EmailVerificationEmailSent({required this.email, required this.sentAt, required this.resendCooldownSeconds});
  

 final  String email;
 final  DateTime sentAt;
 final  int resendCooldownSeconds;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationEmailSentCopyWith<EmailVerificationEmailSent> get copyWith => _$EmailVerificationEmailSentCopyWithImpl<EmailVerificationEmailSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationEmailSent&&(identical(other.email, email) || other.email == email)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt)&&(identical(other.resendCooldownSeconds, resendCooldownSeconds) || other.resendCooldownSeconds == resendCooldownSeconds));
}


@override
int get hashCode => Object.hash(runtimeType,email,sentAt,resendCooldownSeconds);

@override
String toString() {
  return 'EmailVerificationState.emailSent(email: $email, sentAt: $sentAt, resendCooldownSeconds: $resendCooldownSeconds)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationEmailSentCopyWith<$Res> implements $EmailVerificationStateCopyWith<$Res> {
  factory $EmailVerificationEmailSentCopyWith(EmailVerificationEmailSent value, $Res Function(EmailVerificationEmailSent) _then) = _$EmailVerificationEmailSentCopyWithImpl;
@useResult
$Res call({
 String email, DateTime sentAt, int resendCooldownSeconds
});




}
/// @nodoc
class _$EmailVerificationEmailSentCopyWithImpl<$Res>
    implements $EmailVerificationEmailSentCopyWith<$Res> {
  _$EmailVerificationEmailSentCopyWithImpl(this._self, this._then);

  final EmailVerificationEmailSent _self;
  final $Res Function(EmailVerificationEmailSent) _then;

/// Create a copy of EmailVerificationState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,Object? sentAt = null,Object? resendCooldownSeconds = null,}) {
  return _then(EmailVerificationEmailSent(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,resendCooldownSeconds: null == resendCooldownSeconds ? _self.resendCooldownSeconds : resendCooldownSeconds // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
