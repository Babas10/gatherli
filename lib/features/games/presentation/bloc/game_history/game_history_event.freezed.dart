// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_history_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameHistoryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryEvent()';
}


}

/// @nodoc
class $GameHistoryEventCopyWith<$Res>  {
$GameHistoryEventCopyWith(GameHistoryEvent _, $Res Function(GameHistoryEvent) __);
}


/// Adds pattern-matching-related methods to [GameHistoryEvent].
extension GameHistoryEventPatterns on GameHistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameHistoryLoadEvent value)?  load,TResult Function( GameHistoryLoadMoreEvent value)?  loadMore,TResult Function( GameHistoryRefreshEvent value)?  refresh,TResult Function( GameHistoryFilterChangedEvent value)?  filterChanged,TResult Function( GameHistoryDateRangeChangedEvent value)?  dateRangeChanged,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameHistoryLoadEvent() when load != null:
return load(_that);case GameHistoryLoadMoreEvent() when loadMore != null:
return loadMore(_that);case GameHistoryRefreshEvent() when refresh != null:
return refresh(_that);case GameHistoryFilterChangedEvent() when filterChanged != null:
return filterChanged(_that);case GameHistoryDateRangeChangedEvent() when dateRangeChanged != null:
return dateRangeChanged(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameHistoryLoadEvent value)  load,required TResult Function( GameHistoryLoadMoreEvent value)  loadMore,required TResult Function( GameHistoryRefreshEvent value)  refresh,required TResult Function( GameHistoryFilterChangedEvent value)  filterChanged,required TResult Function( GameHistoryDateRangeChangedEvent value)  dateRangeChanged,}){
final _that = this;
switch (_that) {
case GameHistoryLoadEvent():
return load(_that);case GameHistoryLoadMoreEvent():
return loadMore(_that);case GameHistoryRefreshEvent():
return refresh(_that);case GameHistoryFilterChangedEvent():
return filterChanged(_that);case GameHistoryDateRangeChangedEvent():
return dateRangeChanged(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameHistoryLoadEvent value)?  load,TResult? Function( GameHistoryLoadMoreEvent value)?  loadMore,TResult? Function( GameHistoryRefreshEvent value)?  refresh,TResult? Function( GameHistoryFilterChangedEvent value)?  filterChanged,TResult? Function( GameHistoryDateRangeChangedEvent value)?  dateRangeChanged,}){
final _that = this;
switch (_that) {
case GameHistoryLoadEvent() when load != null:
return load(_that);case GameHistoryLoadMoreEvent() when loadMore != null:
return loadMore(_that);case GameHistoryRefreshEvent() when refresh != null:
return refresh(_that);case GameHistoryFilterChangedEvent() when filterChanged != null:
return filterChanged(_that);case GameHistoryDateRangeChangedEvent() when dateRangeChanged != null:
return dateRangeChanged(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? groupId,  String userId,  GameHistoryFilter filter,  DateTime? startDate,  DateTime? endDate)?  load,TResult Function()?  loadMore,TResult Function()?  refresh,TResult Function( GameHistoryFilter filter)?  filterChanged,TResult Function( DateTime? startDate,  DateTime? endDate)?  dateRangeChanged,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameHistoryLoadEvent() when load != null:
return load(_that.groupId,_that.userId,_that.filter,_that.startDate,_that.endDate);case GameHistoryLoadMoreEvent() when loadMore != null:
return loadMore();case GameHistoryRefreshEvent() when refresh != null:
return refresh();case GameHistoryFilterChangedEvent() when filterChanged != null:
return filterChanged(_that.filter);case GameHistoryDateRangeChangedEvent() when dateRangeChanged != null:
return dateRangeChanged(_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? groupId,  String userId,  GameHistoryFilter filter,  DateTime? startDate,  DateTime? endDate)  load,required TResult Function()  loadMore,required TResult Function()  refresh,required TResult Function( GameHistoryFilter filter)  filterChanged,required TResult Function( DateTime? startDate,  DateTime? endDate)  dateRangeChanged,}) {final _that = this;
switch (_that) {
case GameHistoryLoadEvent():
return load(_that.groupId,_that.userId,_that.filter,_that.startDate,_that.endDate);case GameHistoryLoadMoreEvent():
return loadMore();case GameHistoryRefreshEvent():
return refresh();case GameHistoryFilterChangedEvent():
return filterChanged(_that.filter);case GameHistoryDateRangeChangedEvent():
return dateRangeChanged(_that.startDate,_that.endDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? groupId,  String userId,  GameHistoryFilter filter,  DateTime? startDate,  DateTime? endDate)?  load,TResult? Function()?  loadMore,TResult? Function()?  refresh,TResult? Function( GameHistoryFilter filter)?  filterChanged,TResult? Function( DateTime? startDate,  DateTime? endDate)?  dateRangeChanged,}) {final _that = this;
switch (_that) {
case GameHistoryLoadEvent() when load != null:
return load(_that.groupId,_that.userId,_that.filter,_that.startDate,_that.endDate);case GameHistoryLoadMoreEvent() when loadMore != null:
return loadMore();case GameHistoryRefreshEvent() when refresh != null:
return refresh();case GameHistoryFilterChangedEvent() when filterChanged != null:
return filterChanged(_that.filter);case GameHistoryDateRangeChangedEvent() when dateRangeChanged != null:
return dateRangeChanged(_that.startDate,_that.endDate);case _:
  return null;

}
}

}

