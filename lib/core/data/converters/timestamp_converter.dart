// Shared Firestore Timestamp ↔ DateTime converters (Story 31.1).
// Import this file instead of defining converters per-model.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Converts a non-nullable [DateTime] to/from a Firestore [Timestamp].
///
/// Use as `@TimestampConverter()` on required DateTime fields.
class TimestampConverter implements JsonConverter<DateTime, Object> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object json) {
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    throw ArgumentError(
      'TimestampConverter: unsupported type ${json.runtimeType}',
    );
  }

  @override
  Object toJson(DateTime object) => Timestamp.fromDate(object);
}

/// Converts a nullable [DateTime] to/from a Firestore [Timestamp].
///
/// Use as `@NullableTimestampConverter()` on nullable DateTime fields.
class NullableTimestampConverter implements JsonConverter<DateTime?, Object?> {
  const NullableTimestampConverter();

  @override
  DateTime? fromJson(Object? json) {
    if (json == null) return null;
    if (json is Timestamp) return json.toDate();
    if (json is String) return DateTime.parse(json);
    if (json is int) return DateTime.fromMillisecondsSinceEpoch(json);
    return null;
  }

  @override
  Object? toJson(DateTime? object) {
    if (object == null) return null;
    return Timestamp.fromDate(object);
  }
}
