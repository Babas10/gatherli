// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_session_participant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingSessionParticipantModel {

/// User ID of the participant
 String get userId;/// When the user joined the training session
@TimestampConverter() DateTime get joinedAt;/// Participant status
 ParticipantStatus get status;
/// Create a copy of TrainingSessionParticipantModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingSessionParticipantModelCopyWith<TrainingSessionParticipantModel> get copyWith => _$TrainingSessionParticipantModelCopyWithImpl<TrainingSessionParticipantModel>(this as TrainingSessionParticipantModel, _$identity);

  /// Serializes this TrainingSessionParticipantModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingSessionParticipantModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,joinedAt,status);

@override
String toString() {
  return 'TrainingSessionParticipantModel(userId: $userId, joinedAt: $joinedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class $TrainingSessionParticipantModelCopyWith<$Res>  {
  factory $TrainingSessionParticipantModelCopyWith(TrainingSessionParticipantModel value, $Res Function(TrainingSessionParticipantModel) _then) = _$TrainingSessionParticipantModelCopyWithImpl;
@useResult
$Res call({
 String userId,@TimestampConverter() DateTime joinedAt, ParticipantStatus status
});




}
/// @nodoc
class _$TrainingSessionParticipantModelCopyWithImpl<$Res>
    implements $TrainingSessionParticipantModelCopyWith<$Res> {
  _$TrainingSessionParticipantModelCopyWithImpl(this._self, this._then);

  final TrainingSessionParticipantModel _self;
  final $Res Function(TrainingSessionParticipantModel) _then;

/// Create a copy of TrainingSessionParticipantModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? joinedAt = null,Object? status = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParticipantStatus,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingSessionParticipantModel].
extension TrainingSessionParticipantModelPatterns on TrainingSessionParticipantModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingSessionParticipantModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingSessionParticipantModel value)  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingSessionParticipantModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId, @TimestampConverter()  DateTime joinedAt,  ParticipantStatus status)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel() when $default != null:
return $default(_that.userId,_that.joinedAt,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId, @TimestampConverter()  DateTime joinedAt,  ParticipantStatus status)  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel():
return $default(_that.userId,_that.joinedAt,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId, @TimestampConverter()  DateTime joinedAt,  ParticipantStatus status)?  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionParticipantModel() when $default != null:
return $default(_that.userId,_that.joinedAt,_that.status);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingSessionParticipantModel extends TrainingSessionParticipantModel {
  const _TrainingSessionParticipantModel({required this.userId, @TimestampConverter() required this.joinedAt, this.status = ParticipantStatus.joined}): super._();
  factory _TrainingSessionParticipantModel.fromJson(Map<String, dynamic> json) => _$TrainingSessionParticipantModelFromJson(json);

/// User ID of the participant
@override final  String userId;
/// When the user joined the training session
@override@TimestampConverter() final  DateTime joinedAt;
/// Participant status
@override@JsonKey() final  ParticipantStatus status;

/// Create a copy of TrainingSessionParticipantModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingSessionParticipantModelCopyWith<_TrainingSessionParticipantModel> get copyWith => __$TrainingSessionParticipantModelCopyWithImpl<_TrainingSessionParticipantModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingSessionParticipantModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingSessionParticipantModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.status, status) || other.status == status));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,joinedAt,status);

@override
String toString() {
  return 'TrainingSessionParticipantModel(userId: $userId, joinedAt: $joinedAt, status: $status)';
}


}

/// @nodoc
abstract mixin class _$TrainingSessionParticipantModelCopyWith<$Res> implements $TrainingSessionParticipantModelCopyWith<$Res> {
  factory _$TrainingSessionParticipantModelCopyWith(_TrainingSessionParticipantModel value, $Res Function(_TrainingSessionParticipantModel) _then) = __$TrainingSessionParticipantModelCopyWithImpl;
@override @useResult
$Res call({
 String userId,@TimestampConverter() DateTime joinedAt, ParticipantStatus status
});




}
/// @nodoc
class __$TrainingSessionParticipantModelCopyWithImpl<$Res>
    implements _$TrainingSessionParticipantModelCopyWith<$Res> {
  __$TrainingSessionParticipantModelCopyWithImpl(this._self, this._then);

  final _TrainingSessionParticipantModel _self;
  final $Res Function(_TrainingSessionParticipantModel) _then;

/// Create a copy of TrainingSessionParticipantModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? joinedAt = null,Object? status = null,}) {
  return _then(_TrainingSessionParticipantModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ParticipantStatus,
  ));
}


}

// dart format on
