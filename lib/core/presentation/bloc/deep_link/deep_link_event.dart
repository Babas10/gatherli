// Events for the DeepLinkBloc.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/domain/entities/activity_link_target.dart';

sealed class DeepLinkEvent extends Equatable {
  const DeepLinkEvent();

  @override
  List<Object?> get props => [];
}

class InitializeDeepLinks extends DeepLinkEvent {
  const InitializeDeepLinks();
}

class InviteTokenReceived extends DeepLinkEvent {
  final String token;

  const InviteTokenReceived(this.token);

  @override
  List<Object?> get props => [token];
}

class ClearPendingInvite extends DeepLinkEvent {
  const ClearPendingInvite();
}

class ActivityLinkReceived extends DeepLinkEvent {
  final ActivityLinkTarget target;

  const ActivityLinkReceived(this.target);

  @override
  List<Object?> get props => [target];
}

class ClearPendingActivityLink extends DeepLinkEvent {
  const ClearPendingActivityLink();
}
