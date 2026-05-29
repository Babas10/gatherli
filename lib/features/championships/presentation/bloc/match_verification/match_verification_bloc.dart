// Manages verify/dispute flow for a submitted championship match result.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'match_verification_event.dart';
import 'match_verification_state.dart';

class MatchVerificationBloc
    extends Bloc<MatchVerificationEvent, MatchVerificationState> {
  final ChampionshipRepository _championshipRepository;

  MatchVerificationBloc(
      {required ChampionshipRepository championshipRepository})
      : _championshipRepository = championshipRepository,
        super(const MatchVerificationInitial()) {
    on<VerifyMatchResult>(_onVerify);
    on<DisputeMatchResult>(_onDispute);
  }

  Future<void> _onVerify(
    VerifyMatchResult event,
    Emitter<MatchVerificationState> emit,
  ) async {
    emit(const MatchVerificationLoading());
    try {
      await _championshipRepository.verifyMatchResult(
        championshipId: event.championshipId,
        matchId: event.matchId,
        action: 'verify',
      );
      emit(const MatchVerificationVerified());
    } on ChampionshipException catch (e) {
      emit(MatchVerificationError(message: e.message, errorCode: e.code));
    } catch (e) {
      emit(MatchVerificationError(
          message: 'Failed to verify result: ${e.toString()}'));
    }
  }

  Future<void> _onDispute(
    DisputeMatchResult event,
    Emitter<MatchVerificationState> emit,
  ) async {
    emit(const MatchVerificationLoading());
    try {
      await _championshipRepository.verifyMatchResult(
        championshipId: event.championshipId,
        matchId: event.matchId,
        action: 'dispute',
        disputeReason: event.reason,
      );
      emit(const MatchVerificationDisputed());
    } on ChampionshipException catch (e) {
      emit(MatchVerificationError(message: e.message, errorCode: e.code));
    } catch (e) {
      emit(MatchVerificationError(
          message: 'Failed to dispute result: ${e.toString()}'));
    }
  }
}
