// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'partner_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PartnerDetailState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PartnerDetailState()';
}


}

/// @nodoc
class $PartnerDetailStateCopyWith<$Res>  {
$PartnerDetailStateCopyWith(PartnerDetailState _, $Res Function(PartnerDetailState) __);
}


/// Adds pattern-matching-related methods to [PartnerDetailState].
extension PartnerDetailStatePatterns on PartnerDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PartnerDetailInitial value)?  initial,TResult Function( PartnerDetailLoading value)?  loading,TResult Function( PartnerDetailLoaded value)?  loaded,TResult Function( PartnerDetailError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PartnerDetailInitial() when initial != null:
return initial(_that);case PartnerDetailLoading() when loading != null:
return loading(_that);case PartnerDetailLoaded() when loaded != null:
return loaded(_that);case PartnerDetailError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PartnerDetailInitial value)  initial,required TResult Function( PartnerDetailLoading value)  loading,required TResult Function( PartnerDetailLoaded value)  loaded,required TResult Function( PartnerDetailError value)  error,}){
final _that = this;
switch (_that) {
case PartnerDetailInitial():
return initial(_that);case PartnerDetailLoading():
return loading(_that);case PartnerDetailLoaded():
return loaded(_that);case PartnerDetailError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PartnerDetailInitial value)?  initial,TResult? Function( PartnerDetailLoading value)?  loading,TResult? Function( PartnerDetailLoaded value)?  loaded,TResult? Function( PartnerDetailError value)?  error,}){
final _that = this;
switch (_that) {
case PartnerDetailInitial() when initial != null:
return initial(_that);case PartnerDetailLoading() when loading != null:
return loading(_that);case PartnerDetailLoaded() when loaded != null:
return loaded(_that);case PartnerDetailError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( TeammateStats stats,  UserModel partnerProfile)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PartnerDetailInitial() when initial != null:
return initial();case PartnerDetailLoading() when loading != null:
return loading();case PartnerDetailLoaded() when loaded != null:
return loaded(_that.stats,_that.partnerProfile);case PartnerDetailError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( TeammateStats stats,  UserModel partnerProfile)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case PartnerDetailInitial():
return initial();case PartnerDetailLoading():
return loading();case PartnerDetailLoaded():
return loaded(_that.stats,_that.partnerProfile);case PartnerDetailError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( TeammateStats stats,  UserModel partnerProfile)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case PartnerDetailInitial() when initial != null:
return initial();case PartnerDetailLoading() when loading != null:
return loading();case PartnerDetailLoaded() when loaded != null:
return loaded(_that.stats,_that.partnerProfile);case PartnerDetailError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class PartnerDetailInitial implements PartnerDetailState {
  const PartnerDetailInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PartnerDetailState.initial()';
}


}




/// @nodoc


class PartnerDetailLoading implements PartnerDetailState {
  const PartnerDetailLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PartnerDetailState.loading()';
}


}




/// @nodoc


class PartnerDetailLoaded implements PartnerDetailState {
  const PartnerDetailLoaded({required this.stats, required this.partnerProfile});
  

 final  TeammateStats stats;
 final  UserModel partnerProfile;

/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerDetailLoadedCopyWith<PartnerDetailLoaded> get copyWith => _$PartnerDetailLoadedCopyWithImpl<PartnerDetailLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailLoaded&&(identical(other.stats, stats) || other.stats == stats)&&(identical(other.partnerProfile, partnerProfile) || other.partnerProfile == partnerProfile));
}


@override
int get hashCode => Object.hash(runtimeType,stats,partnerProfile);

@override
String toString() {
  return 'PartnerDetailState.loaded(stats: $stats, partnerProfile: $partnerProfile)';
}


}

/// @nodoc
abstract mixin class $PartnerDetailLoadedCopyWith<$Res> implements $PartnerDetailStateCopyWith<$Res> {
  factory $PartnerDetailLoadedCopyWith(PartnerDetailLoaded value, $Res Function(PartnerDetailLoaded) _then) = _$PartnerDetailLoadedCopyWithImpl;
@useResult
$Res call({
 TeammateStats stats, UserModel partnerProfile
});


$TeammateStatsCopyWith<$Res> get stats;$UserModelCopyWith<$Res> get partnerProfile;

}
/// @nodoc
class _$PartnerDetailLoadedCopyWithImpl<$Res>
    implements $PartnerDetailLoadedCopyWith<$Res> {
  _$PartnerDetailLoadedCopyWithImpl(this._self, this._then);

  final PartnerDetailLoaded _self;
  final $Res Function(PartnerDetailLoaded) _then;

/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? stats = null,Object? partnerProfile = null,}) {
  return _then(PartnerDetailLoaded(
stats: null == stats ? _self.stats : stats // ignore: cast_nullable_to_non_nullable
as TeammateStats,partnerProfile: null == partnerProfile ? _self.partnerProfile : partnerProfile // ignore: cast_nullable_to_non_nullable
as UserModel,
  ));
}

/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TeammateStatsCopyWith<$Res> get stats {
  
  return $TeammateStatsCopyWith<$Res>(_self.stats, (value) {
    return _then(_self.copyWith(stats: value));
  });
}/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserModelCopyWith<$Res> get partnerProfile {
  
  return $UserModelCopyWith<$Res>(_self.partnerProfile, (value) {
    return _then(_self.copyWith(partnerProfile: value));
  });
}
}

/// @nodoc


class PartnerDetailError implements PartnerDetailState {
  const PartnerDetailError({required this.message});
  

 final  String message;

/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PartnerDetailErrorCopyWith<PartnerDetailError> get copyWith => _$PartnerDetailErrorCopyWithImpl<PartnerDetailError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PartnerDetailError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PartnerDetailState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $PartnerDetailErrorCopyWith<$Res> implements $PartnerDetailStateCopyWith<$Res> {
  factory $PartnerDetailErrorCopyWith(PartnerDetailError value, $Res Function(PartnerDetailError) _then) = _$PartnerDetailErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$PartnerDetailErrorCopyWithImpl<$Res>
    implements $PartnerDetailErrorCopyWith<$Res> {
  _$PartnerDetailErrorCopyWithImpl(this._self, this._then);

  final PartnerDetailError _self;
  final $Res Function(PartnerDetailError) _then;

/// Create a copy of PartnerDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(PartnerDetailError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
