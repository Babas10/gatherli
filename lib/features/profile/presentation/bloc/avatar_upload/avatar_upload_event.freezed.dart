// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_upload_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvatarUploadEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent()';
}


}

/// @nodoc
class $AvatarUploadEventCopyWith<$Res>  {
$AvatarUploadEventCopyWith(AvatarUploadEvent _, $Res Function(AvatarUploadEvent) __);
}


/// Adds pattern-matching-related methods to [AvatarUploadEvent].
extension AvatarUploadEventPatterns on AvatarUploadEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AvatarUploadStarted value)?  started,TResult Function( AvatarUploadImageSourceSelected value)?  imageSourceSelected,TResult Function( AvatarUploadImagePicked value)?  imagePicked,TResult Function( AvatarUploadUploadRequested value)?  uploadRequested,TResult Function( AvatarUploadUploadCancelled value)?  uploadCancelled,TResult Function( AvatarUploadDeleteRequested value)?  deleteRequested,TResult Function( AvatarUploadReset value)?  reset,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AvatarUploadStarted() when started != null:
return started(_that);case AvatarUploadImageSourceSelected() when imageSourceSelected != null:
return imageSourceSelected(_that);case AvatarUploadImagePicked() when imagePicked != null:
return imagePicked(_that);case AvatarUploadUploadRequested() when uploadRequested != null:
return uploadRequested(_that);case AvatarUploadUploadCancelled() when uploadCancelled != null:
return uploadCancelled(_that);case AvatarUploadDeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case AvatarUploadReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AvatarUploadStarted value)  started,required TResult Function( AvatarUploadImageSourceSelected value)  imageSourceSelected,required TResult Function( AvatarUploadImagePicked value)  imagePicked,required TResult Function( AvatarUploadUploadRequested value)  uploadRequested,required TResult Function( AvatarUploadUploadCancelled value)  uploadCancelled,required TResult Function( AvatarUploadDeleteRequested value)  deleteRequested,required TResult Function( AvatarUploadReset value)  reset,}){
final _that = this;
switch (_that) {
case AvatarUploadStarted():
return started(_that);case AvatarUploadImageSourceSelected():
return imageSourceSelected(_that);case AvatarUploadImagePicked():
return imagePicked(_that);case AvatarUploadUploadRequested():
return uploadRequested(_that);case AvatarUploadUploadCancelled():
return uploadCancelled(_that);case AvatarUploadDeleteRequested():
return deleteRequested(_that);case AvatarUploadReset():
return reset(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AvatarUploadStarted value)?  started,TResult? Function( AvatarUploadImageSourceSelected value)?  imageSourceSelected,TResult? Function( AvatarUploadImagePicked value)?  imagePicked,TResult? Function( AvatarUploadUploadRequested value)?  uploadRequested,TResult? Function( AvatarUploadUploadCancelled value)?  uploadCancelled,TResult? Function( AvatarUploadDeleteRequested value)?  deleteRequested,TResult? Function( AvatarUploadReset value)?  reset,}){
final _that = this;
switch (_that) {
case AvatarUploadStarted() when started != null:
return started(_that);case AvatarUploadImageSourceSelected() when imageSourceSelected != null:
return imageSourceSelected(_that);case AvatarUploadImagePicked() when imagePicked != null:
return imagePicked(_that);case AvatarUploadUploadRequested() when uploadRequested != null:
return uploadRequested(_that);case AvatarUploadUploadCancelled() when uploadCancelled != null:
return uploadCancelled(_that);case AvatarUploadDeleteRequested() when deleteRequested != null:
return deleteRequested(_that);case AvatarUploadReset() when reset != null:
return reset(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( ImageSource source)?  imageSourceSelected,TResult Function( File imageFile)?  imagePicked,TResult Function()?  uploadRequested,TResult Function()?  uploadCancelled,TResult Function()?  deleteRequested,TResult Function()?  reset,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AvatarUploadStarted() when started != null:
return started();case AvatarUploadImageSourceSelected() when imageSourceSelected != null:
return imageSourceSelected(_that.source);case AvatarUploadImagePicked() when imagePicked != null:
return imagePicked(_that.imageFile);case AvatarUploadUploadRequested() when uploadRequested != null:
return uploadRequested();case AvatarUploadUploadCancelled() when uploadCancelled != null:
return uploadCancelled();case AvatarUploadDeleteRequested() when deleteRequested != null:
return deleteRequested();case AvatarUploadReset() when reset != null:
return reset();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( ImageSource source)  imageSourceSelected,required TResult Function( File imageFile)  imagePicked,required TResult Function()  uploadRequested,required TResult Function()  uploadCancelled,required TResult Function()  deleteRequested,required TResult Function()  reset,}) {final _that = this;
switch (_that) {
case AvatarUploadStarted():
return started();case AvatarUploadImageSourceSelected():
return imageSourceSelected(_that.source);case AvatarUploadImagePicked():
return imagePicked(_that.imageFile);case AvatarUploadUploadRequested():
return uploadRequested();case AvatarUploadUploadCancelled():
return uploadCancelled();case AvatarUploadDeleteRequested():
return deleteRequested();case AvatarUploadReset():
return reset();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( ImageSource source)?  imageSourceSelected,TResult? Function( File imageFile)?  imagePicked,TResult? Function()?  uploadRequested,TResult? Function()?  uploadCancelled,TResult? Function()?  deleteRequested,TResult? Function()?  reset,}) {final _that = this;
switch (_that) {
case AvatarUploadStarted() when started != null:
return started();case AvatarUploadImageSourceSelected() when imageSourceSelected != null:
return imageSourceSelected(_that.source);case AvatarUploadImagePicked() when imagePicked != null:
return imagePicked(_that.imageFile);case AvatarUploadUploadRequested() when uploadRequested != null:
return uploadRequested();case AvatarUploadUploadCancelled() when uploadCancelled != null:
return uploadCancelled();case AvatarUploadDeleteRequested() when deleteRequested != null:
return deleteRequested();case AvatarUploadReset() when reset != null:
return reset();case _:
  return null;

}
}

}

