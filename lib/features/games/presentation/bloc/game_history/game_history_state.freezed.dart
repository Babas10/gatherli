// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GameHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryState()';
}


}

/// @nodoc
class $GameHistoryStateCopyWith<$Res>  {
$GameHistoryStateCopyWith(GameHistoryState _, $Res Function(GameHistoryState) __);
}


/// Adds pattern-matching-related methods to [GameHistoryState].
extension GameHistoryStatePatterns on GameHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( GameHistoryInitial value)?  initial,TResult Function( GameHistoryLoading value)?  loading,TResult Function( GameHistoryLoaded value)?  loaded,TResult Function( GameHistoryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case GameHistoryInitial() when initial != null:
return initial(_that);case GameHistoryLoading() when loading != null:
return loading(_that);case GameHistoryLoaded() when loaded != null:
return loaded(_that);case GameHistoryError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( GameHistoryInitial value)  initial,required TResult Function( GameHistoryLoading value)  loading,required TResult Function( GameHistoryLoaded value)  loaded,required TResult Function( GameHistoryError value)  error,}){
final _that = this;
switch (_that) {
case GameHistoryInitial():
return initial(_that);case GameHistoryLoading():
return loading(_that);case GameHistoryLoaded():
return loaded(_that);case GameHistoryError():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( GameHistoryInitial value)?  initial,TResult? Function( GameHistoryLoading value)?  loading,TResult? Function( GameHistoryLoaded value)?  loaded,TResult? Function( GameHistoryError value)?  error,}){
final _that = this;
switch (_that) {
case GameHistoryInitial() when initial != null:
return initial(_that);case GameHistoryLoading() when loading != null:
return loading(_that);case GameHistoryLoaded() when loaded != null:
return loaded(_that);case GameHistoryError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<GameModel> games,  bool hasMore,  GameHistoryFilter currentFilter,  DateTime? startDate,  DateTime? endDate,  bool isLoadingMore)?  loaded,TResult Function( String message,  GameHistoryFilter? lastFilter)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case GameHistoryInitial() when initial != null:
return initial();case GameHistoryLoading() when loading != null:
return loading();case GameHistoryLoaded() when loaded != null:
return loaded(_that.games,_that.hasMore,_that.currentFilter,_that.startDate,_that.endDate,_that.isLoadingMore);case GameHistoryError() when error != null:
return error(_that.message,_that.lastFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<GameModel> games,  bool hasMore,  GameHistoryFilter currentFilter,  DateTime? startDate,  DateTime? endDate,  bool isLoadingMore)  loaded,required TResult Function( String message,  GameHistoryFilter? lastFilter)  error,}) {final _that = this;
switch (_that) {
case GameHistoryInitial():
return initial();case GameHistoryLoading():
return loading();case GameHistoryLoaded():
return loaded(_that.games,_that.hasMore,_that.currentFilter,_that.startDate,_that.endDate,_that.isLoadingMore);case GameHistoryError():
return error(_that.message,_that.lastFilter);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<GameModel> games,  bool hasMore,  GameHistoryFilter currentFilter,  DateTime? startDate,  DateTime? endDate,  bool isLoadingMore)?  loaded,TResult? Function( String message,  GameHistoryFilter? lastFilter)?  error,}) {final _that = this;
switch (_that) {
case GameHistoryInitial() when initial != null:
return initial();case GameHistoryLoading() when loading != null:
return loading();case GameHistoryLoaded() when loaded != null:
return loaded(_that.games,_that.hasMore,_that.currentFilter,_that.startDate,_that.endDate,_that.isLoadingMore);case GameHistoryError() when error != null:
return error(_that.message,_that.lastFilter);case _:
  return null;

}
}

}

/// @nodoc


class GameHistoryInitial implements GameHistoryState {
  const GameHistoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryState.initial()';
}


}




/// @nodoc


class GameHistoryLoading implements GameHistoryState {
  const GameHistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'GameHistoryState.loading()';
}


}




/// @nodoc


