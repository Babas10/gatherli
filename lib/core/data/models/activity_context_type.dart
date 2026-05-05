// Shared context type for all activities (games, training sessions).
// Introduced in Story 31.4, extracted and renamed in Story 31.4b so that
// Story 31.5 (training sessions) and future stories can reuse this enum
// without importing a game-specific file.

import 'package:json_annotation/json_annotation.dart';

/// Describes the context in which an activity (game, training session) was created.
/// - [group]: tied to a specific group (default — existing behaviour, groupId is set)
/// - [pickup]: standalone activity between friends, not tied to any group (groupId is null)
/// - [championship]: tied to a championship match from Epic 30
enum ActivityContextType {
  @JsonValue('group')
  group,
  @JsonValue('pickup')
  pickup,
  @JsonValue('championship')
  championship,
}
