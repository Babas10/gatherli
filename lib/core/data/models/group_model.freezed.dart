// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GroupModel {

 String get id; String get name; String? get description; String? get photoUrl; String get createdBy;@TimestampConverter() DateTime get createdAt;@NullableTimestampConverter() DateTime? get updatedAt; List<String> get memberIds; List<String> get adminIds; GroupPrivacy get privacy; bool get requiresApproval; int get maxMembers; String? get location;// Group settings
 bool get allowMembersToCreateGames; bool get allowMembersToInviteOthers; bool get notifyMembersOfNewGames;// Group stats
 int get totalGamesPlayed;@NullableTimestampConverter() DateTime? get lastActivity;
/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GroupModelCopyWith<GroupModel> get copyWith => _$GroupModelCopyWithImpl<GroupModel>(this as GroupModel, _$identity);

  /// Serializes this GroupModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.memberIds, memberIds)&&const DeepCollectionEquality().equals(other.adminIds, adminIds)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.location, location) || other.location == location)&&(identical(other.allowMembersToCreateGames, allowMembersToCreateGames) || other.allowMembersToCreateGames == allowMembersToCreateGames)&&(identical(other.allowMembersToInviteOthers, allowMembersToInviteOthers) || other.allowMembersToInviteOthers == allowMembersToInviteOthers)&&(identical(other.notifyMembersOfNewGames, notifyMembersOfNewGames) || other.notifyMembersOfNewGames == notifyMembersOfNewGames)&&(identical(other.totalGamesPlayed, totalGamesPlayed) || other.totalGamesPlayed == totalGamesPlayed)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,photoUrl,createdBy,createdAt,updatedAt,const DeepCollectionEquality().hash(memberIds),const DeepCollectionEquality().hash(adminIds),privacy,requiresApproval,maxMembers,location,allowMembersToCreateGames,allowMembersToInviteOthers,notifyMembersOfNewGames,totalGamesPlayed,lastActivity);

@override
String toString() {
  return 'GroupModel(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, memberIds: $memberIds, adminIds: $adminIds, privacy: $privacy, requiresApproval: $requiresApproval, maxMembers: $maxMembers, location: $location, allowMembersToCreateGames: $allowMembersToCreateGames, allowMembersToInviteOthers: $allowMembersToInviteOthers, notifyMembersOfNewGames: $notifyMembersOfNewGames, totalGamesPlayed: $totalGamesPlayed, lastActivity: $lastActivity)';
}


}

