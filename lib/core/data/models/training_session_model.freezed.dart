// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'training_session_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TrainingSessionModel {

 String get id;// Nullable since Story 31.5: group sessions set this; standalone sessions leave it null.
 String? get groupId; ActivityContextType get contextType; String get title; String? get description; GameLocation get location;@TimestampConverter() DateTime get startTime;@TimestampConverter() DateTime get endTime; int get minParticipants; int get maxParticipants; String get createdBy;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;// Recurrence support (Story 15.2)
 RecurrenceRuleModel? get recurrenceRule;// Parent session ID (for recurring session instances)
// If this is set, this session is an instance of a recurring parent
 String? get parentSessionId;// Session status
 TrainingStatus get status;// Participant tracking
 List<String> get participantIds;// Session notes
 String? get notes;// Cancellation tracking (Story 15.14)
 String? get cancelledBy;@NullableTimestampConverter() DateTime? get cancelledAt;
/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingSessionModelCopyWith<TrainingSessionModel> get copyWith => _$TrainingSessionModelCopyWithImpl<TrainingSessionModel>(this as TrainingSessionModel, _$identity);

  /// Serializes this TrainingSessionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.contextType, contextType) || other.contextType == contextType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.parentSessionId, parentSessionId) || other.parentSessionId == parentSessionId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.participantIds, participantIds)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,groupId,contextType,title,description,location,startTime,endTime,minParticipants,maxParticipants,createdBy,createdAt,updatedAt,recurrenceRule,parentSessionId,status,const DeepCollectionEquality().hash(participantIds),notes,cancelledBy,cancelledAt]);

