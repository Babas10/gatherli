// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'statistics_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlayerRating {

 String get playerId; double get rating; String? get displayName;
/// Create a copy of PlayerRating
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<PlayerRating> get copyWith => _$PlayerRatingCopyWithImpl<PlayerRating>(this as PlayerRating, _$identity);

  /// Serializes this PlayerRating to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlayerRating&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,rating,displayName);

@override
String toString() {
  return 'PlayerRating(playerId: $playerId, rating: $rating, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class $PlayerRatingCopyWith<$Res>  {
  factory $PlayerRatingCopyWith(PlayerRating value, $Res Function(PlayerRating) _then) = _$PlayerRatingCopyWithImpl;
@useResult
$Res call({
 String playerId, double rating, String? displayName
});




}
/// @nodoc
class _$PlayerRatingCopyWithImpl<$Res>
    implements $PlayerRatingCopyWith<$Res> {
  _$PlayerRatingCopyWithImpl(this._self, this._then);

  final PlayerRating _self;
  final $Res Function(PlayerRating) _then;

/// Create a copy of PlayerRating
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? rating = null,Object? displayName = freezed,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlayerRating].
extension PlayerRatingPatterns on PlayerRating {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlayerRating value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlayerRating() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlayerRating value)  $default,){
final _that = this;
switch (_that) {
case _PlayerRating():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlayerRating value)?  $default,){
final _that = this;
switch (_that) {
case _PlayerRating() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  double rating,  String? displayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlayerRating() when $default != null:
return $default(_that.playerId,_that.rating,_that.displayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  double rating,  String? displayName)  $default,) {final _that = this;
switch (_that) {
case _PlayerRating():
return $default(_that.playerId,_that.rating,_that.displayName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  double rating,  String? displayName)?  $default,) {final _that = this;
switch (_that) {
case _PlayerRating() when $default != null:
return $default(_that.playerId,_that.rating,_that.displayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlayerRating extends PlayerRating {
  const _PlayerRating({required this.playerId, required this.rating, this.displayName}): super._();
  factory _PlayerRating.fromJson(Map<String, dynamic> json) => _$PlayerRatingFromJson(json);

@override final  String playerId;
@override final  double rating;
@override final  String? displayName;

/// Create a copy of PlayerRating
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlayerRatingCopyWith<_PlayerRating> get copyWith => __$PlayerRatingCopyWithImpl<_PlayerRating>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlayerRatingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlayerRating&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.displayName, displayName) || other.displayName == displayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,rating,displayName);

@override
String toString() {
  return 'PlayerRating(playerId: $playerId, rating: $rating, displayName: $displayName)';
}


}

/// @nodoc
abstract mixin class _$PlayerRatingCopyWith<$Res> implements $PlayerRatingCopyWith<$Res> {
  factory _$PlayerRatingCopyWith(_PlayerRating value, $Res Function(_PlayerRating) _then) = __$PlayerRatingCopyWithImpl;
@override @useResult
$Res call({
 String playerId, double rating, String? displayName
});




}
/// @nodoc
class __$PlayerRatingCopyWithImpl<$Res>
    implements _$PlayerRatingCopyWith<$Res> {
  __$PlayerRatingCopyWithImpl(this._self, this._then);

  final _PlayerRating _self;
  final $Res Function(_PlayerRating) _then;

/// Create a copy of PlayerRating
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? rating = null,Object? displayName = freezed,}) {
  return _then(_PlayerRating(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$EloResult {

 PlayerRating get teamAPlayer1; PlayerRating get teamAPlayer2; PlayerRating get teamBPlayer1; PlayerRating get teamBPlayer2; double get teamARating; double get teamBRating; double get teamAExpectedScore; double get teamBExpectedScore; double get ratingDelta; bool get teamAWon;
/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EloResultCopyWith<EloResult> get copyWith => _$EloResultCopyWithImpl<EloResult>(this as EloResult, _$identity);

  /// Serializes this EloResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloResult&&(identical(other.teamAPlayer1, teamAPlayer1) || other.teamAPlayer1 == teamAPlayer1)&&(identical(other.teamAPlayer2, teamAPlayer2) || other.teamAPlayer2 == teamAPlayer2)&&(identical(other.teamBPlayer1, teamBPlayer1) || other.teamBPlayer1 == teamBPlayer1)&&(identical(other.teamBPlayer2, teamBPlayer2) || other.teamBPlayer2 == teamBPlayer2)&&(identical(other.teamARating, teamARating) || other.teamARating == teamARating)&&(identical(other.teamBRating, teamBRating) || other.teamBRating == teamBRating)&&(identical(other.teamAExpectedScore, teamAExpectedScore) || other.teamAExpectedScore == teamAExpectedScore)&&(identical(other.teamBExpectedScore, teamBExpectedScore) || other.teamBExpectedScore == teamBExpectedScore)&&(identical(other.ratingDelta, ratingDelta) || other.ratingDelta == ratingDelta)&&(identical(other.teamAWon, teamAWon) || other.teamAWon == teamAWon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPlayer1,teamAPlayer2,teamBPlayer1,teamBPlayer2,teamARating,teamBRating,teamAExpectedScore,teamBExpectedScore,ratingDelta,teamAWon);

@override
String toString() {
  return 'EloResult(teamAPlayer1: $teamAPlayer1, teamAPlayer2: $teamAPlayer2, teamBPlayer1: $teamBPlayer1, teamBPlayer2: $teamBPlayer2, teamARating: $teamARating, teamBRating: $teamBRating, teamAExpectedScore: $teamAExpectedScore, teamBExpectedScore: $teamBExpectedScore, ratingDelta: $ratingDelta, teamAWon: $teamAWon)';
}


}

/// @nodoc
abstract mixin class $EloResultCopyWith<$Res>  {
  factory $EloResultCopyWith(EloResult value, $Res Function(EloResult) _then) = _$EloResultCopyWithImpl;
@useResult
$Res call({
 PlayerRating teamAPlayer1, PlayerRating teamAPlayer2, PlayerRating teamBPlayer1, PlayerRating teamBPlayer2, double teamARating, double teamBRating, double teamAExpectedScore, double teamBExpectedScore, double ratingDelta, bool teamAWon
});


$PlayerRatingCopyWith<$Res> get teamAPlayer1;$PlayerRatingCopyWith<$Res> get teamAPlayer2;$PlayerRatingCopyWith<$Res> get teamBPlayer1;$PlayerRatingCopyWith<$Res> get teamBPlayer2;

}
/// @nodoc
class _$EloResultCopyWithImpl<$Res>
    implements $EloResultCopyWith<$Res> {
  _$EloResultCopyWithImpl(this._self, this._then);

  final EloResult _self;
  final $Res Function(EloResult) _then;

/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamAPlayer1 = null,Object? teamAPlayer2 = null,Object? teamBPlayer1 = null,Object? teamBPlayer2 = null,Object? teamARating = null,Object? teamBRating = null,Object? teamAExpectedScore = null,Object? teamBExpectedScore = null,Object? ratingDelta = null,Object? teamAWon = null,}) {
  return _then(_self.copyWith(
teamAPlayer1: null == teamAPlayer1 ? _self.teamAPlayer1 : teamAPlayer1 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamAPlayer2: null == teamAPlayer2 ? _self.teamAPlayer2 : teamAPlayer2 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamBPlayer1: null == teamBPlayer1 ? _self.teamBPlayer1 : teamBPlayer1 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamBPlayer2: null == teamBPlayer2 ? _self.teamBPlayer2 : teamBPlayer2 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamARating: null == teamARating ? _self.teamARating : teamARating // ignore: cast_nullable_to_non_nullable
as double,teamBRating: null == teamBRating ? _self.teamBRating : teamBRating // ignore: cast_nullable_to_non_nullable
as double,teamAExpectedScore: null == teamAExpectedScore ? _self.teamAExpectedScore : teamAExpectedScore // ignore: cast_nullable_to_non_nullable
as double,teamBExpectedScore: null == teamBExpectedScore ? _self.teamBExpectedScore : teamBExpectedScore // ignore: cast_nullable_to_non_nullable
as double,ratingDelta: null == ratingDelta ? _self.ratingDelta : ratingDelta // ignore: cast_nullable_to_non_nullable
as double,teamAWon: null == teamAWon ? _self.teamAWon : teamAWon // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamAPlayer1 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamAPlayer1, (value) {
    return _then(_self.copyWith(teamAPlayer1: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamAPlayer2 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamAPlayer2, (value) {
    return _then(_self.copyWith(teamAPlayer2: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamBPlayer1 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamBPlayer1, (value) {
    return _then(_self.copyWith(teamBPlayer1: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamBPlayer2 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamBPlayer2, (value) {
    return _then(_self.copyWith(teamBPlayer2: value));
  });
}
}


/// Adds pattern-matching-related methods to [EloResult].
extension EloResultPatterns on EloResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EloResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EloResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EloResult value)  $default,){
final _that = this;
switch (_that) {
case _EloResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EloResult value)?  $default,){
final _that = this;
switch (_that) {
case _EloResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlayerRating teamAPlayer1,  PlayerRating teamAPlayer2,  PlayerRating teamBPlayer1,  PlayerRating teamBPlayer2,  double teamARating,  double teamBRating,  double teamAExpectedScore,  double teamBExpectedScore,  double ratingDelta,  bool teamAWon)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EloResult() when $default != null:
return $default(_that.teamAPlayer1,_that.teamAPlayer2,_that.teamBPlayer1,_that.teamBPlayer2,_that.teamARating,_that.teamBRating,_that.teamAExpectedScore,_that.teamBExpectedScore,_that.ratingDelta,_that.teamAWon);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlayerRating teamAPlayer1,  PlayerRating teamAPlayer2,  PlayerRating teamBPlayer1,  PlayerRating teamBPlayer2,  double teamARating,  double teamBRating,  double teamAExpectedScore,  double teamBExpectedScore,  double ratingDelta,  bool teamAWon)  $default,) {final _that = this;
switch (_that) {
case _EloResult():
return $default(_that.teamAPlayer1,_that.teamAPlayer2,_that.teamBPlayer1,_that.teamBPlayer2,_that.teamARating,_that.teamBRating,_that.teamAExpectedScore,_that.teamBExpectedScore,_that.ratingDelta,_that.teamAWon);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlayerRating teamAPlayer1,  PlayerRating teamAPlayer2,  PlayerRating teamBPlayer1,  PlayerRating teamBPlayer2,  double teamARating,  double teamBRating,  double teamAExpectedScore,  double teamBExpectedScore,  double ratingDelta,  bool teamAWon)?  $default,) {final _that = this;
switch (_that) {
case _EloResult() when $default != null:
return $default(_that.teamAPlayer1,_that.teamAPlayer2,_that.teamBPlayer1,_that.teamBPlayer2,_that.teamARating,_that.teamBRating,_that.teamAExpectedScore,_that.teamBExpectedScore,_that.ratingDelta,_that.teamAWon);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EloResult extends EloResult {
  const _EloResult({required this.teamAPlayer1, required this.teamAPlayer2, required this.teamBPlayer1, required this.teamBPlayer2, required this.teamARating, required this.teamBRating, required this.teamAExpectedScore, required this.teamBExpectedScore, required this.ratingDelta, required this.teamAWon}): super._();
  factory _EloResult.fromJson(Map<String, dynamic> json) => _$EloResultFromJson(json);

@override final  PlayerRating teamAPlayer1;
@override final  PlayerRating teamAPlayer2;
@override final  PlayerRating teamBPlayer1;
@override final  PlayerRating teamBPlayer2;
@override final  double teamARating;
@override final  double teamBRating;
@override final  double teamAExpectedScore;
@override final  double teamBExpectedScore;
@override final  double ratingDelta;
@override final  bool teamAWon;

/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EloResultCopyWith<_EloResult> get copyWith => __$EloResultCopyWithImpl<_EloResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EloResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EloResult&&(identical(other.teamAPlayer1, teamAPlayer1) || other.teamAPlayer1 == teamAPlayer1)&&(identical(other.teamAPlayer2, teamAPlayer2) || other.teamAPlayer2 == teamAPlayer2)&&(identical(other.teamBPlayer1, teamBPlayer1) || other.teamBPlayer1 == teamBPlayer1)&&(identical(other.teamBPlayer2, teamBPlayer2) || other.teamBPlayer2 == teamBPlayer2)&&(identical(other.teamARating, teamARating) || other.teamARating == teamARating)&&(identical(other.teamBRating, teamBRating) || other.teamBRating == teamBRating)&&(identical(other.teamAExpectedScore, teamAExpectedScore) || other.teamAExpectedScore == teamAExpectedScore)&&(identical(other.teamBExpectedScore, teamBExpectedScore) || other.teamBExpectedScore == teamBExpectedScore)&&(identical(other.ratingDelta, ratingDelta) || other.ratingDelta == ratingDelta)&&(identical(other.teamAWon, teamAWon) || other.teamAWon == teamAWon));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPlayer1,teamAPlayer2,teamBPlayer1,teamBPlayer2,teamARating,teamBRating,teamAExpectedScore,teamBExpectedScore,ratingDelta,teamAWon);

@override
String toString() {
  return 'EloResult(teamAPlayer1: $teamAPlayer1, teamAPlayer2: $teamAPlayer2, teamBPlayer1: $teamBPlayer1, teamBPlayer2: $teamBPlayer2, teamARating: $teamARating, teamBRating: $teamBRating, teamAExpectedScore: $teamAExpectedScore, teamBExpectedScore: $teamBExpectedScore, ratingDelta: $ratingDelta, teamAWon: $teamAWon)';
}


}

/// @nodoc
abstract mixin class _$EloResultCopyWith<$Res> implements $EloResultCopyWith<$Res> {
  factory _$EloResultCopyWith(_EloResult value, $Res Function(_EloResult) _then) = __$EloResultCopyWithImpl;
@override @useResult
$Res call({
 PlayerRating teamAPlayer1, PlayerRating teamAPlayer2, PlayerRating teamBPlayer1, PlayerRating teamBPlayer2, double teamARating, double teamBRating, double teamAExpectedScore, double teamBExpectedScore, double ratingDelta, bool teamAWon
});


@override $PlayerRatingCopyWith<$Res> get teamAPlayer1;@override $PlayerRatingCopyWith<$Res> get teamAPlayer2;@override $PlayerRatingCopyWith<$Res> get teamBPlayer1;@override $PlayerRatingCopyWith<$Res> get teamBPlayer2;

}
/// @nodoc
class __$EloResultCopyWithImpl<$Res>
    implements _$EloResultCopyWith<$Res> {
  __$EloResultCopyWithImpl(this._self, this._then);

  final _EloResult _self;
  final $Res Function(_EloResult) _then;

/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamAPlayer1 = null,Object? teamAPlayer2 = null,Object? teamBPlayer1 = null,Object? teamBPlayer2 = null,Object? teamARating = null,Object? teamBRating = null,Object? teamAExpectedScore = null,Object? teamBExpectedScore = null,Object? ratingDelta = null,Object? teamAWon = null,}) {
  return _then(_EloResult(
teamAPlayer1: null == teamAPlayer1 ? _self.teamAPlayer1 : teamAPlayer1 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamAPlayer2: null == teamAPlayer2 ? _self.teamAPlayer2 : teamAPlayer2 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamBPlayer1: null == teamBPlayer1 ? _self.teamBPlayer1 : teamBPlayer1 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamBPlayer2: null == teamBPlayer2 ? _self.teamBPlayer2 : teamBPlayer2 // ignore: cast_nullable_to_non_nullable
as PlayerRating,teamARating: null == teamARating ? _self.teamARating : teamARating // ignore: cast_nullable_to_non_nullable
as double,teamBRating: null == teamBRating ? _self.teamBRating : teamBRating // ignore: cast_nullable_to_non_nullable
as double,teamAExpectedScore: null == teamAExpectedScore ? _self.teamAExpectedScore : teamAExpectedScore // ignore: cast_nullable_to_non_nullable
as double,teamBExpectedScore: null == teamBExpectedScore ? _self.teamBExpectedScore : teamBExpectedScore // ignore: cast_nullable_to_non_nullable
as double,ratingDelta: null == ratingDelta ? _self.ratingDelta : ratingDelta // ignore: cast_nullable_to_non_nullable
as double,teamAWon: null == teamAWon ? _self.teamAWon : teamAWon // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamAPlayer1 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamAPlayer1, (value) {
    return _then(_self.copyWith(teamAPlayer1: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamAPlayer2 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamAPlayer2, (value) {
    return _then(_self.copyWith(teamAPlayer2: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamBPlayer1 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamBPlayer1, (value) {
    return _then(_self.copyWith(teamBPlayer1: value));
  });
}/// Create a copy of EloResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PlayerRatingCopyWith<$Res> get teamBPlayer2 {
  
  return $PlayerRatingCopyWith<$Res>(_self.teamBPlayer2, (value) {
    return _then(_self.copyWith(teamBPlayer2: value));
  });
}
}


/// @nodoc
mixin _$TeammateStats {

 String get playerId; String get displayName; int get gamesPlayed; int get gamesWon; int get gamesLost; double get winRate; double get averageRatingChange;
/// Create a copy of TeammateStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TeammateStatsCopyWith<TeammateStats> get copyWith => _$TeammateStatsCopyWithImpl<TeammateStats>(this as TeammateStats, _$identity);

  /// Serializes this TeammateStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TeammateStats&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.averageRatingChange, averageRatingChange) || other.averageRatingChange == averageRatingChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,gamesPlayed,gamesWon,gamesLost,winRate,averageRatingChange);

@override
String toString() {
  return 'TeammateStats(playerId: $playerId, displayName: $displayName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, averageRatingChange: $averageRatingChange)';
}


}

/// @nodoc
abstract mixin class $TeammateStatsCopyWith<$Res>  {
  factory $TeammateStatsCopyWith(TeammateStats value, $Res Function(TeammateStats) _then) = _$TeammateStatsCopyWithImpl;
@useResult
$Res call({
 String playerId, String displayName, int gamesPlayed, int gamesWon, int gamesLost, double winRate, double averageRatingChange
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
@pragma('vm:prefer-inline') @override $Res call({Object? playerId = null,Object? displayName = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? averageRatingChange = null,}) {
  return _then(_self.copyWith(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,averageRatingChange: null == averageRatingChange ? _self.averageRatingChange : averageRatingChange // ignore: cast_nullable_to_non_nullable
as double,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String playerId,  String displayName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  double averageRatingChange)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
return $default(_that.playerId,_that.displayName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.averageRatingChange);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String playerId,  String displayName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  double averageRatingChange)  $default,) {final _that = this;
switch (_that) {
case _TeammateStats():
return $default(_that.playerId,_that.displayName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.averageRatingChange);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String playerId,  String displayName,  int gamesPlayed,  int gamesWon,  int gamesLost,  double winRate,  double averageRatingChange)?  $default,) {final _that = this;
switch (_that) {
case _TeammateStats() when $default != null:
return $default(_that.playerId,_that.displayName,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.winRate,_that.averageRatingChange);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TeammateStats extends TeammateStats {
  const _TeammateStats({required this.playerId, required this.displayName, required this.gamesPlayed, required this.gamesWon, required this.gamesLost, required this.winRate, required this.averageRatingChange}): super._();
  factory _TeammateStats.fromJson(Map<String, dynamic> json) => _$TeammateStatsFromJson(json);

@override final  String playerId;
@override final  String displayName;
@override final  int gamesPlayed;
@override final  int gamesWon;
@override final  int gamesLost;
@override final  double winRate;
@override final  double averageRatingChange;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TeammateStats&&(identical(other.playerId, playerId) || other.playerId == playerId)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.winRate, winRate) || other.winRate == winRate)&&(identical(other.averageRatingChange, averageRatingChange) || other.averageRatingChange == averageRatingChange));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,playerId,displayName,gamesPlayed,gamesWon,gamesLost,winRate,averageRatingChange);

@override
String toString() {
  return 'TeammateStats(playerId: $playerId, displayName: $displayName, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, winRate: $winRate, averageRatingChange: $averageRatingChange)';
}


}

/// @nodoc
abstract mixin class _$TeammateStatsCopyWith<$Res> implements $TeammateStatsCopyWith<$Res> {
  factory _$TeammateStatsCopyWith(_TeammateStats value, $Res Function(_TeammateStats) _then) = __$TeammateStatsCopyWithImpl;
@override @useResult
$Res call({
 String playerId, String displayName, int gamesPlayed, int gamesWon, int gamesLost, double winRate, double averageRatingChange
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
@override @pragma('vm:prefer-inline') $Res call({Object? playerId = null,Object? displayName = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? winRate = null,Object? averageRatingChange = null,}) {
  return _then(_TeammateStats(
playerId: null == playerId ? _self.playerId : playerId // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,averageRatingChange: null == averageRatingChange ? _self.averageRatingChange : averageRatingChange // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
