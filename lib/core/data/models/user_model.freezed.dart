// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel {

 String get uid; String get email; String? get displayName; String? get photoUrl; bool get isEmailVerified;@NullableTimestampConverter() DateTime? get createdAt;@NullableTimestampConverter() DateTime? get lastSignInAt;@NullableTimestampConverter() DateTime? get updatedAt;// Account status fields (Story 17.8.2)
@NullableTimestampConverter() DateTime? get emailVerifiedAt; AccountStatus get accountStatus;@NullableTimestampConverter() DateTime? get gracePeriodExpiresAt;@NullableTimestampConverter() DateTime? get deletionScheduledAt;// Extended fields for full user profile
 String? get firstName; String? get lastName; String? get phoneNumber; DateTime? get dateOfBirth; String? get location; String? get bio;// Social graph cache fields (Story 11.6)
 int get friendCount;// User preferences
 bool get notificationsEnabled; bool get emailNotifications; bool get pushNotifications;// Privacy settings
 UserPrivacyLevel get privacyLevel; bool get showEmail; bool get showPhoneNumber;// Stats
 int get gamesPlayed; int get gamesWon; int get gamesLost; int get totalScore; int get currentStreak;@NullableTimestampConverter() DateTime? get lastGameDate; Map<String, dynamic> get teammateStats;// Gender profile (Story 26.1)
 UserGender? get gender;// ELO Rating fields (Story 14.5.3)
 double get eloRating;@NullableTimestampConverter() DateTime? get eloLastUpdated; double get eloPeak;@NullableTimestampConverter() DateTime? get eloPeakDate; int get eloGamesPlayed;// Nemesis/Rival tracking (Story 301.8)
 NemesisRecord? get nemesis;// Best Win tracking (Story 301.6)
 BestWinRecord? get bestWin;// Point Stats tracking (Story 301.7)
 PointStats? get pointStats;// Role-Based Performance tracking (Story 301.9)
 RoleBasedStats? get roleBasedStats;
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserModelCopyWith<UserModel> get copyWith => _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSignInAt, lastSignInAt) || other.lastSignInAt == lastSignInAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.emailVerifiedAt, emailVerifiedAt) || other.emailVerifiedAt == emailVerifiedAt)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.gracePeriodExpiresAt, gracePeriodExpiresAt) || other.gracePeriodExpiresAt == gracePeriodExpiresAt)&&(identical(other.deletionScheduledAt, deletionScheduledAt) || other.deletionScheduledAt == deletionScheduledAt)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.privacyLevel, privacyLevel) || other.privacyLevel == privacyLevel)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showPhoneNumber, showPhoneNumber) || other.showPhoneNumber == showPhoneNumber)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.lastGameDate, lastGameDate) || other.lastGameDate == lastGameDate)&&const DeepCollectionEquality().equals(other.teammateStats, teammateStats)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.eloRating, eloRating) || other.eloRating == eloRating)&&(identical(other.eloLastUpdated, eloLastUpdated) || other.eloLastUpdated == eloLastUpdated)&&(identical(other.eloPeak, eloPeak) || other.eloPeak == eloPeak)&&(identical(other.eloPeakDate, eloPeakDate) || other.eloPeakDate == eloPeakDate)&&(identical(other.eloGamesPlayed, eloGamesPlayed) || other.eloGamesPlayed == eloGamesPlayed)&&(identical(other.nemesis, nemesis) || other.nemesis == nemesis)&&(identical(other.bestWin, bestWin) || other.bestWin == bestWin)&&(identical(other.pointStats, pointStats) || other.pointStats == pointStats)&&(identical(other.roleBasedStats, roleBasedStats) || other.roleBasedStats == roleBasedStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,isEmailVerified,createdAt,lastSignInAt,updatedAt,emailVerifiedAt,accountStatus,gracePeriodExpiresAt,deletionScheduledAt,firstName,lastName,phoneNumber,dateOfBirth,location,bio,friendCount,notificationsEnabled,emailNotifications,pushNotifications,privacyLevel,showEmail,showPhoneNumber,gamesPlayed,gamesWon,gamesLost,totalScore,currentStreak,lastGameDate,const DeepCollectionEquality().hash(teammateStats),gender,eloRating,eloLastUpdated,eloPeak,eloPeakDate,eloGamesPlayed,nemesis,bestWin,pointStats,roleBasedStats]);

@override
String toString() {
  return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, isEmailVerified: $isEmailVerified, createdAt: $createdAt, lastSignInAt: $lastSignInAt, updatedAt: $updatedAt, emailVerifiedAt: $emailVerifiedAt, accountStatus: $accountStatus, gracePeriodExpiresAt: $gracePeriodExpiresAt, deletionScheduledAt: $deletionScheduledAt, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, location: $location, bio: $bio, friendCount: $friendCount, notificationsEnabled: $notificationsEnabled, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, privacyLevel: $privacyLevel, showEmail: $showEmail, showPhoneNumber: $showPhoneNumber, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, totalScore: $totalScore, currentStreak: $currentStreak, lastGameDate: $lastGameDate, teammateStats: $teammateStats, gender: $gender, eloRating: $eloRating, eloLastUpdated: $eloLastUpdated, eloPeak: $eloPeak, eloPeakDate: $eloPeakDate, eloGamesPlayed: $eloGamesPlayed, nemesis: $nemesis, bestWin: $bestWin, pointStats: $pointStats, roleBasedStats: $roleBasedStats)';
}


}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res>  {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) = _$UserModelCopyWithImpl;
@useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, bool isEmailVerified,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? lastSignInAt,@NullableTimestampConverter() DateTime? updatedAt,@NullableTimestampConverter() DateTime? emailVerifiedAt, AccountStatus accountStatus,@NullableTimestampConverter() DateTime? gracePeriodExpiresAt,@NullableTimestampConverter() DateTime? deletionScheduledAt, String? firstName, String? lastName, String? phoneNumber, DateTime? dateOfBirth, String? location, String? bio, int friendCount, bool notificationsEnabled, bool emailNotifications, bool pushNotifications, UserPrivacyLevel privacyLevel, bool showEmail, bool showPhoneNumber, int gamesPlayed, int gamesWon, int gamesLost, int totalScore, int currentStreak,@NullableTimestampConverter() DateTime? lastGameDate, Map<String, dynamic> teammateStats, UserGender? gender, double eloRating,@NullableTimestampConverter() DateTime? eloLastUpdated, double eloPeak,@NullableTimestampConverter() DateTime? eloPeakDate, int eloGamesPlayed, NemesisRecord? nemesis, BestWinRecord? bestWin, PointStats? pointStats, RoleBasedStats? roleBasedStats
});


$NemesisRecordCopyWith<$Res>? get nemesis;$BestWinRecordCopyWith<$Res>? get bestWin;$PointStatsCopyWith<$Res>? get pointStats;$RoleBasedStatsCopyWith<$Res>? get roleBasedStats;

}
/// @nodoc
class _$UserModelCopyWithImpl<$Res>
    implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? isEmailVerified = null,Object? createdAt = freezed,Object? lastSignInAt = freezed,Object? updatedAt = freezed,Object? emailVerifiedAt = freezed,Object? accountStatus = null,Object? gracePeriodExpiresAt = freezed,Object? deletionScheduledAt = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? dateOfBirth = freezed,Object? location = freezed,Object? bio = freezed,Object? friendCount = null,Object? notificationsEnabled = null,Object? emailNotifications = null,Object? pushNotifications = null,Object? privacyLevel = null,Object? showEmail = null,Object? showPhoneNumber = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? totalScore = null,Object? currentStreak = null,Object? lastGameDate = freezed,Object? teammateStats = null,Object? gender = freezed,Object? eloRating = null,Object? eloLastUpdated = freezed,Object? eloPeak = null,Object? eloPeakDate = freezed,Object? eloGamesPlayed = null,Object? nemesis = freezed,Object? bestWin = freezed,Object? pointStats = freezed,Object? roleBasedStats = freezed,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInAt: freezed == lastSignInAt ? _self.lastSignInAt : lastSignInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as AccountStatus,gracePeriodExpiresAt: freezed == gracePeriodExpiresAt ? _self.gracePeriodExpiresAt : gracePeriodExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletionScheduledAt: freezed == deletionScheduledAt ? _self.deletionScheduledAt : deletionScheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,privacyLevel: null == privacyLevel ? _self.privacyLevel : privacyLevel // ignore: cast_nullable_to_non_nullable