@override
String toString() {
  return 'TrainingSessionModel(id: $id, groupId: $groupId, contextType: $contextType, title: $title, description: $description, location: $location, startTime: $startTime, endTime: $endTime, minParticipants: $minParticipants, maxParticipants: $maxParticipants, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, recurrenceRule: $recurrenceRule, parentSessionId: $parentSessionId, status: $status, participantIds: $participantIds, notes: $notes, cancelledBy: $cancelledBy, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class $TrainingSessionModelCopyWith<$Res>  {
  factory $TrainingSessionModelCopyWith(TrainingSessionModel value, $Res Function(TrainingSessionModel) _then) = _$TrainingSessionModelCopyWithImpl;
@useResult
$Res call({
 String id, String? groupId, ActivityContextType contextType, String title, String? description, GameLocation location,@TimestampConverter() DateTime startTime,@TimestampConverter() DateTime endTime, int minParticipants, int maxParticipants, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt, RecurrenceRuleModel? recurrenceRule, String? parentSessionId, TrainingStatus status, List<String> participantIds, String? notes, String? cancelledBy,@NullableTimestampConverter() DateTime? cancelledAt
});


$GameLocationCopyWith<$Res> get location;$RecurrenceRuleModelCopyWith<$Res>? get recurrenceRule;

}
/// @nodoc
class _$TrainingSessionModelCopyWithImpl<$Res>
    implements $TrainingSessionModelCopyWith<$Res> {
  _$TrainingSessionModelCopyWithImpl(this._self, this._then);

  final TrainingSessionModel _self;
  final $Res Function(TrainingSessionModel) _then;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? groupId = freezed,Object? contextType = null,Object? title = null,Object? description = freezed,Object? location = null,Object? startTime = null,Object? endTime = null,Object? minParticipants = null,Object? maxParticipants = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? recurrenceRule = freezed,Object? parentSessionId = freezed,Object? status = null,Object? participantIds = null,Object? notes = freezed,Object? cancelledBy = freezed,Object? cancelledAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,contextType: null == contextType ? _self.contextType : contextType // ignore: cast_nullable_to_non_nullable
as ActivityContextType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GameLocation,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceRule: freezed == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRuleModel?,parentSessionId: freezed == parentSessionId ? _self.parentSessionId : parentSessionId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrainingStatus,participantIds: null == participantIds ? _self.participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameLocationCopyWith<$Res> get location {
  
  return $GameLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleModelCopyWith<$Res>? get recurrenceRule {
    if (_self.recurrenceRule == null) {
    return null;
  }

  return $RecurrenceRuleModelCopyWith<$Res>(_self.recurrenceRule!, (value) {
    return _then(_self.copyWith(recurrenceRule: value));
  });
}
}


/// Adds pattern-matching-related methods to [TrainingSessionModel].
extension TrainingSessionModelPatterns on TrainingSessionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TrainingSessionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TrainingSessionModel value)  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TrainingSessionModel value)?  $default,){
final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? groupId,  ActivityContextType contextType,  String title,  String? description,  GameLocation location, @TimestampConverter()  DateTime startTime, @TimestampConverter()  DateTime endTime,  int minParticipants,  int maxParticipants,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  RecurrenceRuleModel? recurrenceRule,  String? parentSessionId,  TrainingStatus status,  List<String> participantIds,  String? notes,  String? cancelledBy, @NullableTimestampConverter()  DateTime? cancelledAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
return $default(_that.id,_that.groupId,_that.contextType,_that.title,_that.description,_that.location,_that.startTime,_that.endTime,_that.minParticipants,_that.maxParticipants,_that.createdBy,_that.createdAt,_that.updatedAt,_that.recurrenceRule,_that.parentSessionId,_that.status,_that.participantIds,_that.notes,_that.cancelledBy,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? groupId,  ActivityContextType contextType,  String title,  String? description,  GameLocation location, @TimestampConverter()  DateTime startTime, @TimestampConverter()  DateTime endTime,  int minParticipants,  int maxParticipants,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  RecurrenceRuleModel? recurrenceRule,  String? parentSessionId,  TrainingStatus status,  List<String> participantIds,  String? notes,  String? cancelledBy, @NullableTimestampConverter()  DateTime? cancelledAt)  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionModel():
return $default(_that.id,_that.groupId,_that.contextType,_that.title,_that.description,_that.location,_that.startTime,_that.endTime,_that.minParticipants,_that.maxParticipants,_that.createdBy,_that.createdAt,_that.updatedAt,_that.recurrenceRule,_that.parentSessionId,_that.status,_that.participantIds,_that.notes,_that.cancelledBy,_that.cancelledAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? groupId,  ActivityContextType contextType,  String title,  String? description,  GameLocation location, @TimestampConverter()  DateTime startTime, @TimestampConverter()  DateTime endTime,  int minParticipants,  int maxParticipants,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  RecurrenceRuleModel? recurrenceRule,  String? parentSessionId,  TrainingStatus status,  List<String> participantIds,  String? notes,  String? cancelledBy, @NullableTimestampConverter()  DateTime? cancelledAt)?  $default,) {final _that = this;
switch (_that) {
case _TrainingSessionModel() when $default != null:
return $default(_that.id,_that.groupId,_that.contextType,_that.title,_that.description,_that.location,_that.startTime,_that.endTime,_that.minParticipants,_that.maxParticipants,_that.createdBy,_that.createdAt,_that.updatedAt,_that.recurrenceRule,_that.parentSessionId,_that.status,_that.participantIds,_that.notes,_that.cancelledBy,_that.cancelledAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TrainingSessionModel extends TrainingSessionModel {
  const _TrainingSessionModel({required this.id, this.groupId, this.contextType = ActivityContextType.group, required this.title, this.description, required this.location, @TimestampConverter() required this.startTime, @TimestampConverter() required this.endTime, required this.minParticipants, required this.maxParticipants, required this.createdBy, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt, this.recurrenceRule, this.parentSessionId, this.status = TrainingStatus.scheduled, final  List<String> participantIds = const [], this.notes, this.cancelledBy, @NullableTimestampConverter() this.cancelledAt}): _participantIds = participantIds,super._();
  factory _TrainingSessionModel.fromJson(Map<String, dynamic> json) => _$TrainingSessionModelFromJson(json);

@override final  String id;
// Nullable since Story 31.5: group sessions set this; standalone sessions leave it null.
@override final  String? groupId;
@override@JsonKey() final  ActivityContextType contextType;
@override final  String title;
@override final  String? description;
@override final  GameLocation location;
@override@TimestampConverter() final  DateTime startTime;
@override@TimestampConverter() final  DateTime endTime;
@override final  int minParticipants;
@override final  int maxParticipants;
@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;
// Recurrence support (Story 15.2)
@override final  RecurrenceRuleModel? recurrenceRule;
// Parent session ID (for recurring session instances)
// If this is set, this session is an instance of a recurring parent
@override final  String? parentSessionId;
// Session status
@override@JsonKey() final  TrainingStatus status;
// Participant tracking
 final  List<String> _participantIds;
// Participant tracking
@override@JsonKey() List<String> get participantIds {
  if (_participantIds is EqualUnmodifiableListView) return _participantIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_participantIds);
}

// Session notes
@override final  String? notes;
// Cancellation tracking (Story 15.14)
@override final  String? cancelledBy;
@override@NullableTimestampConverter() final  DateTime? cancelledAt;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrainingSessionModelCopyWith<_TrainingSessionModel> get copyWith => __$TrainingSessionModelCopyWithImpl<_TrainingSessionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrainingSessionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TrainingSessionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.contextType, contextType) || other.contextType == contextType)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.minParticipants, minParticipants) || other.minParticipants == minParticipants)&&(identical(other.maxParticipants, maxParticipants) || other.maxParticipants == maxParticipants)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.recurrenceRule, recurrenceRule) || other.recurrenceRule == recurrenceRule)&&(identical(other.parentSessionId, parentSessionId) || other.parentSessionId == parentSessionId)&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._participantIds, _participantIds)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.cancelledBy, cancelledBy) || other.cancelledBy == cancelledBy)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,groupId,contextType,title,description,location,startTime,endTime,minParticipants,maxParticipants,createdBy,createdAt,updatedAt,recurrenceRule,parentSessionId,status,const DeepCollectionEquality().hash(_participantIds),notes,cancelledBy,cancelledAt]);

