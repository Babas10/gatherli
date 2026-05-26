// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_feedback_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingFeedbackModel {

 String get id; String get trainingSessionId;/// Exercises quality rating (1-5)
 int get exercisesQuality;/// Training intensity rating (1-5)
 int get trainingIntensity;/// Coaching clarity rating (1-5)
 int get coachingClarity;/// Optional written feedback
 String? get comment;/// Hash of participant ID to prevent duplicates without exposing identity
/// Hash is SHA-256 of: trainingSessionId + userId + salt
 String get participantHash;/// Timestamp when feedback was submitted
@TimestampConverter() DateTime get submittedAt;
/// Create a copy of TrainingFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingFeedbackModelCopyWith<TrainingFeedbackModel> get copyWith => _$TrainingFeedbackModelCopyWithImpl<TrainingFeedbackModel>(this as TrainingFeedbackModel, _$identity);

  /// Serializes this TrainingFeedbackModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingFeedbackModel&&(identical(other.id, id) || other.id == id)&&(identical(other.trainingSessionId, trainingSessionId) || other.trainingSessionId == trainingSessionId)&&(identical(other.exercisesQuality, exercisesQuality) || other.exercisesQuality == exercisesQuality)&&(identical(other.trainingIntensity, trainingIntensity) || other.trainingIntensity == trainingIntensity)&&(identical(other.coachingClarity, coachingClarity) || other.coachingClarity == coachingClarity)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.participantHash, participantHash) || other.participantHash == participantHash)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,trainingSessionId,exercisesQuality,trainingIntensity,coachingClarity,comment,participantHash,submittedAt);

