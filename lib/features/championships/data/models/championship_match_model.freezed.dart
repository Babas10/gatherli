// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_match_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MatchSetScore {

 int get teamAPoints; int get teamBPoints; int get setNumber;
/// Create a copy of MatchSetScore
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchSetScoreCopyWith<MatchSetScore> get copyWith => _$MatchSetScoreCopyWithImpl<MatchSetScore>(this as MatchSetScore, _$identity);

  /// Serializes this MatchSetScore to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchSetScore&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPoints,teamBPoints,setNumber);

@override
String toString() {
  return 'MatchSetScore(teamAPoints: $teamAPoints, teamBPoints: $teamBPoints, setNumber: $setNumber)';
}


}

/// @nodoc
abstract mixin class $MatchSetScoreCopyWith<$Res>  {
  factory $MatchSetScoreCopyWith(MatchSetScore value, $Res Function(MatchSetScore) _then) = _$MatchSetScoreCopyWithImpl;
@useResult
$Res call({
 int teamAPoints, int teamBPoints, int setNumber
});




}
/// @nodoc
class _$MatchSetScoreCopyWithImpl<$Res>
    implements $MatchSetScoreCopyWith<$Res> {
  _$MatchSetScoreCopyWithImpl(this._self, this._then);

  final MatchSetScore _self;
  final $Res Function(MatchSetScore) _then;

/// Create a copy of MatchSetScore
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


/// Adds pattern-matching-related methods to [MatchSetScore].
extension MatchSetScorePatterns on MatchSetScore {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchSetScore value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchSetScore() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchSetScore value)  $default,){
final _that = this;
switch (_that) {
case _MatchSetScore():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchSetScore value)?  $default,){
final _that = this;
switch (_that) {
case _MatchSetScore() when $default != null:
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
case _MatchSetScore() when $default != null:
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
case _MatchSetScore():
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
case _MatchSetScore() when $default != null:
return $default(_that.teamAPoints,_that.teamBPoints,_that.setNumber);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchSetScore extends MatchSetScore {
  const _MatchSetScore({required this.teamAPoints, required this.teamBPoints, required this.setNumber}): super._();
  factory _MatchSetScore.fromJson(Map<String, dynamic> json) => _$MatchSetScoreFromJson(json);

@override final  int teamAPoints;
@override final  int teamBPoints;
@override final  int setNumber;

/// Create a copy of MatchSetScore
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchSetScoreCopyWith<_MatchSetScore> get copyWith => __$MatchSetScoreCopyWithImpl<_MatchSetScore>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchSetScoreToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchSetScore&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints)&&(identical(other.setNumber, setNumber) || other.setNumber == setNumber));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,teamAPoints,teamBPoints,setNumber);

@override
String toString() {
  return 'MatchSetScore(teamAPoints: $teamAPoints, teamBPoints: $teamBPoints, setNumber: $setNumber)';
}


}

