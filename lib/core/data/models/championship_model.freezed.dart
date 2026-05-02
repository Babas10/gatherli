// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'championship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ChampionshipModel _$ChampionshipModelFromJson(Map<String, dynamic> json) {
  return _ChampionshipModel.fromJson(json);
}

/// @nodoc
mixin _$ChampionshipModel {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  ChampionshipStatus get status => throw _privateConstructorUsedError;
  int get maxTeams => throw _privateConstructorUsedError;
  int get teamSize => throw _privateConstructorUsedError;
  List<String> get adminIds => throw _privateConstructorUsedError;
  String get createdBy => throw _privateConstructorUsedError;
  @ChampionshipTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @ChampionshipTimestampConverter()
  DateTime get registrationDeadline => throw _privateConstructorUsedError;
  int get currentRound =>
      throw _privateConstructorUsedError; // totalRounds = maxTeams - 1 (single round-robin)
  int get totalRounds => throw _privateConstructorUsedError;
  @ChampionshipNullableTimestampConverter()
  DateTime? get startDate => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get region => throw _privateConstructorUsedError;

  /// Serializes this ChampionshipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChampionshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChampionshipModelCopyWith<ChampionshipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChampionshipModelCopyWith<$Res> {
  factory $ChampionshipModelCopyWith(
    ChampionshipModel value,
    $Res Function(ChampionshipModel) then,
  ) = _$ChampionshipModelCopyWithImpl<$Res, ChampionshipModel>;
  @useResult
  $Res call({
    String id,
    String title,
    ChampionshipStatus status,
    int maxTeams,
    int teamSize,
    List<String> adminIds,
    String createdBy,
    @ChampionshipTimestampConverter() DateTime createdAt,
    @ChampionshipTimestampConverter() DateTime registrationDeadline,
    int currentRound,
    int totalRounds,
    @ChampionshipNullableTimestampConverter() DateTime? startDate,
    String? country,
    String? region,
  });
}

/// @nodoc
class _$ChampionshipModelCopyWithImpl<$Res, $Val extends ChampionshipModel>
    implements $ChampionshipModelCopyWith<$Res> {
  _$ChampionshipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChampionshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? status = null,
    Object? maxTeams = null,
    Object? teamSize = null,
    Object? adminIds = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? registrationDeadline = null,
    Object? currentRound = null,
    Object? totalRounds = null,
    Object? startDate = freezed,
    Object? country = freezed,
    Object? region = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as ChampionshipStatus,
            maxTeams: null == maxTeams
                ? _value.maxTeams
                : maxTeams // ignore: cast_nullable_to_non_nullable
                      as int,
            teamSize: null == teamSize
                ? _value.teamSize
                : teamSize // ignore: cast_nullable_to_non_nullable
                      as int,
            adminIds: null == adminIds
                ? _value.adminIds
                : adminIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdBy: null == createdBy
                ? _value.createdBy
                : createdBy // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            registrationDeadline: null == registrationDeadline
                ? _value.registrationDeadline
                : registrationDeadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            currentRound: null == currentRound
                ? _value.currentRound
                : currentRound // ignore: cast_nullable_to_non_nullable
                      as int,
            totalRounds: null == totalRounds
                ? _value.totalRounds
                : totalRounds // ignore: cast_nullable_to_non_nullable
                      as int,
            startDate: freezed == startDate
                ? _value.startDate
                : startDate // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            country: freezed == country
                ? _value.country
                : country // ignore: cast_nullable_to_non_nullable
                      as String?,
            region: freezed == region
                ? _value.region
                : region // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChampionshipModelImplCopyWith<$Res>
    implements $ChampionshipModelCopyWith<$Res> {
  factory _$$ChampionshipModelImplCopyWith(
    _$ChampionshipModelImpl value,
    $Res Function(_$ChampionshipModelImpl) then,
  ) = __$$ChampionshipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String title,
    ChampionshipStatus status,
    int maxTeams,
    int teamSize,
    List<String> adminIds,
    String createdBy,
    @ChampionshipTimestampConverter() DateTime createdAt,
    @ChampionshipTimestampConverter() DateTime registrationDeadline,
    int currentRound,
    int totalRounds,
    @ChampionshipNullableTimestampConverter() DateTime? startDate,
    String? country,
    String? region,
  });
}

/// @nodoc
class __$$ChampionshipModelImplCopyWithImpl<$Res>
    extends _$ChampionshipModelCopyWithImpl<$Res, _$ChampionshipModelImpl>
    implements _$$ChampionshipModelImplCopyWith<$Res> {
  __$$ChampionshipModelImplCopyWithImpl(
    _$ChampionshipModelImpl _value,
    $Res Function(_$ChampionshipModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChampionshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? status = null,
    Object? maxTeams = null,
    Object? teamSize = null,
    Object? adminIds = null,
    Object? createdBy = null,
    Object? createdAt = null,
    Object? registrationDeadline = null,
    Object? currentRound = null,
    Object? totalRounds = null,
    Object? startDate = freezed,
    Object? country = freezed,
    Object? region = freezed,
  }) {
    return _then(
      _$ChampionshipModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as ChampionshipStatus,
        maxTeams: null == maxTeams
            ? _value.maxTeams
            : maxTeams // ignore: cast_nullable_to_non_nullable
                  as int,
        teamSize: null == teamSize
            ? _value.teamSize
            : teamSize // ignore: cast_nullable_to_non_nullable
                  as int,
        adminIds: null == adminIds
            ? _value._adminIds
            : adminIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdBy: null == createdBy
            ? _value.createdBy
            : createdBy // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        registrationDeadline: null == registrationDeadline
            ? _value.registrationDeadline
            : registrationDeadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        currentRound: null == currentRound
            ? _value.currentRound
            : currentRound // ignore: cast_nullable_to_non_nullable
                  as int,
        totalRounds: null == totalRounds
            ? _value.totalRounds
            : totalRounds // ignore: cast_nullable_to_non_nullable
                  as int,
        startDate: freezed == startDate
            ? _value.startDate
            : startDate // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        country: freezed == country
            ? _value.country
            : country // ignore: cast_nullable_to_non_nullable
                  as String?,
        region: freezed == region
            ? _value.region
            : region // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChampionshipModelImpl extends _ChampionshipModel {
  const _$ChampionshipModelImpl({
    required this.id,
    required this.title,
    this.status = ChampionshipStatus.registration,
    this.maxTeams = 10,
    this.teamSize = 2,
    final List<String> adminIds = const [],
    required this.createdBy,
    @ChampionshipTimestampConverter() required this.createdAt,
    @ChampionshipTimestampConverter() required this.registrationDeadline,
    this.currentRound = 0,
    required this.totalRounds,
    @ChampionshipNullableTimestampConverter() this.startDate,
    this.country,
    this.region,
  }) : _adminIds = adminIds,
       super._();

  factory _$ChampionshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChampionshipModelImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  @JsonKey()
  final ChampionshipStatus status;
  @override
  @JsonKey()
  final int maxTeams;
  @override
  @JsonKey()
  final int teamSize;
  final List<String> _adminIds;
  @override
  @JsonKey()
  List<String> get adminIds {
    if (_adminIds is EqualUnmodifiableListView) return _adminIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_adminIds);
  }

  @override
  final String createdBy;
  @override
  @ChampionshipTimestampConverter()
  final DateTime createdAt;
  @override
  @ChampionshipTimestampConverter()
  final DateTime registrationDeadline;
  @override
  @JsonKey()
  final int currentRound;
  // totalRounds = maxTeams - 1 (single round-robin)
  @override
  final int totalRounds;
  @override
  @ChampionshipNullableTimestampConverter()
  final DateTime? startDate;
  @override
  final String? country;
  @override
  final String? region;

  @override
  String toString() {
    return 'ChampionshipModel(id: $id, title: $title, status: $status, maxTeams: $maxTeams, teamSize: $teamSize, adminIds: $adminIds, createdBy: $createdBy, createdAt: $createdAt, registrationDeadline: $registrationDeadline, currentRound: $currentRound, totalRounds: $totalRounds, startDate: $startDate, country: $country, region: $region)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChampionshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.maxTeams, maxTeams) ||
                other.maxTeams == maxTeams) &&
            (identical(other.teamSize, teamSize) ||
                other.teamSize == teamSize) &&
            const DeepCollectionEquality().equals(other._adminIds, _adminIds) &&
            (identical(other.createdBy, createdBy) ||
                other.createdBy == createdBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.registrationDeadline, registrationDeadline) ||
                other.registrationDeadline == registrationDeadline) &&
            (identical(other.currentRound, currentRound) ||
                other.currentRound == currentRound) &&
            (identical(other.totalRounds, totalRounds) ||
                other.totalRounds == totalRounds) &&
            (identical(other.startDate, startDate) ||
                other.startDate == startDate) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.region, region) || other.region == region));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    title,
    status,
    maxTeams,
    teamSize,
    const DeepCollectionEquality().hash(_adminIds),
    createdBy,
    createdAt,
    registrationDeadline,
    currentRound,
    totalRounds,
    startDate,
    country,
    region,
  );

  /// Create a copy of ChampionshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChampionshipModelImplCopyWith<_$ChampionshipModelImpl> get copyWith =>
      __$$ChampionshipModelImplCopyWithImpl<_$ChampionshipModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChampionshipModelImplToJson(this);
  }
}

