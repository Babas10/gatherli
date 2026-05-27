// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notification_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NotificationEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NotificationEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent()';
}


}

/// @nodoc
class $NotificationEventCopyWith<$Res>  {
$NotificationEventCopyWith(NotificationEvent _, $Res Function(NotificationEvent) __);
}


/// Adds pattern-matching-related methods to [NotificationEvent].
extension NotificationEventPatterns on NotificationEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _LoadPreferences value)?  loadPreferences,TResult Function( _UpdatePreferences value)?  updatePreferences,TResult Function( _ToggleGroupInvitations value)?  toggleGroupInvitations,TResult Function( _ToggleInvitationAccepted value)?  toggleInvitationAccepted,TResult Function( _ToggleGameCreated value)?  toggleGameCreated,TResult Function( _ToggleMemberJoined value)?  toggleMemberJoined,TResult Function( _ToggleMemberLeft value)?  toggleMemberLeft,TResult Function( _ToggleRoleChanged value)?  toggleRoleChanged,TResult Function( _ToggleQuietHours value)?  toggleQuietHours,TResult Function( _ToggleGroupSpecific value)?  toggleGroupSpecific,TResult Function( _ToggleTrainingSessionCreated value)?  toggleTrainingSessionCreated,TResult Function( _ToggleTrainingMinParticipantsReached value)?  toggleTrainingMinParticipantsReached,TResult Function( _ToggleTrainingFeedbackReceived value)?  toggleTrainingFeedbackReceived,TResult Function( _ToggleTrainingSessionCancelled value)?  toggleTrainingSessionCancelled,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoadPreferences() when loadPreferences != null:
return loadPreferences(_that);case _UpdatePreferences() when updatePreferences != null:
return updatePreferences(_that);case _ToggleGroupInvitations() when toggleGroupInvitations != null:
return toggleGroupInvitations(_that);case _ToggleInvitationAccepted() when toggleInvitationAccepted != null:
return toggleInvitationAccepted(_that);case _ToggleGameCreated() when toggleGameCreated != null:
return toggleGameCreated(_that);case _ToggleMemberJoined() when toggleMemberJoined != null:
return toggleMemberJoined(_that);case _ToggleMemberLeft() when toggleMemberLeft != null:
return toggleMemberLeft(_that);case _ToggleRoleChanged() when toggleRoleChanged != null:
return toggleRoleChanged(_that);case _ToggleQuietHours() when toggleQuietHours != null:
return toggleQuietHours(_that);case _ToggleGroupSpecific() when toggleGroupSpecific != null:
return toggleGroupSpecific(_that);case _ToggleTrainingSessionCreated() when toggleTrainingSessionCreated != null:
return toggleTrainingSessionCreated(_that);case _ToggleTrainingMinParticipantsReached() when toggleTrainingMinParticipantsReached != null:
return toggleTrainingMinParticipantsReached(_that);case _ToggleTrainingFeedbackReceived() when toggleTrainingFeedbackReceived != null:
return toggleTrainingFeedbackReceived(_that);case _ToggleTrainingSessionCancelled() when toggleTrainingSessionCancelled != null:
return toggleTrainingSessionCancelled(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _LoadPreferences value)  loadPreferences,required TResult Function( _UpdatePreferences value)  updatePreferences,required TResult Function( _ToggleGroupInvitations value)  toggleGroupInvitations,required TResult Function( _ToggleInvitationAccepted value)  toggleInvitationAccepted,required TResult Function( _ToggleGameCreated value)  toggleGameCreated,required TResult Function( _ToggleMemberJoined value)  toggleMemberJoined,required TResult Function( _ToggleMemberLeft value)  toggleMemberLeft,required TResult Function( _ToggleRoleChanged value)  toggleRoleChanged,required TResult Function( _ToggleQuietHours value)  toggleQuietHours,required TResult Function( _ToggleGroupSpecific value)  toggleGroupSpecific,required TResult Function( _ToggleTrainingSessionCreated value)  toggleTrainingSessionCreated,required TResult Function( _ToggleTrainingMinParticipantsReached value)  toggleTrainingMinParticipantsReached,required TResult Function( _ToggleTrainingFeedbackReceived value)  toggleTrainingFeedbackReceived,required TResult Function( _ToggleTrainingSessionCancelled value)  toggleTrainingSessionCancelled,}){
final _that = this;
switch (_that) {
case _LoadPreferences():
return loadPreferences(_that);case _UpdatePreferences():
return updatePreferences(_that);case _ToggleGroupInvitations():
return toggleGroupInvitations(_that);case _ToggleInvitationAccepted():
return toggleInvitationAccepted(_that);case _ToggleGameCreated():
return toggleGameCreated(_that);case _ToggleMemberJoined():
return toggleMemberJoined(_that);case _ToggleMemberLeft():
return toggleMemberLeft(_that);case _ToggleRoleChanged():
return toggleRoleChanged(_that);case _ToggleQuietHours():
return toggleQuietHours(_that);case _ToggleGroupSpecific():
return toggleGroupSpecific(_that);case _ToggleTrainingSessionCreated():
return toggleTrainingSessionCreated(_that);case _ToggleTrainingMinParticipantsReached():
return toggleTrainingMinParticipantsReached(_that);case _ToggleTrainingFeedbackReceived():
return toggleTrainingFeedbackReceived(_that);case _ToggleTrainingSessionCancelled():
return toggleTrainingSessionCancelled(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _LoadPreferences value)?  loadPreferences,TResult? Function( _UpdatePreferences value)?  updatePreferences,TResult? Function( _ToggleGroupInvitations value)?  toggleGroupInvitations,TResult? Function( _ToggleInvitationAccepted value)?  toggleInvitationAccepted,TResult? Function( _ToggleGameCreated value)?  toggleGameCreated,TResult? Function( _ToggleMemberJoined value)?  toggleMemberJoined,TResult? Function( _ToggleMemberLeft value)?  toggleMemberLeft,TResult? Function( _ToggleRoleChanged value)?  toggleRoleChanged,TResult? Function( _ToggleQuietHours value)?  toggleQuietHours,TResult? Function( _ToggleGroupSpecific value)?  toggleGroupSpecific,TResult? Function( _ToggleTrainingSessionCreated value)?  toggleTrainingSessionCreated,TResult? Function( _ToggleTrainingMinParticipantsReached value)?  toggleTrainingMinParticipantsReached,TResult? Function( _ToggleTrainingFeedbackReceived value)?  toggleTrainingFeedbackReceived,TResult? Function( _ToggleTrainingSessionCancelled value)?  toggleTrainingSessionCancelled,}){
final _that = this;
switch (_that) {
case _LoadPreferences() when loadPreferences != null:
return loadPreferences(_that);case _UpdatePreferences() when updatePreferences != null:
return updatePreferences(_that);case _ToggleGroupInvitations() when toggleGroupInvitations != null:
return toggleGroupInvitations(_that);case _ToggleInvitationAccepted() when toggleInvitationAccepted != null:
return toggleInvitationAccepted(_that);case _ToggleGameCreated() when toggleGameCreated != null:
return toggleGameCreated(_that);case _ToggleMemberJoined() when toggleMemberJoined != null:
return toggleMemberJoined(_that);case _ToggleMemberLeft() when toggleMemberLeft != null:
return toggleMemberLeft(_that);case _ToggleRoleChanged() when toggleRoleChanged != null:
return toggleRoleChanged(_that);case _ToggleQuietHours() when toggleQuietHours != null:
return toggleQuietHours(_that);case _ToggleGroupSpecific() when toggleGroupSpecific != null:
return toggleGroupSpecific(_that);case _ToggleTrainingSessionCreated() when toggleTrainingSessionCreated != null:
return toggleTrainingSessionCreated(_that);case _ToggleTrainingMinParticipantsReached() when toggleTrainingMinParticipantsReached != null:
return toggleTrainingMinParticipantsReached(_that);case _ToggleTrainingFeedbackReceived() when toggleTrainingFeedbackReceived != null:
return toggleTrainingFeedbackReceived(_that);case _ToggleTrainingSessionCancelled() when toggleTrainingSessionCancelled != null:
return toggleTrainingSessionCancelled(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  loadPreferences,TResult Function( NotificationPreferencesEntity preferences)?  updatePreferences,TResult Function( bool enabled)?  toggleGroupInvitations,TResult Function( bool enabled)?  toggleInvitationAccepted,TResult Function( bool enabled)?  toggleGameCreated,TResult Function( bool enabled)?  toggleMemberJoined,TResult Function( bool enabled)?  toggleMemberLeft,TResult Function( bool enabled)?  toggleRoleChanged,TResult Function( bool enabled,  String? start,  String? end)?  toggleQuietHours,TResult Function( String groupId,  bool enabled)?  toggleGroupSpecific,TResult Function( bool enabled)?  toggleTrainingSessionCreated,TResult Function( bool enabled)?  toggleTrainingMinParticipantsReached,TResult Function( bool enabled)?  toggleTrainingFeedbackReceived,TResult Function( bool enabled)?  toggleTrainingSessionCancelled,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoadPreferences() when loadPreferences != null:
return loadPreferences();case _UpdatePreferences() when updatePreferences != null:
return updatePreferences(_that.preferences);case _ToggleGroupInvitations() when toggleGroupInvitations != null:
return toggleGroupInvitations(_that.enabled);case _ToggleInvitationAccepted() when toggleInvitationAccepted != null:
return toggleInvitationAccepted(_that.enabled);case _ToggleGameCreated() when toggleGameCreated != null:
return toggleGameCreated(_that.enabled);case _ToggleMemberJoined() when toggleMemberJoined != null:
return toggleMemberJoined(_that.enabled);case _ToggleMemberLeft() when toggleMemberLeft != null:
return toggleMemberLeft(_that.enabled);case _ToggleRoleChanged() when toggleRoleChanged != null:
return toggleRoleChanged(_that.enabled);case _ToggleQuietHours() when toggleQuietHours != null:
return toggleQuietHours(_that.enabled,_that.start,_that.end);case _ToggleGroupSpecific() when toggleGroupSpecific != null:
return toggleGroupSpecific(_that.groupId,_that.enabled);case _ToggleTrainingSessionCreated() when toggleTrainingSessionCreated != null:
return toggleTrainingSessionCreated(_that.enabled);case _ToggleTrainingMinParticipantsReached() when toggleTrainingMinParticipantsReached != null:
return toggleTrainingMinParticipantsReached(_that.enabled);case _ToggleTrainingFeedbackReceived() when toggleTrainingFeedbackReceived != null:
return toggleTrainingFeedbackReceived(_that.enabled);case _ToggleTrainingSessionCancelled() when toggleTrainingSessionCancelled != null:
return toggleTrainingSessionCancelled(_that.enabled);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  loadPreferences,required TResult Function( NotificationPreferencesEntity preferences)  updatePreferences,required TResult Function( bool enabled)  toggleGroupInvitations,required TResult Function( bool enabled)  toggleInvitationAccepted,required TResult Function( bool enabled)  toggleGameCreated,required TResult Function( bool enabled)  toggleMemberJoined,required TResult Function( bool enabled)  toggleMemberLeft,required TResult Function( bool enabled)  toggleRoleChanged,required TResult Function( bool enabled,  String? start,  String? end)  toggleQuietHours,required TResult Function( String groupId,  bool enabled)  toggleGroupSpecific,required TResult Function( bool enabled)  toggleTrainingSessionCreated,required TResult Function( bool enabled)  toggleTrainingMinParticipantsReached,required TResult Function( bool enabled)  toggleTrainingFeedbackReceived,required TResult Function( bool enabled)  toggleTrainingSessionCancelled,}) {final _that = this;
switch (_that) {
case _LoadPreferences():
return loadPreferences();case _UpdatePreferences():
return updatePreferences(_that.preferences);case _ToggleGroupInvitations():
return toggleGroupInvitations(_that.enabled);case _ToggleInvitationAccepted():
return toggleInvitationAccepted(_that.enabled);case _ToggleGameCreated():
return toggleGameCreated(_that.enabled);case _ToggleMemberJoined():
return toggleMemberJoined(_that.enabled);case _ToggleMemberLeft():
return toggleMemberLeft(_that.enabled);case _ToggleRoleChanged():
return toggleRoleChanged(_that.enabled);case _ToggleQuietHours():
return toggleQuietHours(_that.enabled,_that.start,_that.end);case _ToggleGroupSpecific():
return toggleGroupSpecific(_that.groupId,_that.enabled);case _ToggleTrainingSessionCreated():
return toggleTrainingSessionCreated(_that.enabled);case _ToggleTrainingMinParticipantsReached():
return toggleTrainingMinParticipantsReached(_that.enabled);case _ToggleTrainingFeedbackReceived():
return toggleTrainingFeedbackReceived(_that.enabled);case _ToggleTrainingSessionCancelled():
return toggleTrainingSessionCancelled(_that.enabled);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  loadPreferences,TResult? Function( NotificationPreferencesEntity preferences)?  updatePreferences,TResult? Function( bool enabled)?  toggleGroupInvitations,TResult? Function( bool enabled)?  toggleInvitationAccepted,TResult? Function( bool enabled)?  toggleGameCreated,TResult? Function( bool enabled)?  toggleMemberJoined,TResult? Function( bool enabled)?  toggleMemberLeft,TResult? Function( bool enabled)?  toggleRoleChanged,TResult? Function( bool enabled,  String? start,  String? end)?  toggleQuietHours,TResult? Function( String groupId,  bool enabled)?  toggleGroupSpecific,TResult? Function( bool enabled)?  toggleTrainingSessionCreated,TResult? Function( bool enabled)?  toggleTrainingMinParticipantsReached,TResult? Function( bool enabled)?  toggleTrainingFeedbackReceived,TResult? Function( bool enabled)?  toggleTrainingSessionCancelled,}) {final _that = this;
switch (_that) {
case _LoadPreferences() when loadPreferences != null:
return loadPreferences();case _UpdatePreferences() when updatePreferences != null:
return updatePreferences(_that.preferences);case _ToggleGroupInvitations() when toggleGroupInvitations != null:
return toggleGroupInvitations(_that.enabled);case _ToggleInvitationAccepted() when toggleInvitationAccepted != null:
return toggleInvitationAccepted(_that.enabled);case _ToggleGameCreated() when toggleGameCreated != null:
return toggleGameCreated(_that.enabled);case _ToggleMemberJoined() when toggleMemberJoined != null:
return toggleMemberJoined(_that.enabled);case _ToggleMemberLeft() when toggleMemberLeft != null:
return toggleMemberLeft(_that.enabled);case _ToggleRoleChanged() when toggleRoleChanged != null:
return toggleRoleChanged(_that.enabled);case _ToggleQuietHours() when toggleQuietHours != null:
return toggleQuietHours(_that.enabled,_that.start,_that.end);case _ToggleGroupSpecific() when toggleGroupSpecific != null:
return toggleGroupSpecific(_that.groupId,_that.enabled);case _ToggleTrainingSessionCreated() when toggleTrainingSessionCreated != null:
return toggleTrainingSessionCreated(_that.enabled);case _ToggleTrainingMinParticipantsReached() when toggleTrainingMinParticipantsReached != null:
return toggleTrainingMinParticipantsReached(_that.enabled);case _ToggleTrainingFeedbackReceived() when toggleTrainingFeedbackReceived != null:
return toggleTrainingFeedbackReceived(_that.enabled);case _ToggleTrainingSessionCancelled() when toggleTrainingSessionCancelled != null:
return toggleTrainingSessionCancelled(_that.enabled);case _:
  return null;

}
}

}

