// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameModel {

 String get id; String get title; String? get description;// Nullable since Story 31.4: group games set this; pickup games leave it null.
 String? get groupId; ActivityContextType get contextType; String get createdBy;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt;@TimestampConverter() DateTime get scheduledAt;@NullableTimestampConverter() DateTime? get startedAt;@NullableTimestampConverter() DateTime? get endedAt; GameLocation get location; GameStatus get status; int get maxPlayers; int get minPlayers; List<String> get playerIds; List<String> get waitlistIds;// Game settings
 bool get allowWaitlist; bool get allowPlayerInvites; GameVisibility get visibility;// Game details
 String? get notes; List<String> get equipment; Duration? get estimatedDuration;// Court/Game specific info
 String? get courtInfo; GameType? get gameType; GameSkillLevel? get skillLevel;// Scoring
 List<GameScore> get scores; String? get winnerId;// Teams (for completed games)
 GameTeams? get teams;// Game result (for completed games with entered scores)
 GameResult? get result;// Verification fields
 String? get resultSubmittedBy; List<String> get confirmedBy;// ELO calculation flag (set to false when result is saved, true after Python function processes)
 bool get eloCalculated;// ELO updates per player (populated by Cloud Function after calculation)
// Map<playerId, {previousRating, newRating, change}>
// NOTE: Must be nullable (no default) so Cloud Function can detect unprocessed games
 Map<String, dynamic>? get eloUpdates;// Timestamp when the game result was entered and completed
@NullableTimestampConverter() DateTime? get completedAt;// Weather considerations
 bool get weatherDependent; String? get weatherNotes;// Gender classification — set by creator intent at creation, re-validated by
// Cloud Function when players join (Story 26.4 / Story 26.8).
 GameGenderType? get gameGenderType;
/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameModelCopyWith<GameModel> get copyWith => _$GameModelCopyWithImpl<GameModel>(this as GameModel, _$identity);

  /// Serializes this GameModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.contextType, contextType) || other.contextType == contextType)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxPlayers, maxPlayers) || other.maxPlayers == maxPlayers)&&(identical(other.minPlayers, minPlayers) || other.minPlayers == minPlayers)&&const DeepCollectionEquality().equals(other.playerIds, playerIds)&&const DeepCollectionEquality().equals(other.waitlistIds, waitlistIds)&&(identical(other.allowWaitlist, allowWaitlist) || other.allowWaitlist == allowWaitlist)&&(identical(other.allowPlayerInvites, allowPlayerInvites) || other.allowPlayerInvites == allowPlayerInvites)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other.equipment, equipment)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&(identical(other.courtInfo, courtInfo) || other.courtInfo == courtInfo)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&const DeepCollectionEquality().equals(other.scores, scores)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.teams, teams) || other.teams == teams)&&(identical(other.result, result) || other.result == result)&&(identical(other.resultSubmittedBy, resultSubmittedBy) || other.resultSubmittedBy == resultSubmittedBy)&&const DeepCollectionEquality().equals(other.confirmedBy, confirmedBy)&&(identical(other.eloCalculated, eloCalculated) || other.eloCalculated == eloCalculated)&&const DeepCollectionEquality().equals(other.eloUpdates, eloUpdates)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.weatherDependent, weatherDependent) || other.weatherDependent == weatherDependent)&&(identical(other.weatherNotes, weatherNotes) || other.weatherNotes == weatherNotes)&&(identical(other.gameGenderType, gameGenderType) || other.gameGenderType == gameGenderType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,groupId,contextType,createdBy,createdAt,updatedAt,scheduledAt,startedAt,endedAt,location,status,maxPlayers,minPlayers,const DeepCollectionEquality().hash(playerIds),const DeepCollectionEquality().hash(waitlistIds),allowWaitlist,allowPlayerInvites,visibility,notes,const DeepCollectionEquality().hash(equipment),estimatedDuration,courtInfo,gameType,skillLevel,const DeepCollectionEquality().hash(scores),winnerId,teams,result,resultSubmittedBy,const DeepCollectionEquality().hash(confirmedBy),eloCalculated,const DeepCollectionEquality().hash(eloUpdates),completedAt,weatherDependent,weatherNotes,gameGenderType]);

@override
String toString() {
  return 'GameModel(id: $id, title: $title, description: $description, groupId: $groupId, contextType: $contextType, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, scheduledAt: $scheduledAt, startedAt: $startedAt, endedAt: $endedAt, location: $location, status: $status, maxPlayers: $maxPlayers, minPlayers: $minPlayers, playerIds: $playerIds, waitlistIds: $waitlistIds, allowWaitlist: $allowWaitlist, allowPlayerInvites: $allowPlayerInvites, visibility: $visibility, notes: $notes, equipment: $equipment, estimatedDuration: $estimatedDuration, courtInfo: $courtInfo, gameType: $gameType, skillLevel: $skillLevel, scores: $scores, winnerId: $winnerId, teams: $teams, result: $result, resultSubmittedBy: $resultSubmittedBy, confirmedBy: $confirmedBy, eloCalculated: $eloCalculated, eloUpdates: $eloUpdates, completedAt: $completedAt, weatherDependent: $weatherDependent, weatherNotes: $weatherNotes, gameGenderType: $gameGenderType)';
}


}

/// @nodoc
abstract mixin class $GameModelCopyWith<$Res>  {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) _then) = _$GameModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, String? groupId, ActivityContextType contextType, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime scheduledAt,@NullableTimestampConverter() DateTime? startedAt,@NullableTimestampConverter() DateTime? endedAt, GameLocation location, GameStatus status, int maxPlayers, int minPlayers, List<String> playerIds, List<String> waitlistIds, bool allowWaitlist, bool allowPlayerInvites, GameVisibility visibility, String? notes, List<String> equipment, Duration? estimatedDuration, String? courtInfo, GameType? gameType, GameSkillLevel? skillLevel, List<GameScore> scores, String? winnerId, GameTeams? teams, GameResult? result, String? resultSubmittedBy, List<String> confirmedBy, bool eloCalculated, Map<String, dynamic>? eloUpdates,@NullableTimestampConverter() DateTime? completedAt, bool weatherDependent, String? weatherNotes, GameGenderType? gameGenderType
});


$GameLocationCopyWith<$Res> get location;$GameTeamsCopyWith<$Res>? get teams;$GameResultCopyWith<$Res>? get result;

}
/// @nodoc
class _$GameModelCopyWithImpl<$Res>
    implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._self, this._then);

  final GameModel _self;
  final $Res Function(GameModel) _then;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? groupId = freezed,Object? contextType = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? scheduledAt = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? location = null,Object? status = null,Object? maxPlayers = null,Object? minPlayers = null,Object? playerIds = null,Object? waitlistIds = null,Object? allowWaitlist = null,Object? allowPlayerInvites = null,Object? visibility = null,Object? notes = freezed,Object? equipment = null,Object? estimatedDuration = freezed,Object? courtInfo = freezed,Object? gameType = freezed,Object? skillLevel = freezed,Object? scores = null,Object? winnerId = freezed,Object? teams = freezed,Object? result = freezed,Object? resultSubmittedBy = freezed,Object? confirmedBy = null,Object? eloCalculated = null,Object? eloUpdates = freezed,Object? completedAt = freezed,Object? weatherDependent = null,Object? weatherNotes = freezed,Object? gameGenderType = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,contextType: null == contextType ? _self.contextType : contextType // ignore: cast_nullable_to_non_nullable