class GameHistoryLoaded implements GameHistoryState {
  const GameHistoryLoaded({required final  List<GameModel> games, required this.hasMore, required this.currentFilter, this.startDate, this.endDate, this.isLoadingMore = false}): _games = games;
  

 final  List<GameModel> _games;
 List<GameModel> get games {
  if (_games is EqualUnmodifiableListView) return _games;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_games);
}

 final  bool hasMore;
 final  GameHistoryFilter currentFilter;
 final  DateTime? startDate;
 final  DateTime? endDate;
@JsonKey() final  bool isLoadingMore;

/// Create a copy of GameHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryLoadedCopyWith<GameHistoryLoaded> get copyWith => _$GameHistoryLoadedCopyWithImpl<GameHistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryLoaded&&const DeepCollectionEquality().equals(other._games, _games)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentFilter, currentFilter) || other.currentFilter == currentFilter)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_games),hasMore,currentFilter,startDate,endDate,isLoadingMore);

@override
String toString() {
  return 'GameHistoryState.loaded(games: $games, hasMore: $hasMore, currentFilter: $currentFilter, startDate: $startDate, endDate: $endDate, isLoadingMore: $isLoadingMore)';
}


}

/// @nodoc
abstract mixin class $GameHistoryLoadedCopyWith<$Res> implements $GameHistoryStateCopyWith<$Res> {
  factory $GameHistoryLoadedCopyWith(GameHistoryLoaded value, $Res Function(GameHistoryLoaded) _then) = _$GameHistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<GameModel> games, bool hasMore, GameHistoryFilter currentFilter, DateTime? startDate, DateTime? endDate, bool isLoadingMore
});




}
/// @nodoc
class _$GameHistoryLoadedCopyWithImpl<$Res>
    implements $GameHistoryLoadedCopyWith<$Res> {
  _$GameHistoryLoadedCopyWithImpl(this._self, this._then);

  final GameHistoryLoaded _self;
  final $Res Function(GameHistoryLoaded) _then;

/// Create a copy of GameHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? games = null,Object? hasMore = null,Object? currentFilter = null,Object? startDate = freezed,Object? endDate = freezed,Object? isLoadingMore = null,}) {
  return _then(GameHistoryLoaded(
games: null == games ? _self._games : games // ignore: cast_nullable_to_non_nullable
as List<GameModel>,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentFilter: null == currentFilter ? _self.currentFilter : currentFilter // ignore: cast_nullable_to_non_nullable
as GameHistoryFilter,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class GameHistoryError implements GameHistoryState {
  const GameHistoryError({required this.message, this.lastFilter});
  

 final  String message;
 final  GameHistoryFilter? lastFilter;

/// Create a copy of GameHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GameHistoryErrorCopyWith<GameHistoryError> get copyWith => _$GameHistoryErrorCopyWithImpl<GameHistoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GameHistoryError&&(identical(other.message, message) || other.message == message)&&(identical(other.lastFilter, lastFilter) || other.lastFilter == lastFilter));
}


@override
int get hashCode => Object.hash(runtimeType,message,lastFilter);

@override
String toString() {
  return 'GameHistoryState.error(message: $message, lastFilter: $lastFilter)';
}


}

/// @nodoc
abstract mixin class $GameHistoryErrorCopyWith<$Res> implements $GameHistoryStateCopyWith<$Res> {
  factory $GameHistoryErrorCopyWith(GameHistoryError value, $Res Function(GameHistoryError) _then) = _$GameHistoryErrorCopyWithImpl;
@useResult
$Res call({
 String message, GameHistoryFilter? lastFilter
});




}
/// @nodoc
class _$GameHistoryErrorCopyWithImpl<$Res>
    implements $GameHistoryErrorCopyWith<$Res> {
  _$GameHistoryErrorCopyWithImpl(this._self, this._then);

  final GameHistoryError _self;
  final $Res Function(GameHistoryError) _then;

/// Create a copy of GameHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? lastFilter = freezed,}) {
  return _then(GameHistoryError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,lastFilter: freezed == lastFilter ? _self.lastFilter : lastFilter // ignore: cast_nullable_to_non_nullable
as GameHistoryFilter?,
  ));
}


}

// dart format on
