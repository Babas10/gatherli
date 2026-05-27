// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_preferences_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalePreferencesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesEvent()';
}


}

/// @nodoc
class $LocalePreferencesEventCopyWith<$Res>  {
$LocalePreferencesEventCopyWith(LocalePreferencesEvent _, $Res Function(LocalePreferencesEvent) __);
}


/// Adds pattern-matching-related methods to [LocalePreferencesEvent].
extension LocalePreferencesEventPatterns on LocalePreferencesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadPreferences value)?  loadPreferences,TResult Function( UpdateLanguage value)?  updateLanguage,TResult Function( UpdateCountry value)?  updateCountry,TResult Function( SavePreferences value)?  savePreferences,TResult Function( LoadFromFirestore value)?  loadFromFirestore,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadPreferences() when loadPreferences != null:
return loadPreferences(_that);case UpdateLanguage() when updateLanguage != null:
return updateLanguage(_that);case UpdateCountry() when updateCountry != null:
return updateCountry(_that);case SavePreferences() when savePreferences != null:
return savePreferences(_that);case LoadFromFirestore() when loadFromFirestore != null:
return loadFromFirestore(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadPreferences value)  loadPreferences,required TResult Function( UpdateLanguage value)  updateLanguage,required TResult Function( UpdateCountry value)  updateCountry,required TResult Function( SavePreferences value)  savePreferences,required TResult Function( LoadFromFirestore value)  loadFromFirestore,}){
final _that = this;
switch (_that) {
case LoadPreferences():
return loadPreferences(_that);case UpdateLanguage():
return updateLanguage(_that);case UpdateCountry():
return updateCountry(_that);case SavePreferences():
return savePreferences(_that);case LoadFromFirestore():
return loadFromFirestore(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadPreferences value)?  loadPreferences,TResult? Function( UpdateLanguage value)?  updateLanguage,TResult? Function( UpdateCountry value)?  updateCountry,TResult? Function( SavePreferences value)?  savePreferences,TResult? Function( LoadFromFirestore value)?  loadFromFirestore,}){
final _that = this;
switch (_that) {
case LoadPreferences() when loadPreferences != null:
return loadPreferences(_that);case UpdateLanguage() when updateLanguage != null:
return updateLanguage(_that);case UpdateCountry() when updateCountry != null:
return updateCountry(_that);case SavePreferences() when savePreferences != null:
return savePreferences(_that);case LoadFromFirestore() when loadFromFirestore != null:
return loadFromFirestore(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadPreferences,TResult Function( Locale locale)?  updateLanguage,TResult Function( String country)?  updateCountry,TResult Function( String userId)?  savePreferences,TResult Function( String userId)?  loadFromFirestore,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadPreferences() when loadPreferences != null:
return loadPreferences();case UpdateLanguage() when updateLanguage != null:
return updateLanguage(_that.locale);case UpdateCountry() when updateCountry != null:
return updateCountry(_that.country);case SavePreferences() when savePreferences != null:
return savePreferences(_that.userId);case LoadFromFirestore() when loadFromFirestore != null:
return loadFromFirestore(_that.userId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadPreferences,required TResult Function( Locale locale)  updateLanguage,required TResult Function( String country)  updateCountry,required TResult Function( String userId)  savePreferences,required TResult Function( String userId)  loadFromFirestore,}) {final _that = this;
switch (_that) {
case LoadPreferences():
return loadPreferences();case UpdateLanguage():
return updateLanguage(_that.locale);case UpdateCountry():
return updateCountry(_that.country);case SavePreferences():
return savePreferences(_that.userId);case LoadFromFirestore():
return loadFromFirestore(_that.userId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadPreferences,TResult? Function( Locale locale)?  updateLanguage,TResult? Function( String country)?  updateCountry,TResult? Function( String userId)?  savePreferences,TResult? Function( String userId)?  loadFromFirestore,}) {final _that = this;
switch (_that) {
case LoadPreferences() when loadPreferences != null:
return loadPreferences();case UpdateLanguage() when updateLanguage != null:
return updateLanguage(_that.locale);case UpdateCountry() when updateCountry != null:
return updateCountry(_that.country);case SavePreferences() when savePreferences != null:
return savePreferences(_that.userId);case LoadFromFirestore() when loadFromFirestore != null:
return loadFromFirestore(_that.userId);case _:
  return null;

}
}

}

/// @nodoc


class LoadPreferences implements LocalePreferencesEvent {
  const LoadPreferences();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadPreferences);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LocalePreferencesEvent.loadPreferences()';
}


}




/// @nodoc


class UpdateLanguage implements LocalePreferencesEvent {
  const UpdateLanguage(this.locale);
  