abstract class _ChampionshipModel extends ChampionshipModel {
  const factory _ChampionshipModel({
    required final String id,
    required final String title,
    final ChampionshipStatus status,
    final int maxTeams,
    final int teamSize,
    final List<String> adminIds,
    required final String createdBy,
    @ChampionshipTimestampConverter() required final DateTime createdAt,
    @ChampionshipTimestampConverter()
    required final DateTime registrationDeadline,
    final int currentRound,
    required final int totalRounds,
    @ChampionshipNullableTimestampConverter() final DateTime? startDate,
    final String? country,
    final String? region,
  }) = _$ChampionshipModelImpl;
  const _ChampionshipModel._() : super._();

  factory _ChampionshipModel.fromJson(Map<String, dynamic> json) =
      _$ChampionshipModelImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  ChampionshipStatus get status;
  @override
  int get maxTeams;
  @override
  int get teamSize;
  @override
  List<String> get adminIds;
  @override
  String get createdBy;
  @override
  @ChampionshipTimestampConverter()
  DateTime get createdAt;
  @override
  @ChampionshipTimestampConverter()
  DateTime get registrationDeadline;
  @override
  int get currentRound; // totalRounds = maxTeams - 1 (single round-robin)
  @override
  int get totalRounds;
  @override
  @ChampionshipNullableTimestampConverter()
  DateTime? get startDate;
  @override
  String? get country;
  @override
  String? get region;

  /// Create a copy of ChampionshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChampionshipModelImplCopyWith<_$ChampionshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChampionshipTeamModel _$ChampionshipTeamModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChampionshipTeamModel.fromJson(json);
}

