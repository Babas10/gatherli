// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChampionshipModel {

 String get id; String get title; ChampionshipStatus get status; int get maxTeams; int get teamSize; List<String> get adminIds; String get createdBy;@TimestampConverter() DateTime get createdAt;@TimestampConverter() DateTime get registrationDeadline; int get currentRound; int get totalRounds; int get teamsCount;@NullableTimestampConverter() DateTime? get startDate; String? get country; String? get region; ChampionshipGenderCategory? get genderCategory;
/// Create a copy of ChampionshipModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChampionshipModelCopyWith<ChampionshipModel> get copyWith => _$ChampionshipModelCopyWithImpl<ChampionshipModel>(this as ChampionshipModel, _$identity);

  /// Serializes this ChampionshipModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChampionshipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxTeams, maxTeams) || other.maxTeams == maxTeams)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&const DeepCollectionEquality().equals(other.adminIds, adminIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.teamsCount, teamsCount) || other.teamsCount == teamsCount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.country, country) || other.country == country)&&(identical(other.region, region) || other.region == region)&&(identical(other.genderCategory, genderCategory) || other.genderCategory == genderCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,maxTeams,teamSize,const DeepCollectionEquality().hash(adminIds),createdBy,createdAt,registrationDeadline,currentRound,totalRounds,teamsCount,startDate,country,region,genderCategory);

@override
String toString() {
  return 'ChampionshipModel(id: $id, title: $title, status: $status, maxTeams: $maxTeams, teamSize: $teamSize, adminIds: $adminIds, createdBy: $createdBy, createdAt: $createdAt, registrationDeadline: $registrationDeadline, currentRound: $currentRound, totalRounds: $totalRounds, teamsCount: $teamsCount, startDate: $startDate, country: $country, region: $region, genderCategory: $genderCategory)';
}


}