 final  Locale locale;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateLanguageCopyWith<UpdateLanguage> get copyWith => _$UpdateLanguageCopyWithImpl<UpdateLanguage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateLanguage&&(identical(other.locale, locale) || other.locale == locale));
}


@override
int get hashCode => Object.hash(runtimeType,locale);

@override
String toString() {
  return 'LocalePreferencesEvent.updateLanguage(locale: $locale)';
}


}

/// @nodoc
abstract mixin class $UpdateLanguageCopyWith<$Res> implements $LocalePreferencesEventCopyWith<$Res> {
  factory $UpdateLanguageCopyWith(UpdateLanguage value, $Res Function(UpdateLanguage) _then) = _$UpdateLanguageCopyWithImpl;
@useResult
$Res call({
 Locale locale
});




}
/// @nodoc
class _$UpdateLanguageCopyWithImpl<$Res>
    implements $UpdateLanguageCopyWith<$Res> {
  _$UpdateLanguageCopyWithImpl(this._self, this._then);

  final UpdateLanguage _self;
  final $Res Function(UpdateLanguage) _then;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? locale = null,}) {
  return _then(UpdateLanguage(
null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,
  ));
}


}

/// @nodoc


class UpdateCountry implements LocalePreferencesEvent {
  const UpdateCountry(this.country);
  

 final  String country;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UpdateCountryCopyWith<UpdateCountry> get copyWith => _$UpdateCountryCopyWithImpl<UpdateCountry>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UpdateCountry&&(identical(other.country, country) || other.country == country));
}


@override
int get hashCode => Object.hash(runtimeType,country);

@override
String toString() {
  return 'LocalePreferencesEvent.updateCountry(country: $country)';
}


}

/// @nodoc
abstract mixin class $UpdateCountryCopyWith<$Res> implements $LocalePreferencesEventCopyWith<$Res> {
  factory $UpdateCountryCopyWith(UpdateCountry value, $Res Function(UpdateCountry) _then) = _$UpdateCountryCopyWithImpl;
@useResult
$Res call({
 String country
});




}
/// @nodoc
class _$UpdateCountryCopyWithImpl<$Res>
    implements $UpdateCountryCopyWith<$Res> {
  _$UpdateCountryCopyWithImpl(this._self, this._then);

  final UpdateCountry _self;
  final $Res Function(UpdateCountry) _then;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? country = null,}) {
  return _then(UpdateCountry(
null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SavePreferences implements LocalePreferencesEvent {
  const SavePreferences(this.userId);
  

 final  String userId;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavePreferencesCopyWith<SavePreferences> get copyWith => _$SavePreferencesCopyWithImpl<SavePreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavePreferences&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'LocalePreferencesEvent.savePreferences(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $SavePreferencesCopyWith<$Res> implements $LocalePreferencesEventCopyWith<$Res> {
  factory $SavePreferencesCopyWith(SavePreferences value, $Res Function(SavePreferences) _then) = _$SavePreferencesCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$SavePreferencesCopyWithImpl<$Res>
    implements $SavePreferencesCopyWith<$Res> {
  _$SavePreferencesCopyWithImpl(this._self, this._then);

  final SavePreferences _self;
  final $Res Function(SavePreferences) _then;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(SavePreferences(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class LoadFromFirestore implements LocalePreferencesEvent {
  const LoadFromFirestore(this.userId);
  

 final  String userId;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadFromFirestoreCopyWith<LoadFromFirestore> get copyWith => _$LoadFromFirestoreCopyWithImpl<LoadFromFirestore>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadFromFirestore&&(identical(other.userId, userId) || other.userId == userId));
}


@override
int get hashCode => Object.hash(runtimeType,userId);

@override
String toString() {
  return 'LocalePreferencesEvent.loadFromFirestore(userId: $userId)';
}


}

/// @nodoc
abstract mixin class $LoadFromFirestoreCopyWith<$Res> implements $LocalePreferencesEventCopyWith<$Res> {
  factory $LoadFromFirestoreCopyWith(LoadFromFirestore value, $Res Function(LoadFromFirestore) _then) = _$LoadFromFirestoreCopyWithImpl;
@useResult
$Res call({
 String userId
});




}
/// @nodoc
class _$LoadFromFirestoreCopyWithImpl<$Res>
    implements $LoadFromFirestoreCopyWith<$Res> {
  _$LoadFromFirestoreCopyWithImpl(this._self, this._then);

  final LoadFromFirestore _self;
  final $Res Function(LoadFromFirestore) _then;

/// Create a copy of LocalePreferencesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,}) {
  return _then(LoadFromFirestore(
null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
