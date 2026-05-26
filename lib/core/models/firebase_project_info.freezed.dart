// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'firebase_project_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FirebaseProjectInfo {

 String get environment; String get expectedProjectId; String? get actualProjectId; FirebaseProjectStatus get status; DateTime? get createdAt; bool get matchesExpected;
/// Create a copy of FirebaseProjectInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirebaseProjectInfoCopyWith<FirebaseProjectInfo> get copyWith => _$FirebaseProjectInfoCopyWithImpl<FirebaseProjectInfo>(this as FirebaseProjectInfo, _$identity);

  /// Serializes this FirebaseProjectInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirebaseProjectInfo&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.expectedProjectId, expectedProjectId) || other.expectedProjectId == expectedProjectId)&&(identical(other.actualProjectId, actualProjectId) || other.actualProjectId == actualProjectId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.matchesExpected, matchesExpected) || other.matchesExpected == matchesExpected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,environment,expectedProjectId,actualProjectId,status,createdAt,matchesExpected);

@override
String toString() {
  return 'FirebaseProjectInfo(environment: $environment, expectedProjectId: $expectedProjectId, actualProjectId: $actualProjectId, status: $status, createdAt: $createdAt, matchesExpected: $matchesExpected)';
}


}

/// @nodoc
abstract mixin class $FirebaseProjectInfoCopyWith<$Res>  {
  factory $FirebaseProjectInfoCopyWith(FirebaseProjectInfo value, $Res Function(FirebaseProjectInfo) _then) = _$FirebaseProjectInfoCopyWithImpl;
@useResult
$Res call({
 String environment, String expectedProjectId, String? actualProjectId, FirebaseProjectStatus status, DateTime? createdAt, bool matchesExpected
});




}
/// @nodoc
class _$FirebaseProjectInfoCopyWithImpl<$Res>
    implements $FirebaseProjectInfoCopyWith<$Res> {
  _$FirebaseProjectInfoCopyWithImpl(this._self, this._then);

  final FirebaseProjectInfo _self;
  final $Res Function(FirebaseProjectInfo) _then;

/// Create a copy of FirebaseProjectInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? environment = null,Object? expectedProjectId = null,Object? actualProjectId = freezed,Object? status = null,Object? createdAt = freezed,Object? matchesExpected = null,}) {
  return _then(_self.copyWith(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,expectedProjectId: null == expectedProjectId ? _self.expectedProjectId : expectedProjectId // ignore: cast_nullable_to_non_nullable
as String,actualProjectId: freezed == actualProjectId ? _self.actualProjectId : actualProjectId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FirebaseProjectStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchesExpected: null == matchesExpected ? _self.matchesExpected : matchesExpected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [FirebaseProjectInfo].
extension FirebaseProjectInfoPatterns on FirebaseProjectInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirebaseProjectInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirebaseProjectInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirebaseProjectInfo value)  $default,){
final _that = this;
switch (_that) {
case _FirebaseProjectInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirebaseProjectInfo value)?  $default,){
final _that = this;
switch (_that) {
case _FirebaseProjectInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String environment,  String expectedProjectId,  String? actualProjectId,  FirebaseProjectStatus status,  DateTime? createdAt,  bool matchesExpected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirebaseProjectInfo() when $default != null:
return $default(_that.environment,_that.expectedProjectId,_that.actualProjectId,_that.status,_that.createdAt,_that.matchesExpected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String environment,  String expectedProjectId,  String? actualProjectId,  FirebaseProjectStatus status,  DateTime? createdAt,  bool matchesExpected)  $default,) {final _that = this;
switch (_that) {
case _FirebaseProjectInfo():
return $default(_that.environment,_that.expectedProjectId,_that.actualProjectId,_that.status,_that.createdAt,_that.matchesExpected);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String environment,  String expectedProjectId,  String? actualProjectId,  FirebaseProjectStatus status,  DateTime? createdAt,  bool matchesExpected)?  $default,) {final _that = this;
switch (_that) {
case _FirebaseProjectInfo() when $default != null:
return $default(_that.environment,_that.expectedProjectId,_that.actualProjectId,_that.status,_that.createdAt,_that.matchesExpected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FirebaseProjectInfo implements FirebaseProjectInfo {
  const _FirebaseProjectInfo({required this.environment, required this.expectedProjectId, this.actualProjectId, required this.status, this.createdAt, this.matchesExpected = false});
  factory _FirebaseProjectInfo.fromJson(Map<String, dynamic> json) => _$FirebaseProjectInfoFromJson(json);

@override final  String environment;
@override final  String expectedProjectId;
@override final  String? actualProjectId;
@override final  FirebaseProjectStatus status;
@override final  DateTime? createdAt;
@override@JsonKey() final  bool matchesExpected;

/// Create a copy of FirebaseProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirebaseProjectInfoCopyWith<_FirebaseProjectInfo> get copyWith => __$FirebaseProjectInfoCopyWithImpl<_FirebaseProjectInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FirebaseProjectInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirebaseProjectInfo&&(identical(other.environment, environment) || other.environment == environment)&&(identical(other.expectedProjectId, expectedProjectId) || other.expectedProjectId == expectedProjectId)&&(identical(other.actualProjectId, actualProjectId) || other.actualProjectId == actualProjectId)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.matchesExpected, matchesExpected) || other.matchesExpected == matchesExpected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,environment,expectedProjectId,actualProjectId,status,createdAt,matchesExpected);

@override
String toString() {
  return 'FirebaseProjectInfo(environment: $environment, expectedProjectId: $expectedProjectId, actualProjectId: $actualProjectId, status: $status, createdAt: $createdAt, matchesExpected: $matchesExpected)';
}


}

/// @nodoc
abstract mixin class _$FirebaseProjectInfoCopyWith<$Res> implements $FirebaseProjectInfoCopyWith<$Res> {
  factory _$FirebaseProjectInfoCopyWith(_FirebaseProjectInfo value, $Res Function(_FirebaseProjectInfo) _then) = __$FirebaseProjectInfoCopyWithImpl;
@override @useResult
$Res call({
 String environment, String expectedProjectId, String? actualProjectId, FirebaseProjectStatus status, DateTime? createdAt, bool matchesExpected
});




}
/// @nodoc
class __$FirebaseProjectInfoCopyWithImpl<$Res>
    implements _$FirebaseProjectInfoCopyWith<$Res> {
  __$FirebaseProjectInfoCopyWithImpl(this._self, this._then);

  final _FirebaseProjectInfo _self;
  final $Res Function(_FirebaseProjectInfo) _then;

/// Create a copy of FirebaseProjectInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? environment = null,Object? expectedProjectId = null,Object? actualProjectId = freezed,Object? status = null,Object? createdAt = freezed,Object? matchesExpected = null,}) {
  return _then(_FirebaseProjectInfo(
environment: null == environment ? _self.environment : environment // ignore: cast_nullable_to_non_nullable
as String,expectedProjectId: null == expectedProjectId ? _self.expectedProjectId : expectedProjectId // ignore: cast_nullable_to_non_nullable
as String,actualProjectId: freezed == actualProjectId ? _self.actualProjectId : actualProjectId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FirebaseProjectStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,matchesExpected: null == matchesExpected ? _self.matchesExpected : matchesExpected // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$FirebaseProjectTracker {

 String get storyVersion; DateTime get trackedAt; List<FirebaseProjectInfo> get projects;
/// Create a copy of FirebaseProjectTracker
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FirebaseProjectTrackerCopyWith<FirebaseProjectTracker> get copyWith => _$FirebaseProjectTrackerCopyWithImpl<FirebaseProjectTracker>(this as FirebaseProjectTracker, _$identity);

  /// Serializes this FirebaseProjectTracker to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FirebaseProjectTracker&&(identical(other.storyVersion, storyVersion) || other.storyVersion == storyVersion)&&(identical(other.trackedAt, trackedAt) || other.trackedAt == trackedAt)&&const DeepCollectionEquality().equals(other.projects, projects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storyVersion,trackedAt,const DeepCollectionEquality().hash(projects));

@override
String toString() {
  return 'FirebaseProjectTracker(storyVersion: $storyVersion, trackedAt: $trackedAt, projects: $projects)';
}


}

/// @nodoc
abstract mixin class $FirebaseProjectTrackerCopyWith<$Res>  {
  factory $FirebaseProjectTrackerCopyWith(FirebaseProjectTracker value, $Res Function(FirebaseProjectTracker) _then) = _$FirebaseProjectTrackerCopyWithImpl;
@useResult
$Res call({
 String storyVersion, DateTime trackedAt, List<FirebaseProjectInfo> projects
});




}
/// @nodoc
class _$FirebaseProjectTrackerCopyWithImpl<$Res>
    implements $FirebaseProjectTrackerCopyWith<$Res> {
  _$FirebaseProjectTrackerCopyWithImpl(this._self, this._then);

  final FirebaseProjectTracker _self;
  final $Res Function(FirebaseProjectTracker) _then;

/// Create a copy of FirebaseProjectTracker
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? storyVersion = null,Object? trackedAt = null,Object? projects = null,}) {
  return _then(_self.copyWith(
storyVersion: null == storyVersion ? _self.storyVersion : storyVersion // ignore: cast_nullable_to_non_nullable
as String,trackedAt: null == trackedAt ? _self.trackedAt : trackedAt // ignore: cast_nullable_to_non_nullable
as DateTime,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<FirebaseProjectInfo>,
  ));
}

}


/// Adds pattern-matching-related methods to [FirebaseProjectTracker].
extension FirebaseProjectTrackerPatterns on FirebaseProjectTracker {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FirebaseProjectTracker value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FirebaseProjectTracker() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FirebaseProjectTracker value)  $default,){
final _that = this;
switch (_that) {
case _FirebaseProjectTracker():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FirebaseProjectTracker value)?  $default,){
final _that = this;
switch (_that) {
case _FirebaseProjectTracker() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String storyVersion,  DateTime trackedAt,  List<FirebaseProjectInfo> projects)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FirebaseProjectTracker() when $default != null:
return $default(_that.storyVersion,_that.trackedAt,_that.projects);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String storyVersion,  DateTime trackedAt,  List<FirebaseProjectInfo> projects)  $default,) {final _that = this;
switch (_that) {
case _FirebaseProjectTracker():
return $default(_that.storyVersion,_that.trackedAt,_that.projects);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String storyVersion,  DateTime trackedAt,  List<FirebaseProjectInfo> projects)?  $default,) {final _that = this;
switch (_that) {
case _FirebaseProjectTracker() when $default != null:
return $default(_that.storyVersion,_that.trackedAt,_that.projects);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FirebaseProjectTracker implements FirebaseProjectTracker {
  const _FirebaseProjectTracker({required this.storyVersion, required this.trackedAt, required final  List<FirebaseProjectInfo> projects}): _projects = projects;
  factory _FirebaseProjectTracker.fromJson(Map<String, dynamic> json) => _$FirebaseProjectTrackerFromJson(json);

@override final  String storyVersion;
@override final  DateTime trackedAt;
 final  List<FirebaseProjectInfo> _projects;
@override List<FirebaseProjectInfo> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}


/// Create a copy of FirebaseProjectTracker
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FirebaseProjectTrackerCopyWith<_FirebaseProjectTracker> get copyWith => __$FirebaseProjectTrackerCopyWithImpl<_FirebaseProjectTracker>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FirebaseProjectTrackerToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FirebaseProjectTracker&&(identical(other.storyVersion, storyVersion) || other.storyVersion == storyVersion)&&(identical(other.trackedAt, trackedAt) || other.trackedAt == trackedAt)&&const DeepCollectionEquality().equals(other._projects, _projects));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,storyVersion,trackedAt,const DeepCollectionEquality().hash(_projects));

@override
String toString() {
  return 'FirebaseProjectTracker(storyVersion: $storyVersion, trackedAt: $trackedAt, projects: $projects)';
}


}

/// @nodoc
abstract mixin class _$FirebaseProjectTrackerCopyWith<$Res> implements $FirebaseProjectTrackerCopyWith<$Res> {
  factory _$FirebaseProjectTrackerCopyWith(_FirebaseProjectTracker value, $Res Function(_FirebaseProjectTracker) _then) = __$FirebaseProjectTrackerCopyWithImpl;
@override @useResult
$Res call({
 String storyVersion, DateTime trackedAt, List<FirebaseProjectInfo> projects
});




}
/// @nodoc
class __$FirebaseProjectTrackerCopyWithImpl<$Res>
    implements _$FirebaseProjectTrackerCopyWith<$Res> {
  __$FirebaseProjectTrackerCopyWithImpl(this._self, this._then);

  final _FirebaseProjectTracker _self;
  final $Res Function(_FirebaseProjectTracker) _then;

/// Create a copy of FirebaseProjectTracker
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? storyVersion = null,Object? trackedAt = null,Object? projects = null,}) {
  return _then(_FirebaseProjectTracker(
storyVersion: null == storyVersion ? _self.storyVersion : storyVersion // ignore: cast_nullable_to_non_nullable
as String,trackedAt: null == trackedAt ? _self.trackedAt : trackedAt // ignore: cast_nullable_to_non_nullable
as DateTime,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<FirebaseProjectInfo>,
  ));
}


}

// dart format on