@override
String toString() {
  return 'TrainingSessionModel(id: $id, groupId: $groupId, contextType: $contextType, title: $title, description: $description, location: $location, startTime: $startTime, endTime: $endTime, minParticipants: $minParticipants, maxParticipants: $maxParticipants, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, recurrenceRule: $recurrenceRule, parentSessionId: $parentSessionId, status: $status, participantIds: $participantIds, notes: $notes, cancelledBy: $cancelledBy, cancelledAt: $cancelledAt)';
}


}

/// @nodoc
abstract mixin class _$TrainingSessionModelCopyWith<$Res> implements $TrainingSessionModelCopyWith<$Res> {
  factory _$TrainingSessionModelCopyWith(_TrainingSessionModel value, $Res Function(_TrainingSessionModel) _then) = __$TrainingSessionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String? groupId, ActivityContextType contextType, String title, String? description, GameLocation location,@TimestampConverter() DateTime startTime,@TimestampConverter() DateTime endTime, int minParticipants, int maxParticipants, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt, RecurrenceRuleModel? recurrenceRule, String? parentSessionId, TrainingStatus status, List<String> participantIds, String? notes, String? cancelledBy,@NullableTimestampConverter() DateTime? cancelledAt
});


@override $GameLocationCopyWith<$Res> get location;@override $RecurrenceRuleModelCopyWith<$Res>? get recurrenceRule;

}
/// @nodoc
class __$TrainingSessionModelCopyWithImpl<$Res>
    implements _$TrainingSessionModelCopyWith<$Res> {
  __$TrainingSessionModelCopyWithImpl(this._self, this._then);

  final _TrainingSessionModel _self;
  final $Res Function(_TrainingSessionModel) _then;

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? groupId = freezed,Object? contextType = null,Object? title = null,Object? description = freezed,Object? location = null,Object? startTime = null,Object? endTime = null,Object? minParticipants = null,Object? maxParticipants = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? recurrenceRule = freezed,Object? parentSessionId = freezed,Object? status = null,Object? participantIds = null,Object? notes = freezed,Object? cancelledBy = freezed,Object? cancelledAt = freezed,}) {
  return _then(_TrainingSessionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,contextType: null == contextType ? _self.contextType : contextType // ignore: cast_nullable_to_non_nullable
as ActivityContextType,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GameLocation,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,minParticipants: null == minParticipants ? _self.minParticipants : minParticipants // ignore: cast_nullable_to_non_nullable
as int,maxParticipants: null == maxParticipants ? _self.maxParticipants : maxParticipants // ignore: cast_nullable_to_non_nullable
as int,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,recurrenceRule: freezed == recurrenceRule ? _self.recurrenceRule : recurrenceRule // ignore: cast_nullable_to_non_nullable
as RecurrenceRuleModel?,parentSessionId: freezed == parentSessionId ? _self.parentSessionId : parentSessionId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TrainingStatus,participantIds: null == participantIds ? _self._participantIds : participantIds // ignore: cast_nullable_to_non_nullable
as List<String>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,cancelledBy: freezed == cancelledBy ? _self.cancelledBy : cancelledBy // ignore: cast_nullable_to_non_nullable
as String?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameLocationCopyWith<$Res> get location {
  
  return $GameLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of TrainingSessionModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecurrenceRuleModelCopyWith<$Res>? get recurrenceRule {
    if (_self.recurrenceRule == null) {
    return null;
  }

  return $RecurrenceRuleModelCopyWith<$Res>(_self.recurrenceRule!, (value) {
    return _then(_self.copyWith(recurrenceRule: value));
  });
}
}

// dart format on