/// @nodoc
abstract mixin class $GroupModelCopyWith<$Res>  {
  factory $GroupModelCopyWith(GroupModel value, $Res Function(GroupModel) _then) = _$GroupModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, String? description, String? photoUrl, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt, List<String> memberIds, List<String> adminIds, GroupPrivacy privacy, bool requiresApproval, int maxMembers, String? location, bool allowMembersToCreateGames, bool allowMembersToInviteOthers, bool notifyMembersOfNewGames, int totalGamesPlayed,@NullableTimestampConverter() DateTime? lastActivity
});




}
/// @nodoc
class _$GroupModelCopyWithImpl<$Res>
    implements $GroupModelCopyWith<$Res> {
  _$GroupModelCopyWithImpl(this._self, this._then);

  final GroupModel _self;
  final $Res Function(GroupModel) _then;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? photoUrl = freezed,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? memberIds = null,Object? adminIds = null,Object? privacy = null,Object? requiresApproval = null,Object? maxMembers = null,Object? location = freezed,Object? allowMembersToCreateGames = null,Object? allowMembersToInviteOthers = null,Object? notifyMembersOfNewGames = null,Object? totalGamesPlayed = null,Object? lastActivity = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,memberIds: null == memberIds ? _self.memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self.adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,privacy: null == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as GroupPrivacy,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,allowMembersToCreateGames: null == allowMembersToCreateGames ? _self.allowMembersToCreateGames : allowMembersToCreateGames // ignore: cast_nullable_to_non_nullable
as bool,allowMembersToInviteOthers: null == allowMembersToInviteOthers ? _self.allowMembersToInviteOthers : allowMembersToInviteOthers // ignore: cast_nullable_to_non_nullable
as bool,notifyMembersOfNewGames: null == notifyMembersOfNewGames ? _self.notifyMembersOfNewGames : notifyMembersOfNewGames // ignore: cast_nullable_to_non_nullable
as bool,totalGamesPlayed: null == totalGamesPlayed ? _self.totalGamesPlayed : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,lastActivity: freezed == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [GroupModel].
extension GroupModelPatterns on GroupModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GroupModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GroupModel value)  $default,){
final _that = this;
switch (_that) {
case _GroupModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GroupModel value)?  $default,){
final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? photoUrl,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  List<String> memberIds,  List<String> adminIds,  GroupPrivacy privacy,  bool requiresApproval,  int maxMembers,  String? location,  bool allowMembersToCreateGames,  bool allowMembersToInviteOthers,  bool notifyMembersOfNewGames,  int totalGamesPlayed, @NullableTimestampConverter()  DateTime? lastActivity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.createdBy,_that.createdAt,_that.updatedAt,_that.memberIds,_that.adminIds,_that.privacy,_that.requiresApproval,_that.maxMembers,_that.location,_that.allowMembersToCreateGames,_that.allowMembersToInviteOthers,_that.notifyMembersOfNewGames,_that.totalGamesPlayed,_that.lastActivity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String? description,  String? photoUrl,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  List<String> memberIds,  List<String> adminIds,  GroupPrivacy privacy,  bool requiresApproval,  int maxMembers,  String? location,  bool allowMembersToCreateGames,  bool allowMembersToInviteOthers,  bool notifyMembersOfNewGames,  int totalGamesPlayed, @NullableTimestampConverter()  DateTime? lastActivity)  $default,) {final _that = this;
switch (_that) {
case _GroupModel():
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.createdBy,_that.createdAt,_that.updatedAt,_that.memberIds,_that.adminIds,_that.privacy,_that.requiresApproval,_that.maxMembers,_that.location,_that.allowMembersToCreateGames,_that.allowMembersToInviteOthers,_that.notifyMembersOfNewGames,_that.totalGamesPlayed,_that.lastActivity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String? description,  String? photoUrl,  String createdBy, @TimestampConverter()  DateTime createdAt, @NullableTimestampConverter()  DateTime? updatedAt,  List<String> memberIds,  List<String> adminIds,  GroupPrivacy privacy,  bool requiresApproval,  int maxMembers,  String? location,  bool allowMembersToCreateGames,  bool allowMembersToInviteOthers,  bool notifyMembersOfNewGames,  int totalGamesPlayed, @NullableTimestampConverter()  DateTime? lastActivity)?  $default,) {final _that = this;
switch (_that) {
case _GroupModel() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.photoUrl,_that.createdBy,_that.createdAt,_that.updatedAt,_that.memberIds,_that.adminIds,_that.privacy,_that.requiresApproval,_that.maxMembers,_that.location,_that.allowMembersToCreateGames,_that.allowMembersToInviteOthers,_that.notifyMembersOfNewGames,_that.totalGamesPlayed,_that.lastActivity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _GroupModel extends GroupModel {
  const _GroupModel({required this.id, required this.name, this.description, this.photoUrl, required this.createdBy, @TimestampConverter() required this.createdAt, @NullableTimestampConverter() this.updatedAt, final  List<String> memberIds = const [], final  List<String> adminIds = const [], this.privacy = GroupPrivacy.private, this.requiresApproval = false, this.maxMembers = 20, this.location, this.allowMembersToCreateGames = true, this.allowMembersToInviteOthers = true, this.notifyMembersOfNewGames = true, this.totalGamesPlayed = 0, @NullableTimestampConverter() this.lastActivity}): _memberIds = memberIds,_adminIds = adminIds,super._();
  factory _GroupModel.fromJson(Map<String, dynamic> json) => _$GroupModelFromJson(json);

@override final  String id;
@override final  String name;
@override final  String? description;
@override final  String? photoUrl;
@override final  String createdBy;
@override@TimestampConverter() final  DateTime createdAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;
 final  List<String> _memberIds;
@override@JsonKey() List<String> get memberIds {
  if (_memberIds is EqualUnmodifiableListView) return _memberIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_memberIds);
}

 final  List<String> _adminIds;
@override@JsonKey() List<String> get adminIds {
  if (_adminIds is EqualUnmodifiableListView) return _adminIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminIds);
}

@override@JsonKey() final  GroupPrivacy privacy;
@override@JsonKey() final  bool requiresApproval;
@override@JsonKey() final  int maxMembers;
@override final  String? location;
// Group settings
@override@JsonKey() final  bool allowMembersToCreateGames;
@override@JsonKey() final  bool allowMembersToInviteOthers;
@override@JsonKey() final  bool notifyMembersOfNewGames;
// Group stats
@override@JsonKey() final  int totalGamesPlayed;
@override@NullableTimestampConverter() final  DateTime? lastActivity;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GroupModelCopyWith<_GroupModel> get copyWith => __$GroupModelCopyWithImpl<_GroupModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GroupModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GroupModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._memberIds, _memberIds)&&const DeepCollectionEquality().equals(other._adminIds, _adminIds)&&(identical(other.privacy, privacy) || other.privacy == privacy)&&(identical(other.requiresApproval, requiresApproval) || other.requiresApproval == requiresApproval)&&(identical(other.maxMembers, maxMembers) || other.maxMembers == maxMembers)&&(identical(other.location, location) || other.location == location)&&(identical(other.allowMembersToCreateGames, allowMembersToCreateGames) || other.allowMembersToCreateGames == allowMembersToCreateGames)&&(identical(other.allowMembersToInviteOthers, allowMembersToInviteOthers) || other.allowMembersToInviteOthers == allowMembersToInviteOthers)&&(identical(other.notifyMembersOfNewGames, notifyMembersOfNewGames) || other.notifyMembersOfNewGames == notifyMembersOfNewGames)&&(identical(other.totalGamesPlayed, totalGamesPlayed) || other.totalGamesPlayed == totalGamesPlayed)&&(identical(other.lastActivity, lastActivity) || other.lastActivity == lastActivity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,photoUrl,createdBy,createdAt,updatedAt,const DeepCollectionEquality().hash(_memberIds),const DeepCollectionEquality().hash(_adminIds),privacy,requiresApproval,maxMembers,location,allowMembersToCreateGames,allowMembersToInviteOthers,notifyMembersOfNewGames,totalGamesPlayed,lastActivity);

