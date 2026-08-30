// States for the DeepLinkBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';

sealed class DeepLinkState extends Equatable {
  const DeepLinkState();

  @override
  List<Object?> get props => [];
}

class DeepLinkInitial extends DeepLinkState {
  const DeepLinkInitial();
}

class DeepLinkPendingInvite extends DeepLinkState {
  final String token;

  const DeepLinkPendingInvite({required this.token});

  @override
  List<Object?> get props => [token];
}

class DeepLinkPendingActivityLink extends DeepLinkState {
  final ActivityLinkTarget target;

  const DeepLinkPendingActivityLink({required this.target});

  @override
  List<Object?> get props => [target];
}

// Shared "nothing pending" sentinel for both invite tokens and activity
// link targets (name is legacy but every consumer only checks for the
// specific pending-* states, never this one, for branching logic).
class DeepLinkNoInvite extends DeepLinkState {
  const DeepLinkNoInvite();
}
