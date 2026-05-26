// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_preferences_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NotificationPreferencesEntity {

 bool get groupInvitations; bool get invitationAccepted; bool get gameCreated; bool get memberJoined; bool get memberLeft; bool get roleChanged; bool get friendRequestReceived; bool get friendRequestAccepted; bool get friendRemoved; bool get quietHoursEnabled; String? get quietHoursStart; String? get quietHoursEnd; Map<String, bool> get groupSpecific;// Training session notification preferences (Story 15.13)
 bool get trainingSessionCreated; bool get trainingMinParticipantsReached; bool get trainingFeedbackReceived; bool get trainingSessionCancelled;
/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NotificationPreferencesEntityCopyWith<NotificationPreferencesEntity> get copyWith => _$NotificationPreferencesEntityCopyWithImpl<NotificationPreferencesEntity>(this as NotificationPreferencesEntity, _$identity);

  /// Serializes this NotificationPreferencesEntity to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationPreferencesEntity&&(identical(other.groupInvitations, groupInvitations) || other.groupInvitations == groupInvitations)&&(identical(other.invitationAccepted, invitationAccepted) || other.invitationAccepted == invitationAccepted)&&(identical(other.gameCreated, gameCreated) || other.gameCreated == gameCreated)&&(identical(other.memberJoined, memberJoined) || other.memberJoined == memberJoined)&&(identical(other.memberLeft, memberLeft) || other.memberLeft == memberLeft)&&(identical(other.roleChanged, roleChanged) || other.roleChanged == roleChanged)&&(identical(other.friendRequestReceived, friendRequestReceived) || other.friendRequestReceived == friendRequestReceived)&&(identical(other.friendRequestAccepted, friendRequestAccepted) || other.friendRequestAccepted == friendRequestAccepted)&&(identical(other.friendRemoved, friendRemoved) || other.friendRemoved == friendRemoved)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietHoursStart, quietHoursStart) || other.quietHoursStart == quietHoursStart)&&(identical(other.quietHoursEnd, quietHoursEnd) || other.quietHoursEnd == quietHoursEnd)&&const DeepCollectionEquality().equals(other.groupSpecific, groupSpecific)&&(identical(other.trainingSessionCreated, trainingSessionCreated) || other.trainingSessionCreated == trainingSessionCreated)&&(identical(other.trainingMinParticipantsReached, trainingMinParticipantsReached) || other.trainingMinParticipantsReached == trainingMinParticipantsReached)&&(identical(other.trainingFeedbackReceived, trainingFeedbackReceived) || other.trainingFeedbackReceived == trainingFeedbackReceived)&&(identical(other.trainingSessionCancelled, trainingSessionCancelled) || other.trainingSessionCancelled == trainingSessionCancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupInvitations,invitationAccepted,gameCreated,memberJoined,memberLeft,roleChanged,friendRequestReceived,friendRequestAccepted,friendRemoved,quietHoursEnabled,quietHoursStart,quietHoursEnd,const DeepCollectionEquality().hash(groupSpecific),trainingSessionCreated,trainingMinParticipantsReached,trainingFeedbackReceived,trainingSessionCancelled);

@override
String toString() {
  return 'NotificationPreferencesEntity(groupInvitations: $groupInvitations, invitationAccepted: $invitationAccepted, gameCreated: $gameCreated, memberJoined: $memberJoined, memberLeft: $memberLeft, roleChanged: $roleChanged, friendRequestReceived: $friendRequestReceived, friendRequestAccepted: $friendRequestAccepted, friendRemoved: $friendRemoved, quietHoursEnabled: $quietHoursEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, groupSpecific: $groupSpecific, trainingSessionCreated: $trainingSessionCreated, trainingMinParticipantsReached: $trainingMinParticipantsReached, trainingFeedbackReceived: $trainingFeedbackReceived, trainingSessionCancelled: $trainingSessionCancelled)';
}


}

