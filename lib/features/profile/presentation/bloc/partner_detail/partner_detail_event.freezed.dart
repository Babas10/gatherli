// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_detail_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartnerDetailEvent {

 String get userId; String get partnerId;
/// Create a copy of PartnerDetailEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerDetailEventCopyWith<PartnerDetailEvent> get copyWith => _$PartnerDetailEventCopyWithImpl<PartnerDetailEvent>(this as PartnerDetailEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailEvent&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,partnerId);

@override
String toString() {
  return 'PartnerDetailEvent(userId: $userId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class $PartnerDetailEventCopyWith<$Res>  {
  factory $PartnerDetailEventCopyWith(PartnerDetailEvent value, $Res Function(PartnerDetailEvent) _then) = _$PartnerDetailEventCopyWithImpl;
@useResult
$Res call({
 String userId, String partnerId
});




}
/// @nodoc
class _$PartnerDetailEventCopyWithImpl<$Res>
    implements $PartnerDetailEventCopyWith<$Res> {
  _$PartnerDetailEventCopyWithImpl(this._self, this._then);

  final PartnerDetailEvent _self;
  final $Res Function(PartnerDetailEvent) _then;

/// Create a copy of PartnerDetailEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? partnerId = null,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,partnerId: null == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [PartnerDetailEvent].
extension PartnerDetailEventPatterns on PartnerDetailEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( LoadPartnerDetails value)?  loadPartnerDetails,required TResult orElse(),}){
final _that = this;
switch (_that) {
case LoadPartnerDetails() when loadPartnerDetails != null:
return loadPartnerDetails(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( LoadPartnerDetails value)  loadPartnerDetails,}){
final _that = this;
switch (_that) {
case LoadPartnerDetails():
return loadPartnerDetails(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( LoadPartnerDetails value)?  loadPartnerDetails,}){
final _that = this;
switch (_that) {
case LoadPartnerDetails() when loadPartnerDetails != null:
return loadPartnerDetails(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String userId,  String partnerId)?  loadPartnerDetails,required TResult orElse(),}) {final _that = this;
switch (_that) {
case LoadPartnerDetails() when loadPartnerDetails != null:
return loadPartnerDetails(_that.userId,_that.partnerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String userId,  String partnerId)  loadPartnerDetails,}) {final _that = this;
switch (_that) {
case LoadPartnerDetails():
return loadPartnerDetails(_that.userId,_that.partnerId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String userId,  String partnerId)?  loadPartnerDetails,}) {final _that = this;
switch (_that) {
case LoadPartnerDetails() when loadPartnerDetails != null:
return loadPartnerDetails(_that.userId,_that.partnerId);case _:
  return null;

}
}

}

/// @nodoc


class LoadPartnerDetails implements PartnerDetailEvent {
  const LoadPartnerDetails({required this.userId, required this.partnerId});
  

@override final  String userId;
@override final  String partnerId;

/// Create a copy of PartnerDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoadPartnerDetailsCopyWith<LoadPartnerDetails> get copyWith => _$LoadPartnerDetailsCopyWithImpl<LoadPartnerDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoadPartnerDetails&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.partnerId, partnerId) || other.partnerId == partnerId));
}


@override
int get hashCode => Object.hash(runtimeType,userId,partnerId);

@override
String toString() {
  return 'PartnerDetailEvent.loadPartnerDetails(userId: $userId, partnerId: $partnerId)';
}


}

/// @nodoc
abstract mixin class $LoadPartnerDetailsCopyWith<$Res> implements $PartnerDetailEventCopyWith<$Res> {
  factory $LoadPartnerDetailsCopyWith(LoadPartnerDetails value, $Res Function(LoadPartnerDetails) _then) = _$LoadPartnerDetailsCopyWithImpl;
@override @useResult
$Res call({
 String userId, String partnerId
});




}
/// @nodoc
class _$LoadPartnerDetailsCopyWithImpl<$Res>
    implements $LoadPartnerDetailsCopyWith<$Res> {
  _$LoadPartnerDetailsCopyWithImpl(this._self, this._then);

  final LoadPartnerDetails _self;
  final $Res Function(LoadPartnerDetails) _then;

/// Create a copy of PartnerDetailEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? partnerId = null,}) {
  return _then(LoadPartnerDetails(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,partnerId: null == partnerId ? _self.partnerId : partnerId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
