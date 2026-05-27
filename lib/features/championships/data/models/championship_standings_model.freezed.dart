// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_standings_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChampionshipStandingsModel {

 String get teamId; String get teamName; int get played; int get points; int get wins20;// 2-0 wins (3 pts)
 int get wins21;// 2-1 wins (2 pts)
 int get losses12;// 1-2 losses (1 pt)
 int get losses02;// 0-2 losses (0 pts)
 int get setsWon; int get setsLost; int get position;
/// Create a copy of ChampionshipStandingsModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChampionshipStandingsModelCopyWith<ChampionshipStandingsModel> get copyWith => _$ChampionshipStandingsModelCopyWithImpl<ChampionshipStandingsModel>(this as ChampionshipStandingsModel, _$identity);

  /// Serializes this ChampionshipStandingsModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChampionshipStandingsModel&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.played, played) || other.played == played)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins20, wins20) || other.wins20 == wins20)&&(identical(other.wins21, wins21) || other.wins21 == wins21)&&(identical(other.losses12, losses12) || other.losses12 == losses12)&&(identical(other.losses02, losses02) || other.losses02 == losses02)&&(identical(other.setsWon, setsWon) || other.setsWon == setsWon)&&(identical(other.setsLost, setsLost) || other.setsLost == setsLost)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,teamName,played,points,wins20,wins21,losses12,losses02,setsWon,setsLost,position);

@override
String toString() {
  return 'ChampionshipStandingsModel(teamId: $teamId, teamName: $teamName, played: $played, points: $points, wins20: $wins20, wins21: $wins21, losses12: $losses12, losses02: $losses02, setsWon: $setsWon, setsLost: $setsLost, position: $position)';
}


}

