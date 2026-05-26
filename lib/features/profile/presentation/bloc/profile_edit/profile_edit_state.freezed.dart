// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_edit_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileEditState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState()';
}


}

/// @nodoc
class $ProfileEditStateCopyWith<$Res>  {
$ProfileEditStateCopyWith(ProfileEditState _, $Res Function(ProfileEditState) __);
}


/// Adds pattern-matching-related methods to [ProfileEditState].
extension ProfileEditStatePatterns on ProfileEditState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ProfileEditInitial value)?  initial,TResult Function( ProfileEditLoading value)?  loading,TResult Function( ProfileEditLoaded value)?  loaded,TResult Function( ProfileEditSaving value)?  saving,TResult Function( ProfileEditSuccess value)?  success,TResult Function( ProfileEditError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial(_that);case ProfileEditLoading() when loading != null:
return loading(_that);case ProfileEditLoaded() when loaded != null:
return loaded(_that);case ProfileEditSaving() when saving != null:
return saving(_that);case ProfileEditSuccess() when success != null:
return success(_that);case ProfileEditError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ProfileEditInitial value)  initial,required TResult Function( ProfileEditLoading value)  loading,required TResult Function( ProfileEditLoaded value)  loaded,required TResult Function( ProfileEditSaving value)  saving,required TResult Function( ProfileEditSuccess value)  success,required TResult Function( ProfileEditError value)  error,}){
final _that = this;
switch (_that) {
case ProfileEditInitial():
return initial(_that);case ProfileEditLoading():
return loading(_that);case ProfileEditLoaded():
return loaded(_that);case ProfileEditSaving():
return saving(_that);case ProfileEditSuccess():
return success(_that);case ProfileEditError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ProfileEditInitial value)?  initial,TResult? Function( ProfileEditLoading value)?  loading,TResult? Function( ProfileEditLoaded value)?  loaded,TResult? Function( ProfileEditSaving value)?  saving,TResult? Function( ProfileEditSuccess value)?  success,TResult? Function( ProfileEditError value)?  error,}){
final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial(_that);case ProfileEditLoading() when loading != null:
return loading(_that);case ProfileEditLoaded() when loaded != null:
return loaded(_that);case ProfileEditSaving() when saving != null:
return saving(_that);case ProfileEditSuccess() when success != null:
return success(_that);case ProfileEditError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( String displayName,  String? photoUrl,  String? displayNameError,  String? photoUrlError,  bool hasUnsavedChanges)?  loaded,TResult Function( String displayName,  String? photoUrl)?  saving,TResult Function()?  success,TResult Function( String message,  String displayName,  String? photoUrl)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial();case ProfileEditLoading() when loading != null:
return loading();case ProfileEditLoaded() when loaded != null:
return loaded(_that.displayName,_that.photoUrl,_that.displayNameError,_that.photoUrlError,_that.hasUnsavedChanges);case ProfileEditSaving() when saving != null:
return saving(_that.displayName,_that.photoUrl);case ProfileEditSuccess() when success != null:
return success();case ProfileEditError() when error != null:
return error(_that.message,_that.displayName,_that.photoUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( String displayName,  String? photoUrl,  String? displayNameError,  String? photoUrlError,  bool hasUnsavedChanges)  loaded,required TResult Function( String displayName,  String? photoUrl)  saving,required TResult Function()  success,required TResult Function( String message,  String displayName,  String? photoUrl)  error,}) {final _that = this;
switch (_that) {
case ProfileEditInitial():
return initial();case ProfileEditLoading():
return loading();case ProfileEditLoaded():
return loaded(_that.displayName,_that.photoUrl,_that.displayNameError,_that.photoUrlError,_that.hasUnsavedChanges);case ProfileEditSaving():
return saving(_that.displayName,_that.photoUrl);case ProfileEditSuccess():
return success();case ProfileEditError():
return error(_that.message,_that.displayName,_that.photoUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( String displayName,  String? photoUrl,  String? displayNameError,  String? photoUrlError,  bool hasUnsavedChanges)?  loaded,TResult? Function( String displayName,  String? photoUrl)?  saving,TResult? Function()?  success,TResult? Function( String message,  String displayName,  String? photoUrl)?  error,}) {final _that = this;
switch (_that) {
case ProfileEditInitial() when initial != null:
return initial();case ProfileEditLoading() when loading != null:
return loading();case ProfileEditLoaded() when loaded != null:
return loaded(_that.displayName,_that.photoUrl,_that.displayNameError,_that.photoUrlError,_that.hasUnsavedChanges);case ProfileEditSaving() when saving != null:
return saving(_that.displayName,_that.photoUrl);case ProfileEditSuccess() when success != null:
return success();case ProfileEditError() when error != null:
return error(_that.message,_that.displayName,_that.photoUrl);case _:
  return null;

}
}

}

/// @nodoc


class ProfileEditInitial implements ProfileEditState {
  const ProfileEditInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState.initial()';
}


}




/// @nodoc


class ProfileEditLoading implements ProfileEditState {
  const ProfileEditLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState.loading()';
}


}




/// @nodoc