/// @nodoc


class _LoadPreferences implements NotificationEvent {
  const _LoadPreferences();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoadPreferences);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'NotificationEvent.loadPreferences()';
}


}




/// @nodoc


class _UpdatePreferences implements NotificationEvent {
  const _UpdatePreferences(this.preferences);
  

 final  NotificationPreferencesEntity preferences;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UpdatePreferencesCopyWith<_UpdatePreferences> get copyWith => __$UpdatePreferencesCopyWithImpl<_UpdatePreferences>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UpdatePreferences&&(identical(other.preferences, preferences) || other.preferences == preferences));
}


@override
int get hashCode => Object.hash(runtimeType,preferences);

@override
String toString() {
  return 'NotificationEvent.updatePreferences(preferences: $preferences)';
}


}

/// @nodoc
abstract mixin class _$UpdatePreferencesCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$UpdatePreferencesCopyWith(_UpdatePreferences value, $Res Function(_UpdatePreferences) _then) = __$UpdatePreferencesCopyWithImpl;
@useResult
$Res call({
 NotificationPreferencesEntity preferences
});


$NotificationPreferencesEntityCopyWith<$Res> get preferences;

}
/// @nodoc
class __$UpdatePreferencesCopyWithImpl<$Res>
    implements _$UpdatePreferencesCopyWith<$Res> {
  __$UpdatePreferencesCopyWithImpl(this._self, this._then);

  final _UpdatePreferences _self;
  final $Res Function(_UpdatePreferences) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? preferences = null,}) {
  return _then(_UpdatePreferences(
null == preferences ? _self.preferences : preferences // ignore: cast_nullable_to_non_nullable
as NotificationPreferencesEntity,
  ));
}

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPreferencesEntityCopyWith<$Res> get preferences {
  
  return $NotificationPreferencesEntityCopyWith<$Res>(_self.preferences, (value) {
    return _then(_self.copyWith(preferences: value));
  });
}
}

