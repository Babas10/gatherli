// Manages championship match result submission flow.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'result_submission_event.dart';
import 'result_submission_state.dart';

class ResultSubmissionBloc
    extends Bloc<ResultSubmissionEvent, ResultSubmissionState> {
  final ChampionshipRepository _championshipRepository;

  ResultSubmissionBloc({required ChampionshipRepository championshipRepository})
      : _championshipRepository = championshipRepository,
        super(const ResultSubmissionInitial()) {
    on<SubmitMatchResult>(_onSubmitMatchResult);
  }

  Future<void> _onSubmitMatchResult(
    SubmitMatchResult event,
    Emitter<ResultSubmissionState> emit,
  ) async {
    emit(const ResultSubmissionSubmitting());
    try {
      await _championshipRepository.submitMatchResult(
        championshipId: event.championshipId,
        matchId: event.matchId,
        sets: event.sets,
      );
      emit(const ResultSubmissionSuccess());
    } on ChampionshipException catch (e) {
      emit(ResultSubmissionError(message: e.message, errorCode: e.code));
    } catch (e) {
      emit(
        ResultSubmissionError(message: 'Failed to submit result: ${e.toString()}'),
      );
    }
  }
}
