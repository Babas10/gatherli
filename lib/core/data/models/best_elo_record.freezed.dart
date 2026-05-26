// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'best_elo_record.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BestEloRecord {

/// The highest ELO rating achieved
 double get elo;/// The date when this ELO was achieved
@TimestampConverter() DateTime get date;/// Reference to the game that resulted in this rating
 String get gameId;
/// Create a copy of BestEloRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BestEloRecordCopyWith<BestEloRecord> get copyWith => _$BestEloRecordCopyWithImpl<BestEloRecord>(this as BestEloRecord, _$identity);

  /// Serializes this BestEloRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BestEloRecord&&(identical(other.elo, elo) || other.elo == elo)&&(identical(other.date, date) || other.date == date)&&(identical(other.gameId, gameId) || other.gameId == gameId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elo,date,gameId);

@override
String toString() {
  return 'BestEloRecord(elo: $elo, date: $date, gameId: $gameId)';
}


}

/// @nodoc
abstract mixin class $BestEloRecordCopyWith<$Res>  {
  factory $BestEloRecordCopyWith(BestEloRecord value, $Res Function(BestEloRecord) _then) = _$BestEloRecordCopyWithImpl;
@useResult
$Res call({
 double elo,@TimestampConverter() DateTime date, String gameId
});




}
/// @nodoc
class _$BestEloRecordCopyWithImpl<$Res>
    implements $BestEloRecordCopyWith<$Res> {
  _$BestEloRecordCopyWithImpl(this._self, this._then);

  final BestEloRecord _self;
  final $Res Function(BestEloRecord) _then;

/// Create a copy of BestEloRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? elo = null,Object? date = null,Object? gameId = null,}) {
  return _then(_self.copyWith(
elo: null == elo ? _self.elo : elo // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [BestEloRecord].
extension BestEloRecordPatterns on BestEloRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BestEloRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BestEloRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BestEloRecord value)  $default,){
final _that = this;
switch (_that) {
case _BestEloRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BestEloRecord value)?  $default,){
final _that = this;
switch (_that) {
case _BestEloRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double elo, @TimestampConverter()  DateTime date,  String gameId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BestEloRecord() when $default != null:
return $default(_that.elo,_that.date,_that.gameId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double elo, @TimestampConverter()  DateTime date,  String gameId)  $default,) {final _that = this;
switch (_that) {
case _BestEloRecord():
return $default(_that.elo,_that.date,_that.gameId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double elo, @TimestampConverter()  DateTime date,  String gameId)?  $default,) {final _that = this;
switch (_that) {
case _BestEloRecord() when $default != null:
return $default(_that.elo,_that.date,_that.gameId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BestEloRecord implements BestEloRecord {
  const _BestEloRecord({required this.elo, @TimestampConverter() required this.date, required this.gameId});
  factory _BestEloRecord.fromJson(Map<String, dynamic> json) => _$BestEloRecordFromJson(json);

/// The highest ELO rating achieved
@override final  double elo;
/// The date when this ELO was achieved
@override@TimestampConverter() final  DateTime date;
/// Reference to the game that resulted in this rating
@override final  String gameId;

/// Create a copy of BestEloRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BestEloRecordCopyWith<_BestEloRecord> get copyWith => __$BestEloRecordCopyWithImpl<_BestEloRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BestEloRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BestEloRecord&&(identical(other.elo, elo) || other.elo == elo)&&(identical(other.date, date) || other.date == date)&&(identical(other.gameId, gameId) || other.gameId == gameId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,elo,date,gameId);

@override
String toString() {
  return 'BestEloRecord(elo: $elo, date: $date, gameId: $gameId)';
}


}

/// @nodoc
abstract mixin class _$BestEloRecordCopyWith<$Res> implements $BestEloRecordCopyWith<$Res> {
  factory _$BestEloRecordCopyWith(_BestEloRecord value, $Res Function(_BestEloRecord) _then) = __$BestEloRecordCopyWithImpl;
@override @useResult
$Res call({
 double elo,@TimestampConverter() DateTime date, String gameId
});




}
/// @nodoc
class __$BestEloRecordCopyWithImpl<$Res>
    implements _$BestEloRecordCopyWith<$Res> {
  __$BestEloRecordCopyWithImpl(this._self, this._then);

  final _BestEloRecord _self;
  final $Res Function(_BestEloRecord) _then;

/// Create a copy of BestEloRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? elo = null,Object? date = null,Object? gameId = null,}) {
  return _then(_BestEloRecord(
elo: null == elo ? _self.elo : elo // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