/// @nodoc
abstract mixin class $ChampionshipStandingsModelCopyWith<$Res>  {
  factory $ChampionshipStandingsModelCopyWith(ChampionshipStandingsModel value, $Res Function(ChampionshipStandingsModel) _then) = _$ChampionshipStandingsModelCopyWithImpl;
@useResult
$Res call({
 String teamId, String teamName, int played, int points, int wins20, int wins21, int losses12, int losses02, int setsWon, int setsLost, int position
});




}
/// @nodoc
class _$ChampionshipStandingsModelCopyWithImpl<$Res>
    implements $ChampionshipStandingsModelCopyWith<$Res> {
  _$ChampionshipStandingsModelCopyWithImpl(this._self, this._then);

  final ChampionshipStandingsModel _self;
  final $Res Function(ChampionshipStandingsModel) _then;

/// Create a copy of ChampionshipStandingsModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? teamId = null,Object? teamName = null,Object? played = null,Object? points = null,Object? wins20 = null,Object? wins21 = null,Object? losses12 = null,Object? losses02 = null,Object? setsWon = null,Object? setsLost = null,Object? position = null,}) {
  return _then(_self.copyWith(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,wins20: null == wins20 ? _self.wins20 : wins20 // ignore: cast_nullable_to_non_nullable
as int,wins21: null == wins21 ? _self.wins21 : wins21 // ignore: cast_nullable_to_non_nullable
as int,losses12: null == losses12 ? _self.losses12 : losses12 // ignore: cast_nullable_to_non_nullable
as int,losses02: null == losses02 ? _self.losses02 : losses02 // ignore: cast_nullable_to_non_nullable
as int,setsWon: null == setsWon ? _self.setsWon : setsWon // ignore: cast_nullable_to_non_nullable
as int,setsLost: null == setsLost ? _self.setsLost : setsLost // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ChampionshipStandingsModel].
extension ChampionshipStandingsModelPatterns on ChampionshipStandingsModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChampionshipStandingsModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChampionshipStandingsModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChampionshipStandingsModel value)  $default,){
final _that = this;
switch (_that) {
case _ChampionshipStandingsModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChampionshipStandingsModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChampionshipStandingsModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String teamId,  String teamName,  int played,  int points,  int wins20,  int wins21,  int losses12,  int losses02,  int setsWon,  int setsLost,  int position)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChampionshipStandingsModel() when $default != null:
return $default(_that.teamId,_that.teamName,_that.played,_that.points,_that.wins20,_that.wins21,_that.losses12,_that.losses02,_that.setsWon,_that.setsLost,_that.position);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String teamId,  String teamName,  int played,  int points,  int wins20,  int wins21,  int losses12,  int losses02,  int setsWon,  int setsLost,  int position)  $default,) {final _that = this;
switch (_that) {
case _ChampionshipStandingsModel():
return $default(_that.teamId,_that.teamName,_that.played,_that.points,_that.wins20,_that.wins21,_that.losses12,_that.losses02,_that.setsWon,_that.setsLost,_that.position);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String teamId,  String teamName,  int played,  int points,  int wins20,  int wins21,  int losses12,  int losses02,  int setsWon,  int setsLost,  int position)?  $default,) {final _that = this;
switch (_that) {
case _ChampionshipStandingsModel() when $default != null:
return $default(_that.teamId,_that.teamName,_that.played,_that.points,_that.wins20,_that.wins21,_that.losses12,_that.losses02,_that.setsWon,_that.setsLost,_that.position);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChampionshipStandingsModel extends ChampionshipStandingsModel {
  const _ChampionshipStandingsModel({required this.teamId, required this.teamName, this.played = 0, this.points = 0, this.wins20 = 0, this.wins21 = 0, this.losses12 = 0, this.losses02 = 0, this.setsWon = 0, this.setsLost = 0, this.position = 0}): super._();
  factory _ChampionshipStandingsModel.fromJson(Map<String, dynamic> json) => _$ChampionshipStandingsModelFromJson(json);

@override final  String teamId;
@override final  String teamName;
@override@JsonKey() final  int played;
@override@JsonKey() final  int points;
@override@JsonKey() final  int wins20;
// 2-0 wins (3 pts)
@override@JsonKey() final  int wins21;
// 2-1 wins (2 pts)
@override@JsonKey() final  int losses12;
// 1-2 losses (1 pt)
@override@JsonKey() final  int losses02;
// 0-2 losses (0 pts)
@override@JsonKey() final  int setsWon;
@override@JsonKey() final  int setsLost;
@override@JsonKey() final  int position;

/// Create a copy of ChampionshipStandingsModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChampionshipStandingsModelCopyWith<_ChampionshipStandingsModel> get copyWith => __$ChampionshipStandingsModelCopyWithImpl<_ChampionshipStandingsModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChampionshipStandingsModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChampionshipStandingsModel&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.teamName, teamName) || other.teamName == teamName)&&(identical(other.played, played) || other.played == played)&&(identical(other.points, points) || other.points == points)&&(identical(other.wins20, wins20) || other.wins20 == wins20)&&(identical(other.wins21, wins21) || other.wins21 == wins21)&&(identical(other.losses12, losses12) || other.losses12 == losses12)&&(identical(other.losses02, losses02) || other.losses02 == losses02)&&(identical(other.setsWon, setsWon) || other.setsWon == setsWon)&&(identical(other.setsLost, setsLost) || other.setsLost == setsLost)&&(identical(other.position, position) || other.position == position));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamId,teamName,played,points,wins20,wins21,losses12,losses02,setsWon,setsLost,position);

@override
String toString() {
  return 'ChampionshipStandingsModel(teamId: $teamId, teamName: $teamName, played: $played, points: $points, wins20: $wins20, wins21: $wins21, losses12: $losses12, losses02: $losses02, setsWon: $setsWon, setsLost: $setsLost, position: $position)';
}


}

/// @nodoc
abstract mixin class _$ChampionshipStandingsModelCopyWith<$Res> implements $ChampionshipStandingsModelCopyWith<$Res> {
  factory _$ChampionshipStandingsModelCopyWith(_ChampionshipStandingsModel value, $Res Function(_ChampionshipStandingsModel) _then) = __$ChampionshipStandingsModelCopyWithImpl;
@override @useResult
$Res call({
 String teamId, String teamName, int played, int points, int wins20, int wins21, int losses12, int losses02, int setsWon, int setsLost, int position
});




}
/// @nodoc
class __$ChampionshipStandingsModelCopyWithImpl<$Res>
    implements _$ChampionshipStandingsModelCopyWith<$Res> {
  __$ChampionshipStandingsModelCopyWithImpl(this._self, this._then);

  final _ChampionshipStandingsModel _self;
  final $Res Function(_ChampionshipStandingsModel) _then;

/// Create a copy of ChampionshipStandingsModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamId = null,Object? teamName = null,Object? played = null,Object? points = null,Object? wins20 = null,Object? wins21 = null,Object? losses12 = null,Object? losses02 = null,Object? setsWon = null,Object? setsLost = null,Object? position = null,}) {
  return _then(_ChampionshipStandingsModel(
teamId: null == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String,teamName: null == teamName ? _self.teamName : teamName // ignore: cast_nullable_to_non_nullable
as String,played: null == played ? _self.played : played // ignore: cast_nullable_to_non_nullable
as int,points: null == points ? _self.points : points // ignore: cast_nullable_to_non_nullable
as int,wins20: null == wins20 ? _self.wins20 : wins20 // ignore: cast_nullable_to_non_nullable
as int,wins21: null == wins21 ? _self.wins21 : wins21 // ignore: cast_nullable_to_non_nullable
as int,losses12: null == losses12 ? _self.losses12 : losses12 // ignore: cast_nullable_to_non_nullable
as int,losses02: null == losses02 ? _self.losses02 : losses02 // ignore: cast_nullable_to_non_nullable
as int,setsWon: null == setsWon ? _self.setsWon : setsWon // ignore: cast_nullable_to_non_nullable
as int,setsLost: null == setsLost ? _self.setsLost : setsLost // ignore: cast_nullable_to_non_nullable
as int,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
