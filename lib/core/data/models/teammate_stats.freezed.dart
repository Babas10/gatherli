// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teammate_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TeammateStats {

/// The teammate's user ID
 String get userId;/// Cached display name of the teammate (written by Cloud Function)
 String? get teammateName;/// Total games played together
 int get gamesPlayed;/// Games won together
 int get gamesWon;/// Games lost together
 int get gamesLost;/// Total points scored when playing together
 int get pointsScored;/// Total points allowed when playing together
 int get pointsAllowed;/// ELO rating change when playing together (cumulative)
 double get eloChange;/// Recent game results (up to 10 most recent)
 List<RecentGameResult> get recentGames;/// When these stats were last updated
@NullableTimestampConverter() DateTime? get lastUpdated;
/// Create a copy of TeammateStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeammateStatsCopyWith<TeammateStats> get copyWith => _$TeammateStatsCopyWithImpl<TeammateStats>(this as TeammateStats, _$identity);

  /// Serializes this TeammateStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeammateStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.teammateName, teammateName) || other.teammateName == teammateName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&const DeepCollectionEquality().equals(other.recentGames, recentGames)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,teammateName,gamesPlayed,gamesWon,gamesLost,pointsScored,pointsAllowed,eloChange,const DeepCollectionEquality().hash(recentGames),lastUpdated);