/// @nodoc
abstract mixin class _$MatchSetScoreCopyWith<$Res> implements $MatchSetScoreCopyWith<$Res> {
  factory _$MatchSetScoreCopyWith(_MatchSetScore value, $Res Function(_MatchSetScore) _then) = __$MatchSetScoreCopyWithImpl;
@override @useResult
$Res call({
 int teamAPoints, int teamBPoints, int setNumber
});




}
/// @nodoc
class __$MatchSetScoreCopyWithImpl<$Res>
    implements _$MatchSetScoreCopyWith<$Res> {
  __$MatchSetScoreCopyWithImpl(this._self, this._then);

  final _MatchSetScore _self;
  final $Res Function(_MatchSetScore) _then;

/// Create a copy of MatchSetScore
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? teamAPoints = null,Object? teamBPoints = null,Object? setNumber = null,}) {
  return _then(_MatchSetScore(
teamAPoints: null == teamAPoints ? _self.teamAPoints : teamAPoints // ignore: cast_nullable_to_non_nullable
as int,teamBPoints: null == teamBPoints ? _self.teamBPoints : teamBPoints // ignore: cast_nullable_to_non_nullable
as int,setNumber: null == setNumber ? _self.setNumber : setNumber // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$MatchResult {

@MatchSetScoreListConverter() List<MatchSetScore> get sets; String get winner;// 'teamA' | 'teamB'
/// Championship points awarded (3/2/1/0 system)
 int get teamAPoints; int get teamBPoints;
/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MatchResultCopyWith<MatchResult> get copyWith => _$MatchResultCopyWithImpl<MatchResult>(this as MatchResult, _$identity);

  /// Serializes this MatchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MatchResult&&const DeepCollectionEquality().equals(other.sets, sets)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(sets),winner,teamAPoints,teamBPoints);

@override
String toString() {
  return 'MatchResult(sets: $sets, winner: $winner, teamAPoints: $teamAPoints, teamBPoints: $teamBPoints)';
}


}

/// @nodoc
abstract mixin class $MatchResultCopyWith<$Res>  {
  factory $MatchResultCopyWith(MatchResult value, $Res Function(MatchResult) _then) = _$MatchResultCopyWithImpl;
@useResult
$Res call({
@MatchSetScoreListConverter() List<MatchSetScore> sets, String winner, int teamAPoints, int teamBPoints
});




}
/// @nodoc
class _$MatchResultCopyWithImpl<$Res>
    implements $MatchResultCopyWith<$Res> {
  _$MatchResultCopyWithImpl(this._self, this._then);

  final MatchResult _self;
  final $Res Function(MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sets = null,Object? winner = null,Object? teamAPoints = null,Object? teamBPoints = null,}) {
  return _then(_self.copyWith(
sets: null == sets ? _self.sets : sets // ignore: cast_nullable_to_non_nullable
as List<MatchSetScore>,winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String,teamAPoints: null == teamAPoints ? _self.teamAPoints : teamAPoints // ignore: cast_nullable_to_non_nullable
as int,teamBPoints: null == teamBPoints ? _self.teamBPoints : teamBPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [MatchResult].
extension MatchResultPatterns on MatchResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MatchResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MatchResult value)  $default,){
final _that = this;
switch (_that) {
case _MatchResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MatchResult value)?  $default,){
final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@MatchSetScoreListConverter()  List<MatchSetScore> sets,  String winner,  int teamAPoints,  int teamBPoints)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.sets,_that.winner,_that.teamAPoints,_that.teamBPoints);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@MatchSetScoreListConverter()  List<MatchSetScore> sets,  String winner,  int teamAPoints,  int teamBPoints)  $default,) {final _that = this;
switch (_that) {
case _MatchResult():
return $default(_that.sets,_that.winner,_that.teamAPoints,_that.teamBPoints);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@MatchSetScoreListConverter()  List<MatchSetScore> sets,  String winner,  int teamAPoints,  int teamBPoints)?  $default,) {final _that = this;
switch (_that) {
case _MatchResult() when $default != null:
return $default(_that.sets,_that.winner,_that.teamAPoints,_that.teamBPoints);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MatchResult extends MatchResult {
  const _MatchResult({@MatchSetScoreListConverter() required final  List<MatchSetScore> sets, required this.winner, required this.teamAPoints, required this.teamBPoints}): _sets = sets,super._();
  factory _MatchResult.fromJson(Map<String, dynamic> json) => _$MatchResultFromJson(json);

 final  List<MatchSetScore> _sets;
@override@MatchSetScoreListConverter() List<MatchSetScore> get sets {
  if (_sets is EqualUnmodifiableListView) return _sets;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_sets);
}

@override final  String winner;
// 'teamA' | 'teamB'
/// Championship points awarded (3/2/1/0 system)
@override final  int teamAPoints;
@override final  int teamBPoints;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MatchResultCopyWith<_MatchResult> get copyWith => __$MatchResultCopyWithImpl<_MatchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MatchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MatchResult&&const DeepCollectionEquality().equals(other._sets, _sets)&&(identical(other.winner, winner) || other.winner == winner)&&(identical(other.teamAPoints, teamAPoints) || other.teamAPoints == teamAPoints)&&(identical(other.teamBPoints, teamBPoints) || other.teamBPoints == teamBPoints));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_sets),winner,teamAPoints,teamBPoints);