as UserPrivacyLevel,showEmail: null == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool,showPhoneNumber: null == showPhoneNumber ? _self.showPhoneNumber : showPhoneNumber // ignore: cast_nullable_to_non_nullable
as bool,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,lastGameDate: freezed == lastGameDate ? _self.lastGameDate : lastGameDate // ignore: cast_nullable_to_non_nullable
as DateTime?,teammateStats: null == teammateStats ? _self.teammateStats : teammateStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as UserGender?,eloRating: null == eloRating ? _self.eloRating : eloRating // ignore: cast_nullable_to_non_nullable
as double,eloLastUpdated: freezed == eloLastUpdated ? _self.eloLastUpdated : eloLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,eloPeak: null == eloPeak ? _self.eloPeak : eloPeak // ignore: cast_nullable_to_non_nullable
as double,eloPeakDate: freezed == eloPeakDate ? _self.eloPeakDate : eloPeakDate // ignore: cast_nullable_to_non_nullable
as DateTime?,eloGamesPlayed: null == eloGamesPlayed ? _self.eloGamesPlayed : eloGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,nemesis: freezed == nemesis ? _self.nemesis : nemesis // ignore: cast_nullable_to_non_nullable
as NemesisRecord?,bestWin: freezed == bestWin ? _self.bestWin : bestWin // ignore: cast_nullable_to_non_nullable
as BestWinRecord?,pointStats: freezed == pointStats ? _self.pointStats : pointStats // ignore: cast_nullable_to_non_nullable
as PointStats?,roleBasedStats: freezed == roleBasedStats ? _self.roleBasedStats : roleBasedStats // ignore: cast_nullable_to_non_nullable
as RoleBasedStats?,
  ));
}
/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NemesisRecordCopyWith<$Res>? get nemesis {
    if (_self.nemesis == null) {
    return null;
  }

  return $NemesisRecordCopyWith<$Res>(_self.nemesis!, (value) {
    return _then(_self.copyWith(nemesis: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BestWinRecordCopyWith<$Res>? get bestWin {
    if (_self.bestWin == null) {
    return null;
  }

  return $BestWinRecordCopyWith<$Res>(_self.bestWin!, (value) {
    return _then(_self.copyWith(bestWin: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointStatsCopyWith<$Res>? get pointStats {
    if (_self.pointStats == null) {
    return null;
  }

  return $PointStatsCopyWith<$Res>(_self.pointStats!, (value) {
    return _then(_self.copyWith(pointStats: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleBasedStatsCopyWith<$Res>? get roleBasedStats {
    if (_self.roleBasedStats == null) {
    return null;
  }

  return $RoleBasedStatsCopyWith<$Res>(_self.roleBasedStats!, (value) {
    return _then(_self.copyWith(roleBasedStats: value));
  });
}
}


/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserModel value)  $default,){
final _that = this;
switch (_that) {
case _UserModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? lastSignInAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? emailVerifiedAt,  AccountStatus accountStatus, @NullableTimestampConverter()  DateTime? gracePeriodExpiresAt, @NullableTimestampConverter()  DateTime? deletionScheduledAt,  String? firstName,  String? lastName,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  int friendCount,  bool notificationsEnabled,  bool emailNotifications,  bool pushNotifications,  UserPrivacyLevel privacyLevel,  bool showEmail,  bool showPhoneNumber,  int gamesPlayed,  int gamesWon,  int gamesLost,  int totalScore,  int currentStreak, @NullableTimestampConverter()  DateTime? lastGameDate,  Map<String, dynamic> teammateStats,  UserGender? gender,  double eloRating, @NullableTimestampConverter()  DateTime? eloLastUpdated,  double eloPeak, @NullableTimestampConverter()  DateTime? eloPeakDate,  int eloGamesPlayed,  NemesisRecord? nemesis,  BestWinRecord? bestWin,  PointStats? pointStats,  RoleBasedStats? roleBasedStats)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.updatedAt,_that.emailVerifiedAt,_that.accountStatus,_that.gracePeriodExpiresAt,_that.deletionScheduledAt,_that.firstName,_that.lastName,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.friendCount,_that.notificationsEnabled,_that.emailNotifications,_that.pushNotifications,_that.privacyLevel,_that.showEmail,_that.showPhoneNumber,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.totalScore,_that.currentStreak,_that.lastGameDate,_that.teammateStats,_that.gender,_that.eloRating,_that.eloLastUpdated,_that.eloPeak,_that.eloPeakDate,_that.eloGamesPlayed,_that.nemesis,_that.bestWin,_that.pointStats,_that.roleBasedStats);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? lastSignInAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? emailVerifiedAt,  AccountStatus accountStatus, @NullableTimestampConverter()  DateTime? gracePeriodExpiresAt, @NullableTimestampConverter()  DateTime? deletionScheduledAt,  String? firstName,  String? lastName,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  int friendCount,  bool notificationsEnabled,  bool emailNotifications,  bool pushNotifications,  UserPrivacyLevel privacyLevel,  bool showEmail,  bool showPhoneNumber,  int gamesPlayed,  int gamesWon,  int gamesLost,  int totalScore,  int currentStreak, @NullableTimestampConverter()  DateTime? lastGameDate,  Map<String, dynamic> teammateStats,  UserGender? gender,  double eloRating, @NullableTimestampConverter()  DateTime? eloLastUpdated,  double eloPeak, @NullableTimestampConverter()  DateTime? eloPeakDate,  int eloGamesPlayed,  NemesisRecord? nemesis,  BestWinRecord? bestWin,  PointStats? pointStats,  RoleBasedStats? roleBasedStats)  $default,) {final _that = this;
switch (_that) {
case _UserModel():
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.updatedAt,_that.emailVerifiedAt,_that.accountStatus,_that.gracePeriodExpiresAt,_that.deletionScheduledAt,_that.firstName,_that.lastName,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.friendCount,_that.notificationsEnabled,_that.emailNotifications,_that.pushNotifications,_that.privacyLevel,_that.showEmail,_that.showPhoneNumber,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.totalScore,_that.currentStreak,_that.lastGameDate,_that.teammateStats,_that.gender,_that.eloRating,_that.eloLastUpdated,_that.eloPeak,_that.eloPeakDate,_that.eloGamesPlayed,_that.nemesis,_that.bestWin,_that.pointStats,_that.roleBasedStats);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  String? displayName,  String? photoUrl,  bool isEmailVerified, @NullableTimestampConverter()  DateTime? createdAt, @NullableTimestampConverter()  DateTime? lastSignInAt, @NullableTimestampConverter()  DateTime? updatedAt, @NullableTimestampConverter()  DateTime? emailVerifiedAt,  AccountStatus accountStatus, @NullableTimestampConverter()  DateTime? gracePeriodExpiresAt, @NullableTimestampConverter()  DateTime? deletionScheduledAt,  String? firstName,  String? lastName,  String? phoneNumber,  DateTime? dateOfBirth,  String? location,  String? bio,  int friendCount,  bool notificationsEnabled,  bool emailNotifications,  bool pushNotifications,  UserPrivacyLevel privacyLevel,  bool showEmail,  bool showPhoneNumber,  int gamesPlayed,  int gamesWon,  int gamesLost,  int totalScore,  int currentStreak, @NullableTimestampConverter()  DateTime? lastGameDate,  Map<String, dynamic> teammateStats,  UserGender? gender,  double eloRating, @NullableTimestampConverter()  DateTime? eloLastUpdated,  double eloPeak, @NullableTimestampConverter()  DateTime? eloPeakDate,  int eloGamesPlayed,  NemesisRecord? nemesis,  BestWinRecord? bestWin,  PointStats? pointStats,  RoleBasedStats? roleBasedStats)?  $default,) {final _that = this;
switch (_that) {
case _UserModel() when $default != null:
return $default(_that.uid,_that.email,_that.displayName,_that.photoUrl,_that.isEmailVerified,_that.createdAt,_that.lastSignInAt,_that.updatedAt,_that.emailVerifiedAt,_that.accountStatus,_that.gracePeriodExpiresAt,_that.deletionScheduledAt,_that.firstName,_that.lastName,_that.phoneNumber,_that.dateOfBirth,_that.location,_that.bio,_that.friendCount,_that.notificationsEnabled,_that.emailNotifications,_that.pushNotifications,_that.privacyLevel,_that.showEmail,_that.showPhoneNumber,_that.gamesPlayed,_that.gamesWon,_that.gamesLost,_that.totalScore,_that.currentStreak,_that.lastGameDate,_that.teammateStats,_that.gender,_that.eloRating,_that.eloLastUpdated,_that.eloPeak,_that.eloPeakDate,_that.eloGamesPlayed,_that.nemesis,_that.bestWin,_that.pointStats,_that.roleBasedStats);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserModel extends UserModel {
  const _UserModel({required this.uid, required this.email, this.displayName, this.photoUrl, this.isEmailVerified = false, @NullableTimestampConverter() this.createdAt, @NullableTimestampConverter() this.lastSignInAt, @NullableTimestampConverter() this.updatedAt, @NullableTimestampConverter() this.emailVerifiedAt, this.accountStatus = AccountStatus.pendingVerification, @NullableTimestampConverter() this.gracePeriodExpiresAt, @NullableTimestampConverter() this.deletionScheduledAt, this.firstName, this.lastName, this.phoneNumber, this.dateOfBirth, this.location, this.bio, this.friendCount = 0, this.notificationsEnabled = true, this.emailNotifications = true, this.pushNotifications = true, this.privacyLevel = UserPrivacyLevel.public, this.showEmail = true, this.showPhoneNumber = true, this.gamesPlayed = 0, this.gamesWon = 0, this.gamesLost = 0, this.totalScore = 0, this.currentStreak = 0, @NullableTimestampConverter() this.lastGameDate, final  Map<String, dynamic> teammateStats = const {}, this.gender, this.eloRating = 1200.0, @NullableTimestampConverter() this.eloLastUpdated, this.eloPeak = 1200.0, @NullableTimestampConverter() this.eloPeakDate, this.eloGamesPlayed = 0, this.nemesis, this.bestWin, this.pointStats, this.roleBasedStats}): _teammateStats = teammateStats,super._();
  factory _UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

@override final  String uid;
@override final  String email;
@override final  String? displayName;
@override final  String? photoUrl;
@override@JsonKey() final  bool isEmailVerified;
@override@NullableTimestampConverter() final  DateTime? createdAt;
@override@NullableTimestampConverter() final  DateTime? lastSignInAt;
@override@NullableTimestampConverter() final  DateTime? updatedAt;
// Account status fields (Story 17.8.2)
@override@NullableTimestampConverter() final  DateTime? emailVerifiedAt;
@override@JsonKey() final  AccountStatus accountStatus;
@override@NullableTimestampConverter() final  DateTime? gracePeriodExpiresAt;
@override@NullableTimestampConverter() final  DateTime? deletionScheduledAt;
// Extended fields for full user profile
@override final  String? firstName;
@override final  String? lastName;
@override final  String? phoneNumber;
@override final  DateTime? dateOfBirth;
@override final  String? location;
@override final  String? bio;
// Social graph cache fields (Story 11.6)
@override@JsonKey() final  int friendCount;
// User preferences
@override@JsonKey() final  bool notificationsEnabled;
@override@JsonKey() final  bool emailNotifications;
@override@JsonKey() final  bool pushNotifications;
// Privacy settings
@override@JsonKey() final  UserPrivacyLevel privacyLevel;
@override@JsonKey() final  bool showEmail;
@override@JsonKey() final  bool showPhoneNumber;
// Stats
@override@JsonKey() final  int gamesPlayed;
@override@JsonKey() final  int gamesWon;
@override@JsonKey() final  int gamesLost;
@override@JsonKey() final  int totalScore;
@override@JsonKey() final  int currentStreak;
@override@NullableTimestampConverter() final  DateTime? lastGameDate;
 final  Map<String, dynamic> _teammateStats;
@override@JsonKey() Map<String, dynamic> get teammateStats {
  if (_teammateStats is EqualUnmodifiableMapView) return _teammateStats;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_teammateStats);
}

// Gender profile (Story 26.1)
@override final  UserGender? gender;
// ELO Rating fields (Story 14.5.3)
@override@JsonKey() final  double eloRating;
@override@NullableTimestampConverter() final  DateTime? eloLastUpdated;
@override@JsonKey() final  double eloPeak;
@override@NullableTimestampConverter() final  DateTime? eloPeakDate;
@override@JsonKey() final  int eloGamesPlayed;
// Nemesis/Rival tracking (Story 301.8)
@override final  NemesisRecord? nemesis;
// Best Win tracking (Story 301.6)
@override final  BestWinRecord? bestWin;
// Point Stats tracking (Story 301.7)
@override final  PointStats? pointStats;
// Role-Based Performance tracking (Story 301.9)
@override final  RoleBasedStats? roleBasedStats;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserModelCopyWith<_UserModel> get copyWith => __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserModel&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.isEmailVerified, isEmailVerified) || other.isEmailVerified == isEmailVerified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastSignInAt, lastSignInAt) || other.lastSignInAt == lastSignInAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.emailVerifiedAt, emailVerifiedAt) || other.emailVerifiedAt == emailVerifiedAt)&&(identical(other.accountStatus, accountStatus) || other.accountStatus == accountStatus)&&(identical(other.gracePeriodExpiresAt, gracePeriodExpiresAt) || other.gracePeriodExpiresAt == gracePeriodExpiresAt)&&(identical(other.deletionScheduledAt, deletionScheduledAt) || other.deletionScheduledAt == deletionScheduledAt)&&(identical(other.firstName, firstName) || other.firstName == firstName)&&(identical(other.lastName, lastName) || other.lastName == lastName)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.location, location) || other.location == location)&&(identical(other.bio, bio) || other.bio == bio)&&(identical(other.friendCount, friendCount) || other.friendCount == friendCount)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.emailNotifications, emailNotifications) || other.emailNotifications == emailNotifications)&&(identical(other.pushNotifications, pushNotifications) || other.pushNotifications == pushNotifications)&&(identical(other.privacyLevel, privacyLevel) || other.privacyLevel == privacyLevel)&&(identical(other.showEmail, showEmail) || other.showEmail == showEmail)&&(identical(other.showPhoneNumber, showPhoneNumber) || other.showPhoneNumber == showPhoneNumber)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.totalScore, totalScore) || other.totalScore == totalScore)&&(identical(other.currentStreak, currentStreak) || other.currentStreak == currentStreak)&&(identical(other.lastGameDate, lastGameDate) || other.lastGameDate == lastGameDate)&&const DeepCollectionEquality().equals(other._teammateStats, _teammateStats)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.eloRating, eloRating) || other.eloRating == eloRating)&&(identical(other.eloLastUpdated, eloLastUpdated) || other.eloLastUpdated == eloLastUpdated)&&(identical(other.eloPeak, eloPeak) || other.eloPeak == eloPeak)&&(identical(other.eloPeakDate, eloPeakDate) || other.eloPeakDate == eloPeakDate)&&(identical(other.eloGamesPlayed, eloGamesPlayed) || other.eloGamesPlayed == eloGamesPlayed)&&(identical(other.nemesis, nemesis) || other.nemesis == nemesis)&&(identical(other.bestWin, bestWin) || other.bestWin == bestWin)&&(identical(other.pointStats, pointStats) || other.pointStats == pointStats)&&(identical(other.roleBasedStats, roleBasedStats) || other.roleBasedStats == roleBasedStats));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,uid,email,displayName,photoUrl,isEmailVerified,createdAt,lastSignInAt,updatedAt,emailVerifiedAt,accountStatus,gracePeriodExpiresAt,deletionScheduledAt,firstName,lastName,phoneNumber,dateOfBirth,location,bio,friendCount,notificationsEnabled,emailNotifications,pushNotifications,privacyLevel,showEmail,showPhoneNumber,gamesPlayed,gamesWon,gamesLost,totalScore,currentStreak,lastGameDate,const DeepCollectionEquality().hash(_teammateStats),gender,eloRating,eloLastUpdated,eloPeak,eloPeakDate,eloGamesPlayed,nemesis,bestWin,pointStats,roleBasedStats]);