/// @nodoc
abstract mixin class $NotificationPreferencesEntityCopyWith<$Res>  {
  factory $NotificationPreferencesEntityCopyWith(NotificationPreferencesEntity value, $Res Function(NotificationPreferencesEntity) _then) = _$NotificationPreferencesEntityCopyWithImpl;
@useResult
$Res call({
 bool groupInvitations, bool invitationAccepted, bool gameCreated, bool memberJoined, bool memberLeft, bool roleChanged, bool friendRequestReceived, bool friendRequestAccepted, bool friendRemoved, bool quietHoursEnabled, String? quietHoursStart, String? quietHoursEnd, Map<String, bool> groupSpecific, bool trainingSessionCreated, bool trainingMinParticipantsReached, bool trainingFeedbackReceived, bool trainingSessionCancelled
});




}
/// @nodoc
class _$NotificationPreferencesEntityCopyWithImpl<$Res>
    implements $NotificationPreferencesEntityCopyWith<$Res> {
  _$NotificationPreferencesEntityCopyWithImpl(this._self, this._then);

  final NotificationPreferencesEntity _self;
  final $Res Function(NotificationPreferencesEntity) _then;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? groupInvitations = null,Object? invitationAccepted = null,Object? gameCreated = null,Object? memberJoined = null,Object? memberLeft = null,Object? roleChanged = null,Object? friendRequestReceived = null,Object? friendRequestAccepted = null,Object? friendRemoved = null,Object? quietHoursEnabled = null,Object? quietHoursStart = freezed,Object? quietHoursEnd = freezed,Object? groupSpecific = null,Object? trainingSessionCreated = null,Object? trainingMinParticipantsReached = null,Object? trainingFeedbackReceived = null,Object? trainingSessionCancelled = null,}) {
  return _then(_self.copyWith(
groupInvitations: null == groupInvitations ? _self.groupInvitations : groupInvitations // ignore: cast_nullable_to_non_nullable
as bool,invitationAccepted: null == invitationAccepted ? _self.invitationAccepted : invitationAccepted // ignore: cast_nullable_to_non_nullable
as bool,gameCreated: null == gameCreated ? _self.gameCreated : gameCreated // ignore: cast_nullable_to_non_nullable
as bool,memberJoined: null == memberJoined ? _self.memberJoined : memberJoined // ignore: cast_nullable_to_non_nullable
as bool,memberLeft: null == memberLeft ? _self.memberLeft : memberLeft // ignore: cast_nullable_to_non_nullable
as bool,roleChanged: null == roleChanged ? _self.roleChanged : roleChanged // ignore: cast_nullable_to_non_nullable
as bool,friendRequestReceived: null == friendRequestReceived ? _self.friendRequestReceived : friendRequestReceived // ignore: cast_nullable_to_non_nullable
as bool,friendRequestAccepted: null == friendRequestAccepted ? _self.friendRequestAccepted : friendRequestAccepted // ignore: cast_nullable_to_non_nullable
as bool,friendRemoved: null == friendRemoved ? _self.friendRemoved : friendRemoved // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStart: freezed == quietHoursStart ? _self.quietHoursStart : quietHoursStart // ignore: cast_nullable_to_non_nullable
as String?,quietHoursEnd: freezed == quietHoursEnd ? _self.quietHoursEnd : quietHoursEnd // ignore: cast_nullable_to_non_nullable
as String?,groupSpecific: null == groupSpecific ? _self.groupSpecific : groupSpecific // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,trainingSessionCreated: null == trainingSessionCreated ? _self.trainingSessionCreated : trainingSessionCreated // ignore: cast_nullable_to_non_nullable
as bool,trainingMinParticipantsReached: null == trainingMinParticipantsReached ? _self.trainingMinParticipantsReached : trainingMinParticipantsReached // ignore: cast_nullable_to_non_nullable
as bool,trainingFeedbackReceived: null == trainingFeedbackReceived ? _self.trainingFeedbackReceived : trainingFeedbackReceived // ignore: cast_nullable_to_non_nullable
as bool,trainingSessionCancelled: null == trainingSessionCancelled ? _self.trainingSessionCancelled : trainingSessionCancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [NotificationPreferencesEntity].
extension NotificationPreferencesEntityPatterns on NotificationPreferencesEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NotificationPreferencesEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NotificationPreferencesEntity value)  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NotificationPreferencesEntity value)?  $default,){
final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool groupInvitations,  bool invitationAccepted,  bool gameCreated,  bool memberJoined,  bool memberLeft,  bool roleChanged,  bool friendRequestReceived,  bool friendRequestAccepted,  bool friendRemoved,  bool quietHoursEnabled,  String? quietHoursStart,  String? quietHoursEnd,  Map<String, bool> groupSpecific,  bool trainingSessionCreated,  bool trainingMinParticipantsReached,  bool trainingFeedbackReceived,  bool trainingSessionCancelled)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
return $default(_that.groupInvitations,_that.invitationAccepted,_that.gameCreated,_that.memberJoined,_that.memberLeft,_that.roleChanged,_that.friendRequestReceived,_that.friendRequestAccepted,_that.friendRemoved,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.groupSpecific,_that.trainingSessionCreated,_that.trainingMinParticipantsReached,_that.trainingFeedbackReceived,_that.trainingSessionCancelled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool groupInvitations,  bool invitationAccepted,  bool gameCreated,  bool memberJoined,  bool memberLeft,  bool roleChanged,  bool friendRequestReceived,  bool friendRequestAccepted,  bool friendRemoved,  bool quietHoursEnabled,  String? quietHoursStart,  String? quietHoursEnd,  Map<String, bool> groupSpecific,  bool trainingSessionCreated,  bool trainingMinParticipantsReached,  bool trainingFeedbackReceived,  bool trainingSessionCancelled)  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity():
return $default(_that.groupInvitations,_that.invitationAccepted,_that.gameCreated,_that.memberJoined,_that.memberLeft,_that.roleChanged,_that.friendRequestReceived,_that.friendRequestAccepted,_that.friendRemoved,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.groupSpecific,_that.trainingSessionCreated,_that.trainingMinParticipantsReached,_that.trainingFeedbackReceived,_that.trainingSessionCancelled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool groupInvitations,  bool invitationAccepted,  bool gameCreated,  bool memberJoined,  bool memberLeft,  bool roleChanged,  bool friendRequestReceived,  bool friendRequestAccepted,  bool friendRemoved,  bool quietHoursEnabled,  String? quietHoursStart,  String? quietHoursEnd,  Map<String, bool> groupSpecific,  bool trainingSessionCreated,  bool trainingMinParticipantsReached,  bool trainingFeedbackReceived,  bool trainingSessionCancelled)?  $default,) {final _that = this;
switch (_that) {
case _NotificationPreferencesEntity() when $default != null:
return $default(_that.groupInvitations,_that.invitationAccepted,_that.gameCreated,_that.memberJoined,_that.memberLeft,_that.roleChanged,_that.friendRequestReceived,_that.friendRequestAccepted,_that.friendRemoved,_that.quietHoursEnabled,_that.quietHoursStart,_that.quietHoursEnd,_that.groupSpecific,_that.trainingSessionCreated,_that.trainingMinParticipantsReached,_that.trainingFeedbackReceived,_that.trainingSessionCancelled);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NotificationPreferencesEntity extends NotificationPreferencesEntity {
  const _NotificationPreferencesEntity({this.groupInvitations = true, this.invitationAccepted = true, this.gameCreated = true, this.memberJoined = false, this.memberLeft = false, this.roleChanged = true, this.friendRequestReceived = true, this.friendRequestAccepted = true, this.friendRemoved = false, this.quietHoursEnabled = false, this.quietHoursStart, this.quietHoursEnd, final  Map<String, bool> groupSpecific = const {}, this.trainingSessionCreated = true, this.trainingMinParticipantsReached = true, this.trainingFeedbackReceived = true, this.trainingSessionCancelled = true}): _groupSpecific = groupSpecific,super._();
  factory _NotificationPreferencesEntity.fromJson(Map<String, dynamic> json) => _$NotificationPreferencesEntityFromJson(json);

@override@JsonKey() final  bool groupInvitations;
@override@JsonKey() final  bool invitationAccepted;
@override@JsonKey() final  bool gameCreated;
@override@JsonKey() final  bool memberJoined;
@override@JsonKey() final  bool memberLeft;
@override@JsonKey() final  bool roleChanged;
@override@JsonKey() final  bool friendRequestReceived;
@override@JsonKey() final  bool friendRequestAccepted;
@override@JsonKey() final  bool friendRemoved;
@override@JsonKey() final  bool quietHoursEnabled;
@override final  String? quietHoursStart;
@override final  String? quietHoursEnd;
 final  Map<String, bool> _groupSpecific;
@override@JsonKey() Map<String, bool> get groupSpecific {
  if (_groupSpecific is EqualUnmodifiableMapView) return _groupSpecific;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_groupSpecific);
}

// Training session notification preferences (Story 15.13)
@override@JsonKey() final  bool trainingSessionCreated;
@override@JsonKey() final  bool trainingMinParticipantsReached;
@override@JsonKey() final  bool trainingFeedbackReceived;
@override@JsonKey() final  bool trainingSessionCancelled;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NotificationPreferencesEntityCopyWith<_NotificationPreferencesEntity> get copyWith => __$NotificationPreferencesEntityCopyWithImpl<_NotificationPreferencesEntity>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NotificationPreferencesEntityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NotificationPreferencesEntity&&(identical(other.groupInvitations, groupInvitations) || other.groupInvitations == groupInvitations)&&(identical(other.invitationAccepted, invitationAccepted) || other.invitationAccepted == invitationAccepted)&&(identical(other.gameCreated, gameCreated) || other.gameCreated == gameCreated)&&(identical(other.memberJoined, memberJoined) || other.memberJoined == memberJoined)&&(identical(other.memberLeft, memberLeft) || other.memberLeft == memberLeft)&&(identical(other.roleChanged, roleChanged) || other.roleChanged == roleChanged)&&(identical(other.friendRequestReceived, friendRequestReceived) || other.friendRequestReceived == friendRequestReceived)&&(identical(other.friendRequestAccepted, friendRequestAccepted) || other.friendRequestAccepted == friendRequestAccepted)&&(identical(other.friendRemoved, friendRemoved) || other.friendRemoved == friendRemoved)&&(identical(other.quietHoursEnabled, quietHoursEnabled) || other.quietHoursEnabled == quietHoursEnabled)&&(identical(other.quietHoursStart, quietHoursStart) || other.quietHoursStart == quietHoursStart)&&(identical(other.quietHoursEnd, quietHoursEnd) || other.quietHoursEnd == quietHoursEnd)&&const DeepCollectionEquality().equals(other._groupSpecific, _groupSpecific)&&(identical(other.trainingSessionCreated, trainingSessionCreated) || other.trainingSessionCreated == trainingSessionCreated)&&(identical(other.trainingMinParticipantsReached, trainingMinParticipantsReached) || other.trainingMinParticipantsReached == trainingMinParticipantsReached)&&(identical(other.trainingFeedbackReceived, trainingFeedbackReceived) || other.trainingFeedbackReceived == trainingFeedbackReceived)&&(identical(other.trainingSessionCancelled, trainingSessionCancelled) || other.trainingSessionCancelled == trainingSessionCancelled));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,groupInvitations,invitationAccepted,gameCreated,memberJoined,memberLeft,roleChanged,friendRequestReceived,friendRequestAccepted,friendRemoved,quietHoursEnabled,quietHoursStart,quietHoursEnd,const DeepCollectionEquality().hash(_groupSpecific),trainingSessionCreated,trainingMinParticipantsReached,trainingFeedbackReceived,trainingSessionCancelled);

