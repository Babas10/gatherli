// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elo_history_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EloHistoryState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EloHistoryState()';
}


}

/// @nodoc
class $EloHistoryStateCopyWith<$Res>  {
$EloHistoryStateCopyWith(EloHistoryState _, $Res Function(EloHistoryState) __);
}


/// Adds pattern-matching-related methods to [EloHistoryState].
extension EloHistoryStatePatterns on EloHistoryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( EloHistoryInitial value)?  initial,TResult Function( EloHistoryLoading value)?  loading,TResult Function( EloHistoryLoaded value)?  loaded,TResult Function( EloHistoryError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case EloHistoryInitial() when initial != null:
return initial(_that);case EloHistoryLoading() when loading != null:
return loading(_that);case EloHistoryLoaded() when loaded != null:
return loaded(_that);case EloHistoryError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( EloHistoryInitial value)  initial,required TResult Function( EloHistoryLoading value)  loading,required TResult Function( EloHistoryLoaded value)  loaded,required TResult Function( EloHistoryError value)  error,}){
final _that = this;
switch (_that) {
case EloHistoryInitial():
return initial(_that);case EloHistoryLoading():
return loading(_that);case EloHistoryLoaded():
return loaded(_that);case EloHistoryError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( EloHistoryInitial value)?  initial,TResult? Function( EloHistoryLoading value)?  loading,TResult? Function( EloHistoryLoaded value)?  loaded,TResult? Function( EloHistoryError value)?  error,}){
final _that = this;
switch (_that) {
case EloHistoryInitial() when initial != null:
return initial(_that);case EloHistoryLoading() when loading != null:
return loading(_that);case EloHistoryLoaded() when loaded != null:
return loaded(_that);case EloHistoryError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<RatingHistoryEntry> history,  List<RatingHistoryEntry> filteredHistory,  DateTime? filterStartDate,  DateTime? filterEndDate,  TimePeriod selectedPeriod,  BestEloRecord? bestEloInPeriod)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case EloHistoryInitial() when initial != null:
return initial();case EloHistoryLoading() when loading != null:
return loading();case EloHistoryLoaded() when loaded != null:
return loaded(_that.history,_that.filteredHistory,_that.filterStartDate,_that.filterEndDate,_that.selectedPeriod,_that.bestEloInPeriod);case EloHistoryError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<RatingHistoryEntry> history,  List<RatingHistoryEntry> filteredHistory,  DateTime? filterStartDate,  DateTime? filterEndDate,  TimePeriod selectedPeriod,  BestEloRecord? bestEloInPeriod)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case EloHistoryInitial():
return initial();case EloHistoryLoading():
return loading();case EloHistoryLoaded():
return loaded(_that.history,_that.filteredHistory,_that.filterStartDate,_that.filterEndDate,_that.selectedPeriod,_that.bestEloInPeriod);case EloHistoryError():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<RatingHistoryEntry> history,  List<RatingHistoryEntry> filteredHistory,  DateTime? filterStartDate,  DateTime? filterEndDate,  TimePeriod selectedPeriod,  BestEloRecord? bestEloInPeriod)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case EloHistoryInitial() when initial != null:
return initial();case EloHistoryLoading() when loading != null:
return loading();case EloHistoryLoaded() when loaded != null:
return loaded(_that.history,_that.filteredHistory,_that.filterStartDate,_that.filterEndDate,_that.selectedPeriod,_that.bestEloInPeriod);case EloHistoryError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class EloHistoryInitial implements EloHistoryState {
  const EloHistoryInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EloHistoryState.initial()';
}


}




/// @nodoc


class EloHistoryLoading implements EloHistoryState {
  const EloHistoryLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EloHistoryState.loading()';
}


}




/// @nodoc


class EloHistoryLoaded implements EloHistoryState {
  const EloHistoryLoaded({required final  List<RatingHistoryEntry> history, required final  List<RatingHistoryEntry> filteredHistory, this.filterStartDate, this.filterEndDate, this.selectedPeriod = TimePeriod.allTime, this.bestEloInPeriod}): _history = history,_filteredHistory = filteredHistory;
  

 final  List<RatingHistoryEntry> _history;
 List<RatingHistoryEntry> get history {
  if (_history is EqualUnmodifiableListView) return _history;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_history);
}

 final  List<RatingHistoryEntry> _filteredHistory;
 List<RatingHistoryEntry> get filteredHistory {
  if (_filteredHistory is EqualUnmodifiableListView) return _filteredHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filteredHistory);
}

 final  DateTime? filterStartDate;
 final  DateTime? filterEndDate;
@JsonKey() final  TimePeriod selectedPeriod;
 final  BestEloRecord? bestEloInPeriod;