@override
String toString() {
  return 'MatchResult(sets: $sets, winner: $winner, teamAPoints: $teamAPoints, teamBPoints: $teamBPoints)';
}


}

/// @nodoc
abstract mixin class _$MatchResultCopyWith<$Res> implements $MatchResultCopyWith<$Res> {
  factory _$MatchResultCopyWith(_MatchResult value, $Res Function(_MatchResult) _then) = __$MatchResultCopyWithImpl;
@override @useResult
$Res call({
@MatchSetScoreListConverter() List<MatchSetScore> sets, String winner, int teamAPoints, int teamBPoints
});




}
/// @nodoc
class __$MatchResultCopyWithImpl<$Res>
    implements _$MatchResultCopyWith<$Res> {
  __$MatchResultCopyWithImpl(this._self, this._then);

  final _MatchResult _self;
  final $Res Function(_MatchResult) _then;

/// Create a copy of MatchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sets = null,Object? winner = null,Object? teamAPoints = null,Object? teamBPoints = null,}) {
  return _then(_MatchResult(
sets: null == sets ? _self._sets : sets // ignore: cast_nullable_to_non_nullable
as List<MatchSetScore>,winner: null == winner ? _self.winner : winner // ignore: cast_nullable_to_non_nullable
as String,teamAPoints: null == teamAPoints ? _self.teamAPoints : teamAPoints // ignore: cast_nullable_to_non_nullable
as int,teamBPoints: null == teamBPoints ? _self.teamBPoints : teamBPoints // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$AdminDecision {

 String get decidedBy; String get notes;@TimestampConverter() DateTime get decidedAt;
/// Create a copy of AdminDecision
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminDecisionCopyWith<AdminDecision> get copyWith => _$AdminDecisionCopyWithImpl<AdminDecision>(this as AdminDecision, _$identity);

  /// Serializes this AdminDecision to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminDecision&&(identical(other.decidedBy, decidedBy) || other.decidedBy == decidedBy)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decidedBy,notes,decidedAt);

@override
String toString() {
  return 'AdminDecision(decidedBy: $decidedBy, notes: $notes, decidedAt: $decidedAt)';
}


}

/// @nodoc
abstract mixin class $AdminDecisionCopyWith<$Res>  {
  factory $AdminDecisionCopyWith(AdminDecision value, $Res Function(AdminDecision) _then) = _$AdminDecisionCopyWithImpl;
@useResult
$Res call({
 String decidedBy, String notes,@TimestampConverter() DateTime decidedAt
});




}
/// @nodoc
class _$AdminDecisionCopyWithImpl<$Res>
    implements $AdminDecisionCopyWith<$Res> {
  _$AdminDecisionCopyWithImpl(this._self, this._then);

  final AdminDecision _self;
  final $Res Function(AdminDecision) _then;

/// Create a copy of AdminDecision
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? decidedBy = null,Object? notes = null,Object? decidedAt = null,}) {
  return _then(_self.copyWith(
decidedBy: null == decidedBy ? _self.decidedBy : decidedBy // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,decidedAt: null == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminDecision].
extension AdminDecisionPatterns on AdminDecision {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminDecision value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminDecision() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminDecision value)  $default,){
final _that = this;
switch (_that) {
case _AdminDecision():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminDecision value)?  $default,){
final _that = this;
switch (_that) {
case _AdminDecision() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String decidedBy,  String notes, @TimestampConverter()  DateTime decidedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminDecision() when $default != null:
return $default(_that.decidedBy,_that.notes,_that.decidedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String decidedBy,  String notes, @TimestampConverter()  DateTime decidedAt)  $default,) {final _that = this;
switch (_that) {
case _AdminDecision():
return $default(_that.decidedBy,_that.notes,_that.decidedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String decidedBy,  String notes, @TimestampConverter()  DateTime decidedAt)?  $default,) {final _that = this;
switch (_that) {
case _AdminDecision() when $default != null:
return $default(_that.decidedBy,_that.notes,_that.decidedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminDecision implements AdminDecision {
  const _AdminDecision({required this.decidedBy, required this.notes, @TimestampConverter() required this.decidedAt});
  factory _AdminDecision.fromJson(Map<String, dynamic> json) => _$AdminDecisionFromJson(json);

@override final  String decidedBy;
@override final  String notes;
@override@TimestampConverter() final  DateTime decidedAt;

/// Create a copy of AdminDecision
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminDecisionCopyWith<_AdminDecision> get copyWith => __$AdminDecisionCopyWithImpl<_AdminDecision>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminDecisionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminDecision&&(identical(other.decidedBy, decidedBy) || other.decidedBy == decidedBy)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.decidedAt, decidedAt) || other.decidedAt == decidedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,decidedBy,notes,decidedAt);

@override
String toString() {
  return 'AdminDecision(decidedBy: $decidedBy, notes: $notes, decidedAt: $decidedAt)';
}


}

/// @nodoc
abstract mixin class _$AdminDecisionCopyWith<$Res> implements $AdminDecisionCopyWith<$Res> {
  factory _$AdminDecisionCopyWith(_AdminDecision value, $Res Function(_AdminDecision) _then) = __$AdminDecisionCopyWithImpl;
@override @useResult
$Res call({
 String decidedBy, String notes,@TimestampConverter() DateTime decidedAt
});




}
/// @nodoc
class __$AdminDecisionCopyWithImpl<$Res>
    implements _$AdminDecisionCopyWith<$Res> {
  __$AdminDecisionCopyWithImpl(this._self, this._then);

  final _AdminDecision _self;
  final $Res Function(_AdminDecision) _then;

/// Create a copy of AdminDecision
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? decidedBy = null,Object? notes = null,Object? decidedAt = null,}) {
  return _then(_AdminDecision(
decidedBy: null == decidedBy ? _self.decidedBy : decidedBy // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,decidedAt: null == decidedAt ? _self.decidedAt : decidedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}


/// @nodoc
mixin _$ChampionshipMatchModel {

 String get id; int get round; String get teamAId; String get teamBId;@TimestampConverter() DateTime get deadline; ChampionshipMatchStatus get status;@NullableTimestampConverter() DateTime? get scheduledAt; String? get location;/// The team ID that proposed the current schedule. Null once the opposing
/// team accepts (confirmed). Reset to null when the schedule is rejected.
 String? get scheduledByTeamId;@MatchResultConverter() MatchResult? get result; String? get submittedByTeamId; String? get submittedByUserId; String? get verifiedByTeamId; String? get verifiedByUserId;@NullableTimestampConverter() DateTime? get verifiedAt;@AdminDecisionConverter() AdminDecision? get adminDecision;/// Idempotency guard — set to true by the standings trigger (Story 30.8).
 bool get standingsUpdated;
/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChampionshipMatchModelCopyWith<ChampionshipMatchModel> get copyWith => _$ChampionshipMatchModelCopyWithImpl<ChampionshipMatchModel>(this as ChampionshipMatchModel, _$identity);

  /// Serializes this ChampionshipMatchModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChampionshipMatchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.round, round) || other.round == round)&&(identical(other.teamAId, teamAId) || other.teamAId == teamAId)&&(identical(other.teamBId, teamBId) || other.teamBId == teamBId)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.scheduledByTeamId, scheduledByTeamId) || other.scheduledByTeamId == scheduledByTeamId)&&(identical(other.result, result) || other.result == result)&&(identical(other.submittedByTeamId, submittedByTeamId) || other.submittedByTeamId == submittedByTeamId)&&(identical(other.submittedByUserId, submittedByUserId) || other.submittedByUserId == submittedByUserId)&&(identical(other.verifiedByTeamId, verifiedByTeamId) || other.verifiedByTeamId == verifiedByTeamId)&&(identical(other.verifiedByUserId, verifiedByUserId) || other.verifiedByUserId == verifiedByUserId)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.adminDecision, adminDecision) || other.adminDecision == adminDecision)&&(identical(other.standingsUpdated, standingsUpdated) || other.standingsUpdated == standingsUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,round,teamAId,teamBId,deadline,status,scheduledAt,location,scheduledByTeamId,result,submittedByTeamId,submittedByUserId,verifiedByTeamId,verifiedByUserId,verifiedAt,adminDecision,standingsUpdated);

@override
String toString() {
  return 'ChampionshipMatchModel(id: $id, round: $round, teamAId: $teamAId, teamBId: $teamBId, deadline: $deadline, status: $status, scheduledAt: $scheduledAt, location: $location, scheduledByTeamId: $scheduledByTeamId, result: $result, submittedByTeamId: $submittedByTeamId, submittedByUserId: $submittedByUserId, verifiedByTeamId: $verifiedByTeamId, verifiedByUserId: $verifiedByUserId, verifiedAt: $verifiedAt, adminDecision: $adminDecision, standingsUpdated: $standingsUpdated)';
}


}

/// @nodoc
abstract mixin class $ChampionshipMatchModelCopyWith<$Res>  {
  factory $ChampionshipMatchModelCopyWith(ChampionshipMatchModel value, $Res Function(ChampionshipMatchModel) _then) = _$ChampionshipMatchModelCopyWithImpl;
@useResult
$Res call({
 String id, int round, String teamAId, String teamBId,@TimestampConverter() DateTime deadline, ChampionshipMatchStatus status,@NullableTimestampConverter() DateTime? scheduledAt, String? location, String? scheduledByTeamId,@MatchResultConverter() MatchResult? result, String? submittedByTeamId, String? submittedByUserId, String? verifiedByTeamId, String? verifiedByUserId,@NullableTimestampConverter() DateTime? verifiedAt,@AdminDecisionConverter() AdminDecision? adminDecision, bool standingsUpdated
});


$MatchResultCopyWith<$Res>? get result;$AdminDecisionCopyWith<$Res>? get adminDecision;

}
/// @nodoc
class _$ChampionshipMatchModelCopyWithImpl<$Res>
    implements $ChampionshipMatchModelCopyWith<$Res> {
  _$ChampionshipMatchModelCopyWithImpl(this._self, this._then);

  final ChampionshipMatchModel _self;
  final $Res Function(ChampionshipMatchModel) _then;

/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? round = null,Object? teamAId = null,Object? teamBId = null,Object? deadline = null,Object? status = null,Object? scheduledAt = freezed,Object? location = freezed,Object? scheduledByTeamId = freezed,Object? result = freezed,Object? submittedByTeamId = freezed,Object? submittedByUserId = freezed,Object? verifiedByTeamId = freezed,Object? verifiedByUserId = freezed,Object? verifiedAt = freezed,Object? adminDecision = freezed,Object? standingsUpdated = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,teamAId: null == teamAId ? _self.teamAId : teamAId // ignore: cast_nullable_to_non_nullable
as String,teamBId: null == teamBId ? _self.teamBId : teamBId // ignore: cast_nullable_to_non_nullable
as String,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChampionshipMatchStatus,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,scheduledByTeamId: freezed == scheduledByTeamId ? _self.scheduledByTeamId : scheduledByTeamId // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult?,submittedByTeamId: freezed == submittedByTeamId ? _self.submittedByTeamId : submittedByTeamId // ignore: cast_nullable_to_non_nullable
as String?,submittedByUserId: freezed == submittedByUserId ? _self.submittedByUserId : submittedByUserId // ignore: cast_nullable_to_non_nullable
as String?,verifiedByTeamId: freezed == verifiedByTeamId ? _self.verifiedByTeamId : verifiedByTeamId // ignore: cast_nullable_to_non_nullable
as String?,verifiedByUserId: freezed == verifiedByUserId ? _self.verifiedByUserId : verifiedByUserId // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminDecision: freezed == adminDecision ? _self.adminDecision : adminDecision // ignore: cast_nullable_to_non_nullable
as AdminDecision?,standingsUpdated: null == standingsUpdated ? _self.standingsUpdated : standingsUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MatchResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminDecisionCopyWith<$Res>? get adminDecision {
    if (_self.adminDecision == null) {
    return null;
  }

  return $AdminDecisionCopyWith<$Res>(_self.adminDecision!, (value) {
    return _then(_self.copyWith(adminDecision: value));
  });
}
}


/// Adds pattern-matching-related methods to [ChampionshipMatchModel].
extension ChampionshipMatchModelPatterns on ChampionshipMatchModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChampionshipMatchModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChampionshipMatchModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChampionshipMatchModel value)  $default,){
final _that = this;
switch (_that) {
case _ChampionshipMatchModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChampionshipMatchModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChampionshipMatchModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int round,  String teamAId,  String teamBId, @TimestampConverter()  DateTime deadline,  ChampionshipMatchStatus status, @NullableTimestampConverter()  DateTime? scheduledAt,  String? location,  String? scheduledByTeamId, @MatchResultConverter()  MatchResult? result,  String? submittedByTeamId,  String? submittedByUserId,  String? verifiedByTeamId,  String? verifiedByUserId, @NullableTimestampConverter()  DateTime? verifiedAt, @AdminDecisionConverter()  AdminDecision? adminDecision,  bool standingsUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChampionshipMatchModel() when $default != null:
return $default(_that.id,_that.round,_that.teamAId,_that.teamBId,_that.deadline,_that.status,_that.scheduledAt,_that.location,_that.scheduledByTeamId,_that.result,_that.submittedByTeamId,_that.submittedByUserId,_that.verifiedByTeamId,_that.verifiedByUserId,_that.verifiedAt,_that.adminDecision,_that.standingsUpdated);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int round,  String teamAId,  String teamBId, @TimestampConverter()  DateTime deadline,  ChampionshipMatchStatus status, @NullableTimestampConverter()  DateTime? scheduledAt,  String? location,  String? scheduledByTeamId, @MatchResultConverter()  MatchResult? result,  String? submittedByTeamId,  String? submittedByUserId,  String? verifiedByTeamId,  String? verifiedByUserId, @NullableTimestampConverter()  DateTime? verifiedAt, @AdminDecisionConverter()  AdminDecision? adminDecision,  bool standingsUpdated)  $default,) {final _that = this;
switch (_that) {
case _ChampionshipMatchModel():
return $default(_that.id,_that.round,_that.teamAId,_that.teamBId,_that.deadline,_that.status,_that.scheduledAt,_that.location,_that.scheduledByTeamId,_that.result,_that.submittedByTeamId,_that.submittedByUserId,_that.verifiedByTeamId,_that.verifiedByUserId,_that.verifiedAt,_that.adminDecision,_that.standingsUpdated);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int round,  String teamAId,  String teamBId, @TimestampConverter()  DateTime deadline,  ChampionshipMatchStatus status, @NullableTimestampConverter()  DateTime? scheduledAt,  String? location,  String? scheduledByTeamId, @MatchResultConverter()  MatchResult? result,  String? submittedByTeamId,  String? submittedByUserId,  String? verifiedByTeamId,  String? verifiedByUserId, @NullableTimestampConverter()  DateTime? verifiedAt, @AdminDecisionConverter()  AdminDecision? adminDecision,  bool standingsUpdated)?  $default,) {final _that = this;
switch (_that) {
case _ChampionshipMatchModel() when $default != null:
return $default(_that.id,_that.round,_that.teamAId,_that.teamBId,_that.deadline,_that.status,_that.scheduledAt,_that.location,_that.scheduledByTeamId,_that.result,_that.submittedByTeamId,_that.submittedByUserId,_that.verifiedByTeamId,_that.verifiedByUserId,_that.verifiedAt,_that.adminDecision,_that.standingsUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChampionshipMatchModel extends ChampionshipMatchModel {
  const _ChampionshipMatchModel({required this.id, required this.round, required this.teamAId, required this.teamBId, @TimestampConverter() required this.deadline, this.status = ChampionshipMatchStatus.pending, @NullableTimestampConverter() this.scheduledAt, this.location, this.scheduledByTeamId, @MatchResultConverter() this.result, this.submittedByTeamId, this.submittedByUserId, this.verifiedByTeamId, this.verifiedByUserId, @NullableTimestampConverter() this.verifiedAt, @AdminDecisionConverter() this.adminDecision, this.standingsUpdated = false}): super._();
  factory _ChampionshipMatchModel.fromJson(Map<String, dynamic> json) => _$ChampionshipMatchModelFromJson(json);

@override final  String id;
@override final  int round;
@override final  String teamAId;
@override final  String teamBId;
@override@TimestampConverter() final  DateTime deadline;
@override@JsonKey() final  ChampionshipMatchStatus status;
@override@NullableTimestampConverter() final  DateTime? scheduledAt;
@override final  String? location;
/// The team ID that proposed the current schedule. Null once the opposing
/// team accepts (confirmed). Reset to null when the schedule is rejected.
@override final  String? scheduledByTeamId;
@override@MatchResultConverter() final  MatchResult? result;
@override final  String? submittedByTeamId;
@override final  String? submittedByUserId;
@override final  String? verifiedByTeamId;
@override final  String? verifiedByUserId;
@override@NullableTimestampConverter() final  DateTime? verifiedAt;
@override@AdminDecisionConverter() final  AdminDecision? adminDecision;
/// Idempotency guard — set to true by the standings trigger (Story 30.8).
@override@JsonKey() final  bool standingsUpdated;

/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChampionshipMatchModelCopyWith<_ChampionshipMatchModel> get copyWith => __$ChampionshipMatchModelCopyWithImpl<_ChampionshipMatchModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChampionshipMatchModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChampionshipMatchModel&&(identical(other.id, id) || other.id == id)&&(identical(other.round, round) || other.round == round)&&(identical(other.teamAId, teamAId) || other.teamAId == teamAId)&&(identical(other.teamBId, teamBId) || other.teamBId == teamBId)&&(identical(other.deadline, deadline) || other.deadline == deadline)&&(identical(other.status, status) || other.status == status)&&(identical(other.scheduledAt, scheduledAt) || other.scheduledAt == scheduledAt)&&(identical(other.location, location) || other.location == location)&&(identical(other.scheduledByTeamId, scheduledByTeamId) || other.scheduledByTeamId == scheduledByTeamId)&&(identical(other.result, result) || other.result == result)&&(identical(other.submittedByTeamId, submittedByTeamId) || other.submittedByTeamId == submittedByTeamId)&&(identical(other.submittedByUserId, submittedByUserId) || other.submittedByUserId == submittedByUserId)&&(identical(other.verifiedByTeamId, verifiedByTeamId) || other.verifiedByTeamId == verifiedByTeamId)&&(identical(other.verifiedByUserId, verifiedByUserId) || other.verifiedByUserId == verifiedByUserId)&&(identical(other.verifiedAt, verifiedAt) || other.verifiedAt == verifiedAt)&&(identical(other.adminDecision, adminDecision) || other.adminDecision == adminDecision)&&(identical(other.standingsUpdated, standingsUpdated) || other.standingsUpdated == standingsUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,round,teamAId,teamBId,deadline,status,scheduledAt,location,scheduledByTeamId,result,submittedByTeamId,submittedByUserId,verifiedByTeamId,verifiedByUserId,verifiedAt,adminDecision,standingsUpdated);

@override
String toString() {
  return 'ChampionshipMatchModel(id: $id, round: $round, teamAId: $teamAId, teamBId: $teamBId, deadline: $deadline, status: $status, scheduledAt: $scheduledAt, location: $location, scheduledByTeamId: $scheduledByTeamId, result: $result, submittedByTeamId: $submittedByTeamId, submittedByUserId: $submittedByUserId, verifiedByTeamId: $verifiedByTeamId, verifiedByUserId: $verifiedByUserId, verifiedAt: $verifiedAt, adminDecision: $adminDecision, standingsUpdated: $standingsUpdated)';
}


}

/// @nodoc
abstract mixin class _$ChampionshipMatchModelCopyWith<$Res> implements $ChampionshipMatchModelCopyWith<$Res> {
  factory _$ChampionshipMatchModelCopyWith(_ChampionshipMatchModel value, $Res Function(_ChampionshipMatchModel) _then) = __$ChampionshipMatchModelCopyWithImpl;
@override @useResult
$Res call({
 String id, int round, String teamAId, String teamBId,@TimestampConverter() DateTime deadline, ChampionshipMatchStatus status,@NullableTimestampConverter() DateTime? scheduledAt, String? location, String? scheduledByTeamId,@MatchResultConverter() MatchResult? result, String? submittedByTeamId, String? submittedByUserId, String? verifiedByTeamId, String? verifiedByUserId,@NullableTimestampConverter() DateTime? verifiedAt,@AdminDecisionConverter() AdminDecision? adminDecision, bool standingsUpdated
});


@override $MatchResultCopyWith<$Res>? get result;@override $AdminDecisionCopyWith<$Res>? get adminDecision;

}
/// @nodoc
class __$ChampionshipMatchModelCopyWithImpl<$Res>
    implements _$ChampionshipMatchModelCopyWith<$Res> {
  __$ChampionshipMatchModelCopyWithImpl(this._self, this._then);

  final _ChampionshipMatchModel _self;
  final $Res Function(_ChampionshipMatchModel) _then;

/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? round = null,Object? teamAId = null,Object? teamBId = null,Object? deadline = null,Object? status = null,Object? scheduledAt = freezed,Object? location = freezed,Object? scheduledByTeamId = freezed,Object? result = freezed,Object? submittedByTeamId = freezed,Object? submittedByUserId = freezed,Object? verifiedByTeamId = freezed,Object? verifiedByUserId = freezed,Object? verifiedAt = freezed,Object? adminDecision = freezed,Object? standingsUpdated = null,}) {
  return _then(_ChampionshipMatchModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,round: null == round ? _self.round : round // ignore: cast_nullable_to_non_nullable
as int,teamAId: null == teamAId ? _self.teamAId : teamAId // ignore: cast_nullable_to_non_nullable
as String,teamBId: null == teamBId ? _self.teamBId : teamBId // ignore: cast_nullable_to_non_nullable
as String,deadline: null == deadline ? _self.deadline : deadline // ignore: cast_nullable_to_non_nullable
as DateTime,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChampionshipMatchStatus,scheduledAt: freezed == scheduledAt ? _self.scheduledAt : scheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,scheduledByTeamId: freezed == scheduledByTeamId ? _self.scheduledByTeamId : scheduledByTeamId // ignore: cast_nullable_to_non_nullable
as String?,result: freezed == result ? _self.result : result // ignore: cast_nullable_to_non_nullable
as MatchResult?,submittedByTeamId: freezed == submittedByTeamId ? _self.submittedByTeamId : submittedByTeamId // ignore: cast_nullable_to_non_nullable
as String?,submittedByUserId: freezed == submittedByUserId ? _self.submittedByUserId : submittedByUserId // ignore: cast_nullable_to_non_nullable
as String?,verifiedByTeamId: freezed == verifiedByTeamId ? _self.verifiedByTeamId : verifiedByTeamId // ignore: cast_nullable_to_non_nullable
as String?,verifiedByUserId: freezed == verifiedByUserId ? _self.verifiedByUserId : verifiedByUserId // ignore: cast_nullable_to_non_nullable
as String?,verifiedAt: freezed == verifiedAt ? _self.verifiedAt : verifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,adminDecision: freezed == adminDecision ? _self.adminDecision : adminDecision // ignore: cast_nullable_to_non_nullable
as AdminDecision?,standingsUpdated: null == standingsUpdated ? _self.standingsUpdated : standingsUpdated // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$MatchResultCopyWith<$Res>? get result {
    if (_self.result == null) {
    return null;
  }

  return $MatchResultCopyWith<$Res>(_self.result!, (value) {
    return _then(_self.copyWith(result: value));
  });
}/// Create a copy of ChampionshipMatchModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminDecisionCopyWith<$Res>? get adminDecision {
    if (_self.adminDecision == null) {
    return null;
  }

  return $AdminDecisionCopyWith<$Res>(_self.adminDecision!, (value) {
    return _then(_self.copyWith(adminDecision: value));
  });
}
}

// dart format on