as ActivityContextType,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GameLocation,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,maxPlayers: null == maxPlayers ? _self.maxPlayers : maxPlayers // ignore: cast_nullable_to_non_nullable
as int,minPlayers: null == minPlayers ? _self.minPlayers : minPlayers // ignore: cast_nullable_to_non_nullable
as int,playerIds: null == playerIds ? _self.playerIds : playerIds // ignore: cast_nullable_to_non_nullable
as List<String>,waitlistIds: null == waitlistIds ? _self.waitlistIds : waitlistIds // ignore: cast_nullable_to_non_nullable
as List<String>,allowWaitlist: null == allowWaitlist ? _self.allowWaitlist : allowWaitlist // ignore: cast_nullable_to_non_nullable
as bool,allowPlayerInvites: null == allowPlayerInvites ? _self.allowPlayerInvites : allowPlayerInvites // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as GameVisibility,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,equipment: null == equipment ? _self.equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as Duration?,courtInfo: freezed == courtInfo ? _self.courtInfo : courtInfo // ignore: cast_nullable_to_non_nullable
as String?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as GameType?,skillLevel: freezed == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as GameSkillLevel?,scores: null == scores ? _self.scores : scores // ignore: cast_nullable_to_non_nullable
as List<GameScore>,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,teams: freezed == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as GameTeams?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as GameResult?,resultSubmittedBy: freezed == resultSubmittedBy ? _self.resultSubmittedBy : resultSubmittedBy // ignore: cast_nullable_to_non_nullable
as String?,confirmedBy: null == confirmedBy ? _self.confirmedBy : confirmedBy // ignore: cast_nullable_to_non_nullable
as List<String>,eloCalculated: null == eloCalculated ? _self.eloCalculated : eloCalculated // ignore: cast_nullable_to_non_nullable
as bool,eloUpdates: freezed == eloUpdates ? _self.eloUpdates : eloUpdates // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,weatherDependent: null == weatherDependent ? _self.weatherDependent : weatherDependent // ignore: cast_nullable_to_non_nullable
as bool,weatherNotes: freezed == weatherNotes ? _self.weatherNotes : weatherNotes // ignore: cast_nullable_to_non_nullable
as String?,gameGenderType: freezed == gameGenderType ? _self.gameGenderType : gameGenderType // ignore: cast_nullable_to_non_nullable
as GameGenderType?,
  ));
}
/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameLocationCopyWith<$Res> get location {
  
  return $GameLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameTeamsCopyWith<$Res>? get teams {
    if (_self.teams == null) {
    return null;
  }

  return $GameTeamsCopyWith<$Res>(_self.teams!, (value) {
    return _then(_self.copyWith(teams: value));
  });
}/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $GameResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// Adds pattern-matching-related methods to [GameModel].
extension GameModelPatterns on GameModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameModel value)  $default,){
final _that = this;
switch (_that) {
case _GameModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameModel value)?  $default,){
final _that = this;
switch (_that) {
case _GameModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? groupId,  ActivityContextType contextType,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime scheduledAt, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? endedAt,  GameLocation location,  GameStatus status,  int maxPlayers,  int minPlayers,  List<String> playerIds,  List<String> waitlistIds,  bool allowWaitlist,  bool allowPlayerInvites,  GameVisibility visibility,  String? notes,  List<String> equipment,  Duration? estimatedDuration,  String? courtInfo,  GameType? gameType,  GameSkillLevel? skillLevel,  List<GameScore> scores,  String? winnerId,  GameTeams? teams,  GameResult? result,  String? resultSubmittedBy,  List<String> confirmedBy,  bool eloCalculated,  Map<String, dynamic>? eloUpdates, @NullableTimestampConverter()  DateTime? completedAt,  bool weatherDependent,  String? weatherNotes,  GameGenderType? gameGenderType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.groupId,_that.contextType,_that.createdBy,_that.createdAt,_that.updatedAt,_that.scheduledAt,_that.startedAt,_that.endedAt,_that.location,_that.status,_that.maxPlayers,_that.minPlayers,_that.playerIds,_that.waitlistIds,_that.allowWaitlist,_that.allowPlayerInvites,_that.visibility,_that.notes,_that.equipment,_that.estimatedDuration,_that.courtInfo,_that.gameType,_that.skillLevel,_that.scores,_that.winnerId,_that.teams,_that.result,_that.resultSubmittedBy,_that.confirmedBy,_that.eloCalculated,_that.eloUpdates,_that.completedAt,_that.weatherDependent,_that.weatherNotes,_that.gameGenderType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  String? groupId,  ActivityContextType contextType,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime scheduledAt, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? endedAt,  GameLocation location,  GameStatus status,  int maxPlayers,  int minPlayers,  List<String> playerIds,  List<String> waitlistIds,  bool allowWaitlist,  bool allowPlayerInvites,  GameVisibility visibility,  String? notes,  List<String> equipment,  Duration? estimatedDuration,  String? courtInfo,  GameType? gameType,  GameSkillLevel? skillLevel,  List<GameScore> scores,  String? winnerId,  GameTeams? teams,  GameResult? result,  String? resultSubmittedBy,  List<String> confirmedBy,  bool eloCalculated,  Map<String, dynamic>? eloUpdates, @NullableTimestampConverter()  DateTime? completedAt,  bool weatherDependent,  String? weatherNotes,  GameGenderType? gameGenderType)  $default,) {final _that = this;
switch (_that) {
case _GameModel():
return $default(_that.id,_that.title,_that.description,_that.groupId,_that.contextType,_that.createdBy,_that.createdAt,_that.updatedAt,_that.scheduledAt,_that.startedAt,_that.endedAt,_that.location,_that.status,_that.maxPlayers,_that.minPlayers,_that.playerIds,_that.waitlistIds,_that.allowWaitlist,_that.allowPlayerInvites,_that.visibility,_that.notes,_that.equipment,_that.estimatedDuration,_that.courtInfo,_that.gameType,_that.skillLevel,_that.scores,_that.winnerId,_that.teams,_that.result,_that.resultSubmittedBy,_that.confirmedBy,_that.eloCalculated,_that.eloUpdates,_that.completedAt,_that.weatherDependent,_that.weatherNotes,_that.gameGenderType);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  String? groupId,  ActivityContextType contextType,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt, @TimestampConverter()  DateTime scheduledAt, @NullableTimestampConverter()  DateTime? startedAt, @NullableTimestampConverter()  DateTime? endedAt,  GameLocation location,  GameStatus status,  int maxPlayers,  int minPlayers,  List<String> playerIds,  List<String> waitlistIds,  bool allowWaitlist,  bool allowPlayerInvites,  GameVisibility visibility,  String? notes,  List<String> equipment,  Duration? estimatedDuration,  String? courtInfo,  GameType? gameType,  GameSkillLevel? skillLevel,  List<GameScore> scores,  String? winnerId,  GameTeams? teams,  GameResult? result,  String? resultSubmittedBy,  List<String> confirmedBy,  bool eloCalculated,  Map<String, dynamic>? eloUpdates, @NullableTimestampConverter()  DateTime? completedAt,  bool weatherDependent,  String? weatherNotes,  GameGenderType? gameGenderType)?  $default,) {final _that = this;
switch (_that) {
case _GameModel() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.groupId,_that.contextType,_that.createdBy,_that.createdAt,_that.updatedAt,_that.scheduledAt,_that.startedAt,_that.endedAt,_that.location,_that.status,_that.maxPlayers,_that.minPlayers,_that.playerIds,_that.waitlistIds,_that.allowWaitlist,_that.allowPlayerInvites,_that.visibility,_that.notes,_that.equipment,_that.estimatedDuration,_that.courtInfo,_that.gameType,_that.skillLevel,_that.scores,_that.winnerId,_that.teams,_that.result,_that.resultSubmittedBy,_that.confirmedBy,_that.eloCalculated,_that.eloUpdates,_that.completedAt,_that.weatherDependent,_that.weatherNotes,_that.gameGenderType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameModel extends GameModel {
  const _GameModel({required this.id, required this.title, this.description, this.groupId, this.contextType = ActivityContextType.group, required this.createdBy, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt, @TimestampConverter() required this.scheduledAt, @NullableTimestampConverter() this.startedAt, @NullableTimestampConverter() this.endedAt, required this.location, this.status = GameStatus.scheduled, this.maxPlayers = 4, this.minPlayers = 2, final  List<String> playerIds = const [], final  List<String> waitlistIds = const [], this.allowWaitlist = true, this.allowPlayerInvites = true, this.visibility = GameVisibility.group, this.notes, final  List<String> equipment = const [], this.estimatedDuration, this.courtInfo, this.gameType, this.skillLevel, final  List<GameScore> scores = const [], this.winnerId, this.teams, this.result, this.resultSubmittedBy, final  List<String> confirmedBy = const [], this.eloCalculated = false, final  Map<String, dynamic>? eloUpdates, @NullableTimestampConverter() this.completedAt, this.weatherDependent = true, this.weatherNotes, this.gameGenderType}): _playerIds = playerIds,_waitlistIds = waitlistIds,_equipment = equipment,_scores = scores,_confirmedBy = confirmedBy,_eloUpdates = eloUpdates,super._();
  factory _GameModel.fromJson(Map<String, dynamic> json) => _$GameModelFromJson(json);

@override final  String id;
@override final  String title;
@override final  String? description;
// Nullable since Story 31.4: group games set this; pickup games leave it null.
@override final  String? groupId;
@override@JsonKey() final  ActivityContextType contextType;
@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;
@override@TimestampConverter() final  DateTime scheduledAt;
@override@NullableTimestampConverter() final  DateTime? startedAt;
@override@NullableTimestampConverter() final  DateTime? endedAt;
@override final  GameLocation location;
@override@JsonKey() final  GameStatus status;
@override@JsonKey() final  int maxPlayers;
@override@JsonKey() final  int minPlayers;
 final  List<String> _playerIds;
@override@JsonKey() List<String> get playerIds {
  if (_playerIds is EqualUnmodifiableListView) return _playerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_playerIds);
}

 final  List<String> _waitlistIds;
@override@JsonKey() List<String> get waitlistIds {
  if (_waitlistIds is EqualUnmodifiableListView) return _waitlistIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_waitlistIds);
}

// Game settings
@override@JsonKey() final  bool allowWaitlist;
@override@JsonKey() final  bool allowPlayerInvites;
@override@JsonKey() final  GameVisibility visibility;
// Game details
@override final  String? notes;
 final  List<String> _equipment;
@override@JsonKey() List<String> get equipment {
  if (_equipment is EqualUnmodifiableListView) return _equipment;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_equipment);
}