/// @nodoc


class _ToggleGroupInvitations implements NotificationEvent {
  const _ToggleGroupInvitations(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleGroupInvitationsCopyWith<_ToggleGroupInvitations> get copyWith => __$ToggleGroupInvitationsCopyWithImpl<_ToggleGroupInvitations>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleGroupInvitations&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleGroupInvitations(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleGroupInvitationsCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleGroupInvitationsCopyWith(_ToggleGroupInvitations value, $Res Function(_ToggleGroupInvitations) _then) = __$ToggleGroupInvitationsCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleGroupInvitationsCopyWithImpl<$Res>
    implements _$ToggleGroupInvitationsCopyWith<$Res> {
  __$ToggleGroupInvitationsCopyWithImpl(this._self, this._then);

  final _ToggleGroupInvitations _self;
  final $Res Function(_ToggleGroupInvitations) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleGroupInvitations(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleInvitationAccepted implements NotificationEvent {
  const _ToggleInvitationAccepted(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleInvitationAcceptedCopyWith<_ToggleInvitationAccepted> get copyWith => __$ToggleInvitationAcceptedCopyWithImpl<_ToggleInvitationAccepted>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleInvitationAccepted&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleInvitationAccepted(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleInvitationAcceptedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleInvitationAcceptedCopyWith(_ToggleInvitationAccepted value, $Res Function(_ToggleInvitationAccepted) _then) = __$ToggleInvitationAcceptedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleInvitationAcceptedCopyWithImpl<$Res>
    implements _$ToggleInvitationAcceptedCopyWith<$Res> {
  __$ToggleInvitationAcceptedCopyWithImpl(this._self, this._then);

  final _ToggleInvitationAccepted _self;
  final $Res Function(_ToggleInvitationAccepted) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleInvitationAccepted(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleGameCreated implements NotificationEvent {
  const _ToggleGameCreated(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleGameCreatedCopyWith<_ToggleGameCreated> get copyWith => __$ToggleGameCreatedCopyWithImpl<_ToggleGameCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleGameCreated&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleGameCreated(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleGameCreatedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleGameCreatedCopyWith(_ToggleGameCreated value, $Res Function(_ToggleGameCreated) _then) = __$ToggleGameCreatedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleGameCreatedCopyWithImpl<$Res>
    implements _$ToggleGameCreatedCopyWith<$Res> {
  __$ToggleGameCreatedCopyWithImpl(this._self, this._then);

  final _ToggleGameCreated _self;
  final $Res Function(_ToggleGameCreated) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleGameCreated(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleMemberJoined implements NotificationEvent {
  const _ToggleMemberJoined(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleMemberJoinedCopyWith<_ToggleMemberJoined> get copyWith => __$ToggleMemberJoinedCopyWithImpl<_ToggleMemberJoined>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMemberJoined&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleMemberJoined(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleMemberJoinedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleMemberJoinedCopyWith(_ToggleMemberJoined value, $Res Function(_ToggleMemberJoined) _then) = __$ToggleMemberJoinedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleMemberJoinedCopyWithImpl<$Res>
    implements _$ToggleMemberJoinedCopyWith<$Res> {
  __$ToggleMemberJoinedCopyWithImpl(this._self, this._then);

  final _ToggleMemberJoined _self;
  final $Res Function(_ToggleMemberJoined) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleMemberJoined(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleMemberLeft implements NotificationEvent {
  const _ToggleMemberLeft(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleMemberLeftCopyWith<_ToggleMemberLeft> get copyWith => __$ToggleMemberLeftCopyWithImpl<_ToggleMemberLeft>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleMemberLeft&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleMemberLeft(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleMemberLeftCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleMemberLeftCopyWith(_ToggleMemberLeft value, $Res Function(_ToggleMemberLeft) _then) = __$ToggleMemberLeftCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleMemberLeftCopyWithImpl<$Res>
    implements _$ToggleMemberLeftCopyWith<$Res> {
  __$ToggleMemberLeftCopyWithImpl(this._self, this._then);

  final _ToggleMemberLeft _self;
  final $Res Function(_ToggleMemberLeft) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleMemberLeft(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleRoleChanged implements NotificationEvent {
  const _ToggleRoleChanged(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleRoleChangedCopyWith<_ToggleRoleChanged> get copyWith => __$ToggleRoleChangedCopyWithImpl<_ToggleRoleChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleRoleChanged&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleRoleChanged(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleRoleChangedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleRoleChangedCopyWith(_ToggleRoleChanged value, $Res Function(_ToggleRoleChanged) _then) = __$ToggleRoleChangedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleRoleChangedCopyWithImpl<$Res>
    implements _$ToggleRoleChangedCopyWith<$Res> {
  __$ToggleRoleChangedCopyWithImpl(this._self, this._then);

  final _ToggleRoleChanged _self;
  final $Res Function(_ToggleRoleChanged) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleRoleChanged(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleQuietHours implements NotificationEvent {
  const _ToggleQuietHours({required this.enabled, this.start, this.end});
  

 final  bool enabled;
 final  String? start;
 final  String? end;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleQuietHoursCopyWith<_ToggleQuietHours> get copyWith => __$ToggleQuietHoursCopyWithImpl<_ToggleQuietHours>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleQuietHours&&(identical(other.enabled, enabled) || other.enabled == enabled)&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode => Object.hash(runtimeType,enabled,start,end);

@override
String toString() {
  return 'NotificationEvent.toggleQuietHours(enabled: $enabled, start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$ToggleQuietHoursCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleQuietHoursCopyWith(_ToggleQuietHours value, $Res Function(_ToggleQuietHours) _then) = __$ToggleQuietHoursCopyWithImpl;
@useResult
$Res call({
 bool enabled, String? start, String? end
});




}
/// @nodoc
class __$ToggleQuietHoursCopyWithImpl<$Res>
    implements _$ToggleQuietHoursCopyWith<$Res> {
  __$ToggleQuietHoursCopyWithImpl(this._self, this._then);

  final _ToggleQuietHours _self;
  final $Res Function(_ToggleQuietHours) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,Object? start = freezed,Object? end = freezed,}) {
  return _then(_ToggleQuietHours(
enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,start: freezed == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as String?,end: freezed == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _ToggleGroupSpecific implements NotificationEvent {
  const _ToggleGroupSpecific({required this.groupId, required this.enabled});
  

 final  String groupId;
 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleGroupSpecificCopyWith<_ToggleGroupSpecific> get copyWith => __$ToggleGroupSpecificCopyWithImpl<_ToggleGroupSpecific>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleGroupSpecific&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleGroupSpecific(groupId: $groupId, enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleGroupSpecificCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleGroupSpecificCopyWith(_ToggleGroupSpecific value, $Res Function(_ToggleGroupSpecific) _then) = __$ToggleGroupSpecificCopyWithImpl;
@useResult
$Res call({
 String groupId, bool enabled
});




}
/// @nodoc
class __$ToggleGroupSpecificCopyWithImpl<$Res>
    implements _$ToggleGroupSpecificCopyWith<$Res> {
  __$ToggleGroupSpecificCopyWithImpl(this._self, this._then);

  final _ToggleGroupSpecific _self;
  final $Res Function(_ToggleGroupSpecific) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = null,Object? enabled = null,}) {
  return _then(_ToggleGroupSpecific(
groupId: null == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String,enabled: null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleTrainingSessionCreated implements NotificationEvent {
  const _ToggleTrainingSessionCreated(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleTrainingSessionCreatedCopyWith<_ToggleTrainingSessionCreated> get copyWith => __$ToggleTrainingSessionCreatedCopyWithImpl<_ToggleTrainingSessionCreated>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleTrainingSessionCreated&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleTrainingSessionCreated(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleTrainingSessionCreatedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleTrainingSessionCreatedCopyWith(_ToggleTrainingSessionCreated value, $Res Function(_ToggleTrainingSessionCreated) _then) = __$ToggleTrainingSessionCreatedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleTrainingSessionCreatedCopyWithImpl<$Res>
    implements _$ToggleTrainingSessionCreatedCopyWith<$Res> {
  __$ToggleTrainingSessionCreatedCopyWithImpl(this._self, this._then);

  final _ToggleTrainingSessionCreated _self;
  final $Res Function(_ToggleTrainingSessionCreated) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleTrainingSessionCreated(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleTrainingMinParticipantsReached implements NotificationEvent {
  const _ToggleTrainingMinParticipantsReached(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleTrainingMinParticipantsReachedCopyWith<_ToggleTrainingMinParticipantsReached> get copyWith => __$ToggleTrainingMinParticipantsReachedCopyWithImpl<_ToggleTrainingMinParticipantsReached>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleTrainingMinParticipantsReached&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleTrainingMinParticipantsReached(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleTrainingMinParticipantsReachedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleTrainingMinParticipantsReachedCopyWith(_ToggleTrainingMinParticipantsReached value, $Res Function(_ToggleTrainingMinParticipantsReached) _then) = __$ToggleTrainingMinParticipantsReachedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleTrainingMinParticipantsReachedCopyWithImpl<$Res>
    implements _$ToggleTrainingMinParticipantsReachedCopyWith<$Res> {
  __$ToggleTrainingMinParticipantsReachedCopyWithImpl(this._self, this._then);

  final _ToggleTrainingMinParticipantsReached _self;
  final $Res Function(_ToggleTrainingMinParticipantsReached) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleTrainingMinParticipantsReached(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleTrainingFeedbackReceived implements NotificationEvent {
  const _ToggleTrainingFeedbackReceived(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleTrainingFeedbackReceivedCopyWith<_ToggleTrainingFeedbackReceived> get copyWith => __$ToggleTrainingFeedbackReceivedCopyWithImpl<_ToggleTrainingFeedbackReceived>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleTrainingFeedbackReceived&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleTrainingFeedbackReceived(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleTrainingFeedbackReceivedCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleTrainingFeedbackReceivedCopyWith(_ToggleTrainingFeedbackReceived value, $Res Function(_ToggleTrainingFeedbackReceived) _then) = __$ToggleTrainingFeedbackReceivedCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleTrainingFeedbackReceivedCopyWithImpl<$Res>
    implements _$ToggleTrainingFeedbackReceivedCopyWith<$Res> {
  __$ToggleTrainingFeedbackReceivedCopyWithImpl(this._self, this._then);

  final _ToggleTrainingFeedbackReceived _self;
  final $Res Function(_ToggleTrainingFeedbackReceived) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleTrainingFeedbackReceived(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _ToggleTrainingSessionCancelled implements NotificationEvent {
  const _ToggleTrainingSessionCancelled(this.enabled);
  

 final  bool enabled;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleTrainingSessionCancelledCopyWith<_ToggleTrainingSessionCancelled> get copyWith => __$ToggleTrainingSessionCancelledCopyWithImpl<_ToggleTrainingSessionCancelled>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleTrainingSessionCancelled&&(identical(other.enabled, enabled) || other.enabled == enabled));
}


@override
int get hashCode => Object.hash(runtimeType,enabled);

@override
String toString() {
  return 'NotificationEvent.toggleTrainingSessionCancelled(enabled: $enabled)';
}


}

/// @nodoc
abstract mixin class _$ToggleTrainingSessionCancelledCopyWith<$Res> implements $NotificationEventCopyWith<$Res> {
  factory _$ToggleTrainingSessionCancelledCopyWith(_ToggleTrainingSessionCancelled value, $Res Function(_ToggleTrainingSessionCancelled) _then) = __$ToggleTrainingSessionCancelledCopyWithImpl;
@useResult
$Res call({
 bool enabled
});




}
/// @nodoc
class __$ToggleTrainingSessionCancelledCopyWithImpl<$Res>
    implements _$ToggleTrainingSessionCancelledCopyWith<$Res> {
  __$ToggleTrainingSessionCancelledCopyWithImpl(this._self, this._then);

  final _ToggleTrainingSessionCancelled _self;
  final $Res Function(_ToggleTrainingSessionCancelled) _then;

/// Create a copy of NotificationEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? enabled = null,}) {
  return _then(_ToggleTrainingSessionCancelled(
null == enabled ? _self.enabled : enabled // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
