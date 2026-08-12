// Manages championship creation form submission.
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'championship_creation_event.dart';
import 'championship_creation_state.dart';

class ChampionshipCreationBloc
    extends Bloc<ChampionshipCreationEvent, ChampionshipCreationState> {
  final ChampionshipRepository _repository;

  ChampionshipCreationBloc({required ChampionshipRepository repository})
      : _repository = repository,
        super(const ChampionshipCreationInitial()) {
    on<SubmitChampionshipCreation>(_onSubmit);
  }

  Future<void> _onSubmit(
    SubmitChampionshipCreation event,
    Emitter<ChampionshipCreationState> emit,
  ) async {
    emit(const ChampionshipCreationSubmitting());
    try {
      final id = await _repository.createChampionship(
        title: event.title,
        registrationDeadline: event.registrationDeadline,
        startDate: event.startDate,
        endDate: event.endDate,
        country: event.country,
        region: event.region,
        genderCategory: event.genderCategory,
        maxTeams: event.maxTeams,
        teamSize: event.teamSize,
      );
      emit(ChampionshipCreationSuccess(championshipId: id));
    } on ChampionshipException catch (e) {
      emit(ChampionshipCreationError(message: e.message));
    } catch (e) {
      emit(ChampionshipCreationError(
        message: 'Failed to create championship: $e',
      ));
    }
  }
}
