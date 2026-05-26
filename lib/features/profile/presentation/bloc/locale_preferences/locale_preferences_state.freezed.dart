// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_preferences_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalePreferencesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesState()';
}


}

/// @nodoc
class $LocalePreferencesStateCopyWith<$Res>  {
$LocalePreferencesStateCopyWith(LocalePreferencesState _, $Res Function(LocalePreferencesState) __);
}


/// Adds pattern-matching-related methods to [LocalePreferencesState].
extension LocalePreferencesStatePatterns on LocalePreferencesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LocalePreferencesInitial value)?  initial,TResult Function( LocalePreferencesLoading value)?  loading,TResult Function( LocalePreferencesLoaded value)?  loaded,TResult Function( LocalePreferencesSaving value)?  saving,TResult Function( LocalePreferencesSaved value)?  saved,TResult Function( LocalePreferencesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LocalePreferencesInitial() when initial != null:
return initial(_that);case LocalePreferencesLoading() when loading != null:
return loading(_that);case LocalePreferencesLoaded() when loaded != null:
return loaded(_that);case LocalePreferencesSaving() when saving != null:
return saving(_that);case LocalePreferencesSaved() when saved != null:
return saved(_that);case LocalePreferencesError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LocalePreferencesInitial value)  initial,required TResult Function( LocalePreferencesLoading value)  loading,required TResult Function( LocalePreferencesLoaded value)  loaded,required TResult Function( LocalePreferencesSaving value)  saving,required TResult Function( LocalePreferencesSaved value)  saved,required TResult Function( LocalePreferencesError value)  error,}){
final _that = this;
switch (_that) {
case LocalePreferencesInitial():
return initial(_that);case LocalePreferencesLoading():
return loading(_that);case LocalePreferencesLoaded():
return loaded(_that);case LocalePreferencesSaving():
return saving(_that);case LocalePreferencesSaved():
return saved(_that);case LocalePreferencesError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LocalePreferencesInitial value)?  initial,TResult? Function( LocalePreferencesLoading value)?  loading,TResult? Function( LocalePreferencesLoaded value)?  loaded,TResult? Function( LocalePreferencesSaving value)?  saving,TResult? Function( LocalePreferencesSaved value)?  saved,TResult? Function( LocalePreferencesError value)?  error,}){
final _that = this;
switch (_that) {
case LocalePreferencesInitial() when initial != null:
return initial(_that);case LocalePreferencesLoading() when loading != null:
return loading(_that);case LocalePreferencesLoaded() when loaded != null:
return loaded(_that);case LocalePreferencesSaving() when saving != null:
return saving(_that);case LocalePreferencesSaved() when saved != null:
return saved(_that);case LocalePreferencesError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( LocalePreferencesEntity preferences,  bool hasUnsavedChanges)?  loaded,TResult Function( LocalePreferencesEntity preferences)?  saving,TResult Function()?  saved,TResult Function( String message,  LocalePreferencesEntity? preferences)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LocalePreferencesInitial() when initial != null:
return initial();case LocalePreferencesLoading() when loading != null:
return loading();case LocalePreferencesLoaded() when loaded != null:
return loaded(_that.preferences,_that.hasUnsavedChanges);case LocalePreferencesSaving() when saving != null:
return saving(_that.preferences);case LocalePreferencesSaved() when saved != null:
return saved();case LocalePreferencesError() when error != null:
return error(_that.message,_that.preferences);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( LocalePreferencesEntity preferences,  bool hasUnsavedChanges)  loaded,required TResult Function( LocalePreferencesEntity preferences)  saving,required TResult Function()  saved,required TResult Function( String message,  LocalePreferencesEntity? preferences)  error,}) {final _that = this;
switch (_that) {
case LocalePreferencesInitial():
return initial();case LocalePreferencesLoading():
return loading();case LocalePreferencesLoaded():
return loaded(_that.preferences,_that.hasUnsavedChanges);case LocalePreferencesSaving():
return saving(_that.preferences);case LocalePreferencesSaved():
return saved();case LocalePreferencesError():
return error(_that.message,_that.preferences);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( LocalePreferencesEntity preferences,  bool hasUnsavedChanges)?  loaded,TResult? Function( LocalePreferencesEntity preferences)?  saving,TResult? Function()?  saved,TResult? Function( String message,  LocalePreferencesEntity? preferences)?  error,}) {final _that = this;
switch (_that) {
case LocalePreferencesInitial() when initial != null:
return initial();case LocalePreferencesLoading() when loading != null:
return loading();case LocalePreferencesLoaded() when loaded != null:
return loaded(_that.preferences,_that.hasUnsavedChanges);case LocalePreferencesSaving() when saving != null:
return saving(_that.preferences);case LocalePreferencesSaved() when saved != null:
return saved();case LocalePreferencesError() when error != null:
return error(_that.message,_that.preferences);case _:
  return null;

}
}

}

/// @nodoc


class LocalePreferencesInitial implements LocalePreferencesState {
  const LocalePreferencesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesState.initial()';
}


}




/// @nodoc


class LocalePreferencesLoading implements LocalePreferencesState {
  const LocalePreferencesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesState.loading()';
}


}




/// @nodoc


class LocalePreferencesLoaded implements LocalePreferencesState {
  const LocalePreferencesLoaded({required this.preferences, required this.hasUnsavedChanges});
  

 final  LocalePreferencesEntity preferences;
 final  bool hasUnsavedChanges;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalePreferencesLoadedCopyWith<LocalePreferencesLoaded> get copyWith => _$LocalePreferencesLoadedCopyWithImpl<LocalePreferencesLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesLoaded&&(identical(other.preferences, preferences) || other.preferences == preferences)&&(identical(other.hasUnsavedChanges, hasUnsavedChanges) || other.hasUnsavedChanges == hasUnsavedChanges));
}


