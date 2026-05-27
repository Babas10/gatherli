// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar_upload_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AvatarUploadState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadState()';
}


}

/// @nodoc
class $AvatarUploadStateCopyWith<$Res>  {
$AvatarUploadStateCopyWith(AvatarUploadState _, $Res Function(AvatarUploadState) __);
}


/// Adds pattern-matching-related methods to [AvatarUploadState].
extension AvatarUploadStatePatterns on AvatarUploadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AvatarUploadInitial value)?  initial,TResult Function( AvatarUploadPicking value)?  picking,TResult Function( AvatarUploadPicked value)?  picked,TResult Function( AvatarUploadValidating value)?  validating,TResult Function( AvatarUploadValidationError value)?  validationError,TResult Function( AvatarUploadUploading value)?  uploading,TResult Function( AvatarUploadUploadSuccess value)?  uploadSuccess,TResult Function( AvatarUploadUploadError value)?  uploadError,TResult Function( AvatarUploadDeleting value)?  deleting,TResult Function( AvatarUploadDeleteSuccess value)?  deleteSuccess,TResult Function( AvatarUploadDeleteError value)?  deleteError,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AvatarUploadInitial() when initial != null:
return initial(_that);case AvatarUploadPicking() when picking != null:
return picking(_that);case AvatarUploadPicked() when picked != null:
return picked(_that);case AvatarUploadValidating() when validating != null:
return validating(_that);case AvatarUploadValidationError() when validationError != null:
return validationError(_that);case AvatarUploadUploading() when uploading != null:
return uploading(_that);case AvatarUploadUploadSuccess() when uploadSuccess != null:
return uploadSuccess(_that);case AvatarUploadUploadError() when uploadError != null:
return uploadError(_that);case AvatarUploadDeleting() when deleting != null:
return deleting(_that);case AvatarUploadDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case AvatarUploadDeleteError() when deleteError != null:
return deleteError(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AvatarUploadInitial value)  initial,required TResult Function( AvatarUploadPicking value)  picking,required TResult Function( AvatarUploadPicked value)  picked,required TResult Function( AvatarUploadValidating value)  validating,required TResult Function( AvatarUploadValidationError value)  validationError,required TResult Function( AvatarUploadUploading value)  uploading,required TResult Function( AvatarUploadUploadSuccess value)  uploadSuccess,required TResult Function( AvatarUploadUploadError value)  uploadError,required TResult Function( AvatarUploadDeleting value)  deleting,required TResult Function( AvatarUploadDeleteSuccess value)  deleteSuccess,required TResult Function( AvatarUploadDeleteError value)  deleteError,}){
final _that = this;
switch (_that) {
case AvatarUploadInitial():
return initial(_that);case AvatarUploadPicking():
return picking(_that);case AvatarUploadPicked():
return picked(_that);case AvatarUploadValidating():
return validating(_that);case AvatarUploadValidationError():
return validationError(_that);case AvatarUploadUploading():
return uploading(_that);case AvatarUploadUploadSuccess():
return uploadSuccess(_that);case AvatarUploadUploadError():
return uploadError(_that);case AvatarUploadDeleting():
return deleting(_that);case AvatarUploadDeleteSuccess():
return deleteSuccess(_that);case AvatarUploadDeleteError():
return deleteError(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AvatarUploadInitial value)?  initial,TResult? Function( AvatarUploadPicking value)?  picking,TResult? Function( AvatarUploadPicked value)?  picked,TResult? Function( AvatarUploadValidating value)?  validating,TResult? Function( AvatarUploadValidationError value)?  validationError,TResult? Function( AvatarUploadUploading value)?  uploading,TResult? Function( AvatarUploadUploadSuccess value)?  uploadSuccess,TResult? Function( AvatarUploadUploadError value)?  uploadError,TResult? Function( AvatarUploadDeleting value)?  deleting,TResult? Function( AvatarUploadDeleteSuccess value)?  deleteSuccess,TResult? Function( AvatarUploadDeleteError value)?  deleteError,}){
final _that = this;
switch (_that) {
case AvatarUploadInitial() when initial != null:
return initial(_that);case AvatarUploadPicking() when picking != null:
return picking(_that);case AvatarUploadPicked() when picked != null:
return picked(_that);case AvatarUploadValidating() when validating != null:
return validating(_that);case AvatarUploadValidationError() when validationError != null:
return validationError(_that);case AvatarUploadUploading() when uploading != null:
return uploading(_that);case AvatarUploadUploadSuccess() when uploadSuccess != null:
return uploadSuccess(_that);case AvatarUploadUploadError() when uploadError != null:
return uploadError(_that);case AvatarUploadDeleting() when deleting != null:
return deleting(_that);case AvatarUploadDeleteSuccess() when deleteSuccess != null:
return deleteSuccess(_that);case AvatarUploadDeleteError() when deleteError != null:
return deleteError(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  picking,TResult Function( File imageFile)?  picked,TResult Function( File imageFile)?  validating,TResult Function( String message)?  validationError,TResult Function( File imageFile,  double progress)?  uploading,TResult Function( String downloadUrl)?  uploadSuccess,TResult Function( String message,  File? imageFile)?  uploadError,TResult Function()?  deleting,TResult Function()?  deleteSuccess,TResult Function( String message)?  deleteError,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AvatarUploadInitial() when initial != null:
return initial();case AvatarUploadPicking() when picking != null:
return picking();case AvatarUploadPicked() when picked != null:
return picked(_that.imageFile);case AvatarUploadValidating() when validating != null:
return validating(_that.imageFile);case AvatarUploadValidationError() when validationError != null:
return validationError(_that.message);case AvatarUploadUploading() when uploading != null:
return uploading(_that.imageFile,_that.progress);case AvatarUploadUploadSuccess() when uploadSuccess != null:
return uploadSuccess(_that.downloadUrl);case AvatarUploadUploadError() when uploadError != null:
return uploadError(_that.message,_that.imageFile);case AvatarUploadDeleting() when deleting != null:
return deleting();case AvatarUploadDeleteSuccess() when deleteSuccess != null:
return deleteSuccess();case AvatarUploadDeleteError() when deleteError != null:
return deleteError(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  picking,required TResult Function( File imageFile)  picked,required TResult Function( File imageFile)  validating,required TResult Function( String message)  validationError,required TResult Function( File imageFile,  double progress)  uploading,required TResult Function( String downloadUrl)  uploadSuccess,required TResult Function( String message,  File? imageFile)  uploadError,required TResult Function()  deleting,required TResult Function()  deleteSuccess,required TResult Function( String message)  deleteError,}) {final _that = this;
switch (_that) {
case AvatarUploadInitial():
return initial();case AvatarUploadPicking():
return picking();case AvatarUploadPicked():
return picked(_that.imageFile);case AvatarUploadValidating():
return validating(_that.imageFile);case AvatarUploadValidationError():
return validationError(_that.message);case AvatarUploadUploading():
return uploading(_that.imageFile,_that.progress);case AvatarUploadUploadSuccess():
return uploadSuccess(_that.downloadUrl);case AvatarUploadUploadError():
return uploadError(_that.message,_that.imageFile);case AvatarUploadDeleting():
return deleting();case AvatarUploadDeleteSuccess():
return deleteSuccess();case AvatarUploadDeleteError():
return deleteError(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  picking,TResult? Function( File imageFile)?  picked,TResult? Function( File imageFile)?  validating,TResult? Function( String message)?  validationError,TResult? Function( File imageFile,  double progress)?  uploading,TResult? Function( String downloadUrl)?  uploadSuccess,TResult? Function( String message,  File? imageFile)?  uploadError,TResult? Function()?  deleting,TResult? Function()?  deleteSuccess,TResult? Function( String message)?  deleteError,}) {final _that = this;
switch (_that) {
case AvatarUploadInitial() when initial != null:
return initial();case AvatarUploadPicking() when picking != null:
return picking();case AvatarUploadPicked() when picked != null:
return picked(_that.imageFile);case AvatarUploadValidating() when validating != null:
return validating(_that.imageFile);case AvatarUploadValidationError() when validationError != null:
return validationError(_that.message);case AvatarUploadUploading() when uploading != null:
return uploading(_that.imageFile,_that.progress);case AvatarUploadUploadSuccess() when uploadSuccess != null:
return uploadSuccess(_that.downloadUrl);case AvatarUploadUploadError() when uploadError != null:
return uploadError(_that.message,_that.imageFile);case AvatarUploadDeleting() when deleting != null:
return deleting();case AvatarUploadDeleteSuccess() when deleteSuccess != null:
return deleteSuccess();case AvatarUploadDeleteError() when deleteError != null:
return deleteError(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class AvatarUploadInitial implements AvatarUploadState {
  const AvatarUploadInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadState.initial()';
}


}




/// @nodoc


class AvatarUploadPicking implements AvatarUploadState {
  const AvatarUploadPicking();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadPicking);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadState.picking()';
}


}




/// @nodoc


class AvatarUploadPicked implements AvatarUploadState {
  const AvatarUploadPicked({required this.imageFile});
  

 final  File imageFile;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadPickedCopyWith<AvatarUploadPicked> get copyWith => _$AvatarUploadPickedCopyWithImpl<AvatarUploadPicked>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadPicked&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile));
}


@override
int get hashCode => Object.hash(runtimeType,imageFile);

@override
String toString() {
  return 'AvatarUploadState.picked(imageFile: $imageFile)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadPickedCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadPickedCopyWith(AvatarUploadPicked value, $Res Function(AvatarUploadPicked) _then) = _$AvatarUploadPickedCopyWithImpl;
@useResult
$Res call({
 File imageFile
});




}
/// @nodoc
class _$AvatarUploadPickedCopyWithImpl<$Res>
    implements $AvatarUploadPickedCopyWith<$Res> {
  _$AvatarUploadPickedCopyWithImpl(this._self, this._then);

  final AvatarUploadPicked _self;
  final $Res Function(AvatarUploadPicked) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageFile = null,}) {
  return _then(AvatarUploadPicked(
imageFile: null == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class AvatarUploadValidating implements AvatarUploadState {
  const AvatarUploadValidating({required this.imageFile});
  

 final  File imageFile;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadValidatingCopyWith<AvatarUploadValidating> get copyWith => _$AvatarUploadValidatingCopyWithImpl<AvatarUploadValidating>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadValidating&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile));
}


@override
int get hashCode => Object.hash(runtimeType,imageFile);

@override
String toString() {
  return 'AvatarUploadState.validating(imageFile: $imageFile)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadValidatingCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadValidatingCopyWith(AvatarUploadValidating value, $Res Function(AvatarUploadValidating) _then) = _$AvatarUploadValidatingCopyWithImpl;
@useResult
$Res call({
 File imageFile
});




}
/// @nodoc
class _$AvatarUploadValidatingCopyWithImpl<$Res>
    implements $AvatarUploadValidatingCopyWith<$Res> {
  _$AvatarUploadValidatingCopyWithImpl(this._self, this._then);

  final AvatarUploadValidating _self;
  final $Res Function(AvatarUploadValidating) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageFile = null,}) {
  return _then(AvatarUploadValidating(
imageFile: null == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File,
  ));
}


}

