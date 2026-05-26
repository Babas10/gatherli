// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'head_to_head_stats.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HeadToHeadStats {

/// Primary user ID (the user viewing these stats)
 String get userId;/// Opponent user ID
 String get opponentId;/// Opponent's display name (cached for performance and privacy)
 String? get opponentName;/// Opponent's email (cached for performance and privacy)
 String? get opponentEmail;/// Opponent's photo URL (cached for performance and privacy)
 String? get opponentPhotoUrl;/// Total games played against this opponent
 int get gamesPlayed;/// Games won against this opponent
 int get gamesWon;/// Games lost against this opponent
 int get gamesLost;/// Total points scored against this opponent
 int get pointsScored;/// Total points allowed against this opponent
 int get pointsAllowed;/// Net ELO change from games against this opponent
 double get eloChange;/// Largest point margin victory
 int get largestVictoryMargin;/// Largest point margin defeat
 int get largestDefeatMargin;/// Recent matchup results (up to 10 most recent)
 List<HeadToHeadGameResult> get recentMatchups;/// When these stats were last updated
@NullableTimestampConverter() DateTime? get lastUpdated;
/// Create a copy of HeadToHeadStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadStatsCopyWith<HeadToHeadStats> get copyWith => _$HeadToHeadStatsCopyWithImpl<HeadToHeadStats>(this as HeadToHeadStats, _$identity);

  /// Serializes this HeadToHeadStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.opponentName, opponentName) || other.opponentName == opponentName)&&(identical(other.opponentEmail, opponentEmail) || other.opponentEmail == opponentEmail)&&(identical(other.opponentPhotoUrl, opponentPhotoUrl) || other.opponentPhotoUrl == opponentPhotoUrl)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.largestVictoryMargin, largestVictoryMargin) || other.largestVictoryMargin == largestVictoryMargin)&&(identical(other.largestDefeatMargin, largestDefeatMargin) || other.largestDefeatMargin == largestDefeatMargin)&&const DeepCollectionEquality().equals(other.recentMatchups, recentMatchups)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,opponentId,opponentName,opponentEmail,opponentPhotoUrl,gamesPlayed,gamesWon,gamesLost,pointsScored,pointsAllowed,eloChange,largestVictoryMargin,largestDefeatMargin,const DeepCollectionEquality().hash(recentMatchups),lastUpdated);

