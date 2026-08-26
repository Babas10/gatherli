// Validates that a set of game scores is legal before submission.
// Extracted from score_entry_bloc.dart where it was mixed with UI state.
import 'package:play_with_me/core/domain/use_cases/base_use_case.dart';

class GameScoreInput {
  final List<SetScore> sets;
  final int requiredSetsToWin;    // e.g. 2 for best-of-3
  final int pointsToWinSet;       // e.g. 21 for regular sets
  final int deciderSetPoints;     // e.g. 15 for the deciding 3rd set
  final int minimumPointDiff;     // e.g. 2

  const GameScoreInput({
    required this.sets,
    required this.requiredSetsToWin,
    this.pointsToWinSet = 21,
    this.deciderSetPoints = 15,
    this.minimumPointDiff = 2,
  });
}

class SetScore {
  final int teamAPoints;
  final int teamBPoints;

  const SetScore(this.teamAPoints, this.teamBPoints);

  bool get isTeamAWinner => teamAPoints > teamBPoints;
  bool get isTeamBWinner => teamBPoints > teamAPoints;
}

class GameScoreValidationResult {
  final bool isValid;
  final String? errorMessage;
  final String? winner; // 'teamA' | 'teamB' | null if still ongoing

  const GameScoreValidationResult({
    required this.isValid,
    this.errorMessage,
    this.winner,
  });

  static const valid = GameScoreValidationResult(isValid: true);
}

class ValidateGameScoresUseCase
    extends UseCase<GameScoreInput, GameScoreValidationResult> {

  const ValidateGameScoresUseCase();

  @override
  Future<GameScoreValidationResult> execute(GameScoreInput input) async {
    for (int i = 0; i < input.sets.length; i++) {
      final set = input.sets[i];
      final error = _validateSet(set, input, setIndex: i);
      if (error != null) {
        return GameScoreValidationResult(isValid: false, errorMessage: error);
      }
    }

    final teamASetWins = input.sets.where((s) => s.isTeamAWinner).length;
    final teamBSetWins = input.sets.where((s) => s.isTeamBWinner).length;

    String? winner;
    if (teamASetWins >= input.requiredSetsToWin) winner = 'teamA';
    if (teamBSetWins >= input.requiredSetsToWin) winner = 'teamB';

    return GameScoreValidationResult(isValid: true, winner: winner);
  }

  String? _validateSet(SetScore set, GameScoreInput input, {required int setIndex}) {
    final a = set.teamAPoints;
    final b = set.teamBPoints;

    if (a < 0 || b < 0) {
      return 'Set ${setIndex + 1}: scores cannot be negative.';
    }

    // The deciding set (e.g. 3rd in best-of-3) plays to deciderSetPoints (15),
    // all other sets play to pointsToWinSet (21).
    final totalSets = input.requiredSetsToWin * 2 - 1; // 3 for best-of-3
    final isDeciderSet = setIndex == totalSets - 1;
    final target = isDeciderSet ? input.deciderSetPoints : input.pointsToWinSet;

    final maxPoints = a > b ? a : b;
    final diff = (a - b).abs();

    // Valid set: one team reaches target with minimumPointDiff lead
    // OR extended play (both above target, difference == minimumPointDiff)
    if (maxPoints >= target) {
      if (diff < input.minimumPointDiff) {
        return 'Set ${setIndex + 1}: need a ${input.minimumPointDiff}-point lead to win.';
      }
    }

    return null;
  }
}
