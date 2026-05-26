// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friend_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FriendState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendState()';
}


}

/// @nodoc
class $FriendStateCopyWith<$Res>  {
$FriendStateCopyWith(FriendState _, $Res Function(FriendState) __);
}


/// Adds pattern-matching-related methods to [FriendState].
extension FriendStatePatterns on FriendState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( FriendInitial value)?  initial,TResult Function( FriendLoading value)?  loading,TResult Function( FriendLoaded value)?  loaded,TResult Function( FriendSearchLoading value)?  searchLoading,TResult Function( FriendSearchResult value)?  searchResult,TResult Function( FriendStatusResult value)?  statusResult,TResult Function( FriendError value)?  error,TResult Function( FriendActionSuccess value)?  actionSuccess,required TResult orElse(),}){
final _that = this;
switch (_that) {
case FriendInitial() when initial != null:
return initial(_that);case FriendLoading() when loading != null:
return loading(_that);case FriendLoaded() when loaded != null:
return loaded(_that);case FriendSearchLoading() when searchLoading != null:
return searchLoading(_that);case FriendSearchResult() when searchResult != null:
return searchResult(_that);case FriendStatusResult() when statusResult != null:
return statusResult(_that);case FriendError() when error != null:
return error(_that);case FriendActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( FriendInitial value)  initial,required TResult Function( FriendLoading value)  loading,required TResult Function( FriendLoaded value)  loaded,required TResult Function( FriendSearchLoading value)  searchLoading,required TResult Function( FriendSearchResult value)  searchResult,required TResult Function( FriendStatusResult value)  statusResult,required TResult Function( FriendError value)  error,required TResult Function( FriendActionSuccess value)  actionSuccess,}){
final _that = this;
switch (_that) {
case FriendInitial():
return initial(_that);case FriendLoading():
return loading(_that);case FriendLoaded():
return loaded(_that);case FriendSearchLoading():
return searchLoading(_that);case FriendSearchResult():
return searchResult(_that);case FriendStatusResult():
return statusResult(_that);case FriendError():
return error(_that);case FriendActionSuccess():
return actionSuccess(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( FriendInitial value)?  initial,TResult? Function( FriendLoading value)?  loading,TResult? Function( FriendLoaded value)?  loaded,TResult? Function( FriendSearchLoading value)?  searchLoading,TResult? Function( FriendSearchResult value)?  searchResult,TResult? Function( FriendStatusResult value)?  statusResult,TResult? Function( FriendError value)?  error,TResult? Function( FriendActionSuccess value)?  actionSuccess,}){
final _that = this;
switch (_that) {
case FriendInitial() when initial != null:
return initial(_that);case FriendLoading() when loading != null:
return loading(_that);case FriendLoaded() when loaded != null:
return loaded(_that);case FriendSearchLoading() when searchLoading != null:
return searchLoading(_that);case FriendSearchResult() when searchResult != null:
return searchResult(_that);case FriendStatusResult() when statusResult != null:
return statusResult(_that);case FriendError() when error != null:
return error(_that);case FriendActionSuccess() when actionSuccess != null:
return actionSuccess(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<UserEntity> friends,  List<FriendshipEntity> receivedRequests,  List<FriendshipEntity> sentRequests)?  loaded,TResult Function()?  searchLoading,TResult Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String searchedEmail,  bool isSelfSearch)?  searchResult,TResult Function( FriendshipStatusResult status)?  statusResult,TResult Function( String message)?  error,TResult Function( String message)?  actionSuccess,required TResult orElse(),}) {final _that = this;
switch (_that) {
case FriendInitial() when initial != null:
return initial();case FriendLoading() when loading != null:
return loading();case FriendLoaded() when loaded != null:
return loaded(_that.friends,_that.receivedRequests,_that.sentRequests);case FriendSearchLoading() when searchLoading != null:
return searchLoading();case FriendSearchResult() when searchResult != null:
return searchResult(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.searchedEmail,_that.isSelfSearch);case FriendStatusResult() when statusResult != null:
return statusResult(_that.status);case FriendError() when error != null:
return error(_that.message);case FriendActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<UserEntity> friends,  List<FriendshipEntity> receivedRequests,  List<FriendshipEntity> sentRequests)  loaded,required TResult Function()  searchLoading,required TResult Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String searchedEmail,  bool isSelfSearch)  searchResult,required TResult Function( FriendshipStatusResult status)  statusResult,required TResult Function( String message)  error,required TResult Function( String message)  actionSuccess,}) {final _that = this;
switch (_that) {
case FriendInitial():
return initial();case FriendLoading():
return loading();case FriendLoaded():
return loaded(_that.friends,_that.receivedRequests,_that.sentRequests);case FriendSearchLoading():
return searchLoading();case FriendSearchResult():
return searchResult(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.searchedEmail,_that.isSelfSearch);case FriendStatusResult():
return statusResult(_that.status);case FriendError():
return error(_that.message);case FriendActionSuccess():
return actionSuccess(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<UserEntity> friends,  List<FriendshipEntity> receivedRequests,  List<FriendshipEntity> sentRequests)?  loaded,TResult? Function()?  searchLoading,TResult? Function( UserEntity? user,  bool isFriend,  bool hasPendingRequest,  String? requestDirection,  String searchedEmail,  bool isSelfSearch)?  searchResult,TResult? Function( FriendshipStatusResult status)?  statusResult,TResult? Function( String message)?  error,TResult? Function( String message)?  actionSuccess,}) {final _that = this;
switch (_that) {
case FriendInitial() when initial != null:
return initial();case FriendLoading() when loading != null:
return loading();case FriendLoaded() when loaded != null:
return loaded(_that.friends,_that.receivedRequests,_that.sentRequests);case FriendSearchLoading() when searchLoading != null:
return searchLoading();case FriendSearchResult() when searchResult != null:
return searchResult(_that.user,_that.isFriend,_that.hasPendingRequest,_that.requestDirection,_that.searchedEmail,_that.isSelfSearch);case FriendStatusResult() when statusResult != null:
return statusResult(_that.status);case FriendError() when error != null:
return error(_that.message);case FriendActionSuccess() when actionSuccess != null:
return actionSuccess(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class FriendInitial implements FriendState {
  const FriendInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendState.initial()';
}


}




/// @nodoc


class FriendLoading implements FriendState {
  const FriendLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendState.loading()';
}


}




/// @nodoc


class FriendLoaded implements FriendState {
  const FriendLoaded({required final  List<UserEntity> friends, required final  List<FriendshipEntity> receivedRequests, required final  List<FriendshipEntity> sentRequests}): _friends = friends,_receivedRequests = receivedRequests,_sentRequests = sentRequests;
  

 final  List<UserEntity> _friends;
 List<UserEntity> get friends {
  if (_friends is EqualUnmodifiableListView) return _friends;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_friends);
}

 final  List<FriendshipEntity> _receivedRequests;
 List<FriendshipEntity> get receivedRequests {
  if (_receivedRequests is EqualUnmodifiableListView) return _receivedRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_receivedRequests);
}

 final  List<FriendshipEntity> _sentRequests;
 List<FriendshipEntity> get sentRequests {
  if (_sentRequests is EqualUnmodifiableListView) return _sentRequests;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sentRequests);
}


