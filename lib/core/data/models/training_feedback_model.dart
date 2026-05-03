import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:play_with_me/core/data/converters/timestamp_converter.dart';

part 'training_feedback_model.freezed.dart';
part 'training_feedback_model.g.dart';

/// Represents anonymous feedback for a training session
/// Feedback is stored in a subcollection under training sessions
/// The participant's identity is hashed to prevent duplicates while maintaining anonymity
@freezed
class TrainingFeedbackModel with _$TrainingFeedbackModel {
  const factory TrainingFeedbackModel({
    required String id,
    required String trainingSessionId,

    /// Exercises quality rating (1-5)
    required int exercisesQuality,

    /// Training intensity rating (1-5)
    required int trainingIntensity,

    /// Coaching clarity rating (1-5)
    required int coachingClarity,

    /// Optional written feedback
    String? comment,

    /// Hash of participant ID to prevent duplicates without exposing identity
    /// Hash is SHA-256 of: trainingSessionId + userId + salt
    required String participantHash,

    /// Timestamp when feedback was submitted
    @TimestampConverter() required DateTime submittedAt,
  }) = _TrainingFeedbackModel;

  const TrainingFeedbackModel._();

  factory TrainingFeedbackModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingFeedbackModelFromJson(json);

  /// Factory constructor for creating from Firestore DocumentSnapshot
  factory TrainingFeedbackModel.fromFirestore(
    DocumentSnapshot doc,
    String trainingSessionId,
  ) {
    final data = doc.data() as Map<String, dynamic>;
    return TrainingFeedbackModel.fromJson({
      ...data,
      'id': doc.id,
      'trainingSessionId': trainingSessionId,
    });
  }

  /// Convert to Firestore-compatible map (excludes id since it's the document ID)
  Map<String, dynamic> toFirestore() {
    final json = toJson();
    json.remove('id'); // Remove id as it's the document ID
    json.remove('trainingSessionId'); // Remove trainingSessionId as it's in the path
    return json;
  }

  /// Validation methods

  /// Validate exercises quality rating is in valid range (1-5)
  bool get hasValidExercisesQuality =>
      exercisesQuality >= 1 && exercisesQuality <= 5;

  /// Validate training intensity rating is in valid range (1-5)
  bool get hasValidTrainingIntensity =>
      trainingIntensity >= 1 && trainingIntensity <= 5;

  /// Validate coaching clarity rating is in valid range (1-5)
  bool get hasValidCoachingClarity =>
      coachingClarity >= 1 && coachingClarity <= 5;

  /// Check if all ratings are valid
  bool get hasValidRatings =>
      hasValidExercisesQuality &&
      hasValidTrainingIntensity &&
      hasValidCoachingClarity;

  /// Check if feedback has a comment
  bool get hasComment => comment != null && comment!.trim().isNotEmpty;

  /// Get sanitized comment (null if empty)
  String? get sanitizedComment {
    if (comment == null) return null;
    final trimmed = comment!.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  /// Get average of all three ratings (for overall score)
  double get averageRating =>
      (exercisesQuality + trainingIntensity + coachingClarity) / 3;
}

