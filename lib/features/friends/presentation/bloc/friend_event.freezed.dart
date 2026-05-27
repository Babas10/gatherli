// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendEvent()';
}


}

/// @nodoc
class $FriendEventCopyWith<$Res>  {
$FriendEventCopyWith(FriendEvent _, $Res Function(FriendEvent) __);
}


/// Adds pattern-matching-related methods to [FriendEvent].
extension FriendEventPatterns on FriendEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FriendLoadRequested value)?  loadRequested,TResult Function( FriendRequestSent value)?  requestSent,TResult Function( FriendRequestAccepted value)?  requestAccepted,TResult Function( FriendRequestDeclined value)?  requestDeclined,TResult Function( FriendRequestCancelled value)?  requestCancelled,TResult Function( FriendRemoved value)?  removed,TResult Function( FriendSearchRequested value)?  searchRequested,TResult Function( FriendSearchCleared value)?  searchCleared,TResult Function( FriendStatusChecked value)?  statusChecked,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FriendLoadRequested() when loadRequested != null:
return loadRequested(_that);case FriendRequestSent() when requestSent != null:
return requestSent(_that);case FriendRequestAccepted() when requestAccepted != null:
return requestAccepted(_that);case FriendRequestDeclined() when requestDeclined != null:
return requestDeclined(_that);case FriendRequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case FriendRemoved() when removed != null:
return removed(_that);case FriendSearchRequested() when searchRequested != null:
return searchRequested(_that);case FriendSearchCleared() when searchCleared != null:
return searchCleared(_that);case FriendStatusChecked() when statusChecked != null:
return statusChecked(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FriendLoadRequested value)  loadRequested,required TResult Function( FriendRequestSent value)  requestSent,required TResult Function( FriendRequestAccepted value)  requestAccepted,required TResult Function( FriendRequestDeclined value)  requestDeclined,required TResult Function( FriendRequestCancelled value)  requestCancelled,required TResult Function( FriendRemoved value)  removed,required TResult Function( FriendSearchRequested value)  searchRequested,required TResult Function( FriendSearchCleared value)  searchCleared,required TResult Function( FriendStatusChecked value)  statusChecked,}){
final _that = this;
switch (_that) {
case FriendLoadRequested():
return loadRequested(_that);case FriendRequestSent():
return requestSent(_that);case FriendRequestAccepted():
return requestAccepted(_that);case FriendRequestDeclined():
return requestDeclined(_that);case FriendRequestCancelled():
return requestCancelled(_that);case FriendRemoved():
return removed(_that);case FriendSearchRequested():
return searchRequested(_that);case FriendSearchCleared():
return searchCleared(_that);case FriendStatusChecked():
return statusChecked(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FriendLoadRequested value)?  loadRequested,TResult? Function( FriendRequestSent value)?  requestSent,TResult? Function( FriendRequestAccepted value)?  requestAccepted,TResult? Function( FriendRequestDeclined value)?  requestDeclined,TResult? Function( FriendRequestCancelled value)?  requestCancelled,TResult? Function( FriendRemoved value)?  removed,TResult? Function( FriendSearchRequested value)?  searchRequested,TResult? Function( FriendSearchCleared value)?  searchCleared,TResult? Function( FriendStatusChecked value)?  statusChecked,}){
final _that = this;
switch (_that) {
case FriendLoadRequested() when loadRequested != null:
return loadRequested(_that);case FriendRequestSent() when requestSent != null:
return requestSent(_that);case FriendRequestAccepted() when requestAccepted != null:
return requestAccepted(_that);case FriendRequestDeclined() when requestDeclined != null:
return requestDeclined(_that);case FriendRequestCancelled() when requestCancelled != null:
return requestCancelled(_that);case FriendRemoved() when removed != null:
return removed(_that);case FriendSearchRequested() when searchRequested != null:
return searchRequested(_that);case FriendSearchCleared() when searchCleared != null:
return searchCleared(_that);case FriendStatusChecked() when statusChecked != null:
return statusChecked(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadRequested,TResult Function( String targetUserId)?  requestSent,TResult Function( String friendshipId)?  requestAccepted,TResult Function( String friendshipId)?  requestDeclined,TResult Function( String friendshipId)?  requestCancelled,TResult Function( String friendshipId)?  removed,TResult Function( String email)?  searchRequested,TResult Function()?  searchCleared,TResult Function( String userId)?  statusChecked,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FriendLoadRequested() when loadRequested != null:
return loadRequested();case FriendRequestSent() when requestSent != null:
return requestSent(_that.targetUserId);case FriendRequestAccepted() when requestAccepted != null:
return requestAccepted(_that.friendshipId);case FriendRequestDeclined() when requestDeclined != null:
return requestDeclined(_that.friendshipId);case FriendRequestCancelled() when requestCancelled != null:
return requestCancelled(_that.friendshipId);case FriendRemoved() when removed != null:
return removed(_that.friendshipId);case FriendSearchRequested() when searchRequested != null:
return searchRequested(_that.email);case FriendSearchCleared() when searchCleared != null:
return searchCleared();case FriendStatusChecked() when statusChecked != null:
return statusChecked(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadRequested,required TResult Function( String targetUserId)  requestSent,required TResult Function( String friendshipId)  requestAccepted,required TResult Function( String friendshipId)  requestDeclined,required TResult Function( String friendshipId)  requestCancelled,required TResult Function( String friendshipId)  removed,required TResult Function( String email)  searchRequested,required TResult Function()  searchCleared,required TResult Function( String userId)  statusChecked,}) {final _that = this;
switch (_that) {
case FriendLoadRequested():
return loadRequested();case FriendRequestSent():
return requestSent(_that.targetUserId);case FriendRequestAccepted():
return requestAccepted(_that.friendshipId);case FriendRequestDeclined():
return requestDeclined(_that.friendshipId);case FriendRequestCancelled():
return requestCancelled(_that.friendshipId);case FriendRemoved():
return removed(_that.friendshipId);case FriendSearchRequested():
return searchRequested(_that.email);case FriendSearchCleared():
return searchCleared();case FriendStatusChecked():
return statusChecked(_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadRequested,TResult? Function( String targetUserId)?  requestSent,TResult? Function( String friendshipId)?  requestAccepted,TResult? Function( String friendshipId)?  requestDeclined,TResult? Function( String friendshipId)?  requestCancelled,TResult? Function( String friendshipId)?  removed,TResult? Function( String email)?  searchRequested,TResult? Function()?  searchCleared,TResult? Function( String userId)?  statusChecked,}) {final _that = this;
switch (_that) {
case FriendLoadRequested() when loadRequested != null:
return loadRequested();case FriendRequestSent() when requestSent != null:
return requestSent(_that.targetUserId);case FriendRequestAccepted() when requestAccepted != null:
return requestAccepted(_that.friendshipId);case FriendRequestDeclined() when requestDeclined != null:
return requestDeclined(_that.friendshipId);case FriendRequestCancelled() when requestCancelled != null:
return requestCancelled(_that.friendshipId);case FriendRemoved() when removed != null:
return removed(_that.friendshipId);case FriendSearchRequested() when searchRequested != null:
return searchRequested(_that.email);case FriendSearchCleared() when searchCleared != null:
return searchCleared();case FriendStatusChecked() when statusChecked != null:
return statusChecked(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class FriendLoadRequested implements FriendEvent {
  const FriendLoadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendLoadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendEvent.loadRequested()';
}


}




/// @nodoc


class FriendRequestSent implements FriendEvent {
  const FriendRequestSent({required this.targetUserId});
  

 final  String targetUserId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestSentCopyWith<FriendRequestSent> get copyWith => _$FriendRequestSentCopyWithImpl<FriendRequestSent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestSent&&(identical(other.targetUserId, targetUserId) || other.targetUserId == targetUserId));
}


@override
int get hashCode => Object.hash(runtimeType,targetUserId);

@override
String toString() {
  return 'FriendEvent.requestSent(targetUserId: $targetUserId)';
}


}

/// @nodoc
abstract mixin class $FriendRequestSentCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendRequestSentCopyWith(FriendRequestSent value, $Res Function(FriendRequestSent) _then) = _$FriendRequestSentCopyWithImpl;
@useResult
$Res call({
 String targetUserId
});




}
/// @nodoc
class _$FriendRequestSentCopyWithImpl<$Res>
    implements $FriendRequestSentCopyWith<$Res> {
  _$FriendRequestSentCopyWithImpl(this._self, this._then);

  final FriendRequestSent _self;
  final $Res Function(FriendRequestSent) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? targetUserId = null,}) {
  return _then(FriendRequestSent(
targetUserId: null == targetUserId ? _self.targetUserId : targetUserId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendRequestAccepted implements FriendEvent {
  const FriendRequestAccepted({required this.friendshipId});
  

 final  String friendshipId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestAcceptedCopyWith<FriendRequestAccepted> get copyWith => _$FriendRequestAcceptedCopyWithImpl<FriendRequestAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestAccepted&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}


@override
int get hashCode => Object.hash(runtimeType,friendshipId);

@override
String toString() {
  return 'FriendEvent.requestAccepted(friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class $FriendRequestAcceptedCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendRequestAcceptedCopyWith(FriendRequestAccepted value, $Res Function(FriendRequestAccepted) _then) = _$FriendRequestAcceptedCopyWithImpl;
@useResult
$Res call({
 String friendshipId
});




}
/// @nodoc
class _$FriendRequestAcceptedCopyWithImpl<$Res>
    implements $FriendRequestAcceptedCopyWith<$Res> {
  _$FriendRequestAcceptedCopyWithImpl(this._self, this._then);

  final FriendRequestAccepted _self;
  final $Res Function(FriendRequestAccepted) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,}) {
  return _then(FriendRequestAccepted(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendRequestDeclined implements FriendEvent {
  const FriendRequestDeclined({required this.friendshipId});
  

 final  String friendshipId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestDeclinedCopyWith<FriendRequestDeclined> get copyWith => _$FriendRequestDeclinedCopyWithImpl<FriendRequestDeclined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestDeclined&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}


@override
int get hashCode => Object.hash(runtimeType,friendshipId);

@override
String toString() {
  return 'FriendEvent.requestDeclined(friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class $FriendRequestDeclinedCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendRequestDeclinedCopyWith(FriendRequestDeclined value, $Res Function(FriendRequestDeclined) _then) = _$FriendRequestDeclinedCopyWithImpl;
@useResult
$Res call({
 String friendshipId
});




}
/// @nodoc
class _$FriendRequestDeclinedCopyWithImpl<$Res>
    implements $FriendRequestDeclinedCopyWith<$Res> {
  _$FriendRequestDeclinedCopyWithImpl(this._self, this._then);

  final FriendRequestDeclined _self;
  final $Res Function(FriendRequestDeclined) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,}) {
  return _then(FriendRequestDeclined(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendRequestCancelled implements FriendEvent {
  const FriendRequestCancelled({required this.friendshipId});
  

 final  String friendshipId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRequestCancelledCopyWith<FriendRequestCancelled> get copyWith => _$FriendRequestCancelledCopyWithImpl<FriendRequestCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRequestCancelled&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}


@override
int get hashCode => Object.hash(runtimeType,friendshipId);

@override
String toString() {
  return 'FriendEvent.requestCancelled(friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class $FriendRequestCancelledCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendRequestCancelledCopyWith(FriendRequestCancelled value, $Res Function(FriendRequestCancelled) _then) = _$FriendRequestCancelledCopyWithImpl;
@useResult
$Res call({
 String friendshipId
});




}
/// @nodoc
class _$FriendRequestCancelledCopyWithImpl<$Res>
    implements $FriendRequestCancelledCopyWith<$Res> {
  _$FriendRequestCancelledCopyWithImpl(this._self, this._then);

  final FriendRequestCancelled _self;
  final $Res Function(FriendRequestCancelled) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,}) {
  return _then(FriendRequestCancelled(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendRemoved implements FriendEvent {
  const FriendRemoved({required this.friendshipId});
  

 final  String friendshipId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendRemovedCopyWith<FriendRemoved> get copyWith => _$FriendRemovedCopyWithImpl<FriendRemoved>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendRemoved&&(identical(other.friendshipId, friendshipId) || other.friendshipId == friendshipId));
}


@override
int get hashCode => Object.hash(runtimeType,friendshipId);

@override
String toString() {
  return 'FriendEvent.removed(friendshipId: $friendshipId)';
}


}

/// @nodoc
abstract mixin class $FriendRemovedCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendRemovedCopyWith(FriendRemoved value, $Res Function(FriendRemoved) _then) = _$FriendRemovedCopyWithImpl;
@useResult
$Res call({
 String friendshipId
});




}
/// @nodoc
class _$FriendRemovedCopyWithImpl<$Res>
    implements $FriendRemovedCopyWith<$Res> {
  _$FriendRemovedCopyWithImpl(this._self, this._then);

  final FriendRemoved _self;
  final $Res Function(FriendRemoved) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friendshipId = null,}) {
  return _then(FriendRemoved(
friendshipId: null == friendshipId ? _self.friendshipId : friendshipId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendSearchRequested implements FriendEvent {
  const FriendSearchRequested({required this.email});
  

 final  String email;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendSearchRequestedCopyWith<FriendSearchRequested> get copyWith => _$FriendSearchRequestedCopyWithImpl<FriendSearchRequested>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendSearchRequested&&(identical(other.email, email) || other.email == email));
}


@override
int get hashCode => Object.hash(runtimeType,email);

@override
String toString() {
  return 'FriendEvent.searchRequested(email: $email)';
}


}

/// @nodoc
abstract mixin class $FriendSearchRequestedCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendSearchRequestedCopyWith(FriendSearchRequested value, $Res Function(FriendSearchRequested) _then) = _$FriendSearchRequestedCopyWithImpl;
@useResult
$Res call({
 String email
});




}
/// @nodoc
class _$FriendSearchRequestedCopyWithImpl<$Res>
    implements $FriendSearchRequestedCopyWith<$Res> {
  _$FriendSearchRequestedCopyWithImpl(this._self, this._then);

  final FriendSearchRequested _self;
  final $Res Function(FriendSearchRequested) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? email = null,}) {
  return _then(FriendSearchRequested(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendSearchCleared implements FriendEvent {
  const FriendSearchCleared();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendSearchCleared);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendEvent.searchCleared()';
}


}




/// @nodoc


class FriendStatusChecked implements FriendEvent {
  const FriendStatusChecked({required this.userId});
  

 final  String userId;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendStatusCheckedCopyWith<FriendStatusChecked> get copyWith => _$FriendStatusCheckedCopyWithImpl<FriendStatusChecked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendStatusChecked&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'FriendEvent.statusChecked(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $FriendStatusCheckedCopyWith<$Res> implements $FriendEventCopyWith<$Res> {
  factory $FriendStatusCheckedCopyWith(FriendStatusChecked value, $Res Function(FriendStatusChecked) _then) = _$FriendStatusCheckedCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$FriendStatusCheckedCopyWithImpl<$Res>
    implements $FriendStatusCheckedCopyWith<$Res> {
  _$FriendStatusCheckedCopyWithImpl(this._self, this._then);

  final FriendStatusChecked _self;
  final $Res Function(FriendStatusChecked) _then;

/// Create a copy of FriendEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(FriendStatusChecked(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
