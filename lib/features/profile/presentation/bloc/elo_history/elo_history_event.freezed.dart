// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elo_history_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EloHistoryEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EloHistoryEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EloHistoryEvent()';
}


}

/// @nodoc
class $EloHistoryEventCopyWith<$Res>  {
$EloHistoryEventCopyWith(EloHistoryEvent _, $Res Function(EloHistoryEvent) __);
}


/// Adds pattern-matching-related methods to [EloHistoryEvent].
extension EloHistoryEventPatterns on EloHistoryEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadEloHistory value)?  loadHistory,TResult Function( FilterByPeriod value)?  filterByPeriod,TResult Function( FilterByDateRange value)?  filterByDateRange,TResult Function( ClearFilter value)?  clearFilter,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadEloHistory() when loadHistory != null:
return loadHistory(_that);case FilterByPeriod() when filterByPeriod != null:
return filterByPeriod(_that);case FilterByDateRange() when filterByDateRange != null:
return filterByDateRange(_that);case ClearFilter() when clearFilter != null:
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadEloHistory value)  loadHistory,required TResult Function( FilterByPeriod value)  filterByPeriod,required TResult Function( FilterByDateRange value)  filterByDateRange,required TResult Function( ClearFilter value)  clearFilter,}){
final _that = this;
switch (_that) {
case LoadEloHistory():
return loadHistory(_that);case FilterByPeriod():
return filterByPeriod(_that);case FilterByDateRange():
return filterByDateRange(_that);case ClearFilter():
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadEloHistory value)?  loadHistory,TResult? Function( FilterByPeriod value)?  filterByPeriod,TResult? Function( FilterByDateRange value)?  filterByDateRange,TResult? Function( ClearFilter value)?  clearFilter,}){
final _that = this;
switch (_that) {
case LoadEloHistory() when loadHistory != null:
return loadHistory(_that);case FilterByPeriod() when filterByPeriod != null:
return filterByPeriod(_that);case FilterByDateRange() when filterByDateRange != null:
return filterByDateRange(_that);case ClearFilter() when clearFilter != null:
return clearFilter(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  int limit)?  loadHistory,TResult Function( TimePeriod period)?  filterByPeriod,TResult Function( DateTime startDate,  DateTime endDate)?  filterByDateRange,TResult Function()?  clearFilter,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadEloHistory() when loadHistory != null:
return loadHistory(_that.userId,_that.limit);case FilterByPeriod() when filterByPeriod != null:
return filterByPeriod(_that.period);case FilterByDateRange() when filterByDateRange != null:
return filterByDateRange(_that.startDate,_that.endDate);case ClearFilter() when clearFilter != null:
return clearFilter();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  int limit)  loadHistory,required TResult Function( TimePeriod period)  filterByPeriod,required TResult Function( DateTime startDate,  DateTime endDate)  filterByDateRange,required TResult Function()  clearFilter,}) {final _that = this;
switch (_that) {
case LoadEloHistory():
return loadHistory(_that.userId,_that.limit);case FilterByPeriod():
return filterByPeriod(_that.period);case FilterByDateRange():
return filterByDateRange(_that.startDate,_that.endDate);case ClearFilter():
return clearFilter();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  int limit)?  loadHistory,TResult? Function( TimePeriod period)?  filterByPeriod,TResult? Function( DateTime startDate,  DateTime endDate)?  filterByDateRange,TResult? Function()?  clearFilter,}) {final _that = this;
switch (_that) {
case LoadEloHistory() when loadHistory != null:
return loadHistory(_that.userId,_that.limit);case FilterByPeriod() when filterByPeriod != null:
return filterByPeriod(_that.period);case FilterByDateRange() when filterByDateRange != null:
return filterByDateRange(_that.startDate,_that.endDate);case ClearFilter() when clearFilter != null:
return clearFilter();case _:
  return null;

}
}

}

/// @nodoc


class LoadEloHistory implements EloHistoryEvent {
  const LoadEloHistory({required this.userId, this.limit = 100});
  