/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendLoadedCopyWith<FriendLoaded> get copyWith => _$FriendLoadedCopyWithImpl<FriendLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendLoaded&&const DeepCollectionEquality().equals(other._friends, _friends)&&const DeepCollectionEquality().equals(other._receivedRequests, _receivedRequests)&&const DeepCollectionEquality().equals(other._sentRequests, _sentRequests));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_friends),const DeepCollectionEquality().hash(_receivedRequests),const DeepCollectionEquality().hash(_sentRequests));

@override
String toString() {
  return 'FriendState.loaded(friends: $friends, receivedRequests: $receivedRequests, sentRequests: $sentRequests)';
}


}

/// @nodoc
abstract mixin class $FriendLoadedCopyWith<$Res> implements $FriendStateCopyWith<$Res> {
  factory $FriendLoadedCopyWith(FriendLoaded value, $Res Function(FriendLoaded) _then) = _$FriendLoadedCopyWithImpl;
@useResult
$Res call({
 List<UserEntity> friends, List<FriendshipEntity> receivedRequests, List<FriendshipEntity> sentRequests
});




}
/// @nodoc
class _$FriendLoadedCopyWithImpl<$Res>
    implements $FriendLoadedCopyWith<$Res> {
  _$FriendLoadedCopyWithImpl(this._self, this._then);

  final FriendLoaded _self;
  final $Res Function(FriendLoaded) _then;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? friends = null,Object? receivedRequests = null,Object? sentRequests = null,}) {
  return _then(FriendLoaded(
friends: null == friends ? _self._friends : friends // ignore: cast_nullable_to_non_nullable
as List<UserEntity>,receivedRequests: null == receivedRequests ? _self._receivedRequests : receivedRequests // ignore: cast_nullable_to_non_nullable
as List<FriendshipEntity>,sentRequests: null == sentRequests ? _self._sentRequests : sentRequests // ignore: cast_nullable_to_non_nullable
as List<FriendshipEntity>,
  ));
}


}