@override
String toString() {
  return 'UserModel(uid: $uid, email: $email, displayName: $displayName, photoUrl: $photoUrl, isEmailVerified: $isEmailVerified, createdAt: $createdAt, lastSignInAt: $lastSignInAt, updatedAt: $updatedAt, emailVerifiedAt: $emailVerifiedAt, accountStatus: $accountStatus, gracePeriodExpiresAt: $gracePeriodExpiresAt, deletionScheduledAt: $deletionScheduledAt, firstName: $firstName, lastName: $lastName, phoneNumber: $phoneNumber, dateOfBirth: $dateOfBirth, location: $location, bio: $bio, friendCount: $friendCount, notificationsEnabled: $notificationsEnabled, emailNotifications: $emailNotifications, pushNotifications: $pushNotifications, privacyLevel: $privacyLevel, showEmail: $showEmail, showPhoneNumber: $showPhoneNumber, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, gamesLost: $gamesLost, totalScore: $totalScore, currentStreak: $currentStreak, lastGameDate: $lastGameDate, teammateStats: $teammateStats, gender: $gender, eloRating: $eloRating, eloLastUpdated: $eloLastUpdated, eloPeak: $eloPeak, eloPeakDate: $eloPeakDate, eloGamesPlayed: $eloGamesPlayed, nemesis: $nemesis, bestWin: $bestWin, pointStats: $pointStats, roleBasedStats: $roleBasedStats)';
}


}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(_UserModel value, $Res Function(_UserModel) _then) = __$UserModelCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, String? displayName, String? photoUrl, bool isEmailVerified,@NullableTimestampConverter() DateTime? createdAt,@NullableTimestampConverter() DateTime? lastSignInAt,@NullableTimestampConverter() DateTime? updatedAt,@NullableTimestampConverter() DateTime? emailVerifiedAt, AccountStatus accountStatus,@NullableTimestampConverter() DateTime? gracePeriodExpiresAt,@NullableTimestampConverter() DateTime? deletionScheduledAt, String? firstName, String? lastName, String? phoneNumber, DateTime? dateOfBirth, String? location, String? bio, int friendCount, bool notificationsEnabled, bool emailNotifications, bool pushNotifications, UserPrivacyLevel privacyLevel, bool showEmail, bool showPhoneNumber, int gamesPlayed, int gamesWon, int gamesLost, int totalScore, int currentStreak,@NullableTimestampConverter() DateTime? lastGameDate, Map<String, dynamic> teammateStats, UserGender? gender, double eloRating,@NullableTimestampConverter() DateTime? eloLastUpdated, double eloPeak,@NullableTimestampConverter() DateTime? eloPeakDate, int eloGamesPlayed, NemesisRecord? nemesis, BestWinRecord? bestWin, PointStats? pointStats, RoleBasedStats? roleBasedStats
});