class ProfileEditLoaded implements ProfileEditState {
  const ProfileEditLoaded({required this.displayName, this.photoUrl, this.displayNameError, this.photoUrlError, this.hasUnsavedChanges = false});
  

 final  String displayName;
 final  String? photoUrl;
 final  String? displayNameError;
 final  String? photoUrlError;
@JsonKey() final  bool hasUnsavedChanges;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditLoadedCopyWith<ProfileEditLoaded> get copyWith => _$ProfileEditLoadedCopyWithImpl<ProfileEditLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditLoaded&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.displayNameError, displayNameError) || other.displayNameError == displayNameError)&&(identical(other.photoUrlError, photoUrlError) || other.photoUrlError == photoUrlError)&&(identical(other.hasUnsavedChanges, hasUnsavedChanges) || other.hasUnsavedChanges == hasUnsavedChanges));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,photoUrl,displayNameError,photoUrlError,hasUnsavedChanges);

@override
String toString() {
  return 'ProfileEditState.loaded(displayName: $displayName, photoUrl: $photoUrl, displayNameError: $displayNameError, photoUrlError: $photoUrlError, hasUnsavedChanges: $hasUnsavedChanges)';
}


}

/// @nodoc
abstract mixin class $ProfileEditLoadedCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditLoadedCopyWith(ProfileEditLoaded value, $Res Function(ProfileEditLoaded) _then) = _$ProfileEditLoadedCopyWithImpl;
@useResult
$Res call({
 String displayName, String? photoUrl, String? displayNameError, String? photoUrlError, bool hasUnsavedChanges
});




}
/// @nodoc
class _$ProfileEditLoadedCopyWithImpl<$Res>
    implements $ProfileEditLoadedCopyWith<$Res> {
  _$ProfileEditLoadedCopyWithImpl(this._self, this._then);

  final ProfileEditLoaded _self;
  final $Res Function(ProfileEditLoaded) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? photoUrl = freezed,Object? displayNameError = freezed,Object? photoUrlError = freezed,Object? hasUnsavedChanges = null,}) {
  return _then(ProfileEditLoaded(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,displayNameError: freezed == displayNameError ? _self.displayNameError : displayNameError // ignore: cast_nullable_to_non_nullable
as String?,photoUrlError: freezed == photoUrlError ? _self.photoUrlError : photoUrlError // ignore: cast_nullable_to_non_nullable
as String?,hasUnsavedChanges: null == hasUnsavedChanges ? _self.hasUnsavedChanges : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class ProfileEditSaving implements ProfileEditState {
  const ProfileEditSaving({required this.displayName, this.photoUrl});
  

 final  String displayName;
 final  String? photoUrl;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditSavingCopyWith<ProfileEditSaving> get copyWith => _$ProfileEditSavingCopyWithImpl<ProfileEditSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditSaving&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,displayName,photoUrl);

@override
String toString() {
  return 'ProfileEditState.saving(displayName: $displayName, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileEditSavingCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditSavingCopyWith(ProfileEditSaving value, $Res Function(ProfileEditSaving) _then) = _$ProfileEditSavingCopyWithImpl;
@useResult
$Res call({
 String displayName, String? photoUrl
});




}
/// @nodoc
class _$ProfileEditSavingCopyWithImpl<$Res>
    implements $ProfileEditSavingCopyWith<$Res> {
  _$ProfileEditSavingCopyWithImpl(this._self, this._then);

  final ProfileEditSaving _self;
  final $Res Function(ProfileEditSaving) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? displayName = null,Object? photoUrl = freezed,}) {
  return _then(ProfileEditSaving(
displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class ProfileEditSuccess implements ProfileEditState {
  const ProfileEditSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ProfileEditState.success()';
}


}




/// @nodoc


class ProfileEditError implements ProfileEditState {
  const ProfileEditError({required this.message, required this.displayName, this.photoUrl});
  

 final  String message;
 final  String displayName;
 final  String? photoUrl;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileEditErrorCopyWith<ProfileEditError> get copyWith => _$ProfileEditErrorCopyWithImpl<ProfileEditError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileEditError&&(identical(other.message, message) || other.message == message)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl));
}


@override
int get hashCode => Object.hash(runtimeType,message,displayName,photoUrl);

@override
String toString() {
  return 'ProfileEditState.error(message: $message, displayName: $displayName, photoUrl: $photoUrl)';
}


}

/// @nodoc
abstract mixin class $ProfileEditErrorCopyWith<$Res> implements $ProfileEditStateCopyWith<$Res> {
  factory $ProfileEditErrorCopyWith(ProfileEditError value, $Res Function(ProfileEditError) _then) = _$ProfileEditErrorCopyWithImpl;
@useResult
$Res call({
 String message, String displayName, String? photoUrl
});




}
/// @nodoc
class _$ProfileEditErrorCopyWithImpl<$Res>
    implements $ProfileEditErrorCopyWith<$Res> {
  _$ProfileEditErrorCopyWithImpl(this._self, this._then);

  final ProfileEditError _self;
  final $Res Function(ProfileEditError) _then;

/// Create a copy of ProfileEditState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? displayName = null,Object? photoUrl = freezed,}) {
  return _then(ProfileEditError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