/// @nodoc


class AvatarUploadValidationError implements AvatarUploadState {
  const AvatarUploadValidationError({required this.message});
  

 final  String message;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadValidationErrorCopyWith<AvatarUploadValidationError> get copyWith => _$AvatarUploadValidationErrorCopyWithImpl<AvatarUploadValidationError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadValidationError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AvatarUploadState.validationError(message: $message)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadValidationErrorCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadValidationErrorCopyWith(AvatarUploadValidationError value, $Res Function(AvatarUploadValidationError) _then) = _$AvatarUploadValidationErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AvatarUploadValidationErrorCopyWithImpl<$Res>
    implements $AvatarUploadValidationErrorCopyWith<$Res> {
  _$AvatarUploadValidationErrorCopyWithImpl(this._self, this._then);

  final AvatarUploadValidationError _self;
  final $Res Function(AvatarUploadValidationError) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AvatarUploadValidationError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AvatarUploadUploading implements AvatarUploadState {
  const AvatarUploadUploading({required this.imageFile, this.progress = 0.0});
  

 final  File imageFile;
@JsonKey() final  double progress;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadUploadingCopyWith<AvatarUploadUploading> get copyWith => _$AvatarUploadUploadingCopyWithImpl<AvatarUploadUploading>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadUploading&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile)&&(identical(other.progress, progress) || other.progress == progress));
}


