// Unit tests for ValidateGameScoresUseCase — pure business logic, no dependencies.
import 'package:flutter_test/flutter_test.dart';
import 'package:play_with_me/features/games/domain/use_cases/validate_game_scores_use_case.dart';

void main() {
  const useCase = ValidateGameScoresUseCase();

  GameScoreInput bestOf3({required List<SetScore> sets}) => GameScoreInput(
    sets: sets,
    requiredSetsToWin: 2,
    pointsToWinSet: 21,
    minimumPointDiff: 2,
  );

  group('valid scores', () {
    test('2-0 result is valid', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(21, 15),
        const SetScore(21, 17),
      ]));
      expect(result.isValid, isTrue);
      expect(result.winner, equals('teamA'));
    });

    test('0-2 result is valid', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(15, 21),
        const SetScore(17, 21),
      ]));
      expect(result.isValid, isTrue);
      expect(result.winner, equals('teamB'));
    });

    test('2-1 result is valid', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(21, 15),
        const SetScore(14, 21),
        const SetScore(15, 13),
      ]));
      expect(result.isValid, isTrue);
      expect(result.winner, equals('teamA'));
    });

    test('extended set 23-21 is valid', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(23, 21),
        const SetScore(21, 15),
      ]));
      expect(result.isValid, isTrue);
    });
  });

  group('invalid scores', () {
    test('negative scores are invalid', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(-1, 21),
      ]));
      expect(result.isValid, isFalse);
      expect(result.errorMessage, contains('negative'));
    });

    test('21-20 is invalid — need 2-point lead', () async {
      final result = await useCase(bestOf3(sets: [
        const SetScore(21, 20),
      ]));
      expect(result.isValid, isFalse);
      expect(result.errorMessage, contains('2-point lead'));
    });
  });
}
