// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rating_history_entry.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RatingHistoryEntry {

/// Auto-generated document ID from Firestore
 String get entryId;/// Reference to the game that caused this rating change
 String get gameId;/// Rating before the game
 double get oldRating;/// Rating after the game
 double get newRating;/// Rating change (positive or negative)
 double get ratingChange;/// Display string for opponent team (e.g., "Player A & Player B")
 String get opponentTeam;/// Whether the player's team won
 bool get won;/// When this rating update was recorded
@TimestampConverter() DateTime get timestamp;
/// Create a copy of RatingHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RatingHistoryEntryCopyWith<RatingHistoryEntry> get copyWith => _$RatingHistoryEntryCopyWithImpl<RatingHistoryEntry>(this as RatingHistoryEntry, _$identity);

  /// Serializes this RatingHistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RatingHistoryEntry&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.oldRating, oldRating) || other.oldRating == oldRating)&&(identical(other.newRating, newRating) || other.newRating == newRating)&&(identical(other.ratingChange, ratingChange) || other.ratingChange == ratingChange)&&(identical(other.opponentTeam, opponentTeam) || other.opponentTeam == opponentTeam)&&(identical(other.won, won) || other.won == won)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entryId,gameId,oldRating,newRating,ratingChange,opponentTeam,won,timestamp);