/// @nodoc


class FriendSearchLoading implements FriendState {
  const FriendSearchLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendSearchLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FriendState.searchLoading()';
}


}




/// @nodoc


class FriendSearchResult implements FriendState {
  const FriendSearchResult({this.user, required this.isFriend, required this.hasPendingRequest, this.requestDirection, required this.searchedEmail, this.isSelfSearch = false});
  

 final  UserEntity? user;
 final  bool isFriend;
 final  bool hasPendingRequest;
 final  String? requestDirection;
 final  String searchedEmail;
@JsonKey() final  bool isSelfSearch;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendSearchResultCopyWith<FriendSearchResult> get copyWith => _$FriendSearchResultCopyWithImpl<FriendSearchResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendSearchResult&&(identical(other.user, user) || other.user == user)&&(identical(other.isFriend, isFriend) || other.isFriend == isFriend)&&(identical(other.hasPendingRequest, hasPendingRequest) || other.hasPendingRequest == hasPendingRequest)&&(identical(other.requestDirection, requestDirection) || other.requestDirection == requestDirection)&&(identical(other.searchedEmail, searchedEmail) || other.searchedEmail == searchedEmail)&&(identical(other.isSelfSearch, isSelfSearch) || other.isSelfSearch == isSelfSearch));
}


@override
int get hashCode => Object.hash(runtimeType,user,isFriend,hasPendingRequest,requestDirection,searchedEmail,isSelfSearch);

@override
String toString() {
  return 'FriendState.searchResult(user: $user, isFriend: $isFriend, hasPendingRequest: $hasPendingRequest, requestDirection: $requestDirection, searchedEmail: $searchedEmail, isSelfSearch: $isSelfSearch)';
}


}