@override
String toString() {
  return 'TrainingFeedbackModel(id: $id, trainingSessionId: $trainingSessionId, exercisesQuality: $exercisesQuality, trainingIntensity: $trainingIntensity, coachingClarity: $coachingClarity, comment: $comment, participantHash: $participantHash, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class $TrainingFeedbackModelCopyWith<$Res>  {
  factory $TrainingFeedbackModelCopyWith(TrainingFeedbackModel value, $Res Function(TrainingFeedbackModel) _then) = _$TrainingFeedbackModelCopyWithImpl;
@useResult
$Res call({
 String id, String trainingSessionId, int exercisesQuality, int trainingIntensity, int coachingClarity, String? comment, String participantHash,@TimestampConverter() DateTime submittedAt
});




}
/// @nodoc
class _$TrainingFeedbackModelCopyWithImpl<$Res>
    implements $TrainingFeedbackModelCopyWith<$Res> {
  _$TrainingFeedbackModelCopyWithImpl(this._self, this._then);

  final TrainingFeedbackModel _self;
  final $Res Function(TrainingFeedbackModel) _then;

/// Create a copy of TrainingFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? trainingSessionId = null,Object? exercisesQuality = null,Object? trainingIntensity = null,Object? coachingClarity = null,Object? comment = freezed,Object? participantHash = null,Object? submittedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,trainingSessionId: null == trainingSessionId ? _self.trainingSessionId : trainingSessionId // ignore: cast_nullable_to_non_nullable
as String,exercisesQuality: null == exercisesQuality ? _self.exercisesQuality : exercisesQuality // ignore: cast_nullable_to_non_nullable
as int,trainingIntensity: null == trainingIntensity ? _self.trainingIntensity : trainingIntensity // ignore: cast_nullable_to_non_nullable
as int,coachingClarity: null == coachingClarity ? _self.coachingClarity : coachingClarity // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,participantHash: null == participantHash ? _self.participantHash : participantHash // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [TrainingFeedbackModel].
extension TrainingFeedbackModelPatterns on TrainingFeedbackModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingFeedbackModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingFeedbackModel value)  $default,){
final _that = this;
switch (_that) {
case _TrainingFeedbackModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingFeedbackModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingFeedbackModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String trainingSessionId,  int exercisesQuality,  int trainingIntensity,  int coachingClarity,  String? comment,  String participantHash, @TimestampConverter()  DateTime submittedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingFeedbackModel() when $default != null:
return $default(_that.id,_that.trainingSessionId,_that.exercisesQuality,_that.trainingIntensity,_that.coachingClarity,_that.comment,_that.participantHash,_that.submittedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String trainingSessionId,  int exercisesQuality,  int trainingIntensity,  int coachingClarity,  String? comment,  String participantHash, @TimestampConverter()  DateTime submittedAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingFeedbackModel():
return $default(_that.id,_that.trainingSessionId,_that.exercisesQuality,_that.trainingIntensity,_that.coachingClarity,_that.comment,_that.participantHash,_that.submittedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String trainingSessionId,  int exercisesQuality,  int trainingIntensity,  int coachingClarity,  String? comment,  String participantHash, @TimestampConverter()  DateTime submittedAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingFeedbackModel() when $default != null:
return $default(_that.id,_that.trainingSessionId,_that.exercisesQuality,_that.trainingIntensity,_that.coachingClarity,_that.comment,_that.participantHash,_that.submittedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingFeedbackModel extends TrainingFeedbackModel {
  const _TrainingFeedbackModel({required this.id, required this.trainingSessionId, required this.exercisesQuality, required this.trainingIntensity, required this.coachingClarity, this.comment, required this.participantHash, @TimestampConverter() required this.submittedAt}): super._();
  factory _TrainingFeedbackModel.fromJson(Map<String, dynamic> json) => _$TrainingFeedbackModelFromJson(json);

@override final  String id;
@override final  String trainingSessionId;
/// Exercises quality rating (1-5)
@override final  int exercisesQuality;
/// Training intensity rating (1-5)
@override final  int trainingIntensity;
/// Coaching clarity rating (1-5)
@override final  int coachingClarity;
/// Optional written feedback
@override final  String? comment;
/// Hash of participant ID to prevent duplicates without exposing identity
/// Hash is SHA-256 of: trainingSessionId + userId + salt
@override final  String participantHash;
/// Timestamp when feedback was submitted
@override@TimestampConverter() final  DateTime submittedAt;

/// Create a copy of TrainingFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingFeedbackModelCopyWith<_TrainingFeedbackModel> get copyWith => __$TrainingFeedbackModelCopyWithImpl<_TrainingFeedbackModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingFeedbackModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingFeedbackModel&&(identical(other.id, id) || other.id == id)&&(identical(other.trainingSessionId, trainingSessionId) || other.trainingSessionId == trainingSessionId)&&(identical(other.exercisesQuality, exercisesQuality) || other.exercisesQuality == exercisesQuality)&&(identical(other.trainingIntensity, trainingIntensity) || other.trainingIntensity == trainingIntensity)&&(identical(other.coachingClarity, coachingClarity) || other.coachingClarity == coachingClarity)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.participantHash, participantHash) || other.participantHash == participantHash)&&(identical(other.submittedAt, submittedAt) || other.submittedAt == submittedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,trainingSessionId,exercisesQuality,trainingIntensity,coachingClarity,comment,participantHash,submittedAt);

@override
String toString() {
  return 'TrainingFeedbackModel(id: $id, trainingSessionId: $trainingSessionId, exercisesQuality: $exercisesQuality, trainingIntensity: $trainingIntensity, coachingClarity: $coachingClarity, comment: $comment, participantHash: $participantHash, submittedAt: $submittedAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingFeedbackModelCopyWith<$Res> implements $TrainingFeedbackModelCopyWith<$Res> {
  factory _$TrainingFeedbackModelCopyWith(_TrainingFeedbackModel value, $Res Function(_TrainingFeedbackModel) _then) = __$TrainingFeedbackModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String trainingSessionId, int exercisesQuality, int trainingIntensity, int coachingClarity, String? comment, String participantHash,@TimestampConverter() DateTime submittedAt
});




}
/// @nodoc
class __$TrainingFeedbackModelCopyWithImpl<$Res>
    implements _$TrainingFeedbackModelCopyWith<$Res> {
  __$TrainingFeedbackModelCopyWithImpl(this._self, this._then);

  final _TrainingFeedbackModel _self;
  final $Res Function(_TrainingFeedbackModel) _then;

/// Create a copy of TrainingFeedbackModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? trainingSessionId = null,Object? exercisesQuality = null,Object? trainingIntensity = null,Object? coachingClarity = null,Object? comment = freezed,Object? participantHash = null,Object? submittedAt = null,}) {
  return _then(_TrainingFeedbackModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,trainingSessionId: null == trainingSessionId ? _self.trainingSessionId : trainingSessionId // ignore: cast_nullable_to_non_nullable
as String,exercisesQuality: null == exercisesQuality ? _self.exercisesQuality : exercisesQuality // ignore: cast_nullable_to_non_nullable
as int,trainingIntensity: null == trainingIntensity ? _self.trainingIntensity : trainingIntensity // ignore: cast_nullable_to_non_nullable
as int,coachingClarity: null == coachingClarity ? _self.coachingClarity : coachingClarity // ignore: cast_nullable_to_non_nullable
as int,comment: freezed == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String?,participantHash: null == participantHash ? _self.participantHash : participantHash // ignore: cast_nullable_to_non_nullable
as String,submittedAt: null == submittedAt ? _self.submittedAt : submittedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