/// @nodoc


class AvatarUploadStarted implements AvatarUploadEvent {
  const AvatarUploadStarted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent.started()';
}


}




/// @nodoc


class AvatarUploadImageSourceSelected implements AvatarUploadEvent {
  const AvatarUploadImageSourceSelected({required this.source});
  

 final  ImageSource source;

/// Create a copy of AvatarUploadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadImageSourceSelectedCopyWith<AvatarUploadImageSourceSelected> get copyWith => _$AvatarUploadImageSourceSelectedCopyWithImpl<AvatarUploadImageSourceSelected>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadImageSourceSelected&&(identical(other.source, source) || other.source == source));
}


@override
int get hashCode => Object.hash(runtimeType,source);

@override
String toString() {
  return 'AvatarUploadEvent.imageSourceSelected(source: $source)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadImageSourceSelectedCopyWith<$Res> implements $AvatarUploadEventCopyWith<$Res> {
  factory $AvatarUploadImageSourceSelectedCopyWith(AvatarUploadImageSourceSelected value, $Res Function(AvatarUploadImageSourceSelected) _then) = _$AvatarUploadImageSourceSelectedCopyWithImpl;
@useResult
$Res call({
 ImageSource source
});




}
/// @nodoc
class _$AvatarUploadImageSourceSelectedCopyWithImpl<$Res>
    implements $AvatarUploadImageSourceSelectedCopyWith<$Res> {
  _$AvatarUploadImageSourceSelectedCopyWithImpl(this._self, this._then);

  final AvatarUploadImageSourceSelected _self;
  final $Res Function(AvatarUploadImageSourceSelected) _then;

/// Create a copy of AvatarUploadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? source = null,}) {
  return _then(AvatarUploadImageSourceSelected(
source: null == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as ImageSource,
  ));
}


}

/// @nodoc


class AvatarUploadImagePicked implements AvatarUploadEvent {
  const AvatarUploadImagePicked({required this.imageFile});
  

 final  File imageFile;

/// Create a copy of AvatarUploadEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadImagePickedCopyWith<AvatarUploadImagePicked> get copyWith => _$AvatarUploadImagePickedCopyWithImpl<AvatarUploadImagePicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadImagePicked&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile));
}


@override
int get hashCode => Object.hash(runtimeType,imageFile);

@override
String toString() {
  return 'AvatarUploadEvent.imagePicked(imageFile: $imageFile)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadImagePickedCopyWith<$Res> implements $AvatarUploadEventCopyWith<$Res> {
  factory $AvatarUploadImagePickedCopyWith(AvatarUploadImagePicked value, $Res Function(AvatarUploadImagePicked) _then) = _$AvatarUploadImagePickedCopyWithImpl;
@useResult
$Res call({
 File imageFile
});




}
/// @nodoc
class _$AvatarUploadImagePickedCopyWithImpl<$Res>
    implements $AvatarUploadImagePickedCopyWith<$Res> {
  _$AvatarUploadImagePickedCopyWithImpl(this._self, this._then);

  final AvatarUploadImagePicked _self;
  final $Res Function(AvatarUploadImagePicked) _then;

/// Create a copy of AvatarUploadEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageFile = null,}) {
  return _then(AvatarUploadImagePicked(
imageFile: null == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class AvatarUploadUploadRequested implements AvatarUploadEvent {
  const AvatarUploadUploadRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadUploadRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent.uploadRequested()';
}


}




/// @nodoc


class AvatarUploadUploadCancelled implements AvatarUploadEvent {
  const AvatarUploadUploadCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadUploadCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent.uploadCancelled()';
}


}




/// @nodoc


class AvatarUploadDeleteRequested implements AvatarUploadEvent {
  const AvatarUploadDeleteRequested();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadDeleteRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent.deleteRequested()';
}


}




/// @nodoc


class AvatarUploadReset implements AvatarUploadEvent {
  const AvatarUploadReset();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadReset);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadEvent.reset()';
}


}




// dart format on