@override
String toString() {
  return 'TeammateStats(userId: $userId, teammateName: $teammateName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, recentGames: $recentGames, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $TeammateStatsCopyWith<$Res>  {
  factory $TeammateStatsCopyWith(TeammateStats value, $Res Function(TeammateStats) _then) = _$TeammateStatsCopyWithImpl;
@useResult
$Res call({
 String userId, String? teammateName, int gamesPlayed, int gamesWon, int gamesLost, int pointsScored, int pointsAllowed, double eloChange, List<RecentGameResult> recentGames,@NullableTimestampConverter() DateTime? lastUpdated
});




}
/// @nodoc
class _$TeammateStatsCopyWithImpl<$Res>
    implements $TeammateStatsCopyWith<$Res> {
  _$TeammateStatsCopyWithImpl(this._self, this._then);

  final TeammateStats _self;
  final $Res Function(TeammateStats) _then;

/// Create a copy of TeammateStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? teammateName = freezed,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? recentGames = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,teammateName: freezed == teammateName ? _self.teammateName : teammateName // ignore: cast_nullable_to_non_nullable
as String?,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,recentGames: null == recentGames ? _self.recentGames : recentGames // ignore: cast_nullable_to_non_nullable
as List<RecentGameResult>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [TeammateStats].
extension TeammateStatsPatterns on TeammateStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TeammateStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TeammateStats value)  $default,){
final _that = this;
switch (_that) {
case _TeammateStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TeammateStats value)?  $default,){
final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String? teammateName,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  List<RecentGameResult> recentGames, @NullableTimestampConverter()  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
return $default(_that.userId,_that.teammateName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.recentGames,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String? teammateName,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  List<RecentGameResult> recentGames, @NullableTimestampConverter()  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _TeammateStats():
return $default(_that.userId,_that.teammateName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.recentGames,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String? teammateName,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  List<RecentGameResult> recentGames, @NullableTimestampConverter()  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
return $default(_that.userId,_that.teammateName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.recentGames,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeammateStats extends TeammateStats {
  const _TeammateStats({required this.userId, this.teammateName, required this.gamesPlayed, required this.gamesWon, required this.gamesLost, this.pointsScored = 0, this.pointsAllowed = 0, this.eloChange = 0.0, final  List<RecentGameResult> recentGames = const [], @NullableTimestampConverter() this.lastUpdated}): _recentGames = recentGames,super._();
  factory _TeammateStats.fromJson(Map<String, dynamic> json) => _$TeammateStatsFromJson(json);

/// The teammate's user ID
@override final  String userId;
/// Cached display name of the teammate (written by Cloud Function)
@override final  String? teammateName;
/// Total games played together
@override final  int gamesPlayed;
/// Games won together
@override final  int gamesWon;
/// Games lost together
@override final  int gamesLost;
/// Total points scored when playing together
@override@JsonKey() final  int pointsScored;
/// Total points allowed when playing together
@override@JsonKey() final  int pointsAllowed;
/// ELO rating change when playing together (cumulative)
@override@JsonKey() final  double eloChange;
/// Recent game results (up to 10 most recent)
 final  List<RecentGameResult> _recentGames;
/// Recent game results (up to 10 most recent)
@override@JsonKey() List<RecentGameResult> get recentGames {
  if (_recentGames is EqualUnmodifiableListView) return _recentGames;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentGames);
}

/// When these stats were last updated
@override@NullableTimestampConverter() final  DateTime? lastUpdated;

/// Create a copy of TeammateStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TeammateStatsCopyWith<_TeammateStats> get copyWith => __$TeammateStatsCopyWithImpl<_TeammateStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TeammateStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeammateStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.teammateName, teammateName) || other.teammateName == teammateName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&const DeepCollectionEquality().equals(other._recentGames, _recentGames)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,teammateName,gamesPlayed,gamesWon,gamesLost,pointsScored,pointsAllowed,eloChange,const DeepCollectionEquality().hash(_recentGames),lastUpdated);

@override
String toString() {
  return 'TeammateStats(userId: $userId, teammateName: $teammateName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, recentGames: $recentGames, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$TeammateStatsCopyWith<$Res> implements $TeammateStatsCopyWith<$Res> {
  factory _$TeammateStatsCopyWith(_TeammateStats value, $Res Function(_TeammateStats) _then) = __$TeammateStatsCopyWithImpl;
@override @useResult
$Res call({
 String userId, String? teammateName, int gamesPlayed, int gamesWon, int gamesLost, int pointsScored, int pointsAllowed, double eloChange, List<RecentGameResult> recentGames,@NullableTimestampConverter() DateTime? lastUpdated
});




}
/// @nodoc
class __$TeammateStatsCopyWithImpl<$Res>
    implements _$TeammateStatsCopyWith<$Res> {
  __$TeammateStatsCopyWithImpl(this._self, this._then);

  final _TeammateStats _self;
  final $Res Function(_TeammateStats) _then;

/// Create a copy of TeammateStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? teammateName = freezed,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? recentGames = null,Object? lastUpdated = freezed,}) {
  return _then(_TeammateStats(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,teammateName: freezed == teammateName ? _self.teammateName : teammateName // ignore: cast_nullable_to_non_nullable
as String?,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,recentGames: null == recentGames ? _self._recentGames : recentGames // ignore: cast_nullable_to_non_nullable
as List<RecentGameResult>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$RecentGameResult {

/// Reference to the game
 String get gameId;/// Whether the team won
 bool get won;/// Points scored by the team
 int get pointsScored;/// Points scored by opponents
 int get pointsAllowed;/// ELO change from this game
 double get eloChange;/// When the game was played
@TimestampConverter() DateTime get timestamp;
/// Create a copy of RecentGameResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecentGameResultCopyWith<RecentGameResult> get copyWith => _$RecentGameResultCopyWithImpl<RecentGameResult>(this as RecentGameResult, _$identity);

  /// Serializes this RecentGameResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecentGameResult&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.won, won) || other.won == won)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,won,pointsScored,pointsAllowed,eloChange,timestamp);

@override
String toString() {
  return 'RecentGameResult(gameId: $gameId, won: $won, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $RecentGameResultCopyWith<$Res>  {
  factory $RecentGameResultCopyWith(RecentGameResult value, $Res Function(RecentGameResult) _then) = _$RecentGameResultCopyWithImpl;
@useResult
$Res call({
 String gameId, bool won, int pointsScored, int pointsAllowed, double eloChange,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class _$RecentGameResultCopyWithImpl<$Res>
    implements $RecentGameResultCopyWith<$Res> {
  _$RecentGameResultCopyWithImpl(this._self, this._then);

  final RecentGameResult _self;
  final $Res Function(RecentGameResult) _then;

/// Create a copy of RecentGameResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameId = null,Object? won = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RecentGameResult].
extension RecentGameResultPatterns on RecentGameResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecentGameResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecentGameResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecentGameResult value)  $default,){
final _that = this;
switch (_that) {
case _RecentGameResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecentGameResult value)?  $default,){
final _that = this;
switch (_that) {
case _RecentGameResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange, @TimestampConverter()  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecentGameResult() when $default != null:
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange, @TimestampConverter()  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _RecentGameResult():
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange, @TimestampConverter()  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _RecentGameResult() when $default != null:
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecentGameResult extends RecentGameResult {
  const _RecentGameResult({required this.gameId, required this.won, required this.pointsScored, required this.pointsAllowed, required this.eloChange, @TimestampConverter() required this.timestamp}): super._();
  factory _RecentGameResult.fromJson(Map<String, dynamic> json) => _$RecentGameResultFromJson(json);

/// Reference to the game
@override final  String gameId;
/// Whether the team won
@override final  bool won;
/// Points scored by the team
@override final  int pointsScored;
/// Points scored by opponents
@override final  int pointsAllowed;
/// ELO change from this game
@override final  double eloChange;
/// When the game was played
@override@TimestampConverter() final  DateTime timestamp;

/// Create a copy of RecentGameResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecentGameResultCopyWith<_RecentGameResult> get copyWith => __$RecentGameResultCopyWithImpl<_RecentGameResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecentGameResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecentGameResult&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.won, won) || other.won == won)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,won,pointsScored,pointsAllowed,eloChange,timestamp);

@override
String toString() {
  return 'RecentGameResult(gameId: $gameId, won: $won, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$RecentGameResultCopyWith<$Res> implements $RecentGameResultCopyWith<$Res> {
  factory _$RecentGameResultCopyWith(_RecentGameResult value, $Res Function(_RecentGameResult) _then) = __$RecentGameResultCopyWithImpl;
@override @useResult
$Res call({
 String gameId, bool won, int pointsScored, int pointsAllowed, double eloChange,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class __$RecentGameResultCopyWithImpl<$Res>
    implements _$RecentGameResultCopyWith<$Res> {
  __$RecentGameResultCopyWithImpl(this._self, this._then);

  final _RecentGameResult _self;
  final $Res Function(_RecentGameResult) _then;

/// Create a copy of RecentGameResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameId = null,Object? won = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? timestamp = null,}) {
  return _then(_RecentGameResult(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