@override
int get hashCode => Object.hash(runtimeType,imageFile,progress);

@override
String toString() {
  return 'AvatarUploadState.uploading(imageFile: $imageFile, progress: $progress)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadUploadingCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadUploadingCopyWith(AvatarUploadUploading value, $Res Function(AvatarUploadUploading) _then) = _$AvatarUploadUploadingCopyWithImpl;
@useResult
$Res call({
 File imageFile, double progress
});




}
/// @nodoc
class _$AvatarUploadUploadingCopyWithImpl<$Res>
    implements $AvatarUploadUploadingCopyWith<$Res> {
  _$AvatarUploadUploadingCopyWithImpl(this._self, this._then);

  final AvatarUploadUploading _self;
  final $Res Function(AvatarUploadUploading) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? imageFile = null,Object? progress = null,}) {
  return _then(AvatarUploadUploading(
imageFile: null == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

/// @nodoc


class AvatarUploadUploadSuccess implements AvatarUploadState {
  const AvatarUploadUploadSuccess({required this.downloadUrl});
  

 final  String downloadUrl;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadUploadSuccessCopyWith<AvatarUploadUploadSuccess> get copyWith => _$AvatarUploadUploadSuccessCopyWithImpl<AvatarUploadUploadSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadUploadSuccess&&(identical(other.downloadUrl, downloadUrl) || other.downloadUrl == downloadUrl));
}


@override
int get hashCode => Object.hash(runtimeType,downloadUrl);

@override
String toString() {
  return 'AvatarUploadState.uploadSuccess(downloadUrl: $downloadUrl)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadUploadSuccessCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadUploadSuccessCopyWith(AvatarUploadUploadSuccess value, $Res Function(AvatarUploadUploadSuccess) _then) = _$AvatarUploadUploadSuccessCopyWithImpl;
@useResult
$Res call({
 String downloadUrl
});




}
/// @nodoc
class _$AvatarUploadUploadSuccessCopyWithImpl<$Res>
    implements $AvatarUploadUploadSuccessCopyWith<$Res> {
  _$AvatarUploadUploadSuccessCopyWithImpl(this._self, this._then);

  final AvatarUploadUploadSuccess _self;
  final $Res Function(AvatarUploadUploadSuccess) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? downloadUrl = null,}) {
  return _then(AvatarUploadUploadSuccess(
downloadUrl: null == downloadUrl ? _self.downloadUrl : downloadUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class AvatarUploadUploadError implements AvatarUploadState {
  const AvatarUploadUploadError({required this.message, this.imageFile});
  

 final  String message;
 final  File? imageFile;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadUploadErrorCopyWith<AvatarUploadUploadError> get copyWith => _$AvatarUploadUploadErrorCopyWithImpl<AvatarUploadUploadError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadUploadError&&(identical(other.message, message) || other.message == message)&&(identical(other.imageFile, imageFile) || other.imageFile == imageFile));
}


@override
int get hashCode => Object.hash(runtimeType,message,imageFile);

@override
String toString() {
  return 'AvatarUploadState.uploadError(message: $message, imageFile: $imageFile)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadUploadErrorCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadUploadErrorCopyWith(AvatarUploadUploadError value, $Res Function(AvatarUploadUploadError) _then) = _$AvatarUploadUploadErrorCopyWithImpl;
@useResult
$Res call({
 String message, File? imageFile
});




}
/// @nodoc
class _$AvatarUploadUploadErrorCopyWithImpl<$Res>
    implements $AvatarUploadUploadErrorCopyWith<$Res> {
  _$AvatarUploadUploadErrorCopyWithImpl(this._self, this._then);

  final AvatarUploadUploadError _self;
  final $Res Function(AvatarUploadUploadError) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,Object? imageFile = freezed,}) {
  return _then(AvatarUploadUploadError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,imageFile: freezed == imageFile ? _self.imageFile : imageFile // ignore: cast_nullable_to_non_nullable
as File?,
  ));
}


}

