// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ChampionshipMessageModel {

 String get id; String get senderId; String get senderDisplayName;/// Null for system messages (e.g. schedule proposals).
 String? get teamId; String get text;@TimestampConverter() DateTime get sentAt;
/// Create a copy of ChampionshipMessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChampionshipMessageModelCopyWith<ChampionshipMessageModel> get copyWith => _$ChampionshipMessageModelCopyWithImpl<ChampionshipMessageModel>(this as ChampionshipMessageModel, _$identity);

  /// Serializes this ChampionshipMessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChampionshipMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderDisplayName,teamId,text,sentAt);

@override
String toString() {
  return 'ChampionshipMessageModel(id: $id, senderId: $senderId, senderDisplayName: $senderDisplayName, teamId: $teamId, text: $text, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class $ChampionshipMessageModelCopyWith<$Res>  {
  factory $ChampionshipMessageModelCopyWith(ChampionshipMessageModel value, $Res Function(ChampionshipMessageModel) _then) = _$ChampionshipMessageModelCopyWithImpl;
@useResult
$Res call({
 String id, String senderId, String senderDisplayName, String? teamId, String text,@TimestampConverter() DateTime sentAt
});




}
/// @nodoc
class _$ChampionshipMessageModelCopyWithImpl<$Res>
    implements $ChampionshipMessageModelCopyWith<$Res> {
  _$ChampionshipMessageModelCopyWithImpl(this._self, this._then);

  final ChampionshipMessageModel _self;
  final $Res Function(ChampionshipMessageModel) _then;

/// Create a copy of ChampionshipMessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? senderId = null,Object? senderDisplayName = null,Object? teamId = freezed,Object? text = null,Object? sentAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ChampionshipMessageModel].
extension ChampionshipMessageModelPatterns on ChampionshipMessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChampionshipMessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChampionshipMessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChampionshipMessageModel value)  $default,){
final _that = this;
switch (_that) {
case _ChampionshipMessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChampionshipMessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _ChampionshipMessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderDisplayName,  String? teamId,  String text, @TimestampConverter()  DateTime sentAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChampionshipMessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderDisplayName,_that.teamId,_that.text,_that.sentAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String senderId,  String senderDisplayName,  String? teamId,  String text, @TimestampConverter()  DateTime sentAt)  $default,) {final _that = this;
switch (_that) {
case _ChampionshipMessageModel():
return $default(_that.id,_that.senderId,_that.senderDisplayName,_that.teamId,_that.text,_that.sentAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String senderId,  String senderDisplayName,  String? teamId,  String text, @TimestampConverter()  DateTime sentAt)?  $default,) {final _that = this;
switch (_that) {
case _ChampionshipMessageModel() when $default != null:
return $default(_that.id,_that.senderId,_that.senderDisplayName,_that.teamId,_that.text,_that.sentAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ChampionshipMessageModel extends ChampionshipMessageModel {
  const _ChampionshipMessageModel({required this.id, required this.senderId, required this.senderDisplayName, this.teamId, required this.text, @TimestampConverter() required this.sentAt}): super._();
  factory _ChampionshipMessageModel.fromJson(Map<String, dynamic> json) => _$ChampionshipMessageModelFromJson(json);

@override final  String id;
@override final  String senderId;
@override final  String senderDisplayName;
/// Null for system messages (e.g. schedule proposals).
@override final  String? teamId;
@override final  String text;
@override@TimestampConverter() final  DateTime sentAt;

/// Create a copy of ChampionshipMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChampionshipMessageModelCopyWith<_ChampionshipMessageModel> get copyWith => __$ChampionshipMessageModelCopyWithImpl<_ChampionshipMessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ChampionshipMessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChampionshipMessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.senderDisplayName, senderDisplayName) || other.senderDisplayName == senderDisplayName)&&(identical(other.teamId, teamId) || other.teamId == teamId)&&(identical(other.text, text) || other.text == text)&&(identical(other.sentAt, sentAt) || other.sentAt == sentAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,senderId,senderDisplayName,teamId,text,sentAt);

@override
String toString() {
  return 'ChampionshipMessageModel(id: $id, senderId: $senderId, senderDisplayName: $senderDisplayName, teamId: $teamId, text: $text, sentAt: $sentAt)';
}


}

/// @nodoc
abstract mixin class _$ChampionshipMessageModelCopyWith<$Res> implements $ChampionshipMessageModelCopyWith<$Res> {
  factory _$ChampionshipMessageModelCopyWith(_ChampionshipMessageModel value, $Res Function(_ChampionshipMessageModel) _then) = __$ChampionshipMessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String senderId, String senderDisplayName, String? teamId, String text,@TimestampConverter() DateTime sentAt
});




}
/// @nodoc
class __$ChampionshipMessageModelCopyWithImpl<$Res>
    implements _$ChampionshipMessageModelCopyWith<$Res> {
  __$ChampionshipMessageModelCopyWithImpl(this._self, this._then);

  final _ChampionshipMessageModel _self;
  final $Res Function(_ChampionshipMessageModel) _then;

/// Create a copy of ChampionshipMessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? senderId = null,Object? senderDisplayName = null,Object? teamId = freezed,Object? text = null,Object? sentAt = null,}) {
  return _then(_ChampionshipMessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,senderDisplayName: null == senderDisplayName ? _self.senderDisplayName : senderDisplayName // ignore: cast_nullable_to_non_nullable
as String,teamId: freezed == teamId ? _self.teamId : teamId // ignore: cast_nullable_to_non_nullable
as String?,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,sentAt: null == sentAt ? _self.sentAt : sentAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