/// @nodoc
abstract mixin class $ChampionshipModelCopyWith<$Res>  {
  factory $ChampionshipModelCopyWith(ChampionshipModel value, $Res Function(ChampionshipModel) _then) = _$ChampionshipModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, ChampionshipStatus status, int maxTeams, int teamSize, List<String> adminIds, String createdBy,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime registrationDeadline, int currentRound, int totalRounds, int teamsCount,@NullableTimestampConverter() DateTime? startDate, String? country, String? region, ChampionshipGenderCategory? genderCategory
});




}
/// @nodoc
class _$ChampionshipModelCopyWithImpl<$Res>
    implements $ChampionshipModelCopyWith<$Res> {
  _$ChampionshipModelCopyWithImpl(this._self, this._then);

  final ChampionshipModel _self;
  final $Res Function(ChampionshipModel) _then;

/// Create a copy of ChampionshipModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? status = null,Object? maxTeams = null,Object? teamSize = null,Object? adminIds = null,Object? createdBy = null,Object? createdAt = null,Object? registrationDeadline = null,Object? currentRound = null,Object? totalRounds = null,Object? teamsCount = null,Object? startDate = freezed,Object? country = freezed,Object? region = freezed,Object? genderCategory = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChampionshipStatus,maxTeams: null == maxTeams ? _self.maxTeams : maxTeams // ignore: cast_nullable_to_non_nullable
as int,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as int,adminIds: null == adminIds ? _self.adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationDeadline: null == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,teamsCount: null == teamsCount ? _self.teamsCount : teamsCount // ignore: cast_nullable_to_non_nullable
as int,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,genderCategory: freezed == genderCategory ? _self.genderCategory : genderCategory // ignore: cast_nullable_to_non_nullable
as ChampionshipGenderCategory?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChampionshipModel].
extension ChampionshipModelPatterns on ChampionshipModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChampionshipModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChampionshipModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChampionshipModel value)  $default,){
final _that = this;
switch (_that) {
case _ChampionshipModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChampionshipModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChampionshipModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  ChampionshipStatus status,  int maxTeams,  int teamSize,  List<String> adminIds,  String createdBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime registrationDeadline,  int currentRound,  int totalRounds,  int teamsCount, @NullableTimestampConverter()  DateTime? startDate,  String? country,  String? region,  ChampionshipGenderCategory? genderCategory)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChampionshipModel() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.maxTeams,_that.teamSize,_that.adminIds,_that.createdBy,_that.createdAt,_that.registrationDeadline,_that.currentRound,_that.totalRounds,_that.teamsCount,_that.startDate,_that.country,_that.region,_that.genderCategory);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  ChampionshipStatus status,  int maxTeams,  int teamSize,  List<String> adminIds,  String createdBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime registrationDeadline,  int currentRound,  int totalRounds,  int teamsCount, @NullableTimestampConverter()  DateTime? startDate,  String? country,  String? region,  ChampionshipGenderCategory? genderCategory)  $default,) {final _that = this;
switch (_that) {
case _ChampionshipModel():
return $default(_that.id,_that.title,_that.status,_that.maxTeams,_that.teamSize,_that.adminIds,_that.createdBy,_that.createdAt,_that.registrationDeadline,_that.currentRound,_that.totalRounds,_that.teamsCount,_that.startDate,_that.country,_that.region,_that.genderCategory);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  ChampionshipStatus status,  int maxTeams,  int teamSize,  List<String> adminIds,  String createdBy, @TimestampConverter()  DateTime createdAt, @TimestampConverter()  DateTime registrationDeadline,  int currentRound,  int totalRounds,  int teamsCount, @NullableTimestampConverter()  DateTime? startDate,  String? country,  String? region,  ChampionshipGenderCategory? genderCategory)?  $default,) {final _that = this;
switch (_that) {
case _ChampionshipModel() when $default != null:
return $default(_that.id,_that.title,_that.status,_that.maxTeams,_that.teamSize,_that.adminIds,_that.createdBy,_that.createdAt,_that.registrationDeadline,_that.currentRound,_that.totalRounds,_that.teamsCount,_that.startDate,_that.country,_that.region,_that.genderCategory);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChampionshipModel extends ChampionshipModel {
  const _ChampionshipModel({required this.id, required this.title, this.status = ChampionshipStatus.registration, this.maxTeams = 10, this.teamSize = 2, final  List<String> adminIds = const [], required this.createdBy, @TimestampConverter() required this.createdAt, @TimestampConverter() required this.registrationDeadline, this.currentRound = 0, this.totalRounds = 9, this.teamsCount = 0, @NullableTimestampConverter() this.startDate, this.country, this.region, this.genderCategory}): _adminIds = adminIds,super._();
  factory _ChampionshipModel.fromJson(Map<String, dynamic> json) => _$ChampionshipModelFromJson(json);

@override final  String id;
@override final  String title;
@override@JsonKey() final  ChampionshipStatus status;
@override@JsonKey() final  int maxTeams;
@override@JsonKey() final  int teamSize;
 final  List<String> _adminIds;
@override@JsonKey() List<String> get adminIds {
  if (_adminIds is EqualUnmodifiableListView) return _adminIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminIds);
}

@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@TimestampConverter() final  DateTime registrationDeadline;
@override@JsonKey() final  int currentRound;
@override@JsonKey() final  int totalRounds;
@override@JsonKey() final  int teamsCount;
@override@NullableTimestampConverter() final  DateTime? startDate;
@override final  String? country;
@override final  String? region;
@override final  ChampionshipGenderCategory? genderCategory;

/// Create a copy of ChampionshipModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChampionshipModelCopyWith<_ChampionshipModel> get copyWith => __$ChampionshipModelCopyWithImpl<_ChampionshipModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChampionshipModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChampionshipModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.maxTeams, maxTeams) || other.maxTeams == maxTeams)&&(identical(other.teamSize, teamSize) || other.teamSize == teamSize)&&const DeepCollectionEquality().equals(other._adminIds, _adminIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.registrationDeadline, registrationDeadline) || other.registrationDeadline == registrationDeadline)&&(identical(other.currentRound, currentRound) || other.currentRound == currentRound)&&(identical(other.totalRounds, totalRounds) || other.totalRounds == totalRounds)&&(identical(other.teamsCount, teamsCount) || other.teamsCount == teamsCount)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.country, country) || other.country == country)&&(identical(other.region, region) || other.region == region)&&(identical(other.genderCategory, genderCategory) || other.genderCategory == genderCategory));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,status,maxTeams,teamSize,const DeepCollectionEquality().hash(_adminIds),createdBy,createdAt,registrationDeadline,currentRound,totalRounds,teamsCount,startDate,country,region,genderCategory);

@override
String toString() {
  return 'ChampionshipModel(id: $id, title: $title, status: $status, maxTeams: $maxTeams, teamSize: $teamSize, adminIds: $adminIds, createdBy: $createdBy, createdAt: $createdAt, registrationDeadline: $registrationDeadline, currentRound: $currentRound, totalRounds: $totalRounds, teamsCount: $teamsCount, startDate: $startDate, country: $country, region: $region, genderCategory: $genderCategory)';
}


}

/// @nodoc
abstract mixin class _$ChampionshipModelCopyWith<$Res> implements $ChampionshipModelCopyWith<$Res> {
  factory _$ChampionshipModelCopyWith(_ChampionshipModel value, $Res Function(_ChampionshipModel) _then) = __$ChampionshipModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, ChampionshipStatus status, int maxTeams, int teamSize, List<String> adminIds, String createdBy,@TimestampConverter() DateTime createdAt,@TimestampConverter() DateTime registrationDeadline, int currentRound, int totalRounds, int teamsCount,@NullableTimestampConverter() DateTime? startDate, String? country, String? region, ChampionshipGenderCategory? genderCategory
});




}
/// @nodoc
class __$ChampionshipModelCopyWithImpl<$Res>
    implements _$ChampionshipModelCopyWith<$Res> {
  __$ChampionshipModelCopyWithImpl(this._self, this._then);

  final _ChampionshipModel _self;
  final $Res Function(_ChampionshipModel) _then;

/// Create a copy of ChampionshipModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? status = null,Object? maxTeams = null,Object? teamSize = null,Object? adminIds = null,Object? createdBy = null,Object? createdAt = null,Object? registrationDeadline = null,Object? currentRound = null,Object? totalRounds = null,Object? teamsCount = null,Object? startDate = freezed,Object? country = freezed,Object? region = freezed,Object? genderCategory = freezed,}) {
  return _then(_ChampionshipModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ChampionshipStatus,maxTeams: null == maxTeams ? _self.maxTeams : maxTeams // ignore: cast_nullable_to_non_nullable
as int,teamSize: null == teamSize ? _self.teamSize : teamSize // ignore: cast_nullable_to_non_nullable
as int,adminIds: null == adminIds ? _self._adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,registrationDeadline: null == registrationDeadline ? _self.registrationDeadline : registrationDeadline // ignore: cast_nullable_to_non_nullable
as DateTime,currentRound: null == currentRound ? _self.currentRound : currentRound // ignore: cast_nullable_to_non_nullable
as int,totalRounds: null == totalRounds ? _self.totalRounds : totalRounds // ignore: cast_nullable_to_non_nullable
as int,teamsCount: null == teamsCount ? _self.teamsCount : teamsCount // ignore: cast_nullable_to_non_nullable
as int,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,region: freezed == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String?,genderCategory: freezed == genderCategory ? _self.genderCategory : genderCategory // ignore: cast_nullable_to_non_nullable
as ChampionshipGenderCategory?,
  ));
}


}

// dart format on