/// @nodoc
abstract mixin class $FriendSearchResultCopyWith<$Res> implements $FriendStateCopyWith<$Res> {
  factory $FriendSearchResultCopyWith(FriendSearchResult value, $Res Function(FriendSearchResult) _then) = _$FriendSearchResultCopyWithImpl;
@useResult
$Res call({
 UserEntity? user, bool isFriend, bool hasPendingRequest, String? requestDirection, String searchedEmail, bool isSelfSearch
});


$UserEntityCopyWith<$Res>? get user;

}
/// @nodoc
class _$FriendSearchResultCopyWithImpl<$Res>
    implements $FriendSearchResultCopyWith<$Res> {
  _$FriendSearchResultCopyWithImpl(this._self, this._then);

  final FriendSearchResult _self;
  final $Res Function(FriendSearchResult) _then;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = freezed,Object? isFriend = null,Object? hasPendingRequest = null,Object? requestDirection = freezed,Object? searchedEmail = null,Object? isSelfSearch = null,}) {
  return _then(FriendSearchResult(
user: freezed == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserEntity?,isFriend: null == isFriend ? _self.isFriend : isFriend // ignore: cast_nullable_to_non_nullable
as bool,hasPendingRequest: null == hasPendingRequest ? _self.hasPendingRequest : hasPendingRequest // ignore: cast_nullable_to_non_nullable
as bool,requestDirection: freezed == requestDirection ? _self.requestDirection : requestDirection // ignore: cast_nullable_to_non_nullable
as String?,searchedEmail: null == searchedEmail ? _self.searchedEmail : searchedEmail // ignore: cast_nullable_to_non_nullable
as String,isSelfSearch: null == isSelfSearch ? _self.isSelfSearch : isSelfSearch // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserEntityCopyWith<$Res>? get user {
    if (_self.user == null) {
    return null;
  }

  return $UserEntityCopyWith<$Res>(_self.user!, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class FriendStatusResult implements FriendState {
  const FriendStatusResult({required this.status});
  

 final  FriendshipStatusResult status;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendStatusResultCopyWith<FriendStatusResult> get copyWith => _$FriendStatusResultCopyWithImpl<FriendStatusResult>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendStatusResult&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'FriendState.statusResult(status: $status)';
}


}

/// @nodoc
abstract mixin class $FriendStatusResultCopyWith<$Res> implements $FriendStateCopyWith<$Res> {
  factory $FriendStatusResultCopyWith(FriendStatusResult value, $Res Function(FriendStatusResult) _then) = _$FriendStatusResultCopyWithImpl;
@useResult
$Res call({
 FriendshipStatusResult status
});


$FriendshipStatusResultCopyWith<$Res> get status;

}
/// @nodoc
class _$FriendStatusResultCopyWithImpl<$Res>
    implements $FriendStatusResultCopyWith<$Res> {
  _$FriendStatusResultCopyWithImpl(this._self, this._then);

  final FriendStatusResult _self;
  final $Res Function(FriendStatusResult) _then;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(FriendStatusResult(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FriendshipStatusResult,
  ));
}

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FriendshipStatusResultCopyWith<$Res> get status {
  
  return $FriendshipStatusResultCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc


class FriendError implements FriendState {
  const FriendError({required this.message});
  

 final  String message;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendErrorCopyWith<FriendError> get copyWith => _$FriendErrorCopyWithImpl<FriendError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FriendState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $FriendErrorCopyWith<$Res> implements $FriendStateCopyWith<$Res> {
  factory $FriendErrorCopyWith(FriendError value, $Res Function(FriendError) _then) = _$FriendErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FriendErrorCopyWithImpl<$Res>
    implements $FriendErrorCopyWith<$Res> {
  _$FriendErrorCopyWithImpl(this._self, this._then);

  final FriendError _self;
  final $Res Function(FriendError) _then;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FriendError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class FriendActionSuccess implements FriendState {
  const FriendActionSuccess({required this.message});
  

 final  String message;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FriendActionSuccessCopyWith<FriendActionSuccess> get copyWith => _$FriendActionSuccessCopyWithImpl<FriendActionSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FriendActionSuccess&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'FriendState.actionSuccess(message: $message)';
}


}

/// @nodoc
abstract mixin class $FriendActionSuccessCopyWith<$Res> implements $FriendStateCopyWith<$Res> {
  factory $FriendActionSuccessCopyWith(FriendActionSuccess value, $Res Function(FriendActionSuccess) _then) = _$FriendActionSuccessCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$FriendActionSuccessCopyWithImpl<$Res>
    implements $FriendActionSuccessCopyWith<$Res> {
  _$FriendActionSuccessCopyWithImpl(this._self, this._then);

  final FriendActionSuccess _self;
  final $Res Function(FriendActionSuccess) _then;

/// Create a copy of FriendState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(FriendActionSuccess(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