/// @nodoc


class GameHistoryLoadEvent implements GameHistoryEvent {
  const GameHistoryLoadEvent({this.groupId, required this.userId, this.filter = GameHistoryFilter.all, this.startDate, this.endDate});
  

 final  String? groupId;
 final  String userId;
@JsonKey() final  GameHistoryFilter filter;
 final  DateTime? startDate;
 final  DateTime? endDate;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryLoadEventCopyWith<GameHistoryLoadEvent> get copyWith => _$GameHistoryLoadEventCopyWithImpl<GameHistoryLoadEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryLoadEvent&&(identical(other.groupId, groupId) || other.groupId == groupId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.filter, filter) || other.filter == filter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,groupId,userId,filter,startDate,endDate);

@override
String toString() {
  return 'GameHistoryEvent.load(groupId: $groupId, userId: $userId, filter: $filter, startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $GameHistoryLoadEventCopyWith<$Res> implements $GameHistoryEventCopyWith<$Res> {
  factory $GameHistoryLoadEventCopyWith(GameHistoryLoadEvent value, $Res Function(GameHistoryLoadEvent) _then) = _$GameHistoryLoadEventCopyWithImpl;
@useResult
$Res call({
 String? groupId, String userId, GameHistoryFilter filter, DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$GameHistoryLoadEventCopyWithImpl<$Res>
    implements $GameHistoryLoadEventCopyWith<$Res> {
  _$GameHistoryLoadEventCopyWithImpl(this._self, this._then);

  final GameHistoryLoadEvent _self;
  final $Res Function(GameHistoryLoadEvent) _then;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? groupId = freezed,Object? userId = null,Object? filter = null,Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(GameHistoryLoadEvent(
groupId: freezed == groupId ? _self.groupId : groupId // ignore: cast_nullable_to_non_nullable
as String?,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GameHistoryFilter,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class GameHistoryLoadMoreEvent implements GameHistoryEvent {
  const GameHistoryLoadMoreEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryLoadMoreEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryEvent.loadMore()';
}


}




/// @nodoc


class GameHistoryRefreshEvent implements GameHistoryEvent {
  const GameHistoryRefreshEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryRefreshEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryEvent.refresh()';
}


}




/// @nodoc


class GameHistoryFilterChangedEvent implements GameHistoryEvent {
  const GameHistoryFilterChangedEvent({required this.filter});
  

 final  GameHistoryFilter filter;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryFilterChangedEventCopyWith<GameHistoryFilterChangedEvent> get copyWith => _$GameHistoryFilterChangedEventCopyWithImpl<GameHistoryFilterChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryFilterChangedEvent&&(identical(other.filter, filter) || other.filter == filter));
}


@override
int get hashCode => Object.hash(runtimeType,filter);

@override
String toString() {
  return 'GameHistoryEvent.filterChanged(filter: $filter)';
}


}

/// @nodoc
abstract mixin class $GameHistoryFilterChangedEventCopyWith<$Res> implements $GameHistoryEventCopyWith<$Res> {
  factory $GameHistoryFilterChangedEventCopyWith(GameHistoryFilterChangedEvent value, $Res Function(GameHistoryFilterChangedEvent) _then) = _$GameHistoryFilterChangedEventCopyWithImpl;
@useResult
$Res call({
 GameHistoryFilter filter
});




}
/// @nodoc
class _$GameHistoryFilterChangedEventCopyWithImpl<$Res>
    implements $GameHistoryFilterChangedEventCopyWith<$Res> {
  _$GameHistoryFilterChangedEventCopyWithImpl(this._self, this._then);

  final GameHistoryFilterChangedEvent _self;
  final $Res Function(GameHistoryFilterChangedEvent) _then;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? filter = null,}) {
  return _then(GameHistoryFilterChangedEvent(
filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as GameHistoryFilter,
  ));
}


}

/// @nodoc


class GameHistoryDateRangeChangedEvent implements GameHistoryEvent {
  const GameHistoryDateRangeChangedEvent({this.startDate, this.endDate});
  

 final  DateTime? startDate;
 final  DateTime? endDate;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryDateRangeChangedEventCopyWith<GameHistoryDateRangeChangedEvent> get copyWith => _$GameHistoryDateRangeChangedEventCopyWithImpl<GameHistoryDateRangeChangedEvent>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryDateRangeChangedEvent&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate);

@override
String toString() {
  return 'GameHistoryEvent.dateRangeChanged(startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $GameHistoryDateRangeChangedEventCopyWith<$Res> implements $GameHistoryEventCopyWith<$Res> {
  factory $GameHistoryDateRangeChangedEventCopyWith(GameHistoryDateRangeChangedEvent value, $Res Function(GameHistoryDateRangeChangedEvent) _then) = _$GameHistoryDateRangeChangedEventCopyWithImpl;
@useResult
$Res call({
 DateTime? startDate, DateTime? endDate
});




}
/// @nodoc
class _$GameHistoryDateRangeChangedEventCopyWithImpl<$Res>
    implements $GameHistoryDateRangeChangedEventCopyWith<$Res> {
  _$GameHistoryDateRangeChangedEventCopyWithImpl(this._self, this._then);

  final GameHistoryDateRangeChangedEvent _self;
  final $Res Function(GameHistoryDateRangeChangedEvent) _then;

/// Create a copy of GameHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startDate = freezed,Object? endDate = freezed,}) {
  return _then(GameHistoryDateRangeChangedEvent(
startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
