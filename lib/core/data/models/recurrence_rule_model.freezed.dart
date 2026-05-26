// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recurrence_rule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecurrenceRuleModel {

/// The frequency of recurrence (weekly, monthly, or none)
 RecurrenceFrequency get frequency;/// The interval between occurrences (e.g., every 1 week, every 2 months)
/// Must be >= 1
 int get interval;/// The number of occurrences to generate
/// Either count or endDate should be specified, not both
 int? get count;/// The date until which to generate occurrences
/// Either count or endDate should be specified, not both
// ignore: invalid_annotation_target
@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? get endDate;/// Days of the week for weekly recurrence (1 = Monday, 7 = Sunday)
/// Only applicable when frequency is weekly
/// If null or empty for weekly recurrence, defaults to the same day as the parent session
 List<int>? get daysOfWeek;
/// Create a copy of RecurrenceRuleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecurrenceRuleModelCopyWith<RecurrenceRuleModel> get copyWith => _$RecurrenceRuleModelCopyWithImpl<RecurrenceRuleModel>(this as RecurrenceRuleModel, _$identity);

  /// Serializes this RecurrenceRuleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecurrenceRuleModel&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.count, count) || other.count == count)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other.daysOfWeek, daysOfWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,frequency,interval,count,endDate,const DeepCollectionEquality().hash(daysOfWeek));

@override
String toString() {
  return 'RecurrenceRuleModel(frequency: $frequency, interval: $interval, count: $count, endDate: $endDate, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class $RecurrenceRuleModelCopyWith<$Res>  {
  factory $RecurrenceRuleModelCopyWith(RecurrenceRuleModel value, $Res Function(RecurrenceRuleModel) _then) = _$RecurrenceRuleModelCopyWithImpl;
@useResult
$Res call({
 RecurrenceFrequency frequency, int interval, int? count,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? endDate, List<int>? daysOfWeek
});




}
/// @nodoc
class _$RecurrenceRuleModelCopyWithImpl<$Res>
    implements $RecurrenceRuleModelCopyWith<$Res> {
  _$RecurrenceRuleModelCopyWithImpl(this._self, this._then);

  final RecurrenceRuleModel _self;
  final $Res Function(RecurrenceRuleModel) _then;

/// Create a copy of RecurrenceRuleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? frequency = null,Object? interval = null,Object? count = freezed,Object? endDate = freezed,Object? daysOfWeek = freezed,}) {
  return _then(_self.copyWith(
frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,daysOfWeek: freezed == daysOfWeek ? _self.daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecurrenceRuleModel].
extension RecurrenceRuleModelPatterns on RecurrenceRuleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecurrenceRuleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecurrenceRuleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecurrenceRuleModel value)  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRuleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecurrenceRuleModel value)?  $default,){
final _that = this;
switch (_that) {
case _RecurrenceRuleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecurrenceFrequency frequency,  int interval,  int? count, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime? endDate,  List<int>? daysOfWeek)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecurrenceRuleModel() when $default != null:
return $default(_that.frequency,_that.interval,_that.count,_that.endDate,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecurrenceFrequency frequency,  int interval,  int? count, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime? endDate,  List<int>? daysOfWeek)  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRuleModel():
return $default(_that.frequency,_that.interval,_that.count,_that.endDate,_that.daysOfWeek);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecurrenceFrequency frequency,  int interval,  int? count, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)  DateTime? endDate,  List<int>? daysOfWeek)?  $default,) {final _that = this;
switch (_that) {
case _RecurrenceRuleModel() when $default != null:
return $default(_that.frequency,_that.interval,_that.count,_that.endDate,_that.daysOfWeek);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecurrenceRuleModel extends RecurrenceRuleModel {
  const _RecurrenceRuleModel({this.frequency = RecurrenceFrequency.none, this.interval = 1, this.count, @JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) this.endDate, final  List<int>? daysOfWeek}): _daysOfWeek = daysOfWeek,super._();
  factory _RecurrenceRuleModel.fromJson(Map<String, dynamic> json) => _$RecurrenceRuleModelFromJson(json);

/// The frequency of recurrence (weekly, monthly, or none)
@override@JsonKey() final  RecurrenceFrequency frequency;
/// The interval between occurrences (e.g., every 1 week, every 2 months)
/// Must be >= 1
@override@JsonKey() final  int interval;
/// The number of occurrences to generate
/// Either count or endDate should be specified, not both
@override final  int? count;
/// The date until which to generate occurrences
/// Either count or endDate should be specified, not both
// ignore: invalid_annotation_target
@override@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) final  DateTime? endDate;
/// Days of the week for weekly recurrence (1 = Monday, 7 = Sunday)
/// Only applicable when frequency is weekly
/// If null or empty for weekly recurrence, defaults to the same day as the parent session
 final  List<int>? _daysOfWeek;
/// Days of the week for weekly recurrence (1 = Monday, 7 = Sunday)
/// Only applicable when frequency is weekly
/// If null or empty for weekly recurrence, defaults to the same day as the parent session
@override List<int>? get daysOfWeek {
  final value = _daysOfWeek;
  if (value == null) return null;
  if (_daysOfWeek is EqualUnmodifiableListView) return _daysOfWeek;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of RecurrenceRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecurrenceRuleModelCopyWith<_RecurrenceRuleModel> get copyWith => __$RecurrenceRuleModelCopyWithImpl<_RecurrenceRuleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecurrenceRuleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecurrenceRuleModel&&(identical(other.frequency, frequency) || other.frequency == frequency)&&(identical(other.interval, interval) || other.interval == interval)&&(identical(other.count, count) || other.count == count)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&const DeepCollectionEquality().equals(other._daysOfWeek, _daysOfWeek));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,frequency,interval,count,endDate,const DeepCollectionEquality().hash(_daysOfWeek));

@override
String toString() {
  return 'RecurrenceRuleModel(frequency: $frequency, interval: $interval, count: $count, endDate: $endDate, daysOfWeek: $daysOfWeek)';
}


}

/// @nodoc
abstract mixin class _$RecurrenceRuleModelCopyWith<$Res> implements $RecurrenceRuleModelCopyWith<$Res> {
  factory _$RecurrenceRuleModelCopyWith(_RecurrenceRuleModel value, $Res Function(_RecurrenceRuleModel) _then) = __$RecurrenceRuleModelCopyWithImpl;
@override @useResult
$Res call({
 RecurrenceFrequency frequency, int interval, int? count,@JsonKey(fromJson: _dateTimeFromJson, toJson: _dateTimeToJson) DateTime? endDate, List<int>? daysOfWeek
});




}
/// @nodoc
class __$RecurrenceRuleModelCopyWithImpl<$Res>
    implements _$RecurrenceRuleModelCopyWith<$Res> {
  __$RecurrenceRuleModelCopyWithImpl(this._self, this._then);

  final _RecurrenceRuleModel _self;
  final $Res Function(_RecurrenceRuleModel) _then;

/// Create a copy of RecurrenceRuleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? frequency = null,Object? interval = null,Object? count = freezed,Object? endDate = freezed,Object? daysOfWeek = freezed,}) {
  return _then(_RecurrenceRuleModel(
frequency: null == frequency ? _self.frequency : frequency // ignore: cast_nullable_to_non_nullable
as RecurrenceFrequency,interval: null == interval ? _self.interval : interval // ignore: cast_nullable_to_non_nullable
as int,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,daysOfWeek: freezed == daysOfWeek ? _self._daysOfWeek : daysOfWeek // ignore: cast_nullable_to_non_nullable
as List<int>?,
  ));
}


}

// dart format on
