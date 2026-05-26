// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_ranking.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserRanking {

/// User's position in global rankings (1 = highest rated)
 int get globalRank;/// Total number of users with ELO ratings
 int get totalUsers;/// Percentile (0-100, where 100 = top performer)
 double get percentile;/// User's position among friends (nullable if no friends)
 int? get friendsRank;/// Total number of friends with ELO ratings (nullable if no friends)
 int? get totalFriends;/// When this ranking was calculated
@TimestampConverter() DateTime get calculatedAt;
/// Create a copy of UserRanking
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserRankingCopyWith<UserRanking> get copyWith => _$UserRankingCopyWithImpl<UserRanking>(this as UserRanking, _$identity);

  /// Serializes this UserRanking to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserRanking&&(identical(other.globalRank, globalRank) || other.globalRank == globalRank)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&(identical(other.friendsRank, friendsRank) || other.friendsRank == friendsRank)&&(identical(other.totalFriends, totalFriends) || other.totalFriends == totalFriends)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,globalRank,totalUsers,percentile,friendsRank,totalFriends,calculatedAt);

@override
String toString() {
  return 'UserRanking(globalRank: $globalRank, totalUsers: $totalUsers, percentile: $percentile, friendsRank: $friendsRank, totalFriends: $totalFriends, calculatedAt: $calculatedAt)';
}


}

/// @nodoc
abstract mixin class $UserRankingCopyWith<$Res>  {
  factory $UserRankingCopyWith(UserRanking value, $Res Function(UserRanking) _then) = _$UserRankingCopyWithImpl;
@useResult
$Res call({
 int globalRank, int totalUsers, double percentile, int? friendsRank, int? totalFriends,@TimestampConverter() DateTime calculatedAt
});




}
/// @nodoc
class _$UserRankingCopyWithImpl<$Res>
    implements $UserRankingCopyWith<$Res> {
  _$UserRankingCopyWithImpl(this._self, this._then);

  final UserRanking _self;
  final $Res Function(UserRanking) _then;

/// Create a copy of UserRanking
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? globalRank = null,Object? totalUsers = null,Object? percentile = null,Object? friendsRank = freezed,Object? totalFriends = freezed,Object? calculatedAt = null,}) {
  return _then(_self.copyWith(
globalRank: null == globalRank ? _self.globalRank : globalRank // ignore: cast_nullable_to_non_nullable
as int,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double,friendsRank: freezed == friendsRank ? _self.friendsRank : friendsRank // ignore: cast_nullable_to_non_nullable
as int?,totalFriends: freezed == totalFriends ? _self.totalFriends : totalFriends // ignore: cast_nullable_to_non_nullable
as int?,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [UserRanking].
extension UserRankingPatterns on UserRanking {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserRanking value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserRanking() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserRanking value)  $default,){
final _that = this;
switch (_that) {
case _UserRanking():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserRanking value)?  $default,){
final _that = this;
switch (_that) {
case _UserRanking() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int globalRank,  int totalUsers,  double percentile,  int? friendsRank,  int? totalFriends, @TimestampConverter()  DateTime calculatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserRanking() when $default != null:
return $default(_that.globalRank,_that.totalUsers,_that.percentile,_that.friendsRank,_that.totalFriends,_that.calculatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int globalRank,  int totalUsers,  double percentile,  int? friendsRank,  int? totalFriends, @TimestampConverter()  DateTime calculatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserRanking():
return $default(_that.globalRank,_that.totalUsers,_that.percentile,_that.friendsRank,_that.totalFriends,_that.calculatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int globalRank,  int totalUsers,  double percentile,  int? friendsRank,  int? totalFriends, @TimestampConverter()  DateTime calculatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserRanking() when $default != null:
return $default(_that.globalRank,_that.totalUsers,_that.percentile,_that.friendsRank,_that.totalFriends,_that.calculatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserRanking extends UserRanking {
  const _UserRanking({required this.globalRank, required this.totalUsers, required this.percentile, this.friendsRank, this.totalFriends, @TimestampConverter() required this.calculatedAt}): super._();
  factory _UserRanking.fromJson(Map<String, dynamic> json) => _$UserRankingFromJson(json);

/// User's position in global rankings (1 = highest rated)
@override final  int globalRank;
/// Total number of users with ELO ratings
@override final  int totalUsers;
/// Percentile (0-100, where 100 = top performer)
@override final  double percentile;
/// User's position among friends (nullable if no friends)
@override final  int? friendsRank;
/// Total number of friends with ELO ratings (nullable if no friends)
@override final  int? totalFriends;
/// When this ranking was calculated
@override@TimestampConverter() final  DateTime calculatedAt;

/// Create a copy of UserRanking
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserRankingCopyWith<_UserRanking> get copyWith => __$UserRankingCopyWithImpl<_UserRanking>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserRankingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserRanking&&(identical(other.globalRank, globalRank) || other.globalRank == globalRank)&&(identical(other.totalUsers, totalUsers) || other.totalUsers == totalUsers)&&(identical(other.percentile, percentile) || other.percentile == percentile)&&(identical(other.friendsRank, friendsRank) || other.friendsRank == friendsRank)&&(identical(other.totalFriends, totalFriends) || other.totalFriends == totalFriends)&&(identical(other.calculatedAt, calculatedAt) || other.calculatedAt == calculatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,globalRank,totalUsers,percentile,friendsRank,totalFriends,calculatedAt);

@override
String toString() {
  return 'UserRanking(globalRank: $globalRank, totalUsers: $totalUsers, percentile: $percentile, friendsRank: $friendsRank, totalFriends: $totalFriends, calculatedAt: $calculatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserRankingCopyWith<$Res> implements $UserRankingCopyWith<$Res> {
  factory _$UserRankingCopyWith(_UserRanking value, $Res Function(_UserRanking) _then) = __$UserRankingCopyWithImpl;
@override @useResult
$Res call({
 int globalRank, int totalUsers, double percentile, int? friendsRank, int? totalFriends,@TimestampConverter() DateTime calculatedAt
});




}
/// @nodoc
class __$UserRankingCopyWithImpl<$Res>
    implements _$UserRankingCopyWith<$Res> {
  __$UserRankingCopyWithImpl(this._self, this._then);

  final _UserRanking _self;
  final $Res Function(_UserRanking) _then;

/// Create a copy of UserRanking
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? globalRank = null,Object? totalUsers = null,Object? percentile = null,Object? friendsRank = freezed,Object? totalFriends = freezed,Object? calculatedAt = null,}) {
  return _then(_UserRanking(
globalRank: null == globalRank ? _self.globalRank : globalRank // ignore: cast_nullable_to_non_nullable
as int,totalUsers: null == totalUsers ? _self.totalUsers : totalUsers // ignore: cast_nullable_to_non_nullable
as int,percentile: null == percentile ? _self.percentile : percentile // ignore: cast_nullable_to_non_nullable
as double,friendsRank: freezed == friendsRank ? _self.friendsRank : friendsRank // ignore: cast_nullable_to_non_nullable
as int?,totalFriends: freezed == totalFriends ? _self.totalFriends : totalFriends // ignore: cast_nullable_to_non_nullable
as int?,calculatedAt: null == calculatedAt ? _self.calculatedAt : calculatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
