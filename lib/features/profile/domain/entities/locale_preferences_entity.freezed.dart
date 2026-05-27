// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'locale_preferences_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LocalePreferencesEntity {

 Locale get locale; String get country; String? get timeZone; DateTime? get lastSyncedAt;
/// Create a copy of LocalePreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalePreferencesEntityCopyWith<LocalePreferencesEntity> get copyWith => _$LocalePreferencesEntityCopyWithImpl<LocalePreferencesEntity>(this as LocalePreferencesEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalePreferencesEntity&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.country, country) || other.country == country)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,locale,country,timeZone,lastSyncedAt);

@override
String toString() {
  return 'LocalePreferencesEntity(locale: $locale, country: $country, timeZone: $timeZone, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class $LocalePreferencesEntityCopyWith<$Res>  {
  factory $LocalePreferencesEntityCopyWith(LocalePreferencesEntity value, $Res Function(LocalePreferencesEntity) _then) = _$LocalePreferencesEntityCopyWithImpl;
@useResult
$Res call({
 Locale locale, String country, String? timeZone, DateTime? lastSyncedAt
});




}
/// @nodoc
class _$LocalePreferencesEntityCopyWithImpl<$Res>
    implements $LocalePreferencesEntityCopyWith<$Res> {
  _$LocalePreferencesEntityCopyWithImpl(this._self, this._then);

  final LocalePreferencesEntity _self;
  final $Res Function(LocalePreferencesEntity) _then;

/// Create a copy of LocalePreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? locale = null,Object? country = null,Object? timeZone = freezed,Object? lastSyncedAt = freezed,}) {
  return _then(_self.copyWith(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,timeZone: freezed == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalePreferencesEntity].
extension LocalePreferencesEntityPatterns on LocalePreferencesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalePreferencesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalePreferencesEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalePreferencesEntity value)  $default,){
final _that = this;
switch (_that) {
case _LocalePreferencesEntity():
return $default(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalePreferencesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _LocalePreferencesEntity() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Locale locale,  String country,  String? timeZone,  DateTime? lastSyncedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalePreferencesEntity() when $default != null:
return $default(_that.locale,_that.country,_that.timeZone,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Locale locale,  String country,  String? timeZone,  DateTime? lastSyncedAt)  $default,) {final _that = this;
switch (_that) {
case _LocalePreferencesEntity():
return $default(_that.locale,_that.country,_that.timeZone,_that.lastSyncedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Locale locale,  String country,  String? timeZone,  DateTime? lastSyncedAt)?  $default,) {final _that = this;
switch (_that) {
case _LocalePreferencesEntity() when $default != null:
return $default(_that.locale,_that.country,_that.timeZone,_that.lastSyncedAt);case _:
  return null;

}
}

}

/// @nodoc


class _LocalePreferencesEntity extends LocalePreferencesEntity {
  const _LocalePreferencesEntity({required this.locale, required this.country, this.timeZone, this.lastSyncedAt}): super._();
  

@override final  Locale locale;
@override final  String country;
@override final  String? timeZone;
@override final  DateTime? lastSyncedAt;

/// Create a copy of LocalePreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalePreferencesEntityCopyWith<_LocalePreferencesEntity> get copyWith => __$LocalePreferencesEntityCopyWithImpl<_LocalePreferencesEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalePreferencesEntity&&(identical(other.locale, locale) || other.locale == locale)&&(identical(other.country, country) || other.country == country)&&(identical(other.timeZone, timeZone) || other.timeZone == timeZone)&&(identical(other.lastSyncedAt, lastSyncedAt) || other.lastSyncedAt == lastSyncedAt));
}


@override
int get hashCode => Object.hash(runtimeType,locale,country,timeZone,lastSyncedAt);

@override
String toString() {
  return 'LocalePreferencesEntity(locale: $locale, country: $country, timeZone: $timeZone, lastSyncedAt: $lastSyncedAt)';
}


}

/// @nodoc
abstract mixin class _$LocalePreferencesEntityCopyWith<$Res> implements $LocalePreferencesEntityCopyWith<$Res> {
  factory _$LocalePreferencesEntityCopyWith(_LocalePreferencesEntity value, $Res Function(_LocalePreferencesEntity) _then) = __$LocalePreferencesEntityCopyWithImpl;
@override @useResult
$Res call({
 Locale locale, String country, String? timeZone, DateTime? lastSyncedAt
});




}
/// @nodoc
class __$LocalePreferencesEntityCopyWithImpl<$Res>
    implements _$LocalePreferencesEntityCopyWith<$Res> {
  __$LocalePreferencesEntityCopyWithImpl(this._self, this._then);

  final _LocalePreferencesEntity _self;
  final $Res Function(_LocalePreferencesEntity) _then;

/// Create a copy of LocalePreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? locale = null,Object? country = null,Object? timeZone = freezed,Object? lastSyncedAt = freezed,}) {
  return _then(_LocalePreferencesEntity(
locale: null == locale ? _self.locale : locale // ignore: cast_nullable_to_non_nullable
as Locale,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,timeZone: freezed == timeZone ? _self.timeZone : timeZone // ignore: cast_nullable_to_non_nullable
as String?,lastSyncedAt: freezed == lastSyncedAt ? _self.lastSyncedAt : lastSyncedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
