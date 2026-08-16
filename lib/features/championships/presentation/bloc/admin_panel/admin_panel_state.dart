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
  final bool isStarting;
  final String? startError;
  final int? matchesGenerated;
  final bool isCompleting;
  final String? completeError;
  final bool isCompleted;
  final bool isEditing;
  final String? editError;

  const AdminPanelLoaded({
    required this.matches,
    this.isDeciding = false,
    this.decisionError,
    this.lastDecidedMatchId,
    this.isStarting = false,
    this.startError,
    this.matchesGenerated,
    this.isCompleting = false,
    this.completeError,
    this.isCompleted = false,
    this.isEditing = false,
    this.editError,
  });

  AdminPanelLoaded copyWith({
    List<ChampionshipMatchModel>? matches,
    bool? isDeciding,
    Object? decisionError = _sentinel,
    Object? lastDecidedMatchId = _sentinel,
    bool? isStarting,
    Object? startError = _sentinel,
    Object? matchesGenerated = _sentinel,
    bool? isCompleting,
    Object? completeError = _sentinel,
    bool? isCompleted,
    bool? isEditing,
    Object? editError = _sentinel,
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
      isStarting: isStarting ?? this.isStarting,
      startError:
          startError == _sentinel ? this.startError : startError as String?,
      matchesGenerated: matchesGenerated == _sentinel
          ? this.matchesGenerated
          : matchesGenerated as int?,
      isCompleting: isCompleting ?? this.isCompleting,
      completeError: completeError == _sentinel
          ? this.completeError
          : completeError as String?,
      isCompleted: isCompleted ?? this.isCompleted,
      isEditing: isEditing ?? this.isEditing,
      editError: editError == _sentinel ? this.editError : editError as String?,
    );
  }

  @override
  List<Object?> get props => [
        matches,
        isDeciding,
        decisionError,
        lastDecidedMatchId,
        isStarting,
        startError,
        matchesGenerated,
        isCompleting,
        completeError,
        isCompleted,
        isEditing,
        editError,
      ];
}

class AdminPanelError extends AdminPanelState {
  final String message;

  const AdminPanelError({required this.message});

  @override
  List<Object?> get props => [message];
}

const Object _sentinel = Object();
