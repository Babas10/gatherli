import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/data/models/rating_history_entry.dart';
import 'package:play_with_me/core/data/models/teammate_stats.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/data/models/user_ranking.dart';

abstract class PlayerStatsState extends Equatable {
  const PlayerStatsState();

  @override
  List<Object?> get props => [];
}

class PlayerStatsInitial extends PlayerStatsState {}

class PlayerStatsLoading extends PlayerStatsState {}

class PlayerStatsLoaded extends PlayerStatsState {
  final UserModel user;
  final List<RatingHistoryEntry> history;
  final UserRanking? ranking;
  final bool rankingLoadFailed;
  // Story 34.3: teammate stats loaded from users/{uid}/stats subcollection,
  // not from user.teammateStats on the root document.
  final List<TeammateStats> teammateStats;

  const PlayerStatsLoaded({
    required this.user,
    required this.history,
    this.ranking,
    this.rankingLoadFailed = false,
    this.teammateStats = const [],
  });

  @override
  List<Object?> get props =>
      [user, history, ranking, rankingLoadFailed, teammateStats];

  PlayerStatsLoaded copyWith({
    UserModel? user,
    List<RatingHistoryEntry>? history,
    UserRanking? ranking,
    bool? rankingLoadFailed,
    List<TeammateStats>? teammateStats,
  }) {
    return PlayerStatsLoaded(
      user: user ?? this.user,
      history: history ?? this.history,
      ranking: ranking ?? this.ranking,
      rankingLoadFailed: rankingLoadFailed ?? this.rankingLoadFailed,
      teammateStats: teammateStats ?? this.teammateStats,
    );
  }
}

class PlayerStatsError extends PlayerStatsState {
  final String message;

  const PlayerStatsError(this.message);

  @override
  List<Object> get props => [message];
}
