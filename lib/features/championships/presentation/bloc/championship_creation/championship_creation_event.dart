// Events for ChampionshipCreationBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_model.dart';

abstract class ChampionshipCreationEvent extends Equatable {
  const ChampionshipCreationEvent();

  @override
  List<Object?> get props => [];
}

/// Submits the championship creation form to the Cloud Function.
class SubmitChampionshipCreation extends ChampionshipCreationEvent {
  final String title;
  final DateTime registrationDeadline;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? country;
  final String? region;
  final ChampionshipGenderCategory? genderCategory;
  final int maxTeams;
  final int teamSize;

  const SubmitChampionshipCreation({
    required this.title,
    required this.registrationDeadline,
    this.startDate,
    this.endDate,
    this.country,
    this.region,
    this.genderCategory,
    this.maxTeams = 10,
    this.teamSize = 2,
  });

  @override
  List<Object?> get props => [
        title, registrationDeadline, startDate, endDate,
        country, region, genderCategory, maxTeams, teamSize,
      ];
}
