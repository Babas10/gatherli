// States for AdminPanelBloc (Story 30.12)
import 'package:equatable/equatable.dart';
import 'package:play_with_me/features/championships/data/models/championship_match_model.dart';

abstract class AdminPanelState extends Equatable {
  const AdminPanelState();

  @override
  List<Object?> get props => [];
}

class AdminPanelInitial extends AdminPanelState {
  const AdminPanelInitial();
}

class AdminPanelLoading extends AdminPanelState {
  const AdminPanelLoading();
}

class AdminPanelLoaded extends AdminPanelState {
  /// Matches requiring admin attention: disputed OR (past deadline + not final).
  final List<ChampionshipMatchModel> matches;
  final bool isDeciding;
  final String? decisionError;
  final String? lastDecidedMatchId;

  const AdminPanelLoaded({
    required this.matches,
    this.isDeciding = false,
    this.decisionError,
    this.lastDecidedMatchId,
  });

  AdminPanelLoaded copyWith({
    List<ChampionshipMatchModel>? matches,
    bool? isDeciding,
    Object? decisionError = _sentinel,
    Object? lastDecidedMatchId = _sentinel,
  }) {
    return AdminPanelLoaded(
      matches: matches ?? this.matches,
      isDeciding: isDeciding ?? this.isDeciding,
      decisionError: decisionError == _sentinel
          ? this.decisionError
          : decisionError as String?,
      lastDecidedMatchId: lastDecidedMatchId == _sentinel
          ? this.lastDecidedMatchId
          : lastDecidedMatchId as String?,
    );
  }

  @override
  List<Object?> get props =>
      [matches, isDeciding, decisionError, lastDecidedMatchId];
}

class AdminPanelError extends AdminPanelState {
  final String message;

  const AdminPanelError({required this.message});

  @override
  List<Object?> get props => [message];
}

const Object _sentinel = Object();