/// Create a copy of EloHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EloHistoryLoadedCopyWith<EloHistoryLoaded> get copyWith => _$EloHistoryLoadedCopyWithImpl<EloHistoryLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryLoaded&&const DeepCollectionEquality().equals(other._history, _history)&&const DeepCollectionEquality().equals(other._filteredHistory, _filteredHistory)&&(identical(other.filterStartDate, filterStartDate) || other.filterStartDate == filterStartDate)&&(identical(other.filterEndDate, filterEndDate) || other.filterEndDate == filterEndDate)&&(identical(other.selectedPeriod, selectedPeriod) || other.selectedPeriod == selectedPeriod)&&(identical(other.bestEloInPeriod, bestEloInPeriod) || other.bestEloInPeriod == bestEloInPeriod));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_history),const DeepCollectionEquality().hash(_filteredHistory),filterStartDate,filterEndDate,selectedPeriod,bestEloInPeriod);

@override
String toString() {
  return 'EloHistoryState.loaded(history: $history, filteredHistory: $filteredHistory, filterStartDate: $filterStartDate, filterEndDate: $filterEndDate, selectedPeriod: $selectedPeriod, bestEloInPeriod: $bestEloInPeriod)';
}


}

/// @nodoc
abstract mixin class $EloHistoryLoadedCopyWith<$Res> implements $EloHistoryStateCopyWith<$Res> {
  factory $EloHistoryLoadedCopyWith(EloHistoryLoaded value, $Res Function(EloHistoryLoaded) _then) = _$EloHistoryLoadedCopyWithImpl;
@useResult
$Res call({
 List<RatingHistoryEntry> history, List<RatingHistoryEntry> filteredHistory, DateTime? filterStartDate, DateTime? filterEndDate, TimePeriod selectedPeriod, BestEloRecord? bestEloInPeriod
});


$BestEloRecordCopyWith<$Res>? get bestEloInPeriod;

}
/// @nodoc
class _$EloHistoryLoadedCopyWithImpl<$Res>
    implements $EloHistoryLoadedCopyWith<$Res> {
  _$EloHistoryLoadedCopyWithImpl(this._self, this._then);

  final EloHistoryLoaded _self;
  final $Res Function(EloHistoryLoaded) _then;

/// Create a copy of EloHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? history = null,Object? filteredHistory = null,Object? filterStartDate = freezed,Object? filterEndDate = freezed,Object? selectedPeriod = null,Object? bestEloInPeriod = freezed,}) {
  return _then(EloHistoryLoaded(
history: null == history ? _self._history : history // ignore: cast_nullable_to_non_nullable
as List<RatingHistoryEntry>,filteredHistory: null == filteredHistory ? _self._filteredHistory : filteredHistory // ignore: cast_nullable_to_non_nullable
as List<RatingHistoryEntry>,filterStartDate: freezed == filterStartDate ? _self.filterStartDate : filterStartDate // ignore: cast_nullable_to_non_nullable
as DateTime?,filterEndDate: freezed == filterEndDate ? _self.filterEndDate : filterEndDate // ignore: cast_nullable_to_non_nullable
as DateTime?,selectedPeriod: null == selectedPeriod ? _self.selectedPeriod : selectedPeriod // ignore: cast_nullable_to_non_nullable
as TimePeriod,bestEloInPeriod: freezed == bestEloInPeriod ? _self.bestEloInPeriod : bestEloInPeriod // ignore: cast_nullable_to_non_nullable
as BestEloRecord?,
  ));
}

/// Create a copy of EloHistoryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BestEloRecordCopyWith<$Res>? get bestEloInPeriod {
    if (_self.bestEloInPeriod == null) {
    return null;
  }

  return $BestEloRecordCopyWith<$Res>(_self.bestEloInPeriod!, (value) {
    return _then(_self.copyWith(bestEloInPeriod: value));
  });
}
}

/// @nodoc


class EloHistoryError implements EloHistoryState {
  const EloHistoryError({required this.message});
  

 final  String message;

/// Create a copy of EloHistoryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EloHistoryErrorCopyWith<EloHistoryError> get copyWith => _$EloHistoryErrorCopyWithImpl<EloHistoryError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'EloHistoryState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $EloHistoryErrorCopyWith<$Res> implements $EloHistoryStateCopyWith<$Res> {
  factory $EloHistoryErrorCopyWith(EloHistoryError value, $Res Function(EloHistoryError) _then) = _$EloHistoryErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$EloHistoryErrorCopyWithImpl<$Res>
    implements $EloHistoryErrorCopyWith<$Res> {
  _$EloHistoryErrorCopyWithImpl(this._self, this._then);

  final EloHistoryError _self;
  final $Res Function(EloHistoryError) _then;

/// Create a copy of EloHistoryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(EloHistoryError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