@override final  Duration? estimatedDuration;
// Court/Game specific info
@override final  String? courtInfo;
@override final  GameType? gameType;
@override final  GameSkillLevel? skillLevel;
// Scoring
 final  List<GameScore> _scores;
// Scoring
@override@JsonKey() List<GameScore> get scores {
  if (_scores is EqualUnmodifiableListView) return _scores;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_scores);
}

@override final  String? winnerId;
// Teams (for completed games)
@override final  GameTeams? teams;
// Game result (for completed games with entered scores)
@override final  GameResult? result;
// Verification fields
@override final  String? resultSubmittedBy;
 final  List<String> _confirmedBy;
@override@JsonKey() List<String> get confirmedBy {
  if (_confirmedBy is EqualUnmodifiableListView) return _confirmedBy;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_confirmedBy);
}

// ELO calculation flag (set to false when result is saved, true after Python function processes)
@override@JsonKey() final  bool eloCalculated;
// ELO updates per player (populated by Cloud Function after calculation)
// Map<playerId, {previousRating, newRating, change}>
// NOTE: Must be nullable (no default) so Cloud Function can detect unprocessed games
 final  Map<String, dynamic>? _eloUpdates;
// ELO updates per player (populated by Cloud Function after calculation)
// Map<playerId, {previousRating, newRating, change}>
// NOTE: Must be nullable (no default) so Cloud Function can detect unprocessed games
@override Map<String, dynamic>? get eloUpdates {
  final value = _eloUpdates;
  if (value == null) return null;
  if (_eloUpdates is EqualUnmodifiableMapView) return _eloUpdates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

// Timestamp when the game result was entered and completed
@override@NullableTimestampConverter() final  DateTime? completedAt;
// Weather considerations
@override@JsonKey() final  bool weatherDependent;
@override final  String? weatherNotes;
// Gender classification — set by creator intent at creation, re-validated by
// Cloud Function when players join (Story 26.4 / Story 26.8).
@override final  GameGenderType? gameGenderType;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameModelCopyWith<_GameModel> get copyWith => __$GameModelCopyWithImpl<_GameModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.contextType, contextType) || other.contextType == contextType)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.startedAt, startedAt) || other.startedAt == startedAt)&&(identical(other.endedAt, endedAt) || other.endedAt == endedAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxPlayers, maxPlayers) || other.maxPlayers == maxPlayers)&&(identical(other.minPlayers, minPlayers) || other.minPlayers == minPlayers)&&const DeepCollectionEquality().equals(other._playerIds, _playerIds)&&const DeepCollectionEquality().equals(other._waitlistIds, _waitlistIds)&&(identical(other.allowWaitlist, allowWaitlist) || other.allowWaitlist == allowWaitlist)&&(identical(other.allowPlayerInvites, allowPlayerInvites) || other.allowPlayerInvites == allowPlayerInvites)&&(identical(other.visibility, visibility) || other.visibility == visibility)&&(identical(other.notes, notes) || other.notes == notes)&&const DeepCollectionEquality().equals(other._equipment, _equipment)&&(identical(other.estimatedDuration, estimatedDuration) || other.estimatedDuration == estimatedDuration)&&(identical(other.courtInfo, courtInfo) || other.courtInfo == courtInfo)&&(identical(other.gameType, gameType) || other.gameType == gameType)&&(identical(other.skillLevel, skillLevel) || other.skillLevel == skillLevel)&&const DeepCollectionEquality().equals(other._scores, _scores)&&(identical(other.winnerId, winnerId) || other.winnerId == winnerId)&&(identical(other.teams, teams) || other.teams == teams)&&(identical(other.result, result) || other.result == result)&&(identical(other.resultSubmittedBy, resultSubmittedBy) || other.resultSubmittedBy == resultSubmittedBy)&&const DeepCollectionEquality().equals(other._confirmedBy, _confirmedBy)&&(identical(other.eloCalculated, eloCalculated) || other.eloCalculated == eloCalculated)&&const DeepCollectionEquality().equals(other._eloUpdates, _eloUpdates)&&(identical(other.completedAt, completedAt) || other.completedAt == completedAt)&&(identical(other.weatherDependent, weatherDependent) || other.weatherDependent == weatherDependent)&&(identical(other.weatherNotes, weatherNotes) || other.weatherNotes == weatherNotes)&&(identical(other.gameGenderType, gameGenderType) || other.gameGenderType == gameGenderType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,groupId,contextType,createdBy,createdAt,updatedAt,scheduledAt,startedAt,endedAt,location,status,maxPlayers,minPlayers,const DeepCollectionEquality().hash(_playerIds),const DeepCollectionEquality().hash(_waitlistIds),allowWaitlist,allowPlayerInvites,visibility,notes,const DeepCollectionEquality().hash(_equipment),estimatedDuration,courtInfo,gameType,skillLevel,const DeepCollectionEquality().hash(_scores),winnerId,teams,result,resultSubmittedBy,const DeepCollectionEquality().hash(_confirmedBy),eloCalculated,const DeepCollectionEquality().hash(_eloUpdates),completedAt,weatherDependent,weatherNotes,gameGenderType]);