@override
String toString() {
  return 'HeadToHeadStats(userId: $userId, opponentId: $opponentId, opponentName: $opponentName, opponentEmail: $opponentEmail, opponentPhotoUrl: $opponentPhotoUrl, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, largestVictoryMargin: $largestVictoryMargin, largestDefeatMargin: $largestDefeatMargin, recentMatchups: $recentMatchups, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadStatsCopyWith<$Res>  {
  factory $HeadToHeadStatsCopyWith(HeadToHeadStats value, $Res Function(HeadToHeadStats) _then) = _$HeadToHeadStatsCopyWithImpl;
@useResult
$Res call({
 String userId, String opponentId, String? opponentName, String? opponentEmail, String? opponentPhotoUrl, int gamesPlayed, int gamesWon, int gamesLost, int pointsScored, int pointsAllowed, double eloChange, int largestVictoryMargin, int largestDefeatMargin, List<HeadToHeadGameResult> recentMatchups,@NullableTimestampConverter() DateTime? lastUpdated
});




}
/// @nodoc
class _$HeadToHeadStatsCopyWithImpl<$Res>
    implements $HeadToHeadStatsCopyWith<$Res> {
  _$HeadToHeadStatsCopyWithImpl(this._self, this._then);

  final HeadToHeadStats _self;
  final $Res Function(HeadToHeadStats) _then;

/// Create a copy of HeadToHeadStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? opponentId = null,Object? opponentName = freezed,Object? opponentEmail = freezed,Object? opponentPhotoUrl = freezed,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? largestVictoryMargin = null,Object? largestDefeatMargin = null,Object? recentMatchups = null,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,opponentName: freezed == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String?,opponentEmail: freezed == opponentEmail ? _self.opponentEmail : opponentEmail // ignore: cast_nullable_to_non_nullable
as String?,opponentPhotoUrl: freezed == opponentPhotoUrl ? _self.opponentPhotoUrl : opponentPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,largestVictoryMargin: null == largestVictoryMargin ? _self.largestVictoryMargin : largestVictoryMargin // ignore: cast_nullable_to_non_nullable
as int,largestDefeatMargin: null == largestDefeatMargin ? _self.largestDefeatMargin : largestDefeatMargin // ignore: cast_nullable_to_non_nullable
as int,recentMatchups: null == recentMatchups ? _self.recentMatchups : recentMatchups // ignore: cast_nullable_to_non_nullable
as List<HeadToHeadGameResult>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadToHeadStats].
extension HeadToHeadStatsPatterns on HeadToHeadStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadToHeadStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadToHeadStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadToHeadStats value)  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadToHeadStats value)?  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  String opponentId,  String? opponentName,  String? opponentEmail,  String? opponentPhotoUrl,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  int largestVictoryMargin,  int largestDefeatMargin,  List<HeadToHeadGameResult> recentMatchups, @NullableTimestampConverter()  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadToHeadStats() when $default != null:
return $default(_that.userId,_that.opponentId,_that.opponentName,_that.opponentEmail,_that.opponentPhotoUrl,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.largestVictoryMargin,_that.largestDefeatMargin,_that.recentMatchups,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  String opponentId,  String? opponentName,  String? opponentEmail,  String? opponentPhotoUrl,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  int largestVictoryMargin,  int largestDefeatMargin,  List<HeadToHeadGameResult> recentMatchups, @NullableTimestampConverter()  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadStats():
return $default(_that.userId,_that.opponentId,_that.opponentName,_that.opponentEmail,_that.opponentPhotoUrl,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.largestVictoryMargin,_that.largestDefeatMargin,_that.recentMatchups,_that.lastUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  String opponentId,  String? opponentName,  String? opponentEmail,  String? opponentPhotoUrl,  int gamesPlayed,  int gamesWon,  int gamesLost,  int pointsScored,  int pointsAllowed,  double eloChange,  int largestVictoryMargin,  int largestDefeatMargin,  List<HeadToHeadGameResult> recentMatchups, @NullableTimestampConverter()  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadStats() when $default != null:
return $default(_that.userId,_that.opponentId,_that.opponentName,_that.opponentEmail,_that.opponentPhotoUrl,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.largestVictoryMargin,_that.largestDefeatMargin,_that.recentMatchups,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadToHeadStats extends HeadToHeadStats {
  const _HeadToHeadStats({required this.userId, required this.opponentId, this.opponentName, this.opponentEmail, this.opponentPhotoUrl, required this.gamesPlayed, required this.gamesWon, required this.gamesLost, this.pointsScored = 0, this.pointsAllowed = 0, this.eloChange = 0.0, this.largestVictoryMargin = 0, this.largestDefeatMargin = 0, final  List<HeadToHeadGameResult> recentMatchups = const [], @NullableTimestampConverter() this.lastUpdated}): _recentMatchups = recentMatchups,super._();
  factory _HeadToHeadStats.fromJson(Map<String, dynamic> json) => _$HeadToHeadStatsFromJson(json);

/// Primary user ID (the user viewing these stats)
@override final  String userId;
/// Opponent user ID
@override final  String opponentId;
/// Opponent's display name (cached for performance and privacy)
@override final  String? opponentName;
/// Opponent's email (cached for performance and privacy)
@override final  String? opponentEmail;
/// Opponent's photo URL (cached for performance and privacy)
@override final  String? opponentPhotoUrl;
/// Total games played against this opponent
@override final  int gamesPlayed;
/// Games won against this opponent
@override final  int gamesWon;
/// Games lost against this opponent
@override final  int gamesLost;
/// Total points scored against this opponent
@override@JsonKey() final  int pointsScored;
/// Total points allowed against this opponent
@override@JsonKey() final  int pointsAllowed;
/// Net ELO change from games against this opponent
@override@JsonKey() final  double eloChange;
/// Largest point margin victory
@override@JsonKey() final  int largestVictoryMargin;
/// Largest point margin defeat
@override@JsonKey() final  int largestDefeatMargin;
/// Recent matchup results (up to 10 most recent)
 final  List<HeadToHeadGameResult> _recentMatchups;
/// Recent matchup results (up to 10 most recent)
@override@JsonKey() List<HeadToHeadGameResult> get recentMatchups {
  if (_recentMatchups is EqualUnmodifiableListView) return _recentMatchups;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_recentMatchups);
}

/// When these stats were last updated
@override@NullableTimestampConverter() final  DateTime? lastUpdated;

/// Create a copy of HeadToHeadStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadToHeadStatsCopyWith<_HeadToHeadStats> get copyWith => __$HeadToHeadStatsCopyWithImpl<_HeadToHeadStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadToHeadStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadToHeadStats&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.opponentName, opponentName) || other.opponentName == opponentName)&&(identical(other.opponentEmail, opponentEmail) || other.opponentEmail == opponentEmail)&&(identical(other.opponentPhotoUrl, opponentPhotoUrl) || other.opponentPhotoUrl == opponentPhotoUrl)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.largestVictoryMargin, largestVictoryMargin) || other.largestVictoryMargin == largestVictoryMargin)&&(identical(other.largestDefeatMargin, largestDefeatMargin) || other.largestDefeatMargin == largestDefeatMargin)&&const DeepCollectionEquality().equals(other._recentMatchups, _recentMatchups)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,opponentId,opponentName,opponentEmail,opponentPhotoUrl,gamesPlayed,gamesWon,gamesLost,pointsScored,pointsAllowed,eloChange,largestVictoryMargin,largestDefeatMargin,const DeepCollectionEquality().hash(_recentMatchups),lastUpdated);

@override
String toString() {
  return 'HeadToHeadStats(userId: $userId, opponentId: $opponentId, opponentName: $opponentName, opponentEmail: $opponentEmail, opponentPhotoUrl: $opponentPhotoUrl, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, largestVictoryMargin: $largestVictoryMargin, largestDefeatMargin: $largestDefeatMargin, recentMatchups: $recentMatchups, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$HeadToHeadStatsCopyWith<$Res> implements $HeadToHeadStatsCopyWith<$Res> {
  factory _$HeadToHeadStatsCopyWith(_HeadToHeadStats value, $Res Function(_HeadToHeadStats) _then) = __$HeadToHeadStatsCopyWithImpl;
@override @useResult
$Res call({
 String userId, String opponentId, String? opponentName, String? opponentEmail, String? opponentPhotoUrl, int gamesPlayed, int gamesWon, int gamesLost, int pointsScored, int pointsAllowed, double eloChange, int largestVictoryMargin, int largestDefeatMargin, List<HeadToHeadGameResult> recentMatchups,@NullableTimestampConverter() DateTime? lastUpdated
});




}
/// @nodoc
class __$HeadToHeadStatsCopyWithImpl<$Res>
    implements _$HeadToHeadStatsCopyWith<$Res> {
  __$HeadToHeadStatsCopyWithImpl(this._self, this._then);

  final _HeadToHeadStats _self;
  final $Res Function(_HeadToHeadStats) _then;

/// Create a copy of HeadToHeadStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? opponentId = null,Object? opponentName = freezed,Object? opponentEmail = freezed,Object? opponentPhotoUrl = freezed,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? largestVictoryMargin = null,Object? largestDefeatMargin = null,Object? recentMatchups = null,Object? lastUpdated = freezed,}) {
  return _then(_HeadToHeadStats(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,opponentName: freezed == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String?,opponentEmail: freezed == opponentEmail ? _self.opponentEmail : opponentEmail // ignore: cast_nullable_to_non_nullable
as String?,opponentPhotoUrl: freezed == opponentPhotoUrl ? _self.opponentPhotoUrl : opponentPhotoUrl // ignore: cast_nullable_to_non_nullable
as String?,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,largestVictoryMargin: null == largestVictoryMargin ? _self.largestVictoryMargin : largestVictoryMargin // ignore: cast_nullable_to_non_nullable
as int,largestDefeatMargin: null == largestDefeatMargin ? _self.largestDefeatMargin : largestDefeatMargin // ignore: cast_nullable_to_non_nullable
as int,recentMatchups: null == recentMatchups ? _self._recentMatchups : recentMatchups // ignore: cast_nullable_to_non_nullable
as List<HeadToHeadGameResult>,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$HeadToHeadGameResult {

/// Reference to the game
 String get gameId;/// Whether the primary user won
 bool get won;/// Points scored by user's team
 int get pointsScored;/// Points scored by opponent's team
 int get pointsAllowed;/// ELO change from this game
 double get eloChange;/// Partner who played with the user (if any)
 String? get partnerId;/// Partner who played with the opponent (if any)
 String? get opponentPartnerId;/// When the game was played
@TimestampConverter() DateTime get timestamp;
/// Create a copy of HeadToHeadGameResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeadToHeadGameResultCopyWith<HeadToHeadGameResult> get copyWith => _$HeadToHeadGameResultCopyWithImpl<HeadToHeadGameResult>(this as HeadToHeadGameResult, _$identity);

  /// Serializes this HeadToHeadGameResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeadToHeadGameResult&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.won, won) || other.won == won)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId)&&(identical(other.opponentPartnerId, opponentPartnerId) || other.opponentPartnerId == opponentPartnerId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,won,pointsScored,pointsAllowed,eloChange,partnerId,opponentPartnerId,timestamp);

@override
String toString() {
  return 'HeadToHeadGameResult(gameId: $gameId, won: $won, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, partnerId: $partnerId, opponentPartnerId: $opponentPartnerId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $HeadToHeadGameResultCopyWith<$Res>  {
  factory $HeadToHeadGameResultCopyWith(HeadToHeadGameResult value, $Res Function(HeadToHeadGameResult) _then) = _$HeadToHeadGameResultCopyWithImpl;
@useResult
$Res call({
 String gameId, bool won, int pointsScored, int pointsAllowed, double eloChange, String? partnerId, String? opponentPartnerId,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class _$HeadToHeadGameResultCopyWithImpl<$Res>
    implements $HeadToHeadGameResultCopyWith<$Res> {
  _$HeadToHeadGameResultCopyWithImpl(this._self, this._then);

  final HeadToHeadGameResult _self;
  final $Res Function(HeadToHeadGameResult) _then;

/// Create a copy of HeadToHeadGameResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameId = null,Object? won = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? partnerId = freezed,Object? opponentPartnerId = freezed,Object? timestamp = null,}) {
  return _then(_self.copyWith(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,opponentPartnerId: freezed == opponentPartnerId ? _self.opponentPartnerId : opponentPartnerId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [HeadToHeadGameResult].
extension HeadToHeadGameResultPatterns on HeadToHeadGameResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeadToHeadGameResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeadToHeadGameResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeadToHeadGameResult value)  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadGameResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeadToHeadGameResult value)?  $default,){
final _that = this;
switch (_that) {
case _HeadToHeadGameResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange,  String? partnerId,  String? opponentPartnerId, @TimestampConverter()  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeadToHeadGameResult() when $default != null:
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.partnerId,_that.opponentPartnerId,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange,  String? partnerId,  String? opponentPartnerId, @TimestampConverter()  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadGameResult():
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.partnerId,_that.opponentPartnerId,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gameId,  bool won,  int pointsScored,  int pointsAllowed,  double eloChange,  String? partnerId,  String? opponentPartnerId, @TimestampConverter()  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _HeadToHeadGameResult() when $default != null:
return $default(_that.gameId,_that.won,_that.pointsScored,_that.pointsAllowed,_that.eloChange,_that.partnerId,_that.opponentPartnerId,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HeadToHeadGameResult extends HeadToHeadGameResult {
  const _HeadToHeadGameResult({required this.gameId, required this.won, required this.pointsScored, required this.pointsAllowed, required this.eloChange, this.partnerId, this.opponentPartnerId, @TimestampConverter() required this.timestamp}): super._();
  factory _HeadToHeadGameResult.fromJson(Map<String, dynamic> json) => _$HeadToHeadGameResultFromJson(json);

/// Reference to the game
@override final  String gameId;
/// Whether the primary user won
@override final  bool won;
/// Points scored by user's team
@override final  int pointsScored;
/// Points scored by opponent's team
@override final  int pointsAllowed;
/// ELO change from this game
@override final  double eloChange;
/// Partner who played with the user (if any)
@override final  String? partnerId;
/// Partner who played with the opponent (if any)
@override final  String? opponentPartnerId;
/// When the game was played
@override@TimestampConverter() final  DateTime timestamp;

/// Create a copy of HeadToHeadGameResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeadToHeadGameResultCopyWith<_HeadToHeadGameResult> get copyWith => __$HeadToHeadGameResultCopyWithImpl<_HeadToHeadGameResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HeadToHeadGameResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeadToHeadGameResult&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.won, won) || other.won == won)&&(identical(other.pointsScored, pointsScored) || other.pointsScored == pointsScored)&&(identical(other.pointsAllowed, pointsAllowed) || other.pointsAllowed == pointsAllowed)&&(identical(other.eloChange, eloChange) || other.eloChange == eloChange)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId)&&(identical(other.opponentPartnerId, opponentPartnerId) || other.opponentPartnerId == opponentPartnerId)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,won,pointsScored,pointsAllowed,eloChange,partnerId,opponentPartnerId,timestamp);

@override
String toString() {
  return 'HeadToHeadGameResult(gameId: $gameId, won: $won, pointsScored: $pointsScored, pointsAllowed: $pointsAllowed, eloChange: $eloChange, partnerId: $partnerId, opponentPartnerId: $opponentPartnerId, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$HeadToHeadGameResultCopyWith<$Res> implements $HeadToHeadGameResultCopyWith<$Res> {
  factory _$HeadToHeadGameResultCopyWith(_HeadToHeadGameResult value, $Res Function(_HeadToHeadGameResult) _then) = __$HeadToHeadGameResultCopyWithImpl;
@override @useResult
$Res call({
 String gameId, bool won, int pointsScored, int pointsAllowed, double eloChange, String? partnerId, String? opponentPartnerId,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class __$HeadToHeadGameResultCopyWithImpl<$Res>
    implements _$HeadToHeadGameResultCopyWith<$Res> {
  __$HeadToHeadGameResultCopyWithImpl(this._self, this._then);

  final _HeadToHeadGameResult _self;
  final $Res Function(_HeadToHeadGameResult) _then;

/// Create a copy of HeadToHeadGameResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameId = null,Object? won = null,Object? pointsScored = null,Object? pointsAllowed = null,Object? eloChange = null,Object? partnerId = freezed,Object? opponentPartnerId = freezed,Object? timestamp = null,}) {
  return _then(_HeadToHeadGameResult(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,pointsScored: null == pointsScored ? _self.pointsScored : pointsScored // ignore: cast_nullable_to_non_nullable
as int,pointsAllowed: null == pointsAllowed ? _self.pointsAllowed : pointsAllowed // ignore: cast_nullable_to_non_nullable
as int,eloChange: null == eloChange ? _self.eloChange : eloChange // ignore: cast_nullable_to_non_nullable
as double,partnerId: freezed == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String?,opponentPartnerId: freezed == opponentPartnerId ? _self.opponentPartnerId : opponentPartnerId // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