 final  String userId;
@JsonKey() final  int limit;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadEloHistoryCopyWith<LoadEloHistory> get copyWith => _$LoadEloHistoryCopyWithImpl<LoadEloHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadEloHistory&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.limit, limit) || other.limit == limit));
}


@override
int get hashCode => Object.hash(runtimeType,userId,limit);

@override
String toString() {
  return 'EloHistoryEvent.loadHistory(userId: $userId, limit: $limit)';
}


}

/// @nodoc
abstract mixin class $LoadEloHistoryCopyWith<$Res> implements $EloHistoryEventCopyWith<$Res> {
  factory $LoadEloHistoryCopyWith(LoadEloHistory value, $Res Function(LoadEloHistory) _then) = _$LoadEloHistoryCopyWithImpl;
@useResult
$Res call({
 String userId, int limit
});




}
/// @nodoc
class _$LoadEloHistoryCopyWithImpl<$Res>
    implements $LoadEloHistoryCopyWith<$Res> {
  _$LoadEloHistoryCopyWithImpl(this._self, this._then);

  final LoadEloHistory _self;
  final $Res Function(LoadEloHistory) _then;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? limit = null,}) {
  return _then(LoadEloHistory(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class FilterByPeriod implements EloHistoryEvent {
  const FilterByPeriod(this.period);
  

 final  TimePeriod period;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterByPeriodCopyWith<FilterByPeriod> get copyWith => _$FilterByPeriodCopyWithImpl<FilterByPeriod>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterByPeriod&&(identical(other.period, period) || other.period == period));
}


@override
int get hashCode => Object.hash(runtimeType,period);

@override
String toString() {
  return 'EloHistoryEvent.filterByPeriod(period: $period)';
}


}

/// @nodoc
abstract mixin class $FilterByPeriodCopyWith<$Res> implements $EloHistoryEventCopyWith<$Res> {
  factory $FilterByPeriodCopyWith(FilterByPeriod value, $Res Function(FilterByPeriod) _then) = _$FilterByPeriodCopyWithImpl;
@useResult
$Res call({
 TimePeriod period
});




}
/// @nodoc
class _$FilterByPeriodCopyWithImpl<$Res>
    implements $FilterByPeriodCopyWith<$Res> {
  _$FilterByPeriodCopyWithImpl(this._self, this._then);

  final FilterByPeriod _self;
  final $Res Function(FilterByPeriod) _then;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? period = null,}) {
  return _then(FilterByPeriod(
null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as TimePeriod,
  ));
}


}

/// @nodoc


class FilterByDateRange implements EloHistoryEvent {
  const FilterByDateRange({required this.startDate, required this.endDate});
  

 final  DateTime startDate;
 final  DateTime endDate;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilterByDateRangeCopyWith<FilterByDateRange> get copyWith => _$FilterByDateRangeCopyWithImpl<FilterByDateRange>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilterByDateRange&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate));
}


@override
int get hashCode => Object.hash(runtimeType,startDate,endDate);

@override
String toString() {
  return 'EloHistoryEvent.filterByDateRange(startDate: $startDate, endDate: $endDate)';
}


}

/// @nodoc
abstract mixin class $FilterByDateRangeCopyWith<$Res> implements $EloHistoryEventCopyWith<$Res> {
  factory $FilterByDateRangeCopyWith(FilterByDateRange value, $Res Function(FilterByDateRange) _then) = _$FilterByDateRangeCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate
});




}
/// @nodoc
class _$FilterByDateRangeCopyWithImpl<$Res>
    implements $FilterByDateRangeCopyWith<$Res> {
  _$FilterByDateRangeCopyWithImpl(this._self, this._then);

  final FilterByDateRange _self;
  final $Res Function(FilterByDateRange) _then;

/// Create a copy of EloHistoryEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,}) {
  return _then(FilterByDateRange(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class ClearFilter implements EloHistoryEvent {
  const ClearFilter();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClearFilter);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'EloHistoryEvent.clearFilter()';
}


}




// dart format on