@override $NemesisRecordCopyWith<$Res>? get nemesis;@override $BestWinRecordCopyWith<$Res>? get bestWin;@override $PointStatsCopyWith<$Res>? get pointStats;@override $RoleBasedStatsCopyWith<$Res>? get roleBasedStats;

}
/// @nodoc
class __$UserModelCopyWithImpl<$Res>
    implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? isEmailVerified = null,Object? createdAt = freezed,Object? lastSignInAt = freezed,Object? updatedAt = freezed,Object? emailVerifiedAt = freezed,Object? accountStatus = null,Object? gracePeriodExpiresAt = freezed,Object? deletionScheduledAt = freezed,Object? firstName = freezed,Object? lastName = freezed,Object? phoneNumber = freezed,Object? dateOfBirth = freezed,Object? location = freezed,Object? bio = freezed,Object? friendCount = null,Object? notificationsEnabled = null,Object? emailNotifications = null,Object? pushNotifications = null,Object? privacyLevel = null,Object? showEmail = null,Object? showPhoneNumber = null,Object? gamesPlayed = null,Object? gamesWon = null,Object? gamesLost = null,Object? totalScore = null,Object? currentStreak = null,Object? lastGameDate = freezed,Object? teammateStats = null,Object? gender = freezed,Object? eloRating = null,Object? eloLastUpdated = freezed,Object? eloPeak = null,Object? eloPeakDate = freezed,Object? eloGamesPlayed = null,Object? nemesis = freezed,Object? bestWin = freezed,Object? pointStats = freezed,Object? roleBasedStats = freezed,}) {
  return _then(_UserModel(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,isEmailVerified: null == isEmailVerified ? _self.isEmailVerified : isEmailVerified // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastSignInAt: freezed == lastSignInAt ? _self.lastSignInAt : lastSignInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,emailVerifiedAt: freezed == emailVerifiedAt ? _self.emailVerifiedAt : emailVerifiedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,accountStatus: null == accountStatus ? _self.accountStatus : accountStatus // ignore: cast_nullable_to_non_nullable
as AccountStatus,gracePeriodExpiresAt: freezed == gracePeriodExpiresAt ? _self.gracePeriodExpiresAt : gracePeriodExpiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,deletionScheduledAt: freezed == deletionScheduledAt ? _self.deletionScheduledAt : deletionScheduledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,firstName: freezed == firstName ? _self.firstName : firstName // ignore: cast_nullable_to_non_nullable
as String?,lastName: freezed == lastName ? _self.lastName : lastName // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as DateTime?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,friendCount: null == friendCount ? _self.friendCount : friendCount // ignore: cast_nullable_to_non_nullable
as int,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,emailNotifications: null == emailNotifications ? _self.emailNotifications : emailNotifications // ignore: cast_nullable_to_non_nullable
as bool,pushNotifications: null == pushNotifications ? _self.pushNotifications : pushNotifications // ignore: cast_nullable_to_non_nullable
as bool,privacyLevel: null == privacyLevel ? _self.privacyLevel : privacyLevel // ignore: cast_nullable_to_non_nullable
as UserPrivacyLevel,showEmail: null == showEmail ? _self.showEmail : showEmail // ignore: cast_nullable_to_non_nullable
as bool,showPhoneNumber: null == showPhoneNumber ? _self.showPhoneNumber : showPhoneNumber // ignore: cast_nullable_to_non_nullable
as bool,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,totalScore: null == totalScore ? _self.totalScore : totalScore // ignore: cast_nullable_to_non_nullable
as int,currentStreak: null == currentStreak ? _self.currentStreak : currentStreak // ignore: cast_nullable_to_non_nullable
as int,lastGameDate: freezed == lastGameDate ? _self.lastGameDate : lastGameDate // ignore: cast_nullable_to_non_nullable
as DateTime?,teammateStats: null == teammateStats ? _self._teammateStats : teammateStats // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as UserGender?,eloRating: null == eloRating ? _self.eloRating : eloRating // ignore: cast_nullable_to_non_nullable
as double,eloLastUpdated: freezed == eloLastUpdated ? _self.eloLastUpdated : eloLastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,eloPeak: null == eloPeak ? _self.eloPeak : eloPeak // ignore: cast_nullable_to_non_nullable
as double,eloPeakDate: freezed == eloPeakDate ? _self.eloPeakDate : eloPeakDate // ignore: cast_nullable_to_non_nullable
as DateTime?,eloGamesPlayed: null == eloGamesPlayed ? _self.eloGamesPlayed : eloGamesPlayed // ignore: cast_nullable_to_non_nullable
as int,nemesis: freezed == nemesis ? _self.nemesis : nemesis // ignore: cast_nullable_to_non_nullable
as NemesisRecord?,bestWin: freezed == bestWin ? _self.bestWin : bestWin // ignore: cast_nullable_to_non_nullable
as BestWinRecord?,pointStats: freezed == pointStats ? _self.pointStats : pointStats // ignore: cast_nullable_to_non_nullable
as PointStats?,roleBasedStats: freezed == roleBasedStats ? _self.roleBasedStats : roleBasedStats // ignore: cast_nullable_to_non_nullable
as RoleBasedStats?,
  ));
}

