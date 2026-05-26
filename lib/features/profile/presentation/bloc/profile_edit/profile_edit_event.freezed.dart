// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEditEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditEvent()';
}


}

/// @nodoc
class $ProfileEditEventCopyWith<$Res>  {
$ProfileEditEventCopyWith(ProfileEditEvent _, $Res Function(ProfileEditEvent) __);
}


/// Adds pattern-matching-related methods to [ProfileEditEvent].
extension ProfileEditEventPatterns on ProfileEditEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileEditStarted value)?  started,TResult Function( ProfileEditDisplayNameChanged value)?  displayNameChanged,TResult Function( ProfileEditPhotoUrlChanged value)?  photoUrlChanged,TResult Function( ProfileEditSaveRequested value)?  saveRequested,TResult Function( ProfileEditCancelled value)?  cancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileEditStarted() when started != null:
return started(_that);case ProfileEditDisplayNameChanged() when displayNameChanged != null:
return displayNameChanged(_that);case ProfileEditPhotoUrlChanged() when photoUrlChanged != null:
return photoUrlChanged(_that);case ProfileEditSaveRequested() when saveRequested != null:
return saveRequested(_that);case ProfileEditCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileEditStarted value)  started,required TResult Function( ProfileEditDisplayNameChanged value)  displayNameChanged,required TResult Function( ProfileEditPhotoUrlChanged value)  photoUrlChanged,required TResult Function( ProfileEditSaveRequested value)  saveRequested,required TResult Function( ProfileEditCancelled value)  cancelled,}){
final _that = this;
switch (_that) {
case ProfileEditStarted():
return started(_that);case ProfileEditDisplayNameChanged():
return displayNameChanged(_that);case ProfileEditPhotoUrlChanged():
return photoUrlChanged(_that);case ProfileEditSaveRequested():
return saveRequested(_that);case ProfileEditCancelled():
return cancelled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileEditStarted value)?  started,TResult? Function( ProfileEditDisplayNameChanged value)?  displayNameChanged,TResult? Function( ProfileEditPhotoUrlChanged value)?  photoUrlChanged,TResult? Function( ProfileEditSaveRequested value)?  saveRequested,TResult? Function( ProfileEditCancelled value)?  cancelled,}){
final _that = this;
switch (_that) {
case ProfileEditStarted() when started != null:
return started(_that);case ProfileEditDisplayNameChanged() when displayNameChanged != null:
return displayNameChanged(_that);case ProfileEditPhotoUrlChanged() when photoUrlChanged != null:
return photoUrlChanged(_that);case ProfileEditSaveRequested() when saveRequested != null:
return saveRequested(_that);case ProfileEditCancelled() when cancelled != null:
return cancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String currentDisplayName,  String? currentPhotoUrl)?  started,TResult Function( String displayName)?  displayNameChanged,TResult Function( String photoUrl)?  photoUrlChanged,TResult Function()?  saveRequested,TResult Function()?  cancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileEditStarted() when started != null:
return started(_that.currentDisplayName,_that.currentPhotoUrl);case ProfileEditDisplayNameChanged() when displayNameChanged != null:
return displayNameChanged(_that.displayName);case ProfileEditPhotoUrlChanged() when photoUrlChanged != null:
return photoUrlChanged(_that.photoUrl);case ProfileEditSaveRequested() when saveRequested != null:
return saveRequested();case ProfileEditCancelled() when cancelled != null:
return cancelled();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String currentDisplayName,  String? currentPhotoUrl)  started,required TResult Function( String displayName)  displayNameChanged,required TResult Function( String photoUrl)  photoUrlChanged,required TResult Function()  saveRequested,required TResult Function()  cancelled,}) {final _that = this;
switch (_that) {
case ProfileEditStarted():
return started(_that.currentDisplayName,_that.currentPhotoUrl);case ProfileEditDisplayNameChanged():
return displayNameChanged(_that.displayName);case ProfileEditPhotoUrlChanged():
return photoUrlChanged(_that.photoUrl);case ProfileEditSaveRequested():
return saveRequested();case ProfileEditCancelled():
return cancelled();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String currentDisplayName,  String? currentPhotoUrl)?  started,TResult? Function( String displayName)?  displayNameChanged,TResult? Function( String photoUrl)?  photoUrlChanged,TResult? Function()?  saveRequested,TResult? Function()?  cancelled,}) {final _that = this;
switch (_that) {
case ProfileEditStarted() when started != null:
return started(_that.currentDisplayName,_that.currentPhotoUrl);case ProfileEditDisplayNameChanged() when displayNameChanged != null:
return displayNameChanged(_that.displayName);case ProfileEditPhotoUrlChanged() when photoUrlChanged != null:
return photoUrlChanged(_that.photoUrl);case ProfileEditSaveRequested() when saveRequested != null:
return saveRequested();case ProfileEditCancelled() when cancelled != null:
return cancelled();case _:
  return null;

}
}

}

/// @nodoc


class ProfileEditStarted implements ProfileEditEvent {
  const ProfileEditStarted({required this.currentDisplayName, this.currentPhotoUrl});
  