@override
String toString() {
  return 'GameModel(id: $id, title: $title, description: $description, groupId: $groupId, contextType: $contextType, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, scheduledAt: $scheduledAt, startedAt: $startedAt, endedAt: $endedAt, location: $location, status: $status, maxPlayers: $maxPlayers, minPlayers: $minPlayers, playerIds: $playerIds, waitlistIds: $waitlistIds, allowWaitlist: $allowWaitlist, allowPlayerInvites: $allowPlayerInvites, visibility: $visibility, notes: $notes, equipment: $equipment, estimatedDuration: $estimatedDuration, courtInfo: $courtInfo, gameType: $gameType, skillLevel: $skillLevel, scores: $scores, winnerId: $winnerId, teams: $teams, result: $result, resultSubmittedBy: $resultSubmittedBy, confirmedBy: $confirmedBy, eloCalculated: $eloCalculated, eloUpdates: $eloUpdates, completedAt: $completedAt, weatherDependent: $weatherDependent, weatherNotes: $weatherNotes, gameGenderType: $gameGenderType)';
}


}

/// @nodoc
abstract mixin class _$GameModelCopyWith<$Res> implements $GameModelCopyWith<$Res> {
  factory _$GameModelCopyWith(_GameModel value, $Res Function(_GameModel) _then) = __$GameModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, String? groupId, ActivityContextType contextType, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt,@TimestampConverter() DateTime scheduledAt,@NullableTimestampConverter() DateTime? startedAt,@NullableTimestampConverter() DateTime? endedAt, GameLocation location, GameStatus status, int maxPlayers, int minPlayers, List<String> playerIds, List<String> waitlistIds, bool allowWaitlist, bool allowPlayerInvites, GameVisibility visibility, String? notes, List<String> equipment, Duration? estimatedDuration, String? courtInfo, GameType? gameType, GameSkillLevel? skillLevel, List<GameScore> scores, String? winnerId, GameTeams? teams, GameResult? result, String? resultSubmittedBy, List<String> confirmedBy, bool eloCalculated, Map<String, dynamic>? eloUpdates,@NullableTimestampConverter() DateTime? completedAt, bool weatherDependent, String? weatherNotes, GameGenderType? gameGenderType
});


@override $GameLocationCopyWith<$Res> get location;@override $GameTeamsCopyWith<$Res>? get teams;@override $GameResultCopyWith<$Res>? get result;

}
/// @nodoc
class __$GameModelCopyWithImpl<$Res>
    implements _$GameModelCopyWith<$Res> {
  __$GameModelCopyWithImpl(this._self, this._then);

  final _GameModel _self;
  final $Res Function(_GameModel) _then;

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? groupId = freezed,Object? contextType = null,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? scheduledAt = null,Object? startedAt = freezed,Object? endedAt = freezed,Object? location = null,Object? status = null,Object? maxPlayers = null,Object? minPlayers = null,Object? playerIds = null,Object? waitlistIds = null,Object? allowWaitlist = null,Object? allowPlayerInvites = null,Object? visibility = null,Object? notes = freezed,Object? equipment = null,Object? estimatedDuration = freezed,Object? courtInfo = freezed,Object? gameType = freezed,Object? skillLevel = freezed,Object? scores = null,Object? winnerId = freezed,Object? teams = freezed,Object? result = freezed,Object? resultSubmittedBy = freezed,Object? confirmedBy = null,Object? eloCalculated = null,Object? eloUpdates = freezed,Object? completedAt = freezed,Object? weatherDependent = null,Object? weatherNotes = freezed,Object? gameGenderType = freezed,}) {
  return _then(_GameModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,contextType: null == contextType ? _self.contextType : contextType // ignore: cast_nullable_to_non_nullable
as ActivityContextType,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,scheduledAt: null == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime,startedAt: freezed == startedAt ? _self.startedAt : startedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,endedAt: freezed == endedAt ? _self.endedAt : endedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as GameLocation,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as GameStatus,maxPlayers: null == maxPlayers ? _self.maxPlayers : maxPlayers // ignore: cast_nullable_to_non_nullable
as int,minPlayers: null == minPlayers ? _self.minPlayers : minPlayers // ignore: cast_nullable_to_non_nullable
as int,playerIds: null == playerIds ? _self._playerIds : playerIds // ignore: cast_nullable_to_non_nullable
as List<String>,waitlistIds: null == waitlistIds ? _self._waitlistIds : waitlistIds // ignore: cast_nullable_to_non_nullable
as List<String>,allowWaitlist: null == allowWaitlist ? _self.allowWaitlist : allowWaitlist // ignore: cast_nullable_to_non_nullable
as bool,allowPlayerInvites: null == allowPlayerInvites ? _self.allowPlayerInvites : allowPlayerInvites // ignore: cast_nullable_to_non_nullable
as bool,visibility: null == visibility ? _self.visibility : visibility // ignore: cast_nullable_to_non_nullable
as GameVisibility,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,equipment: null == equipment ? _self._equipment : equipment // ignore: cast_nullable_to_non_nullable
as List<String>,estimatedDuration: freezed == estimatedDuration ? _self.estimatedDuration : estimatedDuration // ignore: cast_nullable_to_non_nullable
as Duration?,courtInfo: freezed == courtInfo ? _self.courtInfo : courtInfo // ignore: cast_nullable_to_non_nullable
as String?,gameType: freezed == gameType ? _self.gameType : gameType // ignore: cast_nullable_to_non_nullable
as GameType?,skillLevel: freezed == skillLevel ? _self.skillLevel : skillLevel // ignore: cast_nullable_to_non_nullable
as GameSkillLevel?,scores: null == scores ? _self._scores : scores // ignore: cast_nullable_to_non_nullable
as List<GameScore>,winnerId: freezed == winnerId ? _self.winnerId : winnerId // ignore: cast_nullable_to_non_nullable
as String?,teams: freezed == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as GameTeams?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as GameResult?,resultSubmittedBy: freezed == resultSubmittedBy ? _self.resultSubmittedBy : resultSubmittedBy // ignore: cast_nullable_to_non_nullable
as String?,confirmedBy: null == confirmedBy ? _self._confirmedBy : confirmedBy // ignore: cast_nullable_to_non_nullable
as List<String>,eloCalculated: null == eloCalculated ? _self.eloCalculated : eloCalculated // ignore: cast_nullable_to_non_nullable
as bool,eloUpdates: freezed == eloUpdates ? _self._eloUpdates : eloUpdates // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,completedAt: freezed == completedAt ? _self.completedAt : completedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,weatherDependent: null == weatherDependent ? _self.weatherDependent : weatherDependent // ignore: cast_nullable_to_non_nullable
as bool,weatherNotes: freezed == weatherNotes ? _self.weatherNotes : weatherNotes // ignore: cast_nullable_to_non_nullable
as String?,gameGenderType: freezed == gameGenderType ? _self.gameGenderType : gameGenderType // ignore: cast_nullable_to_non_nullable
as GameGenderType?,
  ));
}