@override
int get hashCode => Object.hash(runtimeType,preferences,hasUnsavedChanges);

@override
String toString() {
  return 'LocalePreferencesState.loaded(preferences: $preferences, hasUnsavedChanges: $hasUnsavedChanges)';
}


}

/// @nodoc
abstract mixin class $LocalePreferencesLoadedCopyWith<$Res> implements $LocalePreferencesStateCopyWith<$Res> {
  factory $LocalePreferencesLoadedCopyWith(LocalePreferencesLoaded value, $Res Function(LocalePreferencesLoaded) _then) = _$LocalePreferencesLoadedCopyWithImpl;
@useResult
$Res call({
 LocalePreferencesEntity preferences, bool hasUnsavedChanges
});


$LocalePreferencesEntityCopyWith<$Res> get preferences;

}
/// @nodoc
class _$LocalePreferencesLoadedCopyWithImpl<$Res>
    implements $LocalePreferencesLoadedCopyWith<$Res> {
  _$LocalePreferencesLoadedCopyWithImpl(this._self, this._then);

  final LocalePreferencesLoaded _self;
  final $Res Function(LocalePreferencesLoaded) _then;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preferences = null,Object? hasUnsavedChanges = null,}) {
  return _then(LocalePreferencesLoaded(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as LocalePreferencesEntity,hasUnsavedChanges: null == hasUnsavedChanges ? _self.hasUnsavedChanges : hasUnsavedChanges // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalePreferencesEntityCopyWith<$Res> get preferences {
  
  return $LocalePreferencesEntityCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

/// @nodoc


class LocalePreferencesSaving implements LocalePreferencesState {
  const LocalePreferencesSaving({required this.preferences});
  

 final  LocalePreferencesEntity preferences;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalePreferencesSavingCopyWith<LocalePreferencesSaving> get copyWith => _$LocalePreferencesSavingCopyWithImpl<LocalePreferencesSaving>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesSaving&&(identical(other.preferences, preferences) || other.preferences == preferences));
}


@override
int get hashCode => Object.hash(runtimeType,preferences);

@override
String toString() {
  return 'LocalePreferencesState.saving(preferences: $preferences)';
}


}

/// @nodoc
abstract mixin class $LocalePreferencesSavingCopyWith<$Res> implements $LocalePreferencesStateCopyWith<$Res> {
  factory $LocalePreferencesSavingCopyWith(LocalePreferencesSaving value, $Res Function(LocalePreferencesSaving) _then) = _$LocalePreferencesSavingCopyWithImpl;
@useResult
$Res call({
 LocalePreferencesEntity preferences
});


$LocalePreferencesEntityCopyWith<$Res> get preferences;

}
/// @nodoc
class _$LocalePreferencesSavingCopyWithImpl<$Res>
    implements $LocalePreferencesSavingCopyWith<$Res> {
  _$LocalePreferencesSavingCopyWithImpl(this._self, this._then);

  final LocalePreferencesSaving _self;
  final $Res Function(LocalePreferencesSaving) _then;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preferences = null,}) {
  return _then(LocalePreferencesSaving(
preferences: null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as LocalePreferencesEntity,
  ));
}

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalePreferencesEntityCopyWith<$Res> get preferences {
  
  return $LocalePreferencesEntityCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

/// @nodoc


class LocalePreferencesSaved implements LocalePreferencesState {
  const LocalePreferencesSaved();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesSaved);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesState.saved()';
}


}




/// @nodoc


class LocalePreferencesError implements LocalePreferencesState {
  const LocalePreferencesError({required this.message, this.preferences});
  

 final  String message;
 final  LocalePreferencesEntity? preferences;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalePreferencesErrorCopyWith<LocalePreferencesError> get copyWith => _$LocalePreferencesErrorCopyWithImpl<LocalePreferencesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesError&&(identical(other.message, message) || other.message == message)&&(identical(other.preferences, preferences) || other.preferences == preferences));
}


@override
int get hashCode => Object.hash(runtimeType,message,preferences);

@override
String toString() {
  return 'LocalePreferencesState.error(message: $message, preferences: $preferences)';
}


}

/// @nodoc
abstract mixin class $LocalePreferencesErrorCopyWith<$Res> implements $LocalePreferencesStateCopyWith<$Res> {
  factory $LocalePreferencesErrorCopyWith(LocalePreferencesError value, $Res Function(LocalePreferencesError) _then) = _$LocalePreferencesErrorCopyWithImpl;
@useResult
$Res call({
 String message, LocalePreferencesEntity? preferences
});


$LocalePreferencesEntityCopyWith<$Res>? get preferences;

}
/// @nodoc
class _$LocalePreferencesErrorCopyWithImpl<$Res>
    implements $LocalePreferencesErrorCopyWith<$Res> {
  _$LocalePreferencesErrorCopyWithImpl(this._self, this._then);

  final LocalePreferencesError _self;
  final $Res Function(LocalePreferencesError) _then;

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? preferences = freezed,}) {
  return _then(LocalePreferencesError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,preferences: freezed == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as LocalePreferencesEntity?,
  ));
}

/// Create a copy of LocalePreferencesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocalePreferencesEntityCopyWith<$Res>? get preferences {
    if (_self.preferences == null) {
    return null;
  }

  return $LocalePreferencesEntityCopyWith<$Res>(_self.preferences!, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

// dart format on