@override
String toString() {
  return 'NotificationPreferencesEntity(groupInvitations: $groupInvitations, invitationAccepted: $invitationAccepted, gameCreated: $gameCreated, memberJoined: $memberJoined, memberLeft: $memberLeft, roleChanged: $roleChanged, friendRequestReceived: $friendRequestReceived, friendRequestAccepted: $friendRequestAccepted, friendRemoved: $friendRemoved, quietHoursEnabled: $quietHoursEnabled, quietHoursStart: $quietHoursStart, quietHoursEnd: $quietHoursEnd, groupSpecific: $groupSpecific, trainingSessionCreated: $trainingSessionCreated, trainingMinParticipantsReached: $trainingMinParticipantsReached, trainingFeedbackReceived: $trainingFeedbackReceived, trainingSessionCancelled: $trainingSessionCancelled)';
}


}

/// @nodoc
abstract mixin class _$NotificationPreferencesEntityCopyWith<$Res> implements $NotificationPreferencesEntityCopyWith<$Res> {
  factory _$NotificationPreferencesEntityCopyWith(_NotificationPreferencesEntity value, $Res Function(_NotificationPreferencesEntity) _then) = __$NotificationPreferencesEntityCopyWithImpl;
@override @useResult
$Res call({
 bool groupInvitations, bool invitationAccepted, bool gameCreated, bool memberJoined, bool memberLeft, bool roleChanged, bool friendRequestReceived, bool friendRequestAccepted, bool friendRemoved, bool quietHoursEnabled, String? quietHoursStart, String? quietHoursEnd, Map<String, bool> groupSpecific, bool trainingSessionCreated, bool trainingMinParticipantsReached, bool trainingFeedbackReceived, bool trainingSessionCancelled
});




}
/// @nodoc
class __$NotificationPreferencesEntityCopyWithImpl<$Res>
    implements _$NotificationPreferencesEntityCopyWith<$Res> {
  __$NotificationPreferencesEntityCopyWithImpl(this._self, this._then);

  final _NotificationPreferencesEntity _self;
  final $Res Function(_NotificationPreferencesEntity) _then;

/// Create a copy of NotificationPreferencesEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? groupInvitations = null,Object? invitationAccepted = null,Object? gameCreated = null,Object? memberJoined = null,Object? memberLeft = null,Object? roleChanged = null,Object? friendRequestReceived = null,Object? friendRequestAccepted = null,Object? friendRemoved = null,Object? quietHoursEnabled = null,Object? quietHoursStart = freezed,Object? quietHoursEnd = freezed,Object? groupSpecific = null,Object? trainingSessionCreated = null,Object? trainingMinParticipantsReached = null,Object? trainingFeedbackReceived = null,Object? trainingSessionCancelled = null,}) {
  return _then(_NotificationPreferencesEntity(
groupInvitations: null == groupInvitations ? _self.groupInvitations : groupInvitations // ignore: cast_nullable_to_non_nullable
as bool,invitationAccepted: null == invitationAccepted ? _self.invitationAccepted : invitationAccepted // ignore: cast_nullable_to_non_nullable
as bool,gameCreated: null == gameCreated ? _self.gameCreated : gameCreated // ignore: cast_nullable_to_non_nullable
as bool,memberJoined: null == memberJoined ? _self.memberJoined : memberJoined // ignore: cast_nullable_to_non_nullable
as bool,memberLeft: null == memberLeft ? _self.memberLeft : memberLeft // ignore: cast_nullable_to_non_nullable
as bool,roleChanged: null == roleChanged ? _self.roleChanged : roleChanged // ignore: cast_nullable_to_non_nullable
as bool,friendRequestReceived: null == friendRequestReceived ? _self.friendRequestReceived : friendRequestReceived // ignore: cast_nullable_to_non_nullable
as bool,friendRequestAccepted: null == friendRequestAccepted ? _self.friendRequestAccepted : friendRequestAccepted // ignore: cast_nullable_to_non_nullable
as bool,friendRemoved: null == friendRemoved ? _self.friendRemoved : friendRemoved // ignore: cast_nullable_to_non_nullable
as bool,quietHoursEnabled: null == quietHoursEnabled ? _self.quietHoursEnabled : quietHoursEnabled // ignore: cast_nullable_to_non_nullable
as bool,quietHoursStart: freezed == quietHoursStart ? _self.quietHoursStart : quietHoursStart // ignore: cast_nullable_to_non_nullable
as String?,quietHoursEnd: freezed == quietHoursEnd ? _self.quietHoursEnd : quietHoursEnd // ignore: cast_nullable_to_non_nullable
as String?,groupSpecific: null == groupSpecific ? _self._groupSpecific : groupSpecific // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,trainingSessionCreated: null == trainingSessionCreated ? _self.trainingSessionCreated : trainingSessionCreated // ignore: cast_nullable_to_non_nullable
as bool,trainingMinParticipantsReached: null == trainingMinParticipantsReached ? _self.trainingMinParticipantsReached : trainingMinParticipantsReached // ignore: cast_nullable_to_non_nullable
as bool,trainingFeedbackReceived: null == trainingFeedbackReceived ? _self.trainingFeedbackReceived : trainingFeedbackReceived // ignore: cast_nullable_to_non_nullable
as bool,trainingSessionCancelled: null == trainingSessionCancelled ? _self.trainingSessionCancelled : trainingSessionCancelled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