/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameLocationCopyWith<$Res> get location {
  
  return $GameLocationCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameTeamsCopyWith<$Res>? get teams {
    if (_self.teams == null) {
    return null;
  }

  return $GameTeamsCopyWith<$Res>(_self.teams!, (value) {
    return _then(_self.copyWith(teams: value));
  });
}/// Create a copy of GameModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $GameResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}
}


/// @nodoc
mixin _$GameTeams {

 List<String> get teamAPlayerIds; List<String> get teamBPlayerIds;
/// Create a copy of GameTeams
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameTeamsCopyWith<GameTeams> get copyWith => _$GameTeamsCopyWithImpl<GameTeams>(this as GameTeams, _$identity);

  /// Serializes this GameTeams to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameTeams&&const DeepCollectionEquality().equals(other.teamAPlayerIds, teamAPlayerIds)&&const DeepCollectionEquality().equals(other.teamBPlayerIds, teamBPlayerIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(teamAPlayerIds),const DeepCollectionEquality().hash(teamBPlayerIds));

@override
String toString() {
  return 'GameTeams(teamAPlayerIds: $teamAPlayerIds, teamBPlayerIds: $teamBPlayerIds)';
}


}

/// @nodoc
abstract mixin class $GameTeamsCopyWith<$Res>  {
  factory $GameTeamsCopyWith(GameTeams value, $Res Function(GameTeams) _then) = _$GameTeamsCopyWithImpl;
@useResult
$Res call({
 List<String> teamAPlayerIds, List<String> teamBPlayerIds
});




}
/// @nodoc
class _$GameTeamsCopyWithImpl<$Res>
    implements $GameTeamsCopyWith<$Res> {
  _$GameTeamsCopyWithImpl(this._self, this._then);

  final GameTeams _self;
  final $Res Function(GameTeams) _then;

/// Create a copy of GameTeams
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamAPlayerIds = null,Object? teamBPlayerIds = null,}) {
  return _then(_self.copyWith(
teamAPlayerIds: null == teamAPlayerIds ? _self.teamAPlayerIds : teamAPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,teamBPlayerIds: null == teamBPlayerIds ? _self.teamBPlayerIds : teamBPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [GameTeams].
extension GameTeamsPatterns on GameTeams {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameTeams value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameTeams() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameTeams value)  $default,){
final _that = this;
switch (_that) {
case _GameTeams():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameTeams value)?  $default,){
final _that = this;
switch (_that) {
case _GameTeams() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> teamAPlayerIds,  List<String> teamBPlayerIds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameTeams() when $default != null:
return $default(_that.teamAPlayerIds,_that.teamBPlayerIds);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> teamAPlayerIds,  List<String> teamBPlayerIds)  $default,) {final _that = this;
switch (_that) {
case _GameTeams():
return $default(_that.teamAPlayerIds,_that.teamBPlayerIds);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> teamAPlayerIds,  List<String> teamBPlayerIds)?  $default,) {final _that = this;
switch (_that) {
case _GameTeams() when $default != null:
return $default(_that.teamAPlayerIds,_that.teamBPlayerIds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameTeams extends GameTeams {
  const _GameTeams({final  List<String> teamAPlayerIds = const [], final  List<String> teamBPlayerIds = const []}): _teamAPlayerIds = teamAPlayerIds,_teamBPlayerIds = teamBPlayerIds,super._();
  factory _GameTeams.fromJson(Map<String, dynamic> json) => _$GameTeamsFromJson(json);

 final  List<String> _teamAPlayerIds;
@override@JsonKey() List<String> get teamAPlayerIds {
  if (_teamAPlayerIds is EqualUnmodifiableListView) return _teamAPlayerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamAPlayerIds);
}

 final  List<String> _teamBPlayerIds;
@override@JsonKey() List<String> get teamBPlayerIds {
  if (_teamBPlayerIds is EqualUnmodifiableListView) return _teamBPlayerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_teamBPlayerIds);
}


/// Create a copy of GameTeams
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameTeamsCopyWith<_GameTeams> get copyWith => __$GameTeamsCopyWithImpl<_GameTeams>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameTeamsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameTeams&&const DeepCollectionEquality().equals(other._teamAPlayerIds, _teamAPlayerIds)&&const DeepCollectionEquality().equals(other._teamBPlayerIds, _teamBPlayerIds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_teamAPlayerIds),const DeepCollectionEquality().hash(_teamBPlayerIds));

@override
String toString() {
  return 'GameTeams(teamAPlayerIds: $teamAPlayerIds, teamBPlayerIds: $teamBPlayerIds)';
}


}

/// @nodoc
abstract mixin class _$GameTeamsCopyWith<$Res> implements $GameTeamsCopyWith<$Res> {
  factory _$GameTeamsCopyWith(_GameTeams value, $Res Function(_GameTeams) _then) = __$GameTeamsCopyWithImpl;
@override @useResult
$Res call({
 List<String> teamAPlayerIds, List<String> teamBPlayerIds
});




}
/// @nodoc
class __$GameTeamsCopyWithImpl<$Res>
    implements _$GameTeamsCopyWith<$Res> {
  __$GameTeamsCopyWithImpl(this._self, this._then);

  final _GameTeams _self;
  final $Res Function(_GameTeams) _then;

/// Create a copy of GameTeams
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamAPlayerIds = null,Object? teamBPlayerIds = null,}) {
  return _then(_GameTeams(
teamAPlayerIds: null == teamAPlayerIds ? _self._teamAPlayerIds : teamAPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,teamBPlayerIds: null == teamBPlayerIds ? _self._teamBPlayerIds : teamBPlayerIds // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$GameLocation {

 String get name; String? get address; double? get latitude; double? get longitude; String? get description; String? get parkingInfo; String? get accessInstructions;
/// Create a copy of GameLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameLocationCopyWith<GameLocation> get copyWith => _$GameLocationCopyWithImpl<GameLocation>(this as GameLocation, _$identity);

  /// Serializes this GameLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.parkingInfo, parkingInfo) || other.parkingInfo == parkingInfo)&&(identical(other.accessInstructions, accessInstructions) || other.accessInstructions == accessInstructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,description,parkingInfo,accessInstructions);

@override
String toString() {
  return 'GameLocation(name: $name, address: $address, latitude: $latitude, longitude: $longitude, description: $description, parkingInfo: $parkingInfo, accessInstructions: $accessInstructions)';
}


}

/// @nodoc
abstract mixin class $GameLocationCopyWith<$Res>  {
  factory $GameLocationCopyWith(GameLocation value, $Res Function(GameLocation) _then) = _$GameLocationCopyWithImpl;
@useResult
$Res call({
 String name, String? address, double? latitude, double? longitude, String? description, String? parkingInfo, String? accessInstructions
});




}
/// @nodoc
class _$GameLocationCopyWithImpl<$Res>
    implements $GameLocationCopyWith<$Res> {
  _$GameLocationCopyWithImpl(this._self, this._then);

  final GameLocation _self;
  final $Res Function(GameLocation) _then;

/// Create a copy of GameLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? description = freezed,Object? parkingInfo = freezed,Object? accessInstructions = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parkingInfo: freezed == parkingInfo ? _self.parkingInfo : parkingInfo // ignore: cast_nullable_to_non_nullable
as String?,accessInstructions: freezed == accessInstructions ? _self.accessInstructions : accessInstructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameLocation].
extension GameLocationPatterns on GameLocation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameLocation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameLocation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameLocation value)  $default,){
final _that = this;
switch (_that) {
case _GameLocation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameLocation value)?  $default,){
final _that = this;
switch (_that) {
case _GameLocation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String? address,  double? latitude,  double? longitude,  String? description,  String? parkingInfo,  String? accessInstructions)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameLocation() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.description,_that.parkingInfo,_that.accessInstructions);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String? address,  double? latitude,  double? longitude,  String? description,  String? parkingInfo,  String? accessInstructions)  $default,) {final _that = this;
switch (_that) {
case _GameLocation():
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.description,_that.parkingInfo,_that.accessInstructions);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String? address,  double? latitude,  double? longitude,  String? description,  String? parkingInfo,  String? accessInstructions)?  $default,) {final _that = this;
switch (_that) {
case _GameLocation() when $default != null:
return $default(_that.name,_that.address,_that.latitude,_that.longitude,_that.description,_that.parkingInfo,_that.accessInstructions);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameLocation implements GameLocation {
  const _GameLocation({required this.name, this.address, this.latitude, this.longitude, this.description, this.parkingInfo, this.accessInstructions});
  factory _GameLocation.fromJson(Map<String, dynamic> json) => _$GameLocationFromJson(json);

@override final  String name;
@override final  String? address;
@override final  double? latitude;
@override final  double? longitude;
@override final  String? description;
@override final  String? parkingInfo;
@override final  String? accessInstructions;

/// Create a copy of GameLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameLocationCopyWith<_GameLocation> get copyWith => __$GameLocationCopyWithImpl<_GameLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameLocation&&(identical(other.name, name) || other.name == name)&&(identical(other.address, address) || other.address == address)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.description, description) || other.description == description)&&(identical(other.parkingInfo, parkingInfo) || other.parkingInfo == parkingInfo)&&(identical(other.accessInstructions, accessInstructions) || other.accessInstructions == accessInstructions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,address,latitude,longitude,description,parkingInfo,accessInstructions);

@override
String toString() {
  return 'GameLocation(name: $name, address: $address, latitude: $latitude, longitude: $longitude, description: $description, parkingInfo: $parkingInfo, accessInstructions: $accessInstructions)';
}


}

/// @nodoc
abstract mixin class _$GameLocationCopyWith<$Res> implements $GameLocationCopyWith<$Res> {
  factory _$GameLocationCopyWith(_GameLocation value, $Res Function(_GameLocation) _then) = __$GameLocationCopyWithImpl;
@override @useResult
$Res call({
 String name, String? address, double? latitude, double? longitude, String? description, String? parkingInfo, String? accessInstructions
});




}
/// @nodoc
class __$GameLocationCopyWithImpl<$Res>
    implements _$GameLocationCopyWith<$Res> {
  __$GameLocationCopyWithImpl(this._self, this._then);

  final _GameLocation _self;
  final $Res Function(_GameLocation) _then;

/// Create a copy of GameLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? address = freezed,Object? latitude = freezed,Object? longitude = freezed,Object? description = freezed,Object? parkingInfo = freezed,Object? accessInstructions = freezed,}) {
  return _then(_GameLocation(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,latitude: freezed == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double?,longitude: freezed == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,parkingInfo: freezed == parkingInfo ? _self.parkingInfo : parkingInfo // ignore: cast_nullable_to_non_nullable
as String?,accessInstructions: freezed == accessInstructions ? _self.accessInstructions : accessInstructions // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$GameScore {

 String get playerId; int get score; int get sets; int get gamesWon; Map<String, dynamic>? get additionalStats;
/// Create a copy of GameScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameScoreCopyWith<GameScore> get copyWith => _$GameScoreCopyWithImpl<GameScore>(this as GameScore, _$identity);

  /// Serializes this GameScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameScore&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.score, score) || other.score == score)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&const DeepCollectionEquality().equals(other.additionalStats, additionalStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,score,sets,gamesWon,const DeepCollectionEquality().hash(additionalStats));

@override
String toString() {
  return 'GameScore(playerId: $playerId, score: $score, sets: $sets, gamesWon: $gamesWon, additionalStats: $additionalStats)';
}


}

/// @nodoc
abstract mixin class $GameScoreCopyWith<$Res>  {
  factory $GameScoreCopyWith(GameScore value, $Res Function(GameScore) _then) = _$GameScoreCopyWithImpl;
@useResult
$Res call({
 String playerId, int score, int sets, int gamesWon, Map<String, dynamic>? additionalStats
});




}
/// @nodoc
class _$GameScoreCopyWithImpl<$Res>
    implements $GameScoreCopyWith<$Res> {
  _$GameScoreCopyWithImpl(this._self, this._then);

  final GameScore _self;
  final $Res Function(GameScore) _then;

/// Create a copy of GameScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? score = null,Object? sets = null,Object? gamesWon = null,Object? additionalStats = freezed,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,additionalStats: freezed == additionalStats ? _self.additionalStats : additionalStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameScore].
extension GameScorePatterns on GameScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameScore value)  $default,){
final _that = this;
switch (_that) {
case _GameScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameScore value)?  $default,){
final _that = this;
switch (_that) {
case _GameScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  int score,  int sets,  int gamesWon,  Map<String, dynamic>? additionalStats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameScore() when $default != null:
return $default(_that.playerId,_that.score,_that.sets,_that.gamesWon,_that.additionalStats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  int score,  int sets,  int gamesWon,  Map<String, dynamic>? additionalStats)  $default,) {final _that = this;
switch (_that) {
case _GameScore():
return $default(_that.playerId,_that.score,_that.sets,_that.gamesWon,_that.additionalStats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  int score,  int sets,  int gamesWon,  Map<String, dynamic>? additionalStats)?  $default,) {final _that = this;
switch (_that) {
case _GameScore() when $default != null:
return $default(_that.playerId,_that.score,_that.sets,_that.gamesWon,_that.additionalStats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameScore implements GameScore {
  const _GameScore({required this.playerId, required this.score, this.sets = 0, this.gamesWon = 0, final  Map<String, dynamic>? additionalStats}): _additionalStats = additionalStats;
  factory _GameScore.fromJson(Map<String, dynamic> json) => _$GameScoreFromJson(json);

@override final  String playerId;
@override final  int score;
@override@JsonKey() final  int sets;
@override@JsonKey() final  int gamesWon;
 final  Map<String, dynamic>? _additionalStats;
@override Map<String, dynamic>? get additionalStats {
  final value = _additionalStats;
  if (value == null) return null;
  if (_additionalStats is EqualUnmodifiableMapView) return _additionalStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of GameScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameScoreCopyWith<_GameScore> get copyWith => __$GameScoreCopyWithImpl<_GameScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameScore&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.score, score) || other.score == score)&&(identical(other.sets, sets) || other.sets == sets)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&const DeepCollectionEquality().equals(other._additionalStats, _additionalStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,score,sets,gamesWon,const DeepCollectionEquality().hash(_additionalStats));

@override
String toString() {
  return 'GameScore(playerId: $playerId, score: $score, sets: $sets, gamesWon: $gamesWon, additionalStats: $additionalStats)';
}


}

/// @nodoc
abstract mixin class _$GameScoreCopyWith<$Res> implements $GameScoreCopyWith<$Res> {
  factory _$GameScoreCopyWith(_GameScore value, $Res Function(_GameScore) _then) = __$GameScoreCopyWithImpl;
@override @useResult
$Res call({
 String playerId, int score, int sets, int gamesWon, Map<String, dynamic>? additionalStats
});




}
/// @nodoc
class __$GameScoreCopyWithImpl<$Res>
    implements _$GameScoreCopyWith<$Res> {
  __$GameScoreCopyWithImpl(this._self, this._then);

  final _GameScore _self;
  final $Res Function(_GameScore) _then;

/// Create a copy of GameScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? score = null,Object? sets = null,Object? gamesWon = null,Object? additionalStats = freezed,}) {
  return _then(_GameScore(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,score: null == score ? _self.score : score // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,additionalStats: freezed == additionalStats ? _self._additionalStats : additionalStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$SetScore {

 int get teamAPoints; int get teamBPoints; int get setNumber;
/// Create a copy of SetScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SetScoreCopyWith<SetScore> get copyWith => _$SetScoreCopyWithImpl<SetScore>(this as SetScore, _$identity);

  /// Serializes this SetScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SetScore&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPoints,teamBPoints,setNumber);

@override
String toString() {
  return 'SetScore(teamAPoints: $teamAPoints, teamBPoints: $teamBPoints, setNumber: $setNumber)';
}


}

/// @nodoc
abstract mixin class $SetScoreCopyWith<$Res>  {
  factory $SetScoreCopyWith(SetScore value, $Res Function(SetScore) _then) = _$SetScoreCopyWithImpl;
@useResult
$Res call({
 int teamAPoints, int teamBPoints, int setNumber
});




}
/// @nodoc
class _$SetScoreCopyWithImpl<$Res>
    implements $SetScoreCopyWith<$Res> {
  _$SetScoreCopyWithImpl(this._self, this._then);

  final SetScore _self;
  final $Res Function(SetScore) _then;

/// Create a copy of SetScore
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamAPoints = null,Object? teamBPoints = null,Object? setNumber = null,}) {
  return _then(_self.copyWith(
teamAPoints: null == teamAPoints ? _self.teamAPoints : teamAPoints // ignore: cast_nullable_to_non_nullable
as int,teamBPoints: null == teamBPoints ? _self.teamBPoints : teamBPoints // ignore: cast_nullable_to_non_nullable
as int,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [SetScore].
extension SetScorePatterns on SetScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SetScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SetScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SetScore value)  $default,){
final _that = this;
switch (_that) {
case _SetScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SetScore value)?  $default,){
final _that = this;
switch (_that) {
case _SetScore() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int teamAPoints,  int teamBPoints,  int setNumber)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SetScore() when $default != null:
return $default(_that.teamAPoints,_that.teamBPoints,_that.setNumber);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int teamAPoints,  int teamBPoints,  int setNumber)  $default,) {final _that = this;
switch (_that) {
case _SetScore():
return $default(_that.teamAPoints,_that.teamBPoints,_that.setNumber);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int teamAPoints,  int teamBPoints,  int setNumber)?  $default,) {final _that = this;
switch (_that) {
case _SetScore() when $default != null:
return $default(_that.teamAPoints,_that.teamBPoints,_that.setNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SetScore extends SetScore {
  const _SetScore({required this.teamAPoints, required this.teamBPoints, required this.setNumber}): super._();
  factory _SetScore.fromJson(Map<String, dynamic> json) => _$SetScoreFromJson(json);

@override final  int teamAPoints;
@override final  int teamBPoints;
@override final  int setNumber;

/// Create a copy of SetScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SetScoreCopyWith<_SetScore> get copyWith => __$SetScoreCopyWithImpl<_SetScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SetScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SetScore&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPoints,teamBPoints,setNumber);

@override
String toString() {
  return 'SetScore(teamAPoints: $teamAPoints, teamBPoints: $teamBPoints, setNumber: $setNumber)';
}


}

/// @nodoc
abstract mixin class _$SetScoreCopyWith<$Res> implements $SetScoreCopyWith<$Res> {
  factory _$SetScoreCopyWith(_SetScore value, $Res Function(_SetScore) _then) = __$SetScoreCopyWithImpl;
@override @useResult
$Res call({
 int teamAPoints, int teamBPoints, int setNumber
});




}
/// @nodoc
class __$SetScoreCopyWithImpl<$Res>
    implements _$SetScoreCopyWith<$Res> {
  __$SetScoreCopyWithImpl(this._self, this._then);

  final _SetScore _self;
  final $Res Function(_SetScore) _then;

/// Create a copy of SetScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamAPoints = null,Object? teamBPoints = null,Object? setNumber = null,}) {
  return _then(_SetScore(
teamAPoints: null == teamAPoints ? _self.teamAPoints : teamAPoints // ignore: cast_nullable_to_non_nullable
as int,teamBPoints: null == teamBPoints ? _self.teamBPoints : teamBPoints // ignore: cast_nullable_to_non_nullable
as int,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$IndividualGame {

 int get gameNumber;// 1, 2, 3, etc. within the session
@SetScoreListConverter() List<SetScore> get sets; String get winner;// 'teamA' or 'teamB'
@GameTeamsConverter() GameTeams? get teams;
/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IndividualGameCopyWith<IndividualGame> get copyWith => _$IndividualGameCopyWithImpl<IndividualGame>(this as IndividualGame, _$identity);

  /// Serializes this IndividualGame to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IndividualGame&&(identical(other.gameNumber, gameNumber) || other.gameNumber == gameNumber)&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.teams, teams) || other.teams == teams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameNumber,const DeepCollectionEquality().hash(sets),winner,teams);

@override
String toString() {
  return 'IndividualGame(gameNumber: $gameNumber, sets: $sets, winner: $winner, teams: $teams)';
}


}

/// @nodoc
abstract mixin class $IndividualGameCopyWith<$Res>  {
  factory $IndividualGameCopyWith(IndividualGame value, $Res Function(IndividualGame) _then) = _$IndividualGameCopyWithImpl;
@useResult
$Res call({
 int gameNumber,@SetScoreListConverter() List<SetScore> sets, String winner,@GameTeamsConverter() GameTeams? teams
});


$GameTeamsCopyWith<$Res>? get teams;

}
/// @nodoc
class _$IndividualGameCopyWithImpl<$Res>
    implements $IndividualGameCopyWith<$Res> {
  _$IndividualGameCopyWithImpl(this._self, this._then);

  final IndividualGame _self;
  final $Res Function(IndividualGame) _then;

/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameNumber = null,Object? sets = null,Object? winner = null,Object? teams = freezed,}) {
  return _then(_self.copyWith(
gameNumber: null == gameNumber ? _self.gameNumber : gameNumber // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetScore>,winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String,teams: freezed == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as GameTeams?,
  ));
}
/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameTeamsCopyWith<$Res>? get teams {
    if (_self.teams == null) {
    return null;
  }

  return $GameTeamsCopyWith<$Res>(_self.teams!, (value) {
    return _then(_self.copyWith(teams: value));
  });
}
}


/// Adds pattern-matching-related methods to [IndividualGame].
extension IndividualGamePatterns on IndividualGame {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IndividualGame value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IndividualGame() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IndividualGame value)  $default,){
final _that = this;
switch (_that) {
case _IndividualGame():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IndividualGame value)?  $default,){
final _that = this;
switch (_that) {
case _IndividualGame() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int gameNumber, @SetScoreListConverter()  List<SetScore> sets,  String winner, @GameTeamsConverter()  GameTeams? teams)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IndividualGame() when $default != null:
return $default(_that.gameNumber,_that.sets,_that.winner,_that.teams);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int gameNumber, @SetScoreListConverter()  List<SetScore> sets,  String winner, @GameTeamsConverter()  GameTeams? teams)  $default,) {final _that = this;
switch (_that) {
case _IndividualGame():
return $default(_that.gameNumber,_that.sets,_that.winner,_that.teams);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int gameNumber, @SetScoreListConverter()  List<SetScore> sets,  String winner, @GameTeamsConverter()  GameTeams? teams)?  $default,) {final _that = this;
switch (_that) {
case _IndividualGame() when $default != null:
return $default(_that.gameNumber,_that.sets,_that.winner,_that.teams);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IndividualGame extends IndividualGame {
  const _IndividualGame({required this.gameNumber, @SetScoreListConverter() required final  List<SetScore> sets, required this.winner, @GameTeamsConverter() this.teams}): _sets = sets,super._();
  factory _IndividualGame.fromJson(Map<String, dynamic> json) => _$IndividualGameFromJson(json);

@override final  int gameNumber;
// 1, 2, 3, etc. within the session
 final  List<SetScore> _sets;
// 1, 2, 3, etc. within the session
@override@SetScoreListConverter() List<SetScore> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override final  String winner;
// 'teamA' or 'teamB'
@override@GameTeamsConverter() final  GameTeams? teams;

/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IndividualGameCopyWith<_IndividualGame> get copyWith => __$IndividualGameCopyWithImpl<_IndividualGame>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IndividualGameToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IndividualGame&&(identical(other.gameNumber, gameNumber) || other.gameNumber == gameNumber)&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.teams, teams) || other.teams == teams));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameNumber,const DeepCollectionEquality().hash(_sets),winner,teams);

@override
String toString() {
  return 'IndividualGame(gameNumber: $gameNumber, sets: $sets, winner: $winner, teams: $teams)';
}


}

/// @nodoc
abstract mixin class _$IndividualGameCopyWith<$Res> implements $IndividualGameCopyWith<$Res> {
  factory _$IndividualGameCopyWith(_IndividualGame value, $Res Function(_IndividualGame) _then) = __$IndividualGameCopyWithImpl;
@override @useResult
$Res call({
 int gameNumber,@SetScoreListConverter() List<SetScore> sets, String winner,@GameTeamsConverter() GameTeams? teams
});


@override $GameTeamsCopyWith<$Res>? get teams;

}
/// @nodoc
class __$IndividualGameCopyWithImpl<$Res>
    implements _$IndividualGameCopyWith<$Res> {
  __$IndividualGameCopyWithImpl(this._self, this._then);

  final _IndividualGame _self;
  final $Res Function(_IndividualGame) _then;

/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameNumber = null,Object? sets = null,Object? winner = null,Object? teams = freezed,}) {
  return _then(_IndividualGame(
gameNumber: null == gameNumber ? _self.gameNumber : gameNumber // ignore: cast_nullable_to_non_nullable
as int,sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<SetScore>,winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String,teams: freezed == teams ? _self.teams : teams // ignore: cast_nullable_to_non_nullable
as GameTeams?,
  ));
}

/// Create a copy of IndividualGame
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameTeamsCopyWith<$Res>? get teams {
    if (_self.teams == null) {
    return null;
  }

  return $GameTeamsCopyWith<$Res>(_self.teams!, (value) {
    return _then(_self.copyWith(teams: value));
  });
}
}


/// @nodoc
mixin _$GameResult {

@IndividualGameListConverter() List<IndividualGame> get games; String? get overallWinner;
/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameResultCopyWith<GameResult> get copyWith => _$GameResultCopyWithImpl<GameResult>(this as GameResult, _$identity);

  /// Serializes this GameResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameResult&&const DeepCollectionEquality().equals(other.games, games)&&(identical(other.overallWinner, overallWinner) || other.overallWinner == overallWinner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(games),overallWinner);

@override
String toString() {
  return 'GameResult(games: $games, overallWinner: $overallWinner)';
}


}

/// @nodoc
abstract mixin class $GameResultCopyWith<$Res>  {
  factory $GameResultCopyWith(GameResult value, $Res Function(GameResult) _then) = _$GameResultCopyWithImpl;
@useResult
$Res call({
@IndividualGameListConverter() List<IndividualGame> games, String? overallWinner
});




}
/// @nodoc
class _$GameResultCopyWithImpl<$Res>
    implements $GameResultCopyWith<$Res> {
  _$GameResultCopyWithImpl(this._self, this._then);

  final GameResult _self;
  final $Res Function(GameResult) _then;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? games = null,Object? overallWinner = freezed,}) {
  return _then(_self.copyWith(
games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as List<IndividualGame>,overallWinner: freezed == overallWinner ? _self.overallWinner : overallWinner // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [GameResult].
extension GameResultPatterns on GameResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GameResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GameResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GameResult value)  $default,){
final _that = this;
switch (_that) {
case _GameResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GameResult value)?  $default,){
final _that = this;
switch (_that) {
case _GameResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@IndividualGameListConverter()  List<IndividualGame> games,  String? overallWinner)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GameResult() when $default != null:
return $default(_that.games,_that.overallWinner);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@IndividualGameListConverter()  List<IndividualGame> games,  String? overallWinner)  $default,) {final _that = this;
switch (_that) {
case _GameResult():
return $default(_that.games,_that.overallWinner);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@IndividualGameListConverter()  List<IndividualGame> games,  String? overallWinner)?  $default,) {final _that = this;
switch (_that) {
case _GameResult() when $default != null:
return $default(_that.games,_that.overallWinner);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GameResult extends GameResult {
  const _GameResult({@IndividualGameListConverter() required final  List<IndividualGame> games, this.overallWinner}): _games = games,super._();
  factory _GameResult.fromJson(Map<String, dynamic> json) => _$GameResultFromJson(json);

 final  List<IndividualGame> _games;
@override@IndividualGameListConverter() List<IndividualGame> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

@override final  String? overallWinner;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GameResultCopyWith<_GameResult> get copyWith => __$GameResultCopyWithImpl<_GameResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GameResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GameResult&&const DeepCollectionEquality().equals(other._games, _games)&&(identical(other.overallWinner, overallWinner) || other.overallWinner == overallWinner));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_games),overallWinner);

@override
String toString() {
  return 'GameResult(games: $games, overallWinner: $overallWinner)';
}


}

/// @nodoc
abstract mixin class _$GameResultCopyWith<$Res> implements $GameResultCopyWith<$Res> {
  factory _$GameResultCopyWith(_GameResult value, $Res Function(_GameResult) _then) = __$GameResultCopyWithImpl;
@override @useResult
$Res call({
@IndividualGameListConverter() List<IndividualGame> games, String? overallWinner
});




}
/// @nodoc
class __$GameResultCopyWithImpl<$Res>
    implements _$GameResultCopyWith<$Res> {
  __$GameResultCopyWithImpl(this._self, this._then);

  final _GameResult _self;
  final $Res Function(_GameResult) _then;

/// Create a copy of GameResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? games = null,Object? overallWinner = freezed,}) {
  return _then(_GameResult(
games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<IndividualGame>,overallWinner: freezed == overallWinner ? _self.overallWinner : overallWinner // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