/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NemesisRecordCopyWith<$Res>? get nemesis {
    if (_self.nemesis == null) {
    return null;
  }

  return $NemesisRecordCopyWith<$Res>(_self.nemesis!, (value) {
    return _then(_self.copyWith(nemesis: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BestWinRecordCopyWith<$Res>? get bestWin {
    if (_self.bestWin == null) {
    return null;
  }

  return $BestWinRecordCopyWith<$Res>(_self.bestWin!, (value) {
    return _then(_self.copyWith(bestWin: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PointStatsCopyWith<$Res>? get pointStats {
    if (_self.pointStats == null) {
    return null;
  }

  return $PointStatsCopyWith<$Res>(_self.pointStats!, (value) {
    return _then(_self.copyWith(pointStats: value));
  });
}/// Create a copy of UserModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleBasedStatsCopyWith<$Res>? get roleBasedStats {
    if (_self.roleBasedStats == null) {
    return null;
  }

  return $RoleBasedStatsCopyWith<$Res>(_self.roleBasedStats!, (value) {
    return _then(_self.copyWith(roleBasedStats: value));
  });
}
}


/// @nodoc
mixin _$NemesisRecord {

/// Opponent user ID
 String get opponentId;/// Opponent display name (cached for quick display)
 String get opponentName;/// Total games lost against this opponent
 int get gamesLost;/// Total games won against this opponent
 int get gamesWon;/// Total games played against this opponent (gamesWon + gamesLost)
 int get gamesPlayed;/// Win rate as percentage (0-100)
 double get winRate;
/// Create a copy of NemesisRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NemesisRecordCopyWith<NemesisRecord> get copyWith => _$NemesisRecordCopyWithImpl<NemesisRecord>(this as NemesisRecord, _$identity);

  /// Serializes this NemesisRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NemesisRecord&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.opponentName, opponentName) || other.opponentName == opponentName)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.winRate, winRate) || other.winRate == winRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opponentId,opponentName,gamesLost,gamesWon,gamesPlayed,winRate);

@override
String toString() {
  return 'NemesisRecord(opponentId: $opponentId, opponentName: $opponentName, gamesLost: $gamesLost, gamesWon: $gamesWon, gamesPlayed: $gamesPlayed, winRate: $winRate)';
}


}

/// @nodoc
abstract mixin class $NemesisRecordCopyWith<$Res>  {
  factory $NemesisRecordCopyWith(NemesisRecord value, $Res Function(NemesisRecord) _then) = _$NemesisRecordCopyWithImpl;
@useResult
$Res call({
 String opponentId, String opponentName, int gamesLost, int gamesWon, int gamesPlayed, double winRate
});




}
/// @nodoc
class _$NemesisRecordCopyWithImpl<$Res>
    implements $NemesisRecordCopyWith<$Res> {
  _$NemesisRecordCopyWithImpl(this._self, this._then);

  final NemesisRecord _self;
  final $Res Function(NemesisRecord) _then;

/// Create a copy of NemesisRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opponentId = null,Object? opponentName = null,Object? gamesLost = null,Object? gamesWon = null,Object? gamesPlayed = null,Object? winRate = null,}) {
  return _then(_self.copyWith(
opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,opponentName: null == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [NemesisRecord].
extension NemesisRecordPatterns on NemesisRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NemesisRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NemesisRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NemesisRecord value)  $default,){
final _that = this;
switch (_that) {
case _NemesisRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NemesisRecord value)?  $default,){
final _that = this;
switch (_that) {
case _NemesisRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opponentId,  String opponentName,  int gamesLost,  int gamesWon,  int gamesPlayed,  double winRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NemesisRecord() when $default != null:
return $default(_that.opponentId,_that.opponentName,_that.gamesLost,_that.gamesWon,_that.gamesPlayed,_that.winRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opponentId,  String opponentName,  int gamesLost,  int gamesWon,  int gamesPlayed,  double winRate)  $default,) {final _that = this;
switch (_that) {
case _NemesisRecord():
return $default(_that.opponentId,_that.opponentName,_that.gamesLost,_that.gamesWon,_that.gamesPlayed,_that.winRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opponentId,  String opponentName,  int gamesLost,  int gamesWon,  int gamesPlayed,  double winRate)?  $default,) {final _that = this;
switch (_that) {
case _NemesisRecord() when $default != null:
return $default(_that.opponentId,_that.opponentName,_that.gamesLost,_that.gamesWon,_that.gamesPlayed,_that.winRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NemesisRecord extends NemesisRecord {
  const _NemesisRecord({required this.opponentId, required this.opponentName, required this.gamesLost, required this.gamesWon, required this.gamesPlayed, required this.winRate}): super._();
  factory _NemesisRecord.fromJson(Map<String, dynamic> json) => _$NemesisRecordFromJson(json);

/// Opponent user ID
@override final  String opponentId;
/// Opponent display name (cached for quick display)
@override final  String opponentName;
/// Total games lost against this opponent
@override final  int gamesLost;
/// Total games won against this opponent
@override final  int gamesWon;
/// Total games played against this opponent (gamesWon + gamesLost)
@override final  int gamesPlayed;
/// Win rate as percentage (0-100)
@override final  double winRate;

/// Create a copy of NemesisRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NemesisRecordCopyWith<_NemesisRecord> get copyWith => __$NemesisRecordCopyWithImpl<_NemesisRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NemesisRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NemesisRecord&&(identical(other.opponentId, opponentId) || other.opponentId == opponentId)&&(identical(other.opponentName, opponentName) || other.opponentName == opponentName)&&(identical(other.gamesLost, gamesLost) || other.gamesLost == gamesLost)&&(identical(other.gamesWon, gamesWon) || other.gamesWon == gamesWon)&&(identical(other.gamesPlayed, gamesPlayed) || other.gamesPlayed == gamesPlayed)&&(identical(other.winRate, winRate) || other.winRate == winRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opponentId,opponentName,gamesLost,gamesWon,gamesPlayed,winRate);

@override
String toString() {
  return 'NemesisRecord(opponentId: $opponentId, opponentName: $opponentName, gamesLost: $gamesLost, gamesWon: $gamesWon, gamesPlayed: $gamesPlayed, winRate: $winRate)';
}


}

/// @nodoc
abstract mixin class _$NemesisRecordCopyWith<$Res> implements $NemesisRecordCopyWith<$Res> {
  factory _$NemesisRecordCopyWith(_NemesisRecord value, $Res Function(_NemesisRecord) _then) = __$NemesisRecordCopyWithImpl;
@override @useResult
$Res call({
 String opponentId, String opponentName, int gamesLost, int gamesWon, int gamesPlayed, double winRate
});




}
/// @nodoc
class __$NemesisRecordCopyWithImpl<$Res>
    implements _$NemesisRecordCopyWith<$Res> {
  __$NemesisRecordCopyWithImpl(this._self, this._then);

  final _NemesisRecord _self;
  final $Res Function(_NemesisRecord) _then;

/// Create a copy of NemesisRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opponentId = null,Object? opponentName = null,Object? gamesLost = null,Object? gamesWon = null,Object? gamesPlayed = null,Object? winRate = null,}) {
  return _then(_NemesisRecord(
opponentId: null == opponentId ? _self.opponentId : opponentId // ignore: cast_nullable_to_non_nullable
as String,opponentName: null == opponentName ? _self.opponentName : opponentName // ignore: cast_nullable_to_non_nullable
as String,gamesLost: null == gamesLost ? _self.gamesLost : gamesLost // ignore: cast_nullable_to_non_nullable
as int,gamesWon: null == gamesWon ? _self.gamesWon : gamesWon // ignore: cast_nullable_to_non_nullable
as int,gamesPlayed: null == gamesPlayed ? _self.gamesPlayed : gamesPlayed // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$BestWinRecord {

/// Game ID where this best win occurred
 String get gameId;/// Combined opponent team ELO at time of game
 double get opponentTeamElo;/// Average opponent team ELO at time of game
 double get opponentTeamAvgElo;/// ELO gained from this specific win
 double get eloGained;/// Date when this win occurred
@TimestampConverter() DateTime get date;/// Game title or description for display
 String get gameTitle;/// Opponent team member names (cached for display, joined with " & ")
/// Example: "Alice & Bob" or "John Doe & Jane Smith"
/// Falls back to email if displayName is not available
 String? get opponentNames;
/// Create a copy of BestWinRecord
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BestWinRecordCopyWith<BestWinRecord> get copyWith => _$BestWinRecordCopyWithImpl<BestWinRecord>(this as BestWinRecord, _$identity);

  /// Serializes this BestWinRecord to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BestWinRecord&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.opponentTeamElo, opponentTeamElo) || other.opponentTeamElo == opponentTeamElo)&&(identical(other.opponentTeamAvgElo, opponentTeamAvgElo) || other.opponentTeamAvgElo == opponentTeamAvgElo)&&(identical(other.eloGained, eloGained) || other.eloGained == eloGained)&&(identical(other.date, date) || other.date == date)&&(identical(other.gameTitle, gameTitle) || other.gameTitle == gameTitle)&&(identical(other.opponentNames, opponentNames) || other.opponentNames == opponentNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,opponentTeamElo,opponentTeamAvgElo,eloGained,date,gameTitle,opponentNames);

@override
String toString() {
  return 'BestWinRecord(gameId: $gameId, opponentTeamElo: $opponentTeamElo, opponentTeamAvgElo: $opponentTeamAvgElo, eloGained: $eloGained, date: $date, gameTitle: $gameTitle, opponentNames: $opponentNames)';
}


}

/// @nodoc
abstract mixin class $BestWinRecordCopyWith<$Res>  {
  factory $BestWinRecordCopyWith(BestWinRecord value, $Res Function(BestWinRecord) _then) = _$BestWinRecordCopyWithImpl;
@useResult
$Res call({
 String gameId, double opponentTeamElo, double opponentTeamAvgElo, double eloGained,@TimestampConverter() DateTime date, String gameTitle, String? opponentNames
});




}
/// @nodoc
class _$BestWinRecordCopyWithImpl<$Res>
    implements $BestWinRecordCopyWith<$Res> {
  _$BestWinRecordCopyWithImpl(this._self, this._then);

  final BestWinRecord _self;
  final $Res Function(BestWinRecord) _then;

/// Create a copy of BestWinRecord
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? gameId = null,Object? opponentTeamElo = null,Object? opponentTeamAvgElo = null,Object? eloGained = null,Object? date = null,Object? gameTitle = null,Object? opponentNames = freezed,}) {
  return _then(_self.copyWith(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,opponentTeamElo: null == opponentTeamElo ? _self.opponentTeamElo : opponentTeamElo // ignore: cast_nullable_to_non_nullable
as double,opponentTeamAvgElo: null == opponentTeamAvgElo ? _self.opponentTeamAvgElo : opponentTeamAvgElo // ignore: cast_nullable_to_non_nullable
as double,eloGained: null == eloGained ? _self.eloGained : eloGained // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,gameTitle: null == gameTitle ? _self.gameTitle : gameTitle // ignore: cast_nullable_to_non_nullable
as String,opponentNames: freezed == opponentNames ? _self.opponentNames : opponentNames // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BestWinRecord].
extension BestWinRecordPatterns on BestWinRecord {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BestWinRecord value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BestWinRecord() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BestWinRecord value)  $default,){
final _that = this;
switch (_that) {
case _BestWinRecord():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BestWinRecord value)?  $default,){
final _that = this;
switch (_that) {
case _BestWinRecord() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String gameId,  double opponentTeamElo,  double opponentTeamAvgElo,  double eloGained, @TimestampConverter()  DateTime date,  String gameTitle,  String? opponentNames)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BestWinRecord() when $default != null:
return $default(_that.gameId,_that.opponentTeamElo,_that.opponentTeamAvgElo,_that.eloGained,_that.date,_that.gameTitle,_that.opponentNames);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String gameId,  double opponentTeamElo,  double opponentTeamAvgElo,  double eloGained, @TimestampConverter()  DateTime date,  String gameTitle,  String? opponentNames)  $default,) {final _that = this;
switch (_that) {
case _BestWinRecord():
return $default(_that.gameId,_that.opponentTeamElo,_that.opponentTeamAvgElo,_that.eloGained,_that.date,_that.gameTitle,_that.opponentNames);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String gameId,  double opponentTeamElo,  double opponentTeamAvgElo,  double eloGained, @TimestampConverter()  DateTime date,  String gameTitle,  String? opponentNames)?  $default,) {final _that = this;
switch (_that) {
case _BestWinRecord() when $default != null:
return $default(_that.gameId,_that.opponentTeamElo,_that.opponentTeamAvgElo,_that.eloGained,_that.date,_that.gameTitle,_that.opponentNames);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BestWinRecord extends BestWinRecord {
  const _BestWinRecord({required this.gameId, required this.opponentTeamElo, required this.opponentTeamAvgElo, required this.eloGained, @TimestampConverter() required this.date, required this.gameTitle, this.opponentNames}): super._();
  factory _BestWinRecord.fromJson(Map<String, dynamic> json) => _$BestWinRecordFromJson(json);

/// Game ID where this best win occurred
@override final  String gameId;
/// Combined opponent team ELO at time of game
@override final  double opponentTeamElo;
/// Average opponent team ELO at time of game
@override final  double opponentTeamAvgElo;
/// ELO gained from this specific win
@override final  double eloGained;
/// Date when this win occurred
@override@TimestampConverter() final  DateTime date;
/// Game title or description for display
@override final  String gameTitle;
/// Opponent team member names (cached for display, joined with " & ")
/// Example: "Alice & Bob" or "John Doe & Jane Smith"
/// Falls back to email if displayName is not available
@override final  String? opponentNames;

/// Create a copy of BestWinRecord
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BestWinRecordCopyWith<_BestWinRecord> get copyWith => __$BestWinRecordCopyWithImpl<_BestWinRecord>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BestWinRecordToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BestWinRecord&&(identical(other.gameId, gameId) || other.gameId == gameId)&&(identical(other.opponentTeamElo, opponentTeamElo) || other.opponentTeamElo == opponentTeamElo)&&(identical(other.opponentTeamAvgElo, opponentTeamAvgElo) || other.opponentTeamAvgElo == opponentTeamAvgElo)&&(identical(other.eloGained, eloGained) || other.eloGained == eloGained)&&(identical(other.date, date) || other.date == date)&&(identical(other.gameTitle, gameTitle) || other.gameTitle == gameTitle)&&(identical(other.opponentNames, opponentNames) || other.opponentNames == opponentNames));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,gameId,opponentTeamElo,opponentTeamAvgElo,eloGained,date,gameTitle,opponentNames);

@override
String toString() {
  return 'BestWinRecord(gameId: $gameId, opponentTeamElo: $opponentTeamElo, opponentTeamAvgElo: $opponentTeamAvgElo, eloGained: $eloGained, date: $date, gameTitle: $gameTitle, opponentNames: $opponentNames)';
}


}

/// @nodoc
abstract mixin class _$BestWinRecordCopyWith<$Res> implements $BestWinRecordCopyWith<$Res> {
  factory _$BestWinRecordCopyWith(_BestWinRecord value, $Res Function(_BestWinRecord) _then) = __$BestWinRecordCopyWithImpl;
@override @useResult
$Res call({
 String gameId, double opponentTeamElo, double opponentTeamAvgElo, double eloGained,@TimestampConverter() DateTime date, String gameTitle, String? opponentNames
});




}
/// @nodoc
class __$BestWinRecordCopyWithImpl<$Res>
    implements _$BestWinRecordCopyWith<$Res> {
  __$BestWinRecordCopyWithImpl(this._self, this._then);

  final _BestWinRecord _self;
  final $Res Function(_BestWinRecord) _then;

/// Create a copy of BestWinRecord
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? gameId = null,Object? opponentTeamElo = null,Object? opponentTeamAvgElo = null,Object? eloGained = null,Object? date = null,Object? gameTitle = null,Object? opponentNames = freezed,}) {
  return _then(_BestWinRecord(
gameId: null == gameId ? _self.gameId : gameId // ignore: cast_nullable_to_non_nullable
as String,opponentTeamElo: null == opponentTeamElo ? _self.opponentTeamElo : opponentTeamElo // ignore: cast_nullable_to_non_nullable
as double,opponentTeamAvgElo: null == opponentTeamAvgElo ? _self.opponentTeamAvgElo : opponentTeamAvgElo // ignore: cast_nullable_to_non_nullable
as double,eloGained: null == eloGained ? _self.eloGained : eloGained // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,gameTitle: null == gameTitle ? _self.gameTitle : gameTitle // ignore: cast_nullable_to_non_nullable
as String,opponentNames: freezed == opponentNames ? _self.opponentNames : opponentNames // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$PointStats {

/// Sum of point differentials in winning sets (always positive)
 int get totalDiffInWinningSets;/// Number of sets won by player's team
 int get winningSetsCount;/// Sum of point differentials in losing sets (always negative)
 int get totalDiffInLosingSets;/// Number of sets lost by player's team
 int get losingSetsCount;
/// Create a copy of PointStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PointStatsCopyWith<PointStats> get copyWith => _$PointStatsCopyWithImpl<PointStats>(this as PointStats, _$identity);

  /// Serializes this PointStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PointStats&&(identical(other.totalDiffInWinningSets, totalDiffInWinningSets) || other.totalDiffInWinningSets == totalDiffInWinningSets)&&(identical(other.winningSetsCount, winningSetsCount) || other.winningSetsCount == winningSetsCount)&&(identical(other.totalDiffInLosingSets, totalDiffInLosingSets) || other.totalDiffInLosingSets == totalDiffInLosingSets)&&(identical(other.losingSetsCount, losingSetsCount) || other.losingSetsCount == losingSetsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDiffInWinningSets,winningSetsCount,totalDiffInLosingSets,losingSetsCount);

@override
String toString() {
  return 'PointStats(totalDiffInWinningSets: $totalDiffInWinningSets, winningSetsCount: $winningSetsCount, totalDiffInLosingSets: $totalDiffInLosingSets, losingSetsCount: $losingSetsCount)';
}


}

/// @nodoc
abstract mixin class $PointStatsCopyWith<$Res>  {
  factory $PointStatsCopyWith(PointStats value, $Res Function(PointStats) _then) = _$PointStatsCopyWithImpl;
@useResult
$Res call({
 int totalDiffInWinningSets, int winningSetsCount, int totalDiffInLosingSets, int losingSetsCount
});




}
/// @nodoc
class _$PointStatsCopyWithImpl<$Res>
    implements $PointStatsCopyWith<$Res> {
  _$PointStatsCopyWithImpl(this._self, this._then);

  final PointStats _self;
  final $Res Function(PointStats) _then;

/// Create a copy of PointStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalDiffInWinningSets = null,Object? winningSetsCount = null,Object? totalDiffInLosingSets = null,Object? losingSetsCount = null,}) {
  return _then(_self.copyWith(
totalDiffInWinningSets: null == totalDiffInWinningSets ? _self.totalDiffInWinningSets : totalDiffInWinningSets // ignore: cast_nullable_to_non_nullable
as int,winningSetsCount: null == winningSetsCount ? _self.winningSetsCount : winningSetsCount // ignore: cast_nullable_to_non_nullable
as int,totalDiffInLosingSets: null == totalDiffInLosingSets ? _self.totalDiffInLosingSets : totalDiffInLosingSets // ignore: cast_nullable_to_non_nullable
as int,losingSetsCount: null == losingSetsCount ? _self.losingSetsCount : losingSetsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PointStats].
extension PointStatsPatterns on PointStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PointStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PointStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PointStats value)  $default,){
final _that = this;
switch (_that) {
case _PointStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PointStats value)?  $default,){
final _that = this;
switch (_that) {
case _PointStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalDiffInWinningSets,  int winningSetsCount,  int totalDiffInLosingSets,  int losingSetsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PointStats() when $default != null:
return $default(_that.totalDiffInWinningSets,_that.winningSetsCount,_that.totalDiffInLosingSets,_that.losingSetsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalDiffInWinningSets,  int winningSetsCount,  int totalDiffInLosingSets,  int losingSetsCount)  $default,) {final _that = this;
switch (_that) {
case _PointStats():
return $default(_that.totalDiffInWinningSets,_that.winningSetsCount,_that.totalDiffInLosingSets,_that.losingSetsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalDiffInWinningSets,  int winningSetsCount,  int totalDiffInLosingSets,  int losingSetsCount)?  $default,) {final _that = this;
switch (_that) {
case _PointStats() when $default != null:
return $default(_that.totalDiffInWinningSets,_that.winningSetsCount,_that.totalDiffInLosingSets,_that.losingSetsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PointStats extends PointStats {
  const _PointStats({this.totalDiffInWinningSets = 0, this.winningSetsCount = 0, this.totalDiffInLosingSets = 0, this.losingSetsCount = 0}): super._();
  factory _PointStats.fromJson(Map<String, dynamic> json) => _$PointStatsFromJson(json);

/// Sum of point differentials in winning sets (always positive)
@override@JsonKey() final  int totalDiffInWinningSets;
/// Number of sets won by player's team
@override@JsonKey() final  int winningSetsCount;
/// Sum of point differentials in losing sets (always negative)
@override@JsonKey() final  int totalDiffInLosingSets;
/// Number of sets lost by player's team
@override@JsonKey() final  int losingSetsCount;

/// Create a copy of PointStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PointStatsCopyWith<_PointStats> get copyWith => __$PointStatsCopyWithImpl<_PointStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PointStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PointStats&&(identical(other.totalDiffInWinningSets, totalDiffInWinningSets) || other.totalDiffInWinningSets == totalDiffInWinningSets)&&(identical(other.winningSetsCount, winningSetsCount) || other.winningSetsCount == winningSetsCount)&&(identical(other.totalDiffInLosingSets, totalDiffInLosingSets) || other.totalDiffInLosingSets == totalDiffInLosingSets)&&(identical(other.losingSetsCount, losingSetsCount) || other.losingSetsCount == losingSetsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalDiffInWinningSets,winningSetsCount,totalDiffInLosingSets,losingSetsCount);

@override
String toString() {
  return 'PointStats(totalDiffInWinningSets: $totalDiffInWinningSets, winningSetsCount: $winningSetsCount, totalDiffInLosingSets: $totalDiffInLosingSets, losingSetsCount: $losingSetsCount)';
}


}

/// @nodoc
abstract mixin class _$PointStatsCopyWith<$Res> implements $PointStatsCopyWith<$Res> {
  factory _$PointStatsCopyWith(_PointStats value, $Res Function(_PointStats) _then) = __$PointStatsCopyWithImpl;
@override @useResult
$Res call({
 int totalDiffInWinningSets, int winningSetsCount, int totalDiffInLosingSets, int losingSetsCount
});




}
/// @nodoc
class __$PointStatsCopyWithImpl<$Res>
    implements _$PointStatsCopyWith<$Res> {
  __$PointStatsCopyWithImpl(this._self, this._then);

  final _PointStats _self;
  final $Res Function(_PointStats) _then;

/// Create a copy of PointStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalDiffInWinningSets = null,Object? winningSetsCount = null,Object? totalDiffInLosingSets = null,Object? losingSetsCount = null,}) {
  return _then(_PointStats(
totalDiffInWinningSets: null == totalDiffInWinningSets ? _self.totalDiffInWinningSets : totalDiffInWinningSets // ignore: cast_nullable_to_non_nullable
as int,winningSetsCount: null == winningSetsCount ? _self.winningSetsCount : winningSetsCount // ignore: cast_nullable_to_non_nullable
as int,totalDiffInLosingSets: null == totalDiffInLosingSets ? _self.totalDiffInLosingSets : totalDiffInLosingSets // ignore: cast_nullable_to_non_nullable
as int,losingSetsCount: null == losingSetsCount ? _self.losingSetsCount : losingSetsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$RoleStats {

/// Number of games played in this role
 int get games;/// Number of games won in this role
 int get wins;/// Win rate as decimal (0.0 - 1.0)
 double get winRate;
/// Create a copy of RoleStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<RoleStats> get copyWith => _$RoleStatsCopyWithImpl<RoleStats>(this as RoleStats, _$identity);

  /// Serializes this RoleStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleStats&&(identical(other.games, games) || other.games == games)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.winRate, winRate) || other.winRate == winRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,games,wins,winRate);

@override
String toString() {
  return 'RoleStats(games: $games, wins: $wins, winRate: $winRate)';
}


}

/// @nodoc
abstract mixin class $RoleStatsCopyWith<$Res>  {
  factory $RoleStatsCopyWith(RoleStats value, $Res Function(RoleStats) _then) = _$RoleStatsCopyWithImpl;
@useResult
$Res call({
 int games, int wins, double winRate
});




}
/// @nodoc
class _$RoleStatsCopyWithImpl<$Res>
    implements $RoleStatsCopyWith<$Res> {
  _$RoleStatsCopyWithImpl(this._self, this._then);

  final RoleStats _self;
  final $Res Function(RoleStats) _then;

/// Create a copy of RoleStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? games = null,Object? wins = null,Object? winRate = null,}) {
  return _then(_self.copyWith(
games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [RoleStats].
extension RoleStatsPatterns on RoleStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleStats value)  $default,){
final _that = this;
switch (_that) {
case _RoleStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleStats value)?  $default,){
final _that = this;
switch (_that) {
case _RoleStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int games,  int wins,  double winRate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleStats() when $default != null:
return $default(_that.games,_that.wins,_that.winRate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int games,  int wins,  double winRate)  $default,) {final _that = this;
switch (_that) {
case _RoleStats():
return $default(_that.games,_that.wins,_that.winRate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int games,  int wins,  double winRate)?  $default,) {final _that = this;
switch (_that) {
case _RoleStats() when $default != null:
return $default(_that.games,_that.wins,_that.winRate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleStats extends RoleStats {
  const _RoleStats({this.games = 0, this.wins = 0, this.winRate = 0.0}): super._();
  factory _RoleStats.fromJson(Map<String, dynamic> json) => _$RoleStatsFromJson(json);

/// Number of games played in this role
@override@JsonKey() final  int games;
/// Number of games won in this role
@override@JsonKey() final  int wins;
/// Win rate as decimal (0.0 - 1.0)
@override@JsonKey() final  double winRate;

/// Create a copy of RoleStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleStatsCopyWith<_RoleStats> get copyWith => __$RoleStatsCopyWithImpl<_RoleStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleStats&&(identical(other.games, games) || other.games == games)&&(identical(other.wins, wins) || other.wins == wins)&&(identical(other.winRate, winRate) || other.winRate == winRate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,games,wins,winRate);

@override
String toString() {
  return 'RoleStats(games: $games, wins: $wins, winRate: $winRate)';
}


}

/// @nodoc
abstract mixin class _$RoleStatsCopyWith<$Res> implements $RoleStatsCopyWith<$Res> {
  factory _$RoleStatsCopyWith(_RoleStats value, $Res Function(_RoleStats) _then) = __$RoleStatsCopyWithImpl;
@override @useResult
$Res call({
 int games, int wins, double winRate
});




}
/// @nodoc
class __$RoleStatsCopyWithImpl<$Res>
    implements _$RoleStatsCopyWith<$Res> {
  __$RoleStatsCopyWithImpl(this._self, this._then);

  final _RoleStats _self;
  final $Res Function(_RoleStats) _then;

/// Create a copy of RoleStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? games = null,Object? wins = null,Object? winRate = null,}) {
  return _then(_RoleStats(
games: null == games ? _self.games : games // ignore: cast_nullable_to_non_nullable
as int,wins: null == wins ? _self.wins : wins // ignore: cast_nullable_to_non_nullable
as int,winRate: null == winRate ? _self.winRate : winRate // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$RoleBasedStats {

/// Stats when player is lowest ELO on their team (playing with stronger teammates)
 RoleStats get weakLink;/// Stats when player is highest ELO on their team (leading/carrying the team)
 RoleStats get carry;/// Stats when player is middle ELO or tied (balanced team composition)
 RoleStats get balanced;
/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoleBasedStatsCopyWith<RoleBasedStats> get copyWith => _$RoleBasedStatsCopyWithImpl<RoleBasedStats>(this as RoleBasedStats, _$identity);

  /// Serializes this RoleBasedStats to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoleBasedStats&&(identical(other.weakLink, weakLink) || other.weakLink == weakLink)&&(identical(other.carry, carry) || other.carry == carry)&&(identical(other.balanced, balanced) || other.balanced == balanced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weakLink,carry,balanced);

@override
String toString() {
  return 'RoleBasedStats(weakLink: $weakLink, carry: $carry, balanced: $balanced)';
}


}

/// @nodoc
abstract mixin class $RoleBasedStatsCopyWith<$Res>  {
  factory $RoleBasedStatsCopyWith(RoleBasedStats value, $Res Function(RoleBasedStats) _then) = _$RoleBasedStatsCopyWithImpl;
@useResult
$Res call({
 RoleStats weakLink, RoleStats carry, RoleStats balanced
});


$RoleStatsCopyWith<$Res> get weakLink;$RoleStatsCopyWith<$Res> get carry;$RoleStatsCopyWith<$Res> get balanced;

}
/// @nodoc
class _$RoleBasedStatsCopyWithImpl<$Res>
    implements $RoleBasedStatsCopyWith<$Res> {
  _$RoleBasedStatsCopyWithImpl(this._self, this._then);

  final RoleBasedStats _self;
  final $Res Function(RoleBasedStats) _then;

/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weakLink = null,Object? carry = null,Object? balanced = null,}) {
  return _then(_self.copyWith(
weakLink: null == weakLink ? _self.weakLink : weakLink // ignore: cast_nullable_to_non_nullable
as RoleStats,carry: null == carry ? _self.carry : carry // ignore: cast_nullable_to_non_nullable
as RoleStats,balanced: null == balanced ? _self.balanced : balanced // ignore: cast_nullable_to_non_nullable
as RoleStats,
  ));
}
/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get weakLink {
  
  return $RoleStatsCopyWith<$Res>(_self.weakLink, (value) {
    return _then(_self.copyWith(weakLink: value));
  });
}/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get carry {
  
  return $RoleStatsCopyWith<$Res>(_self.carry, (value) {
    return _then(_self.copyWith(carry: value));
  });
}/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get balanced {
  
  return $RoleStatsCopyWith<$Res>(_self.balanced, (value) {
    return _then(_self.copyWith(balanced: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoleBasedStats].
extension RoleBasedStatsPatterns on RoleBasedStats {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoleBasedStats value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoleBasedStats() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoleBasedStats value)  $default,){
final _that = this;
switch (_that) {
case _RoleBasedStats():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoleBasedStats value)?  $default,){
final _that = this;
switch (_that) {
case _RoleBasedStats() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoleStats weakLink,  RoleStats carry,  RoleStats balanced)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoleBasedStats() when $default != null:
return $default(_that.weakLink,_that.carry,_that.balanced);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoleStats weakLink,  RoleStats carry,  RoleStats balanced)  $default,) {final _that = this;
switch (_that) {
case _RoleBasedStats():
return $default(_that.weakLink,_that.carry,_that.balanced);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoleStats weakLink,  RoleStats carry,  RoleStats balanced)?  $default,) {final _that = this;
switch (_that) {
case _RoleBasedStats() when $default != null:
return $default(_that.weakLink,_that.carry,_that.balanced);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoleBasedStats extends RoleBasedStats {
  const _RoleBasedStats({this.weakLink = const RoleStats(), this.carry = const RoleStats(), this.balanced = const RoleStats()}): super._();
  factory _RoleBasedStats.fromJson(Map<String, dynamic> json) => _$RoleBasedStatsFromJson(json);

/// Stats when player is lowest ELO on their team (playing with stronger teammates)
@override@JsonKey() final  RoleStats weakLink;
/// Stats when player is highest ELO on their team (leading/carrying the team)
@override@JsonKey() final  RoleStats carry;
/// Stats when player is middle ELO or tied (balanced team composition)
@override@JsonKey() final  RoleStats balanced;

/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoleBasedStatsCopyWith<_RoleBasedStats> get copyWith => __$RoleBasedStatsCopyWithImpl<_RoleBasedStats>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoleBasedStatsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoleBasedStats&&(identical(other.weakLink, weakLink) || other.weakLink == weakLink)&&(identical(other.carry, carry) || other.carry == carry)&&(identical(other.balanced, balanced) || other.balanced == balanced));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,weakLink,carry,balanced);

@override
String toString() {
  return 'RoleBasedStats(weakLink: $weakLink, carry: $carry, balanced: $balanced)';
}


}

/// @nodoc
abstract mixin class _$RoleBasedStatsCopyWith<$Res> implements $RoleBasedStatsCopyWith<$Res> {
  factory _$RoleBasedStatsCopyWith(_RoleBasedStats value, $Res Function(_RoleBasedStats) _then) = __$RoleBasedStatsCopyWithImpl;
@override @useResult
$Res call({
 RoleStats weakLink, RoleStats carry, RoleStats balanced
});


@override $RoleStatsCopyWith<$Res> get weakLink;@override $RoleStatsCopyWith<$Res> get carry;@override $RoleStatsCopyWith<$Res> get balanced;

}
/// @nodoc
class __$RoleBasedStatsCopyWithImpl<$Res>
    implements _$RoleBasedStatsCopyWith<$Res> {
  __$RoleBasedStatsCopyWithImpl(this._self, this._then);

  final _RoleBasedStats _self;
  final $Res Function(_RoleBasedStats) _then;

/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weakLink = null,Object? carry = null,Object? balanced = null,}) {
  return _then(_RoleBasedStats(
weakLink: null == weakLink ? _self.weakLink : weakLink // ignore: cast_nullable_to_non_nullable
as RoleStats,carry: null == carry ? _self.carry : carry // ignore: cast_nullable_to_non_nullable
as RoleStats,balanced: null == balanced ? _self.balanced : balanced // ignore: cast_nullable_to_non_nullable
as RoleStats,
  ));
}

/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get weakLink {
  
  return $RoleStatsCopyWith<$Res>(_self.weakLink, (value) {
    return _then(_self.copyWith(weakLink: value));
  });
}/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get carry {
  
  return $RoleStatsCopyWith<$Res>(_self.carry, (value) {
    return _then(_self.copyWith(carry: value));
  });
}/// Create a copy of RoleBasedStats
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoleStatsCopyWith<$Res> get balanced {
  
  return $RoleStatsCopyWith<$Res>(_self.balanced, (value) {
    return _then(_self.copyWith(balanced: value));
  });
}
}

// dart format on