@override
String toString() {
  return 'GroupModel(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdBy: $createdBy, createdAt: $createdAt, updatedAt: $updatedAt, memberIds: $memberIds, adminIds: $adminIds, privacy: $privacy, requiresApproval: $requiresApproval, maxMembers: $maxMembers, location: $location, allowMembersToCreateGames: $allowMembersToCreateGames, allowMembersToInviteOthers: $allowMembersToInviteOthers, notifyMembersOfNewGames: $notifyMembersOfNewGames, totalGamesPlayed: $totalGamesPlayed, lastActivity: $lastActivity)';
}


}

/// @nodoc
abstract mixin class _$GroupModelCopyWith<$Res> implements $GroupModelCopyWith<$Res> {
  factory _$GroupModelCopyWith(_GroupModel value, $Res Function(_GroupModel) _then) = __$GroupModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String? description, String? photoUrl, String createdBy,@TimestampConverter() DateTime createdAt,@NullableTimestampConverter() DateTime? updatedAt, List<String> memberIds, List<String> adminIds, GroupPrivacy privacy, bool requiresApproval, int maxMembers, String? location, bool allowMembersToCreateGames, bool allowMembersToInviteOthers, bool notifyMembersOfNewGames, int totalGamesPlayed,@NullableTimestampConverter() DateTime? lastActivity
});




}
/// @nodoc
class __$GroupModelCopyWithImpl<$Res>
    implements _$GroupModelCopyWith<$Res> {
  __$GroupModelCopyWithImpl(this._self, this._then);

  final _GroupModel _self;
  final $Res Function(_GroupModel) _then;

/// Create a copy of GroupModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = freezed,Object? photoUrl = freezed,Object? createdBy = null,Object? createdAt = null,Object? updatedAt = freezed,Object? memberIds = null,Object? adminIds = null,Object? privacy = null,Object? requiresApproval = null,Object? maxMembers = null,Object? location = freezed,Object? allowMembersToCreateGames = null,Object? allowMembersToInviteOthers = null,Object? notifyMembersOfNewGames = null,Object? totalGamesPlayed = null,Object? lastActivity = freezed,}) {
  return _then(_GroupModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,memberIds: null == memberIds ? _self._memberIds : memberIds // ignore: cast_nullable_to_non_nullable
as List<String>,adminIds: null == adminIds ? _self._adminIds : adminIds // ignore: cast_nullable_to_non_nullable
as List<String>,privacy: null == privacy ? _self.privacy : privacy // ignore: cast_nullable_to_non_nullable
as GroupPrivacy,requiresApproval: null == requiresApproval ? _self.requiresApproval : requiresApproval // ignore: cast_nullable_to_non_nullable
as bool,maxMembers: null == maxMembers ? _self.maxMembers : maxMembers // ignore: cast_nullable_to_non_nullable
as int,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,allowMembersToCreateGames: null == allowMembersToCreateGames ? _self.allowMembersToCreateGames : allowMembersToCreateGames // ignore: cast_nullable_to_non_nullable
as bool,allowMembersToInviteOthers: null == allowMembersToInviteOthers ? _self.allowMembersToInviteOthers : allowMembersToInviteOthers // ignore: cast_nullable_to_non_nullable
as bool,notifyMembersOfNewGames: null == notifyMembersOfNewGames ? _self.notifyMembersOfNewGames : notifyMembersOfNewGames // ignore: cast_nullable_to_non_nullable
as bool,totalGamesPlayed: null == totalGamesPlayed ? _self.totalGamesPlayed : totalGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,lastActivity: freezed == lastActivity ? _self.lastActivity : lastActivity // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
