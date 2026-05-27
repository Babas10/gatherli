// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_team_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChampionshipTeamModel {

 String get id; String get name; String get captainId; List<String> get memberIds;// always exactly 2
@TimestampConverter() DateTime get createdAt;
/// Create a copy of ChampionshipTeamModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChampionshipTeamModelCopyWith<ChampionshipTeamModel> get copyWith => _$ChampionshipTeamModelCopyWithImpl<ChampionshipTeamModel>(this as ChampionshipTeamModel, _$identity);

  /// Serializes this ChampionshipTeamModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChampionshipTeamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.captainId, captainId) || other.captainId == captainId)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,captainId,const DeepCollectionEquality().hash(memberIds),createdAt);

@override
String toString() {
  return 'ChampionshipTeamModel(id: $id, name: $name, captainId: $captainId, memberIds: $memberIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ChampionshipTeamModelCopyWith<$Res>  {
  factory $ChampionshipTeamModelCopyWith(ChampionshipTeamModel value, $Res Function(ChampionshipTeamModel) _then) = _$ChampionshipTeamModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String captainId, List<String> memberIds,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class _$ChampionshipTeamModelCopyWithImpl<$Res>
    implements $ChampionshipTeamModelCopyWith<$Res> {
  _$ChampionshipTeamModelCopyWithImpl(this._self, this._then);

  final ChampionshipTeamModel _self;
  final $Res Function(ChampionshipTeamModel) _then;

/// Create a copy of ChampionshipTeamModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? captainId = null,Object? memberIds = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,captainId: null == captainId ? _self.captainId : captainId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChampionshipTeamModel].
extension ChampionshipTeamModelPatterns on ChampionshipTeamModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChampionshipTeamModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChampionshipTeamModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChampionshipTeamModel value)  $default,){
final _that = this;
switch (_that) {
case _ChampionshipTeamModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChampionshipTeamModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChampionshipTeamModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String captainId,  List<String> memberIds, @TimestampConverter()  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChampionshipTeamModel() when $default != null:
return $default(_that.id,_that.name,_that.captainId,_that.memberIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String captainId,  List<String> memberIds, @TimestampConverter()  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _ChampionshipTeamModel():
return $default(_that.id,_that.name,_that.captainId,_that.memberIds,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String captainId,  List<String> memberIds, @TimestampConverter()  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ChampionshipTeamModel() when $default != null:
return $default(_that.id,_that.name,_that.captainId,_that.memberIds,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChampionshipTeamModel extends ChampionshipTeamModel {
  const _ChampionshipTeamModel({required this.id, required this.name, required this.captainId, required final  List<String> memberIds, @TimestampConverter() required this.createdAt}): _memberIds = memberIds,super._();
  factory _ChampionshipTeamModel.fromJson(Map<String, dynamic> json) => _$ChampionshipTeamModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String captainId;
 final  List<String> _memberIds;
@override List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

// always exactly 2
@override@TimestampConverter() final  DateTime createdAt;

/// Create a copy of ChampionshipTeamModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChampionshipTeamModelCopyWith<_ChampionshipTeamModel> get copyWith => __$ChampionshipTeamModelCopyWithImpl<_ChampionshipTeamModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChampionshipTeamModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChampionshipTeamModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.captainId, captainId) || other.captainId == captainId)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,captainId,const DeepCollectionEquality().hash(_memberIds),createdAt);

@override
String toString() {
  return 'ChampionshipTeamModel(id: $id, name: $name, captainId: $captainId, memberIds: $memberIds, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ChampionshipTeamModelCopyWith<$Res> implements $ChampionshipTeamModelCopyWith<$Res> {
  factory _$ChampionshipTeamModelCopyWith(_ChampionshipTeamModel value, $Res Function(_ChampionshipTeamModel) _then) = __$ChampionshipTeamModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String captainId, List<String> memberIds,@TimestampConverter() DateTime createdAt
});




}
/// @nodoc
class __$ChampionshipTeamModelCopyWithImpl<$Res>
    implements _$ChampionshipTeamModelCopyWith<$Res> {
  __$ChampionshipTeamModelCopyWithImpl(this._self, this._then);

  final _ChampionshipTeamModel _self;
  final $Res Function(_ChampionshipTeamModel) _then;

/// Create a copy of ChampionshipTeamModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? captainId = null,Object? memberIds = null,Object? createdAt = null,}) {
  return _then(_ChampionshipTeamModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,captainId: null == captainId ? _self.captainId : captainId // ignore: cast_nullable_to_non_nullable
as String,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