/// @nodoc


class AvatarUploadDeleting implements AvatarUploadState {
  const AvatarUploadDeleting();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadDeleting);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadState.deleting()';
}


}




/// @nodoc


class AvatarUploadDeleteSuccess implements AvatarUploadState {
  const AvatarUploadDeleteSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadDeleteSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AvatarUploadState.deleteSuccess()';
}


}




/// @nodoc


class AvatarUploadDeleteError implements AvatarUploadState {
  const AvatarUploadDeleteError({required this.message});
  

 final  String message;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AvatarUploadDeleteErrorCopyWith<AvatarUploadDeleteError> get copyWith => _$AvatarUploadDeleteErrorCopyWithImpl<AvatarUploadDeleteError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AvatarUploadDeleteError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'AvatarUploadState.deleteError(message: $message)';
}


}

/// @nodoc
abstract mixin class $AvatarUploadDeleteErrorCopyWith<$Res> implements $AvatarUploadStateCopyWith<$Res> {
  factory $AvatarUploadDeleteErrorCopyWith(AvatarUploadDeleteError value, $Res Function(AvatarUploadDeleteError) _then) = _$AvatarUploadDeleteErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$AvatarUploadDeleteErrorCopyWithImpl<$Res>
    implements $AvatarUploadDeleteErrorCopyWith<$Res> {
  _$AvatarUploadDeleteErrorCopyWithImpl(this._self, this._then);

  final AvatarUploadDeleteError _self;
  final $Res Function(AvatarUploadDeleteError) _then;

/// Create a copy of AvatarUploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(AvatarUploadDeleteError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