 final  String currentDisplayName;
 final  String? currentPhotoUrl;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditStartedCopyWith<ProfileEditStarted> get copyWith => _$ProfileEditStartedCopyWithImpl<ProfileEditStarted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditStarted&&(identical(other.currentDisplayName, currentDisplayName) || other.currentDisplayName == currentDisplayName)&&(identical(other.currentPhotoUrl, currentPhotoUrl) || other.currentPhotoUrl == currentPhotoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,currentDisplayName,currentPhotoUrl);

@override
String toString() {
  return 'ProfileEditEvent.started(currentDisplayName: $currentDisplayName, currentPhotoUrl: $currentPhotoUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileEditStartedCopyWith<$Res> implements $ProfileEditEventCopyWith<$Res> {
  factory $ProfileEditStartedCopyWith(ProfileEditStarted value, $Res Function(ProfileEditStarted) _then) = _$ProfileEditStartedCopyWithImpl;
@useResult
$Res call({
 String currentDisplayName, String? currentPhotoUrl
});




}
/// @nodoc
class _$ProfileEditStartedCopyWithImpl<$Res>
    implements $ProfileEditStartedCopyWith<$Res> {
  _$ProfileEditStartedCopyWithImpl(this._self, this._then);

  final ProfileEditStarted _self;
  final $Res Function(ProfileEditStarted) _then;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? currentDisplayName = null,Object? currentPhotoUrl = freezed,}) {
  return _then(ProfileEditStarted(
currentDisplayName: null == currentDisplayName ? _self.currentDisplayName : currentDisplayName // ignore: cast_nullable_to_non_nullable
as String,currentPhotoUrl: freezed == currentPhotoUrl ? _self.currentPhotoUrl : currentPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ProfileEditDisplayNameChanged implements ProfileEditEvent {
  const ProfileEditDisplayNameChanged(this.displayName);
  

 final  String displayName;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditDisplayNameChangedCopyWith<ProfileEditDisplayNameChanged> get copyWith => _$ProfileEditDisplayNameChangedCopyWithImpl<ProfileEditDisplayNameChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditDisplayNameChanged&&(identical(other.displayName, displayName) || other.displayName == displayName));
}


@override
int get hashCode => Object.hash(runtimeType,displayName);

@override
String toString() {
  return 'ProfileEditEvent.displayNameChanged(displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $ProfileEditDisplayNameChangedCopyWith<$Res> implements $ProfileEditEventCopyWith<$Res> {
  factory $ProfileEditDisplayNameChangedCopyWith(ProfileEditDisplayNameChanged value, $Res Function(ProfileEditDisplayNameChanged) _then) = _$ProfileEditDisplayNameChangedCopyWithImpl;
@useResult
$Res call({
 String displayName
});




}
/// @nodoc
class _$ProfileEditDisplayNameChangedCopyWithImpl<$Res>
    implements $ProfileEditDisplayNameChangedCopyWith<$Res> {
  _$ProfileEditDisplayNameChangedCopyWithImpl(this._self, this._then);

  final ProfileEditDisplayNameChanged _self;
  final $Res Function(ProfileEditDisplayNameChanged) _then;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,}) {
  return _then(ProfileEditDisplayNameChanged(
null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfileEditPhotoUrlChanged implements ProfileEditEvent {
  const ProfileEditPhotoUrlChanged(this.photoUrl);
  

 final  String photoUrl;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditPhotoUrlChangedCopyWith<ProfileEditPhotoUrlChanged> get copyWith => _$ProfileEditPhotoUrlChangedCopyWithImpl<ProfileEditPhotoUrlChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditPhotoUrlChanged&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,photoUrl);

@override
String toString() {
  return 'ProfileEditEvent.photoUrlChanged(photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileEditPhotoUrlChangedCopyWith<$Res> implements $ProfileEditEventCopyWith<$Res> {
  factory $ProfileEditPhotoUrlChangedCopyWith(ProfileEditPhotoUrlChanged value, $Res Function(ProfileEditPhotoUrlChanged) _then) = _$ProfileEditPhotoUrlChangedCopyWithImpl;
@useResult
$Res call({
 String photoUrl
});




}
/// @nodoc
class _$ProfileEditPhotoUrlChangedCopyWithImpl<$Res>
    implements $ProfileEditPhotoUrlChangedCopyWith<$Res> {
  _$ProfileEditPhotoUrlChangedCopyWithImpl(this._self, this._then);

  final ProfileEditPhotoUrlChanged _self;
  final $Res Function(ProfileEditPhotoUrlChanged) _then;

/// Create a copy of ProfileEditEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? photoUrl = null,}) {
  return _then(ProfileEditPhotoUrlChanged(
null == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class ProfileEditSaveRequested implements ProfileEditEvent {
  const ProfileEditSaveRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditSaveRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditEvent.saveRequested()';
}


}




/// @nodoc


class ProfileEditCancelled implements ProfileEditEvent {
  const ProfileEditCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditEvent.cancelled()';
}


}




// dart format on