/// @nodoc
mixin _$ChampionshipTeamModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get captainId => throw _privateConstructorUsedError;
  List<String> get memberIds => throw _privateConstructorUsedError; // exactly 2
  @ChampionshipTimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Serializes this ChampionshipTeamModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChampionshipTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChampionshipTeamModelCopyWith<ChampionshipTeamModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChampionshipTeamModelCopyWith<$Res> {
  factory $ChampionshipTeamModelCopyWith(
    ChampionshipTeamModel value,
    $Res Function(ChampionshipTeamModel) then,
  ) = _$ChampionshipTeamModelCopyWithImpl<$Res, ChampionshipTeamModel>;
  @useResult
  $Res call({
    String id,
    String name,
    String captainId,
    List<String> memberIds,
    @ChampionshipTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class _$ChampionshipTeamModelCopyWithImpl<
  $Res,
  $Val extends ChampionshipTeamModel
>
    implements $ChampionshipTeamModelCopyWith<$Res> {
  _$ChampionshipTeamModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChampionshipTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? captainId = null,
    Object? memberIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            captainId: null == captainId
                ? _value.captainId
                : captainId // ignore: cast_nullable_to_non_nullable
                      as String,
            memberIds: null == memberIds
                ? _value.memberIds
                : memberIds // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChampionshipTeamModelImplCopyWith<$Res>
    implements $ChampionshipTeamModelCopyWith<$Res> {
  factory _$$ChampionshipTeamModelImplCopyWith(
    _$ChampionshipTeamModelImpl value,
    $Res Function(_$ChampionshipTeamModelImpl) then,
  ) = __$$ChampionshipTeamModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String captainId,
    List<String> memberIds,
    @ChampionshipTimestampConverter() DateTime createdAt,
  });
}

/// @nodoc
class __$$ChampionshipTeamModelImplCopyWithImpl<$Res>
    extends
        _$ChampionshipTeamModelCopyWithImpl<$Res, _$ChampionshipTeamModelImpl>
    implements _$$ChampionshipTeamModelImplCopyWith<$Res> {
  __$$ChampionshipTeamModelImplCopyWithImpl(
    _$ChampionshipTeamModelImpl _value,
    $Res Function(_$ChampionshipTeamModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChampionshipTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? captainId = null,
    Object? memberIds = null,
    Object? createdAt = null,
  }) {
    return _then(
      _$ChampionshipTeamModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        captainId: null == captainId
            ? _value.captainId
            : captainId // ignore: cast_nullable_to_non_nullable
                  as String,
        memberIds: null == memberIds
            ? _value._memberIds
            : memberIds // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChampionshipTeamModelImpl extends _ChampionshipTeamModel {
  const _$ChampionshipTeamModelImpl({
    required this.id,
    required this.name,
    required this.captainId,
    required final List<String> memberIds,
    @ChampionshipTimestampConverter() required this.createdAt,
  }) : _memberIds = memberIds,
       super._();

  factory _$ChampionshipTeamModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChampionshipTeamModelImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String captainId;
  final List<String> _memberIds;
  @override
  List<String> get memberIds {
    if (_memberIds is EqualUnmodifiableListView) return _memberIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_memberIds);
  }

  // exactly 2
  @override
  @ChampionshipTimestampConverter()
  final DateTime createdAt;

  @override
  String toString() {
    return 'ChampionshipTeamModel(id: $id, name: $name, captainId: $captainId, memberIds: $memberIds, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChampionshipTeamModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.captainId, captainId) ||
                other.captainId == captainId) &&
            const DeepCollectionEquality().equals(
              other._memberIds,
              _memberIds,
            ) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    captainId,
    const DeepCollectionEquality().hash(_memberIds),
    createdAt,
  );

  /// Create a copy of ChampionshipTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChampionshipTeamModelImplCopyWith<_$ChampionshipTeamModelImpl>
  get copyWith =>
      __$$ChampionshipTeamModelImplCopyWithImpl<_$ChampionshipTeamModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChampionshipTeamModelImplToJson(this);
  }
}

abstract class _ChampionshipTeamModel extends ChampionshipTeamModel {
  const factory _ChampionshipTeamModel({
    required final String id,
    required final String name,
    required final String captainId,
    required final List<String> memberIds,
    @ChampionshipTimestampConverter() required final DateTime createdAt,
  }) = _$ChampionshipTeamModelImpl;
  const _ChampionshipTeamModel._() : super._();

  factory _ChampionshipTeamModel.fromJson(Map<String, dynamic> json) =
      _$ChampionshipTeamModelImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get captainId;
  @override
  List<String> get memberIds; // exactly 2
  @override
  @ChampionshipTimestampConverter()
  DateTime get createdAt;

  /// Create a copy of ChampionshipTeamModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChampionshipTeamModelImplCopyWith<_$ChampionshipTeamModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

MatchSetScore _$MatchSetScoreFromJson(Map<String, dynamic> json) {
  return _MatchSetScore.fromJson(json);
}

/// @nodoc
mixin _$MatchSetScore {
  int get setNumber => throw _privateConstructorUsedError;
  int get teamAPoints => throw _privateConstructorUsedError;
  int get teamBPoints => throw _privateConstructorUsedError;

  /// Serializes this MatchSetScore to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchSetScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchSetScoreCopyWith<MatchSetScore> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchSetScoreCopyWith<$Res> {
  factory $MatchSetScoreCopyWith(
    MatchSetScore value,
    $Res Function(MatchSetScore) then,
  ) = _$MatchSetScoreCopyWithImpl<$Res, MatchSetScore>;
  @useResult
  $Res call({int setNumber, int teamAPoints, int teamBPoints});
}

/// @nodoc
class _$MatchSetScoreCopyWithImpl<$Res, $Val extends MatchSetScore>
    implements $MatchSetScoreCopyWith<$Res> {
  _$MatchSetScoreCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchSetScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setNumber = null,
    Object? teamAPoints = null,
    Object? teamBPoints = null,
  }) {
    return _then(
      _value.copyWith(
            setNumber: null == setNumber
                ? _value.setNumber
                : setNumber // ignore: cast_nullable_to_non_nullable
                      as int,
            teamAPoints: null == teamAPoints
                ? _value.teamAPoints
                : teamAPoints // ignore: cast_nullable_to_non_nullable
                      as int,
            teamBPoints: null == teamBPoints
                ? _value.teamBPoints
                : teamBPoints // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MatchSetScoreImplCopyWith<$Res>
    implements $MatchSetScoreCopyWith<$Res> {
  factory _$$MatchSetScoreImplCopyWith(
    _$MatchSetScoreImpl value,
    $Res Function(_$MatchSetScoreImpl) then,
  ) = __$$MatchSetScoreImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int setNumber, int teamAPoints, int teamBPoints});
}

/// @nodoc
class __$$MatchSetScoreImplCopyWithImpl<$Res>
    extends _$MatchSetScoreCopyWithImpl<$Res, _$MatchSetScoreImpl>
    implements _$$MatchSetScoreImplCopyWith<$Res> {
  __$$MatchSetScoreImplCopyWithImpl(
    _$MatchSetScoreImpl _value,
    $Res Function(_$MatchSetScoreImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchSetScore
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? setNumber = null,
    Object? teamAPoints = null,
    Object? teamBPoints = null,
  }) {
    return _then(
      _$MatchSetScoreImpl(
        setNumber: null == setNumber
            ? _value.setNumber
            : setNumber // ignore: cast_nullable_to_non_nullable
                  as int,
        teamAPoints: null == teamAPoints
            ? _value.teamAPoints
            : teamAPoints // ignore: cast_nullable_to_non_nullable
                  as int,
        teamBPoints: null == teamBPoints
            ? _value.teamBPoints
            : teamBPoints // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchSetScoreImpl extends _MatchSetScore {
  const _$MatchSetScoreImpl({
    required this.setNumber,
    required this.teamAPoints,
    required this.teamBPoints,
  }) : super._();

  factory _$MatchSetScoreImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchSetScoreImplFromJson(json);

  @override
  final int setNumber;
  @override
  final int teamAPoints;
  @override
  final int teamBPoints;

  @override
  String toString() {
    return 'MatchSetScore(setNumber: $setNumber, teamAPoints: $teamAPoints, teamBPoints: $teamBPoints)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchSetScoreImpl &&
            (identical(other.setNumber, setNumber) ||
                other.setNumber == setNumber) &&
            (identical(other.teamAPoints, teamAPoints) ||
                other.teamAPoints == teamAPoints) &&
            (identical(other.teamBPoints, teamBPoints) ||
                other.teamBPoints == teamBPoints));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, setNumber, teamAPoints, teamBPoints);

  /// Create a copy of MatchSetScore
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchSetScoreImplCopyWith<_$MatchSetScoreImpl> get copyWith =>
      __$$MatchSetScoreImplCopyWithImpl<_$MatchSetScoreImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchSetScoreImplToJson(this);
  }
}

abstract class _MatchSetScore extends MatchSetScore {
  const factory _MatchSetScore({
    required final int setNumber,
    required final int teamAPoints,
    required final int teamBPoints,
  }) = _$MatchSetScoreImpl;
  const _MatchSetScore._() : super._();

  factory _MatchSetScore.fromJson(Map<String, dynamic> json) =
      _$MatchSetScoreImpl.fromJson;

  @override
  int get setNumber;
  @override
  int get teamAPoints;
  @override
  int get teamBPoints;

  /// Create a copy of MatchSetScore
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchSetScoreImplCopyWith<_$MatchSetScoreImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MatchResult _$MatchResultFromJson(Map<String, dynamic> json) {
  return _MatchResult.fromJson(json);
}

/// @nodoc
mixin _$MatchResult {
  @MatchSetScoreListConverter()
  List<MatchSetScore> get sets => throw _privateConstructorUsedError;
  String get winner => throw _privateConstructorUsedError;

  /// Serializes this MatchResult to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MatchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MatchResultCopyWith<MatchResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MatchResultCopyWith<$Res> {
  factory $MatchResultCopyWith(
    MatchResult value,
    $Res Function(MatchResult) then,
  ) = _$MatchResultCopyWithImpl<$Res, MatchResult>;
  @useResult
  $Res call({
    @MatchSetScoreListConverter() List<MatchSetScore> sets,
    String winner,
  });
}

/// @nodoc
class _$MatchResultCopyWithImpl<$Res, $Val extends MatchResult>
    implements $MatchResultCopyWith<$Res> {
  _$MatchResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MatchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sets = null, Object? winner = null}) {
    return _then(
      _value.copyWith(
            sets: null == sets
                ? _value.sets
                : sets // ignore: cast_nullable_to_non_nullable
                      as List<MatchSetScore>,
            winner: null == winner
                ? _value.winner
                : winner // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MatchResultImplCopyWith<$Res>
    implements $MatchResultCopyWith<$Res> {
  factory _$$MatchResultImplCopyWith(
    _$MatchResultImpl value,
    $Res Function(_$MatchResultImpl) then,
  ) = __$$MatchResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @MatchSetScoreListConverter() List<MatchSetScore> sets,
    String winner,
  });
}

/// @nodoc
class __$$MatchResultImplCopyWithImpl<$Res>
    extends _$MatchResultCopyWithImpl<$Res, _$MatchResultImpl>
    implements _$$MatchResultImplCopyWith<$Res> {
  __$$MatchResultImplCopyWithImpl(
    _$MatchResultImpl _value,
    $Res Function(_$MatchResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MatchResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? sets = null, Object? winner = null}) {
    return _then(
      _$MatchResultImpl(
        sets: null == sets
            ? _value._sets
            : sets // ignore: cast_nullable_to_non_nullable
                  as List<MatchSetScore>,
        winner: null == winner
            ? _value.winner
            : winner // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MatchResultImpl extends _MatchResult {
  const _$MatchResultImpl({
    @MatchSetScoreListConverter() required final List<MatchSetScore> sets,
    required this.winner,
  }) : _sets = sets,
       super._();

  factory _$MatchResultImpl.fromJson(Map<String, dynamic> json) =>
      _$$MatchResultImplFromJson(json);

  final List<MatchSetScore> _sets;
  @override
  @MatchSetScoreListConverter()
  List<MatchSetScore> get sets {
    if (_sets is EqualUnmodifiableListView) return _sets;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_sets);
  }

  @override
  final String winner;

  @override
  String toString() {
    return 'MatchResult(sets: $sets, winner: $winner)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MatchResultImpl &&
            const DeepCollectionEquality().equals(other._sets, _sets) &&
            (identical(other.winner, winner) || other.winner == winner));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_sets),
    winner,
  );

  /// Create a copy of MatchResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MatchResultImplCopyWith<_$MatchResultImpl> get copyWith =>
      __$$MatchResultImplCopyWithImpl<_$MatchResultImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MatchResultImplToJson(this);
  }
}

abstract class _MatchResult extends MatchResult {
  const factory _MatchResult({
    @MatchSetScoreListConverter() required final List<MatchSetScore> sets,
    required final String winner,
  }) = _$MatchResultImpl;
  const _MatchResult._() : super._();

  factory _MatchResult.fromJson(Map<String, dynamic> json) =
      _$MatchResultImpl.fromJson;

  @override
  @MatchSetScoreListConverter()
  List<MatchSetScore> get sets;
  @override
  String get winner;

  /// Create a copy of MatchResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MatchResultImplCopyWith<_$MatchResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminDecision _$AdminDecisionFromJson(Map<String, dynamic> json) {
  return _AdminDecision.fromJson(json);
}

/// @nodoc
mixin _$AdminDecision {
  String get adminId => throw _privateConstructorUsedError;
  String get winner => throw _privateConstructorUsedError; // 'teamA' or 'teamB'
  String get reason => throw _privateConstructorUsedError;
  @ChampionshipTimestampConverter()
  DateTime get decidedAt => throw _privateConstructorUsedError;

  /// Serializes this AdminDecision to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminDecision
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminDecisionCopyWith<AdminDecision> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminDecisionCopyWith<$Res> {
  factory $AdminDecisionCopyWith(
    AdminDecision value,
    $Res Function(AdminDecision) then,
  ) = _$AdminDecisionCopyWithImpl<$Res, AdminDecision>;
  @useResult
  $Res call({
    String adminId,
    String winner,
    String reason,
    @ChampionshipTimestampConverter() DateTime decidedAt,
  });
}

/// @nodoc
class _$AdminDecisionCopyWithImpl<$Res, $Val extends AdminDecision>
    implements $AdminDecisionCopyWith<$Res> {
  _$AdminDecisionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminDecision
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adminId = null,
    Object? winner = null,
    Object? reason = null,
    Object? decidedAt = null,
  }) {
    return _then(
      _value.copyWith(
            adminId: null == adminId
                ? _value.adminId
                : adminId // ignore: cast_nullable_to_non_nullable
                      as String,
            winner: null == winner
                ? _value.winner
                : winner // ignore: cast_nullable_to_non_nullable
                      as String,
            reason: null == reason
                ? _value.reason
                : reason // ignore: cast_nullable_to_non_nullable
                      as String,
            decidedAt: null == decidedAt
                ? _value.decidedAt
                : decidedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AdminDecisionImplCopyWith<$Res>
    implements $AdminDecisionCopyWith<$Res> {
  factory _$$AdminDecisionImplCopyWith(
    _$AdminDecisionImpl value,
    $Res Function(_$AdminDecisionImpl) then,
  ) = __$$AdminDecisionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String adminId,
    String winner,
    String reason,
    @ChampionshipTimestampConverter() DateTime decidedAt,
  });
}

/// @nodoc
class __$$AdminDecisionImplCopyWithImpl<$Res>
    extends _$AdminDecisionCopyWithImpl<$Res, _$AdminDecisionImpl>
    implements _$$AdminDecisionImplCopyWith<$Res> {
  __$$AdminDecisionImplCopyWithImpl(
    _$AdminDecisionImpl _value,
    $Res Function(_$AdminDecisionImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AdminDecision
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? adminId = null,
    Object? winner = null,
    Object? reason = null,
    Object? decidedAt = null,
  }) {
    return _then(
      _$AdminDecisionImpl(
        adminId: null == adminId
            ? _value.adminId
            : adminId // ignore: cast_nullable_to_non_nullable
                  as String,
        winner: null == winner
            ? _value.winner
            : winner // ignore: cast_nullable_to_non_nullable
                  as String,
        reason: null == reason
            ? _value.reason
            : reason // ignore: cast_nullable_to_non_nullable
                  as String,
        decidedAt: null == decidedAt
            ? _value.decidedAt
            : decidedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminDecisionImpl extends _AdminDecision {
  const _$AdminDecisionImpl({
    required this.adminId,
    required this.winner,
    required this.reason,
    @ChampionshipTimestampConverter() required this.decidedAt,
  }) : super._();

  factory _$AdminDecisionImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminDecisionImplFromJson(json);

  @override
  final String adminId;
  @override
  final String winner;
  // 'teamA' or 'teamB'
  @override
  final String reason;
  @override
  @ChampionshipTimestampConverter()
  final DateTime decidedAt;

  @override
  String toString() {
    return 'AdminDecision(adminId: $adminId, winner: $winner, reason: $reason, decidedAt: $decidedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminDecisionImpl &&
            (identical(other.adminId, adminId) || other.adminId == adminId) &&
            (identical(other.winner, winner) || other.winner == winner) &&
            (identical(other.reason, reason) || other.reason == reason) &&
            (identical(other.decidedAt, decidedAt) ||
                other.decidedAt == decidedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, adminId, winner, reason, decidedAt);

  /// Create a copy of AdminDecision
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminDecisionImplCopyWith<_$AdminDecisionImpl> get copyWith =>
      __$$AdminDecisionImplCopyWithImpl<_$AdminDecisionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminDecisionImplToJson(this);
  }
}

abstract class _AdminDecision extends AdminDecision {
  const factory _AdminDecision({
    required final String adminId,
    required final String winner,
    required final String reason,
    @ChampionshipTimestampConverter() required final DateTime decidedAt,
  }) = _$AdminDecisionImpl;
  const _AdminDecision._() : super._();

  factory _AdminDecision.fromJson(Map<String, dynamic> json) =
      _$AdminDecisionImpl.fromJson;

  @override
  String get adminId;
  @override
  String get winner; // 'teamA' or 'teamB'
  @override
  String get reason;
  @override
  @ChampionshipTimestampConverter()
  DateTime get decidedAt;

  /// Create a copy of AdminDecision
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminDecisionImplCopyWith<_$AdminDecisionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChampionshipMatchModel _$ChampionshipMatchModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChampionshipMatchModel.fromJson(json);
}

/// @nodoc
mixin _$ChampionshipMatchModel {
  String get id => throw _privateConstructorUsedError;
  int get round => throw _privateConstructorUsedError;
  String get teamAId => throw _privateConstructorUsedError;
  String get teamBId => throw _privateConstructorUsedError;
  @ChampionshipTimestampConverter()
  DateTime get deadline => throw _privateConstructorUsedError;
  MatchStatus get status => throw _privateConstructorUsedError;
  @ChampionshipNullableTimestampConverter()
  DateTime? get scheduledAt => throw _privateConstructorUsedError;
  String? get location => throw _privateConstructorUsedError;
  @MatchResultConverter()
  MatchResult? get result => throw _privateConstructorUsedError;
  String? get submittedByTeamId => throw _privateConstructorUsedError;
  String? get submittedByUserId => throw _privateConstructorUsedError;
  String? get verifiedByTeamId => throw _privateConstructorUsedError;
  String? get verifiedByUserId => throw _privateConstructorUsedError;
  @ChampionshipNullableTimestampConverter()
  DateTime? get verifiedAt => throw _privateConstructorUsedError;
  @AdminDecisionConverter()
  AdminDecision? get adminDecision => throw _privateConstructorUsedError;

  /// Serializes this ChampionshipMatchModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChampionshipMatchModelCopyWith<ChampionshipMatchModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChampionshipMatchModelCopyWith<$Res> {
  factory $ChampionshipMatchModelCopyWith(
    ChampionshipMatchModel value,
    $Res Function(ChampionshipMatchModel) then,
  ) = _$ChampionshipMatchModelCopyWithImpl<$Res, ChampionshipMatchModel>;
  @useResult
  $Res call({
    String id,
    int round,
    String teamAId,
    String teamBId,
    @ChampionshipTimestampConverter() DateTime deadline,
    MatchStatus status,
    @ChampionshipNullableTimestampConverter() DateTime? scheduledAt,
    String? location,
    @MatchResultConverter() MatchResult? result,
    String? submittedByTeamId,
    String? submittedByUserId,
    String? verifiedByTeamId,
    String? verifiedByUserId,
    @ChampionshipNullableTimestampConverter() DateTime? verifiedAt,
    @AdminDecisionConverter() AdminDecision? adminDecision,
  });

  $MatchResultCopyWith<$Res>? get result;
  $AdminDecisionCopyWith<$Res>? get adminDecision;
}

/// @nodoc
class _$ChampionshipMatchModelCopyWithImpl<
  $Res,
  $Val extends ChampionshipMatchModel
>
    implements $ChampionshipMatchModelCopyWith<$Res> {
  _$ChampionshipMatchModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? round = null,
    Object? teamAId = null,
    Object? teamBId = null,
    Object? deadline = null,
    Object? status = null,
    Object? scheduledAt = freezed,
    Object? location = freezed,
    Object? result = freezed,
    Object? submittedByTeamId = freezed,
    Object? submittedByUserId = freezed,
    Object? verifiedByTeamId = freezed,
    Object? verifiedByUserId = freezed,
    Object? verifiedAt = freezed,
    Object? adminDecision = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            round: null == round
                ? _value.round
                : round // ignore: cast_nullable_to_non_nullable
                      as int,
            teamAId: null == teamAId
                ? _value.teamAId
                : teamAId // ignore: cast_nullable_to_non_nullable
                      as String,
            teamBId: null == teamBId
                ? _value.teamBId
                : teamBId // ignore: cast_nullable_to_non_nullable
                      as String,
            deadline: null == deadline
                ? _value.deadline
                : deadline // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as MatchStatus,
            scheduledAt: freezed == scheduledAt
                ? _value.scheduledAt
                : scheduledAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            result: freezed == result
                ? _value.result
                : result // ignore: cast_nullable_to_non_nullable
                      as MatchResult?,
            submittedByTeamId: freezed == submittedByTeamId
                ? _value.submittedByTeamId
                : submittedByTeamId // ignore: cast_nullable_to_non_nullable
                      as String?,
            submittedByUserId: freezed == submittedByUserId
                ? _value.submittedByUserId
                : submittedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            verifiedByTeamId: freezed == verifiedByTeamId
                ? _value.verifiedByTeamId
                : verifiedByTeamId // ignore: cast_nullable_to_non_nullable
                      as String?,
            verifiedByUserId: freezed == verifiedByUserId
                ? _value.verifiedByUserId
                : verifiedByUserId // ignore: cast_nullable_to_non_nullable
                      as String?,
            verifiedAt: freezed == verifiedAt
                ? _value.verifiedAt
                : verifiedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            adminDecision: freezed == adminDecision
                ? _value.adminDecision
                : adminDecision // ignore: cast_nullable_to_non_nullable
                      as AdminDecision?,
          )
          as $Val,
    );
  }

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $MatchResultCopyWith<$Res>? get result {
    if (_value.result == null) {
      return null;
    }

    return $MatchResultCopyWith<$Res>(_value.result!, (value) {
      return _then(_value.copyWith(result: value) as $Val);
    });
  }

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminDecisionCopyWith<$Res>? get adminDecision {
    if (_value.adminDecision == null) {
      return null;
    }

    return $AdminDecisionCopyWith<$Res>(_value.adminDecision!, (value) {
      return _then(_value.copyWith(adminDecision: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ChampionshipMatchModelImplCopyWith<$Res>
    implements $ChampionshipMatchModelCopyWith<$Res> {
  factory _$$ChampionshipMatchModelImplCopyWith(
    _$ChampionshipMatchModelImpl value,
    $Res Function(_$ChampionshipMatchModelImpl) then,
  ) = __$$ChampionshipMatchModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    int round,
    String teamAId,
    String teamBId,
    @ChampionshipTimestampConverter() DateTime deadline,
    MatchStatus status,
    @ChampionshipNullableTimestampConverter() DateTime? scheduledAt,
    String? location,
    @MatchResultConverter() MatchResult? result,
    String? submittedByTeamId,
    String? submittedByUserId,
    String? verifiedByTeamId,
    String? verifiedByUserId,
    @ChampionshipNullableTimestampConverter() DateTime? verifiedAt,
    @AdminDecisionConverter() AdminDecision? adminDecision,
  });

  @override
  $MatchResultCopyWith<$Res>? get result;
  @override
  $AdminDecisionCopyWith<$Res>? get adminDecision;
}

/// @nodoc
class __$$ChampionshipMatchModelImplCopyWithImpl<$Res>
    extends
        _$ChampionshipMatchModelCopyWithImpl<$Res, _$ChampionshipMatchModelImpl>
    implements _$$ChampionshipMatchModelImplCopyWith<$Res> {
  __$$ChampionshipMatchModelImplCopyWithImpl(
    _$ChampionshipMatchModelImpl _value,
    $Res Function(_$ChampionshipMatchModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? round = null,
    Object? teamAId = null,
    Object? teamBId = null,
    Object? deadline = null,
    Object? status = null,
    Object? scheduledAt = freezed,
    Object? location = freezed,
    Object? result = freezed,
    Object? submittedByTeamId = freezed,
    Object? submittedByUserId = freezed,
    Object? verifiedByTeamId = freezed,
    Object? verifiedByUserId = freezed,
    Object? verifiedAt = freezed,
    Object? adminDecision = freezed,
  }) {
    return _then(
      _$ChampionshipMatchModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        round: null == round
            ? _value.round
            : round // ignore: cast_nullable_to_non_nullable
                  as int,
        teamAId: null == teamAId
            ? _value.teamAId
            : teamAId // ignore: cast_nullable_to_non_nullable
                  as String,
        teamBId: null == teamBId
            ? _value.teamBId
            : teamBId // ignore: cast_nullable_to_non_nullable
                  as String,
        deadline: null == deadline
            ? _value.deadline
            : deadline // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as MatchStatus,
        scheduledAt: freezed == scheduledAt
            ? _value.scheduledAt
            : scheduledAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        result: freezed == result
            ? _value.result
            : result // ignore: cast_nullable_to_non_nullable
                  as MatchResult?,
        submittedByTeamId: freezed == submittedByTeamId
            ? _value.submittedByTeamId
            : submittedByTeamId // ignore: cast_nullable_to_non_nullable
                  as String?,
        submittedByUserId: freezed == submittedByUserId
            ? _value.submittedByUserId
            : submittedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        verifiedByTeamId: freezed == verifiedByTeamId
            ? _value.verifiedByTeamId
            : verifiedByTeamId // ignore: cast_nullable_to_non_nullable
                  as String?,
        verifiedByUserId: freezed == verifiedByUserId
            ? _value.verifiedByUserId
            : verifiedByUserId // ignore: cast_nullable_to_non_nullable
                  as String?,
        verifiedAt: freezed == verifiedAt
            ? _value.verifiedAt
            : verifiedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        adminDecision: freezed == adminDecision
            ? _value.adminDecision
            : adminDecision // ignore: cast_nullable_to_non_nullable
                  as AdminDecision?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChampionshipMatchModelImpl extends _ChampionshipMatchModel {
  const _$ChampionshipMatchModelImpl({
    required this.id,
    required this.round,
    required this.teamAId,
    required this.teamBId,
    @ChampionshipTimestampConverter() required this.deadline,
    this.status = MatchStatus.pending,
    @ChampionshipNullableTimestampConverter() this.scheduledAt,
    this.location,
    @MatchResultConverter() this.result,
    this.submittedByTeamId,
    this.submittedByUserId,
    this.verifiedByTeamId,
    this.verifiedByUserId,
    @ChampionshipNullableTimestampConverter() this.verifiedAt,
    @AdminDecisionConverter() this.adminDecision,
  }) : super._();

  factory _$ChampionshipMatchModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChampionshipMatchModelImplFromJson(json);

  @override
  final String id;
  @override
  final int round;
  @override
  final String teamAId;
  @override
  final String teamBId;
  @override
  @ChampionshipTimestampConverter()
  final DateTime deadline;
  @override
  @JsonKey()
  final MatchStatus status;
  @override
  @ChampionshipNullableTimestampConverter()
  final DateTime? scheduledAt;
  @override
  final String? location;
  @override
  @MatchResultConverter()
  final MatchResult? result;
  @override
  final String? submittedByTeamId;
  @override
  final String? submittedByUserId;
  @override
  final String? verifiedByTeamId;
  @override
  final String? verifiedByUserId;
  @override
  @ChampionshipNullableTimestampConverter()
  final DateTime? verifiedAt;
  @override
  @AdminDecisionConverter()
  final AdminDecision? adminDecision;

  @override
  String toString() {
    return 'ChampionshipMatchModel(id: $id, round: $round, teamAId: $teamAId, teamBId: $teamBId, deadline: $deadline, status: $status, scheduledAt: $scheduledAt, location: $location, result: $result, submittedByTeamId: $submittedByTeamId, submittedByUserId: $submittedByUserId, verifiedByTeamId: $verifiedByTeamId, verifiedByUserId: $verifiedByUserId, verifiedAt: $verifiedAt, adminDecision: $adminDecision)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChampionshipMatchModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.round, round) || other.round == round) &&
            (identical(other.teamAId, teamAId) || other.teamAId == teamAId) &&
            (identical(other.teamBId, teamBId) || other.teamBId == teamBId) &&
            (identical(other.deadline, deadline) ||
                other.deadline == deadline) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.scheduledAt, scheduledAt) ||
                other.scheduledAt == scheduledAt) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.result, result) || other.result == result) &&
            (identical(other.submittedByTeamId, submittedByTeamId) ||
                other.submittedByTeamId == submittedByTeamId) &&
            (identical(other.submittedByUserId, submittedByUserId) ||
                other.submittedByUserId == submittedByUserId) &&
            (identical(other.verifiedByTeamId, verifiedByTeamId) ||
                other.verifiedByTeamId == verifiedByTeamId) &&
            (identical(other.verifiedByUserId, verifiedByUserId) ||
                other.verifiedByUserId == verifiedByUserId) &&
            (identical(other.verifiedAt, verifiedAt) ||
                other.verifiedAt == verifiedAt) &&
            (identical(other.adminDecision, adminDecision) ||
                other.adminDecision == adminDecision));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    round,
    teamAId,
    teamBId,
    deadline,
    status,
    scheduledAt,
    location,
    result,
    submittedByTeamId,
    submittedByUserId,
    verifiedByTeamId,
    verifiedByUserId,
    verifiedAt,
    adminDecision,
  );

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChampionshipMatchModelImplCopyWith<_$ChampionshipMatchModelImpl>
  get copyWith =>
      __$$ChampionshipMatchModelImplCopyWithImpl<_$ChampionshipMatchModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChampionshipMatchModelImplToJson(this);
  }
}

abstract class _ChampionshipMatchModel extends ChampionshipMatchModel {
  const factory _ChampionshipMatchModel({
    required final String id,
    required final int round,
    required final String teamAId,
    required final String teamBId,
    @ChampionshipTimestampConverter() required final DateTime deadline,
    final MatchStatus status,
    @ChampionshipNullableTimestampConverter() final DateTime? scheduledAt,
    final String? location,
    @MatchResultConverter() final MatchResult? result,
    final String? submittedByTeamId,
    final String? submittedByUserId,
    final String? verifiedByTeamId,
    final String? verifiedByUserId,
    @ChampionshipNullableTimestampConverter() final DateTime? verifiedAt,
    @AdminDecisionConverter() final AdminDecision? adminDecision,
  }) = _$ChampionshipMatchModelImpl;
  const _ChampionshipMatchModel._() : super._();

  factory _ChampionshipMatchModel.fromJson(Map<String, dynamic> json) =
      _$ChampionshipMatchModelImpl.fromJson;

  @override
  String get id;
  @override
  int get round;
  @override
  String get teamAId;
  @override
  String get teamBId;
  @override
  @ChampionshipTimestampConverter()
  DateTime get deadline;
  @override
  MatchStatus get status;
  @override
  @ChampionshipNullableTimestampConverter()
  DateTime? get scheduledAt;
  @override
  String? get location;
  @override
  @MatchResultConverter()
  MatchResult? get result;
  @override
  String? get submittedByTeamId;
  @override
  String? get submittedByUserId;
  @override
  String? get verifiedByTeamId;
  @override
  String? get verifiedByUserId;
  @override
  @ChampionshipNullableTimestampConverter()
  DateTime? get verifiedAt;
  @override
  @AdminDecisionConverter()
  AdminDecision? get adminDecision;

  /// Create a copy of ChampionshipMatchModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChampionshipMatchModelImplCopyWith<_$ChampionshipMatchModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChampionshipStandingsModel _$ChampionshipStandingsModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChampionshipStandingsModel.fromJson(json);
}

/// @nodoc
mixin _$ChampionshipStandingsModel {
  String get teamId => throw _privateConstructorUsedError;
  String get teamName => throw _privateConstructorUsedError;
  int get played => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get wins20 => throw _privateConstructorUsedError; // 2-0 wins  (3 pts)
  int get wins21 => throw _privateConstructorUsedError; // 2-1 wins  (2 pts)
  int get losses12 => throw _privateConstructorUsedError; // 1-2 losses (1 pt)
  int get losses02 => throw _privateConstructorUsedError; // 0-2 losses (0 pts)
  int get setsWon => throw _privateConstructorUsedError;
  int get setsLost => throw _privateConstructorUsedError;
  int get position => throw _privateConstructorUsedError;

  /// Serializes this ChampionshipStandingsModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChampionshipStandingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChampionshipStandingsModelCopyWith<ChampionshipStandingsModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChampionshipStandingsModelCopyWith<$Res> {
  factory $ChampionshipStandingsModelCopyWith(
    ChampionshipStandingsModel value,
    $Res Function(ChampionshipStandingsModel) then,
  ) =
      _$ChampionshipStandingsModelCopyWithImpl<
        $Res,
        ChampionshipStandingsModel
      >;
  @useResult
  $Res call({
    String teamId,
    String teamName,
    int played,
    int points,
    int wins20,
    int wins21,
    int losses12,
    int losses02,
    int setsWon,
    int setsLost,
    int position,
  });
}

/// @nodoc
class _$ChampionshipStandingsModelCopyWithImpl<
  $Res,
  $Val extends ChampionshipStandingsModel
>
    implements $ChampionshipStandingsModelCopyWith<$Res> {
  _$ChampionshipStandingsModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChampionshipStandingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? played = null,
    Object? points = null,
    Object? wins20 = null,
    Object? wins21 = null,
    Object? losses12 = null,
    Object? losses02 = null,
    Object? setsWon = null,
    Object? setsLost = null,
    Object? position = null,
  }) {
    return _then(
      _value.copyWith(
            teamId: null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                      as String,
            teamName: null == teamName
                ? _value.teamName
                : teamName // ignore: cast_nullable_to_non_nullable
                      as String,
            played: null == played
                ? _value.played
                : played // ignore: cast_nullable_to_non_nullable
                      as int,
            points: null == points
                ? _value.points
                : points // ignore: cast_nullable_to_non_nullable
                      as int,
            wins20: null == wins20
                ? _value.wins20
                : wins20 // ignore: cast_nullable_to_non_nullable
                      as int,
            wins21: null == wins21
                ? _value.wins21
                : wins21 // ignore: cast_nullable_to_non_nullable
                      as int,
            losses12: null == losses12
                ? _value.losses12
                : losses12 // ignore: cast_nullable_to_non_nullable
                      as int,
            losses02: null == losses02
                ? _value.losses02
                : losses02 // ignore: cast_nullable_to_non_nullable
                      as int,
            setsWon: null == setsWon
                ? _value.setsWon
                : setsWon // ignore: cast_nullable_to_non_nullable
                      as int,
            setsLost: null == setsLost
                ? _value.setsLost
                : setsLost // ignore: cast_nullable_to_non_nullable
                      as int,
            position: null == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChampionshipStandingsModelImplCopyWith<$Res>
    implements $ChampionshipStandingsModelCopyWith<$Res> {
  factory _$$ChampionshipStandingsModelImplCopyWith(
    _$ChampionshipStandingsModelImpl value,
    $Res Function(_$ChampionshipStandingsModelImpl) then,
  ) = __$$ChampionshipStandingsModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String teamId,
    String teamName,
    int played,
    int points,
    int wins20,
    int wins21,
    int losses12,
    int losses02,
    int setsWon,
    int setsLost,
    int position,
  });
}

/// @nodoc
class __$$ChampionshipStandingsModelImplCopyWithImpl<$Res>
    extends
        _$ChampionshipStandingsModelCopyWithImpl<
          $Res,
          _$ChampionshipStandingsModelImpl
        >
    implements _$$ChampionshipStandingsModelImplCopyWith<$Res> {
  __$$ChampionshipStandingsModelImplCopyWithImpl(
    _$ChampionshipStandingsModelImpl _value,
    $Res Function(_$ChampionshipStandingsModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChampionshipStandingsModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? teamId = null,
    Object? teamName = null,
    Object? played = null,
    Object? points = null,
    Object? wins20 = null,
    Object? wins21 = null,
    Object? losses12 = null,
    Object? losses02 = null,
    Object? setsWon = null,
    Object? setsLost = null,
    Object? position = null,
  }) {
    return _then(
      _$ChampionshipStandingsModelImpl(
        teamId: null == teamId
            ? _value.teamId
            : teamId // ignore: cast_nullable_to_non_nullable
                  as String,
        teamName: null == teamName
            ? _value.teamName
            : teamName // ignore: cast_nullable_to_non_nullable
                  as String,
        played: null == played
            ? _value.played
            : played // ignore: cast_nullable_to_non_nullable
                  as int,
        points: null == points
            ? _value.points
            : points // ignore: cast_nullable_to_non_nullable
                  as int,
        wins20: null == wins20
            ? _value.wins20
            : wins20 // ignore: cast_nullable_to_non_nullable
                  as int,
        wins21: null == wins21
            ? _value.wins21
            : wins21 // ignore: cast_nullable_to_non_nullable
                  as int,
        losses12: null == losses12
            ? _value.losses12
            : losses12 // ignore: cast_nullable_to_non_nullable
                  as int,
        losses02: null == losses02
            ? _value.losses02
            : losses02 // ignore: cast_nullable_to_non_nullable
                  as int,
        setsWon: null == setsWon
            ? _value.setsWon
            : setsWon // ignore: cast_nullable_to_non_nullable
                  as int,
        setsLost: null == setsLost
            ? _value.setsLost
            : setsLost // ignore: cast_nullable_to_non_nullable
                  as int,
        position: null == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChampionshipStandingsModelImpl extends _ChampionshipStandingsModel {
  const _$ChampionshipStandingsModelImpl({
    required this.teamId,
    required this.teamName,
    this.played = 0,
    this.points = 0,
    this.wins20 = 0,
    this.wins21 = 0,
    this.losses12 = 0,
    this.losses02 = 0,
    this.setsWon = 0,
    this.setsLost = 0,
    this.position = 0,
  }) : super._();

  factory _$ChampionshipStandingsModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$ChampionshipStandingsModelImplFromJson(json);

  @override
  final String teamId;
  @override
  final String teamName;
  @override
  @JsonKey()
  final int played;
  @override
  @JsonKey()
  final int points;
  @override
  @JsonKey()
  final int wins20;
  // 2-0 wins  (3 pts)
  @override
  @JsonKey()
  final int wins21;
  // 2-1 wins  (2 pts)
  @override
  @JsonKey()
  final int losses12;
  // 1-2 losses (1 pt)
  @override
  @JsonKey()
  final int losses02;
  // 0-2 losses (0 pts)
  @override
  @JsonKey()
  final int setsWon;
  @override
  @JsonKey()
  final int setsLost;
  @override
  @JsonKey()
  final int position;

  @override
  String toString() {
    return 'ChampionshipStandingsModel(teamId: $teamId, teamName: $teamName, played: $played, points: $points, wins20: $wins20, wins21: $wins21, losses12: $losses12, losses02: $losses02, setsWon: $setsWon, setsLost: $setsLost, position: $position)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChampionshipStandingsModelImpl &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.teamName, teamName) ||
                other.teamName == teamName) &&
            (identical(other.played, played) || other.played == played) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.wins20, wins20) || other.wins20 == wins20) &&
            (identical(other.wins21, wins21) || other.wins21 == wins21) &&
            (identical(other.losses12, losses12) ||
                other.losses12 == losses12) &&
            (identical(other.losses02, losses02) ||
                other.losses02 == losses02) &&
            (identical(other.setsWon, setsWon) || other.setsWon == setsWon) &&
            (identical(other.setsLost, setsLost) ||
                other.setsLost == setsLost) &&
            (identical(other.position, position) ||
                other.position == position));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    teamId,
    teamName,
    played,
    points,
    wins20,
    wins21,
    losses12,
    losses02,
    setsWon,
    setsLost,
    position,
  );

  /// Create a copy of ChampionshipStandingsModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChampionshipStandingsModelImplCopyWith<_$ChampionshipStandingsModelImpl>
  get copyWith =>
      __$$ChampionshipStandingsModelImplCopyWithImpl<
        _$ChampionshipStandingsModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChampionshipStandingsModelImplToJson(this);
  }
}

abstract class _ChampionshipStandingsModel extends ChampionshipStandingsModel {
  const factory _ChampionshipStandingsModel({
    required final String teamId,
    required final String teamName,
    final int played,
    final int points,
    final int wins20,
    final int wins21,
    final int losses12,
    final int losses02,
    final int setsWon,
    final int setsLost,
    final int position,
  }) = _$ChampionshipStandingsModelImpl;
  const _ChampionshipStandingsModel._() : super._();

  factory _ChampionshipStandingsModel.fromJson(Map<String, dynamic> json) =
      _$ChampionshipStandingsModelImpl.fromJson;

  @override
  String get teamId;
  @override
  String get teamName;
  @override
  int get played;
  @override
  int get points;
  @override
  int get wins20; // 2-0 wins  (3 pts)
  @override
  int get wins21; // 2-1 wins  (2 pts)
  @override
  int get losses12; // 1-2 losses (1 pt)
  @override
  int get losses02; // 0-2 losses (0 pts)
  @override
  int get setsWon;
  @override
  int get setsLost;
  @override
  int get position;

  /// Create a copy of ChampionshipStandingsModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChampionshipStandingsModelImplCopyWith<_$ChampionshipStandingsModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChampionshipMessageModel _$ChampionshipMessageModelFromJson(
  Map<String, dynamic> json,
) {
  return _ChampionshipMessageModel.fromJson(json);
}

/// @nodoc
mixin _$ChampionshipMessageModel {
  String get id => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get senderDisplayName => throw _privateConstructorUsedError;
  String get teamId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  @ChampionshipTimestampConverter()
  DateTime get sentAt => throw _privateConstructorUsedError;

  /// Serializes this ChampionshipMessageModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChampionshipMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChampionshipMessageModelCopyWith<ChampionshipMessageModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChampionshipMessageModelCopyWith<$Res> {
  factory $ChampionshipMessageModelCopyWith(
    ChampionshipMessageModel value,
    $Res Function(ChampionshipMessageModel) then,
  ) = _$ChampionshipMessageModelCopyWithImpl<$Res, ChampionshipMessageModel>;
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderDisplayName,
    String teamId,
    String text,
    @ChampionshipTimestampConverter() DateTime sentAt,
  });
}

/// @nodoc
class _$ChampionshipMessageModelCopyWithImpl<
  $Res,
  $Val extends ChampionshipMessageModel
>
    implements $ChampionshipMessageModelCopyWith<$Res> {
  _$ChampionshipMessageModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChampionshipMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderDisplayName = null,
    Object? teamId = null,
    Object? text = null,
    Object? sentAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            senderId: null == senderId
                ? _value.senderId
                : senderId // ignore: cast_nullable_to_non_nullable
                      as String,
            senderDisplayName: null == senderDisplayName
                ? _value.senderDisplayName
                : senderDisplayName // ignore: cast_nullable_to_non_nullable
                      as String,
            teamId: null == teamId
                ? _value.teamId
                : teamId // ignore: cast_nullable_to_non_nullable
                      as String,
            text: null == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String,
            sentAt: null == sentAt
                ? _value.sentAt
                : sentAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChampionshipMessageModelImplCopyWith<$Res>
    implements $ChampionshipMessageModelCopyWith<$Res> {
  factory _$$ChampionshipMessageModelImplCopyWith(
    _$ChampionshipMessageModelImpl value,
    $Res Function(_$ChampionshipMessageModelImpl) then,
  ) = __$$ChampionshipMessageModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String senderId,
    String senderDisplayName,
    String teamId,
    String text,
    @ChampionshipTimestampConverter() DateTime sentAt,
  });
}

/// @nodoc
class __$$ChampionshipMessageModelImplCopyWithImpl<$Res>
    extends
        _$ChampionshipMessageModelCopyWithImpl<
          $Res,
          _$ChampionshipMessageModelImpl
        >
    implements _$$ChampionshipMessageModelImplCopyWith<$Res> {
  __$$ChampionshipMessageModelImplCopyWithImpl(
    _$ChampionshipMessageModelImpl _value,
    $Res Function(_$ChampionshipMessageModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChampionshipMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? senderId = null,
    Object? senderDisplayName = null,
    Object? teamId = null,
    Object? text = null,
    Object? sentAt = null,
  }) {
    return _then(
      _$ChampionshipMessageModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        senderId: null == senderId
            ? _value.senderId
            : senderId // ignore: cast_nullable_to_non_nullable
                  as String,
        senderDisplayName: null == senderDisplayName
            ? _value.senderDisplayName
            : senderDisplayName // ignore: cast_nullable_to_non_nullable
                  as String,
        teamId: null == teamId
            ? _value.teamId
            : teamId // ignore: cast_nullable_to_non_nullable
                  as String,
        text: null == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String,
        sentAt: null == sentAt
            ? _value.sentAt
            : sentAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChampionshipMessageModelImpl extends _ChampionshipMessageModel {
  const _$ChampionshipMessageModelImpl({
    required this.id,
    required this.senderId,
    required this.senderDisplayName,
    required this.teamId,
    required this.text,
    @ChampionshipTimestampConverter() required this.sentAt,
  }) : super._();

  factory _$ChampionshipMessageModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChampionshipMessageModelImplFromJson(json);

  @override
  final String id;
  @override
  final String senderId;
  @override
  final String senderDisplayName;
  @override
  final String teamId;
  @override
  final String text;
  @override
  @ChampionshipTimestampConverter()
  final DateTime sentAt;

  @override
  String toString() {
    return 'ChampionshipMessageModel(id: $id, senderId: $senderId, senderDisplayName: $senderDisplayName, teamId: $teamId, text: $text, sentAt: $sentAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChampionshipMessageModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.senderDisplayName, senderDisplayName) ||
                other.senderDisplayName == senderDisplayName) &&
            (identical(other.teamId, teamId) || other.teamId == teamId) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.sentAt, sentAt) || other.sentAt == sentAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    senderId,
    senderDisplayName,
    teamId,
    text,
    sentAt,
  );

  /// Create a copy of ChampionshipMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChampionshipMessageModelImplCopyWith<_$ChampionshipMessageModelImpl>
  get copyWith =>
      __$$ChampionshipMessageModelImplCopyWithImpl<
        _$ChampionshipMessageModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChampionshipMessageModelImplToJson(this);
  }
}

abstract class _ChampionshipMessageModel extends ChampionshipMessageModel {
  const factory _ChampionshipMessageModel({
    required final String id,
    required final String senderId,
    required final String senderDisplayName,
    required final String teamId,
    required final String text,
    @ChampionshipTimestampConverter() required final DateTime sentAt,
  }) = _$ChampionshipMessageModelImpl;
  const _ChampionshipMessageModel._() : super._();

  factory _ChampionshipMessageModel.fromJson(Map<String, dynamic> json) =
      _$ChampionshipMessageModelImpl.fromJson;

  @override
  String get id;
  @override
  String get senderId;
  @override
  String get senderDisplayName;
  @override
  String get teamId;
  @override
  String get text;
  @override
  @ChampionshipTimestampConverter()
  DateTime get sentAt;

  /// Create a copy of ChampionshipMessageModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChampionshipMessageModelImplCopyWith<_$ChampionshipMessageModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
