// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'group_activity_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GroupActivityItem {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GroupActivityItem);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GroupActivityItem()';
}


}

/// @nodoc
class $GroupActivityItemCopyWith<$Res>  {
$GroupActivityItemCopyWith(GroupActivityItem _, $Res Function(GroupActivityItem) __);
}


/// Adds pattern-matching-related methods to [GroupActivityItem].
extension GroupActivityItemPatterns on GroupActivityItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameActivityItem value)?  game,TResult Function( TrainingActivityItem value)?  training,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameActivityItem() when game != null:
return game(_that);case TrainingActivityItem() when training != null:
return training(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameActivityItem value)  game,required TResult Function( TrainingActivityItem value)  training,}){
final _that = this;
switch (_that) {
case GameActivityItem():
return game(_that);case TrainingActivityItem():
return training(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameActivityItem value)?  game,TResult? Function( TrainingActivityItem value)?  training,}){
final _that = this;
switch (_that) {
case GameActivityItem() when game != null:
return game(_that);case TrainingActivityItem() when training != null:
return training(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( GameModel game)?  game,TResult Function( TrainingSessionModel session)?  training,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameActivityItem() when game != null:
return game(_that.game);case TrainingActivityItem() when training != null:
return training(_that.session);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( GameModel game)  game,required TResult Function( TrainingSessionModel session)  training,}) {final _that = this;
switch (_that) {
case GameActivityItem():
return game(_that.game);case TrainingActivityItem():
return training(_that.session);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( GameModel game)?  game,TResult? Function( TrainingSessionModel session)?  training,}) {final _that = this;
switch (_that) {
case GameActivityItem() when game != null:
return game(_that.game);case TrainingActivityItem() when training != null:
return training(_that.session);case _:
  return null;

}
}

}

/// @nodoc


class GameActivityItem extends GroupActivityItem {
  const GameActivityItem(this.game): super._();
  

 final  GameModel game;

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameActivityItemCopyWith<GameActivityItem> get copyWith => _$GameActivityItemCopyWithImpl<GameActivityItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameActivityItem&&(identical(other.game, game) || other.game == game));
}


@override
int get hashCode => Object.hash(runtimeType,game);

@override
String toString() {
  return 'GroupActivityItem.game(game: $game)';
}


}

/// @nodoc
abstract mixin class $GameActivityItemCopyWith<$Res> implements $GroupActivityItemCopyWith<$Res> {
  factory $GameActivityItemCopyWith(GameActivityItem value, $Res Function(GameActivityItem) _then) = _$GameActivityItemCopyWithImpl;
@useResult
$Res call({
 GameModel game
});


$GameModelCopyWith<$Res> get game;

}
/// @nodoc
class _$GameActivityItemCopyWithImpl<$Res>
    implements $GameActivityItemCopyWith<$Res> {
  _$GameActivityItemCopyWithImpl(this._self, this._then);

  final GameActivityItem _self;
  final $Res Function(GameActivityItem) _then;

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? game = null,}) {
  return _then(GameActivityItem(
null == game ? _self.game : game // ignore: cast_nullable_to_non_nullable
as GameModel,
  ));
}

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GameModelCopyWith<$Res> get game {
  
  return $GameModelCopyWith<$Res>(_self.game, (value) {
    return _then(_self.copyWith(game: value));
  });
}
}

/// @nodoc


class TrainingActivityItem extends GroupActivityItem {
  const TrainingActivityItem(this.session): super._();
  

 final  TrainingSessionModel session;

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrainingActivityItemCopyWith<TrainingActivityItem> get copyWith => _$TrainingActivityItemCopyWithImpl<TrainingActivityItem>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TrainingActivityItem&&(identical(other.session, session) || other.session == session));
}


@override
int get hashCode => Object.hash(runtimeType,session);

@override
String toString() {
  return 'GroupActivityItem.training(session: $session)';
}


}

/// @nodoc
abstract mixin class $TrainingActivityItemCopyWith<$Res> implements $GroupActivityItemCopyWith<$Res> {
  factory $TrainingActivityItemCopyWith(TrainingActivityItem value, $Res Function(TrainingActivityItem) _then) = _$TrainingActivityItemCopyWithImpl;
@useResult
$Res call({
 TrainingSessionModel session
});


$TrainingSessionModelCopyWith<$Res> get session;

}
/// @nodoc
class _$TrainingActivityItemCopyWithImpl<$Res>
    implements $TrainingActivityItemCopyWith<$Res> {
  _$TrainingActivityItemCopyWithImpl(this._self, this._then);

  final TrainingActivityItem _self;
  final $Res Function(TrainingActivityItem) _then;

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? session = null,}) {
  return _then(TrainingActivityItem(
null == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as TrainingSessionModel,
  ));
}

/// Create a copy of GroupActivityItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TrainingSessionModelCopyWith<$Res> get session {
  
  return $TrainingSessionModelCopyWith<$Res>(_self.session, (value) {
    return _then(_self.copyWith(session: value));
  });
}
}

// dart format on