@override
String toString() {
  return 'RatingHistoryEntry(entryId: $entryId, gameId: $gameId, oldRating: $oldRating, newRating: $newRating, ratingChange: $ratingChange, opponentTeam: $opponentTeam, won: $won, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $RatingHistoryEntryCopyWith<$Res>  {
  factory $RatingHistoryEntryCopyWith(RatingHistoryEntry value, $Res Function(RatingHistoryEntry) _then) = _$RatingHistoryEntryCopyWithImpl;
@useResult
$Res call({
 String entryId, String gameId, double oldRating, double newRating, double ratingChange, String opponentTeam, bool won,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class _$RatingHistoryEntryCopyWithImpl<$Res>
    implements $RatingHistoryEntryCopyWith<$Res> {
  _$RatingHistoryEntryCopyWithImpl(this._self, this._then);

  final RatingHistoryEntry _self;
  final $Res Function(RatingHistoryEntry) _then;

/// Create a copy of RatingHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entryId = null,Object? gameId = null,Object? oldRating = null,Object? newRating = null,Object? ratingChange = null,Object? opponentTeam = null,Object? won = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,oldRating: null == oldRating ? _self.oldRating : oldRating // ignore: cast_nullable_to_non_nullable
as double,newRating: null == newRating ? _self.newRating : newRating // ignore: cast_nullable_to_non_nullable
as double,ratingChange: null == ratingChange ? _self.ratingChange : ratingChange // ignore: cast_nullable_to_non_nullable
as double,opponentTeam: null == opponentTeam ? _self.opponentTeam : opponentTeam // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [RatingHistoryEntry].
extension RatingHistoryEntryPatterns on RatingHistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RatingHistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RatingHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RatingHistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _RatingHistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RatingHistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _RatingHistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String entryId,  String gameId,  double oldRating,  double newRating,  double ratingChange,  String opponentTeam,  bool won, @TimestampConverter()  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RatingHistoryEntry() when $default != null:
return $default(_that.entryId,_that.gameId,_that.oldRating,_that.newRating,_that.ratingChange,_that.opponentTeam,_that.won,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String entryId,  String gameId,  double oldRating,  double newRating,  double ratingChange,  String opponentTeam,  bool won, @TimestampConverter()  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _RatingHistoryEntry():
return $default(_that.entryId,_that.gameId,_that.oldRating,_that.newRating,_that.ratingChange,_that.opponentTeam,_that.won,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String entryId,  String gameId,  double oldRating,  double newRating,  double ratingChange,  String opponentTeam,  bool won, @TimestampConverter()  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _RatingHistoryEntry() when $default != null:
return $default(_that.entryId,_that.gameId,_that.oldRating,_that.newRating,_that.ratingChange,_that.opponentTeam,_that.won,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RatingHistoryEntry extends RatingHistoryEntry {
  const _RatingHistoryEntry({required this.entryId, required this.gameId, required this.oldRating, required this.newRating, required this.ratingChange, required this.opponentTeam, required this.won, @TimestampConverter() required this.timestamp}): super._();
  factory _RatingHistoryEntry.fromJson(Map<String, dynamic> json) => _$RatingHistoryEntryFromJson(json);

/// Auto-generated document ID from Firestore
@override final  String entryId;
/// Reference to the game that caused this rating change
@override final  String gameId;
/// Rating before the game
@override final  double oldRating;
/// Rating after the game
@override final  double newRating;
/// Rating change (positive or negative)
@override final  double ratingChange;
/// Display string for opponent team (e.g., "Player A & Player B")
@override final  String opponentTeam;
/// Whether the player's team won
@override final  bool won;
/// When this rating update was recorded
@override@TimestampConverter() final  DateTime timestamp;

/// Create a copy of RatingHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RatingHistoryEntryCopyWith<_RatingHistoryEntry> get copyWith => __$RatingHistoryEntryCopyWithImpl<_RatingHistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RatingHistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RatingHistoryEntry&&(identical(other.entryId, entryId) || other.entryId == entryId)&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.oldRating, oldRating) || other.oldRating == oldRating)&&(identical(other.newRating, newRating) || other.newRating == newRating)&&(identical(other.ratingChange, ratingChange) || other.ratingChange == ratingChange)&&(identical(other.opponentTeam, opponentTeam) || other.opponentTeam == opponentTeam)&&(identical(other.won, won) || other.won == won)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,entryId,gameId,oldRating,newRating,ratingChange,opponentTeam,won,timestamp);

@override
String toString() {
  return 'RatingHistoryEntry(entryId: $entryId, gameId: $gameId, oldRating: $oldRating, newRating: $newRating, ratingChange: $ratingChange, opponentTeam: $opponentTeam, won: $won, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$RatingHistoryEntryCopyWith<$Res> implements $RatingHistoryEntryCopyWith<$Res> {
  factory _$RatingHistoryEntryCopyWith(_RatingHistoryEntry value, $Res Function(_RatingHistoryEntry) _then) = __$RatingHistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String entryId, String gameId, double oldRating, double newRating, double ratingChange, String opponentTeam, bool won,@TimestampConverter() DateTime timestamp
});




}
/// @nodoc
class __$RatingHistoryEntryCopyWithImpl<$Res>
    implements _$RatingHistoryEntryCopyWith<$Res> {
  __$RatingHistoryEntryCopyWithImpl(this._self, this._then);

  final _RatingHistoryEntry _self;
  final $Res Function(_RatingHistoryEntry) _then;

/// Create a copy of RatingHistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entryId = null,Object? gameId = null,Object? oldRating = null,Object? newRating = null,Object? ratingChange = null,Object? opponentTeam = null,Object? won = null,Object? timestamp = null,}) {
  return _then(_RatingHistoryEntry(
entryId: null == entryId ? _self.entryId : entryId // ignore: cast_nullable_to_non_nullable
as String,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,oldRating: null == oldRating ? _self.oldRating : oldRating // ignore: cast_nullable_to_non_nullable
as double,newRating: null == newRating ? _self.newRating : newRating // ignore: cast_nullable_to_non_nullable
as double,ratingChange: null == ratingChange ? _self.ratingChange : ratingChange // ignore: cast_nullable_to_non_nullable
as double,opponentTeam: null == opponentTeam ? _self.opponentTeam : opponentTeam // ignore: cast_nullable_to_non_nullable
as String,won: null == won ? _self.won : won // ignore: cast_nullable_to_non_nullable
as bool,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
