// Central mock and fake registry for all test files.
//
// Usage:
//   import '../helpers/mocks.dart'; // adjust relative depth as needed
//
// Call registerFallbackValues() once in setUpAll() in any test that uses
// any Fake* class as a fallback argument matcher.

// ignore_for_file: lines_longer_than_80_chars

import 'package:bloc_test/bloc_test.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mocktail/mocktail.dart';

// Auth
import 'package:play_with_me/features/auth/domain/repositories/auth_repository.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/authentication/authentication_state.dart';
import 'package:play_with_me/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/login/login_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/login/login_state.dart';
import 'package:play_with_me/features/auth/presentation/bloc/password_reset/password_reset_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/password_reset/password_reset_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/password_reset/password_reset_state.dart';
import 'package:play_with_me/features/auth/presentation/bloc/registration/registration_bloc.dart';
import 'package:play_with_me/features/auth/presentation/bloc/registration/registration_event.dart';
import 'package:play_with_me/features/auth/presentation/bloc/registration/registration_state.dart';

// Championships
import 'package:play_with_me/features/championships/domain/repositories/championship_repository.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/admin_panel/admin_panel_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_creation/championship_creation_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_detail/championship_detail_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/championship_list/championship_list_state.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_detail/match_detail_state.dart';

// Core repositories
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/core/domain/repositories/game_repository.dart';
import 'package:play_with_me/core/domain/repositories/group_repository.dart';
import 'package:play_with_me/core/domain/repositories/group_invite_link_repository.dart';
import 'package:play_with_me/core/domain/repositories/image_storage_repository.dart';
import 'package:play_with_me/core/domain/repositories/invitation_repository.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/domain/repositories/user_repository.dart';
import 'package:play_with_me/core/services/image_picker_service.dart';
import 'package:play_with_me/core/services/deep_link_service.dart';
import 'package:play_with_me/core/services/deferred_deep_link/deferred_deep_link_orchestrator.dart';
import 'package:play_with_me/core/services/pending_invite_storage.dart';
import 'package:play_with_me/core/services/pending_activity_link_storage.dart';

// Core BLoCs
import 'package:play_with_me/core/presentation/bloc/account_status/account_status_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/deep_link/deep_link_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/group/group_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/group/group_event.dart';
import 'package:play_with_me/core/presentation/bloc/group/group_state.dart';
import 'package:play_with_me/core/presentation/bloc/group_member/group_member_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/group_member/group_member_event.dart';
import 'package:play_with_me/core/presentation/bloc/group_member/group_member_state.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_event.dart';
import 'package:play_with_me/core/presentation/bloc/invitation/invitation_state.dart';

// Friends
import 'package:play_with_me/features/friends/presentation/bloc/friend_bloc.dart';
import 'package:play_with_me/features/friends/presentation/bloc/friend_event.dart';
import 'package:play_with_me/features/friends/presentation/bloc/friend_state.dart';

// Games
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_creation/game_creation_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_history/game_history_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_history/game_history_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_history/game_history_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_invitations/game_invitations_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/games_list/games_list_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/games_list/games_list_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/games_list/games_list_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/record_results/record_results_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/record_results/record_results_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/record_results/record_results_state.dart';
import 'package:play_with_me/features/games/presentation/bloc/score_entry/score_entry_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/score_entry/score_entry_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/score_entry/score_entry_state.dart';

// Groups
import 'package:play_with_me/features/groups/presentation/bloc/group_invite_link/group_invite_link_bloc.dart';
import 'package:play_with_me/features/groups/presentation/bloc/group_invite_link/group_invite_link_event.dart';
import 'package:play_with_me/features/groups/presentation/bloc/group_invite_link/group_invite_link_state.dart';

// Invitations
import 'package:play_with_me/features/invitations/presentation/bloc/invite_join/invite_join_bloc.dart';
import 'package:play_with_me/features/invitations/presentation/bloc/invite_registration/invite_registration_bloc.dart';
import 'package:play_with_me/features/invitations/presentation/bloc/invite_registration/invite_registration_event.dart';
import 'package:play_with_me/features/invitations/presentation/bloc/invite_registration/invite_registration_state.dart';

// Notifications
import 'package:play_with_me/features/notifications/domain/repositories/notification_repository.dart';

// Profile
import 'package:play_with_me/features/profile/domain/entities/locale_preferences_entity.dart';
import 'package:play_with_me/features/profile/domain/repositories/locale_preferences_repository.dart';
import 'package:play_with_me/features/profile/presentation/bloc/player_stats/player_stats_bloc.dart';

// Training
import 'package:play_with_me/features/training/presentation/bloc/exercise/exercise_bloc.dart';
import 'package:play_with_me/features/training/presentation/bloc/feedback/training_feedback_bloc.dart';
import 'package:play_with_me/features/training/presentation/bloc/feedback/training_feedback_event.dart';
import 'package:play_with_me/features/training/presentation/bloc/feedback/training_feedback_state.dart';
import 'package:play_with_me/features/training/presentation/bloc/training_session_creation/training_session_creation_bloc.dart';
import 'package:play_with_me/features/training/presentation/bloc/training_session_creation/training_session_creation_event.dart';
import 'package:play_with_me/features/training/presentation/bloc/training_session_creation/training_session_creation_state.dart';

// ─── Firebase infrastructure ─────────────────────────────────────────────────

class MockFirebaseAnalytics extends Mock implements FirebaseAnalytics {}
class MockFirebaseAuth extends Mock implements FirebaseAuth {}
class MockUser extends Mock implements User {}
// ignore: subtype_of_sealed_class
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}
class MockHttpsCallable extends Mock implements HttpsCallable {}
class MockHttpsCallableResult<T> extends Mock
    implements HttpsCallableResult<T> {}

// ─── Navigation ───────────────────────────────────────────────────────────────

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
class FakeRoute extends Fake implements Route<dynamic> {}

// ─── Auth ────────────────────────────────────────────────────────────────────

class MockAuthRepository extends Mock implements AuthRepository {}
class MockAuthenticationBloc
    extends MockBloc<AuthenticationEvent, AuthenticationState>
    implements AuthenticationBloc {}
class MockLoginBloc extends MockBloc<LoginEvent, LoginState>
    implements LoginBloc {}
class MockRegistrationBloc
    extends MockBloc<RegistrationEvent, RegistrationState>
    implements RegistrationBloc {}
class MockPasswordResetBloc
    extends MockBloc<PasswordResetEvent, PasswordResetState>
    implements PasswordResetBloc {}

class FakeAuthenticationEvent extends Fake implements AuthenticationEvent {}
class FakeAuthenticationState extends Fake implements AuthenticationState {}
class FakeLoginEvent extends Fake implements LoginEvent {}
class FakeLoginState extends Fake implements LoginState {}
class FakeRegistrationEvent extends Fake implements RegistrationEvent {}
class FakeRegistrationState extends Fake implements RegistrationState {}
class FakePasswordResetEvent extends Fake implements PasswordResetEvent {}
class FakePasswordResetState extends Fake implements PasswordResetState {}

// ─── Core repositories ───────────────────────────────────────────────────────

class MockUserRepository extends Mock implements UserRepository {}
class MockGameRepository extends Mock implements GameRepository {}
class MockGroupRepository extends Mock implements GroupRepository {}
class MockInvitationRepository extends Mock implements InvitationRepository {}
class MockFriendRepository extends Mock implements FriendRepository {}
class MockGroupInviteLinkRepository extends Mock
    implements GroupInviteLinkRepository {}
class MockPendingInviteStorage extends Mock implements PendingInviteStorage {}
class MockPendingActivityLinkStorage extends Mock
    implements PendingActivityLinkStorage {}
class MockMessageRepository extends Mock implements MessageRepository {}
class MockNotificationRepository extends Mock
    implements NotificationRepository {}
class MockImageStorageRepository extends Mock
    implements ImageStorageRepository {}
class MockImagePickerService extends Mock implements ImagePickerService {}

// ─── Core BLoCs ──────────────────────────────────────────────────────────────

class MockInvitationBloc extends MockBloc<InvitationEvent, InvitationState>
    implements InvitationBloc {}
class MockGroupBloc extends MockBloc<GroupEvent, GroupState>
    implements GroupBloc {}
class MockGroupMemberBloc extends MockBloc<GroupMemberEvent, GroupMemberState>
    implements GroupMemberBloc {}
class MockAccountStatusBloc extends Mock implements AccountStatusBloc {}
class MockDeepLinkBloc extends Mock implements DeepLinkBloc {}
class MockDeepLinkService extends Mock implements DeepLinkService {}
class MockDeferredDeepLinkOrchestrator extends Mock
    implements DeferredDeepLinkOrchestrator {}
class MockLocalePreferencesRepository extends Mock
    implements LocalePreferencesRepository {}

class FakeInvitationEvent extends Fake implements InvitationEvent {}
class FakeInvitationState extends Fake implements InvitationState {}
class FakeGroupEvent extends Fake implements GroupEvent {}
class FakeGroupState extends Fake implements GroupState {}
class FakeGroupMemberEvent extends Fake implements GroupMemberEvent {}
class FakeGroupMemberState extends Fake implements GroupMemberState {}
class FakeLocalePreferencesEntity extends Fake
    implements LocalePreferencesEntity {}
class FakeUserModel extends Fake implements UserModel {}

// ─── Friends ─────────────────────────────────────────────────────────────────

class MockFriendBloc extends MockBloc<FriendEvent, FriendState>
    implements FriendBloc {}

class FakeFriendEvent extends Fake implements FriendEvent {}
class FakeFriendState extends Fake implements FriendState {}

// ─── Games ───────────────────────────────────────────────────────────────────

class MockGamesListBloc extends MockBloc<GamesListEvent, GamesListState>
    implements GamesListBloc {}
class MockGameCreationBloc
    extends MockBloc<GameCreationEvent, GameCreationState>
    implements GameCreationBloc {}
class MockGameHistoryBloc
    extends MockBloc<GameHistoryEvent, GameHistoryState>
    implements GameHistoryBloc {}
class MockGameInvitationsBloc
    extends MockBloc<GameInvitationsEvent, GameInvitationsState>
    implements GameInvitationsBloc {}
class MockInviteeSelectionBloc
    extends MockBloc<InviteeSelectionEvent, InviteeSelectionState>
    implements InviteeSelectionBloc {}
class MockRecordResultsBloc
    extends MockBloc<RecordResultsEvent, RecordResultsState>
    implements RecordResultsBloc {}
class MockScoreEntryBloc extends MockBloc<ScoreEntryEvent, ScoreEntryState>
    implements ScoreEntryBloc {}

class FakeGamesListEvent extends Fake implements GamesListEvent {}
class FakeGamesListState extends Fake implements GamesListState {}
class FakeGameCreationEvent extends Fake implements GameCreationEvent {}
class FakeGameCreationState extends Fake implements GameCreationState {}
class FakeGameHistoryEvent extends Fake implements GameHistoryEvent {}
class FakeGameHistoryState extends Fake implements GameHistoryState {}
// GameInvitations event/state are part files — no separate Fake classes needed.
class FakeInviteeSelectionEvent extends Fake implements InviteeSelectionEvent {}
class FakeInviteeSelectionState extends Fake implements InviteeSelectionState {}
class FakeRecordResultsEvent extends Fake implements RecordResultsEvent {}
class FakeRecordResultsState extends Fake implements RecordResultsState {}
class FakeScoreEntryEvent extends Fake implements ScoreEntryEvent {}
class FakeScoreEntryState extends Fake implements ScoreEntryState {}

// ─── Groups ──────────────────────────────────────────────────────────────────

class MockGroupInviteLinkBloc
    extends MockBloc<GroupInviteLinkEvent, GroupInviteLinkState>
    implements GroupInviteLinkBloc {}

// ─── Invitations ─────────────────────────────────────────────────────────────

class MockInviteJoinBloc extends Mock implements InviteJoinBloc {}
class MockInviteRegistrationBloc
    extends MockBloc<InviteRegistrationEvent, InviteRegistrationState>
    implements InviteRegistrationBloc {}

// ─── Profile ─────────────────────────────────────────────────────────────────

class MockPlayerStatsBloc extends Mock implements PlayerStatsBloc {}

// ─── Training ────────────────────────────────────────────────────────────────

class MockExerciseBloc extends Mock implements ExerciseBloc {}
class MockTrainingSessionCreationBloc
    extends MockBloc<TrainingSessionCreationEvent, TrainingSessionCreationState>
    implements TrainingSessionCreationBloc {}
class MockTrainingFeedbackBloc
    extends MockBloc<TrainingFeedbackEvent, TrainingFeedbackState>
    implements TrainingFeedbackBloc {}

class FakeTrainingSessionCreationEvent extends Fake
    implements TrainingSessionCreationEvent {}
class FakeTrainingSessionCreationState extends Fake
    implements TrainingSessionCreationState {}
class FakeTrainingFeedbackEvent extends Fake implements TrainingFeedbackEvent {}
class FakeTrainingFeedbackState extends Fake implements TrainingFeedbackState {}

// ─── Championships ───────────────────────────────────────────────────────────

class MockChampionshipRepository extends Mock
    implements ChampionshipRepository {}
class MockChampionshipDetailBloc
    extends MockBloc<ChampionshipDetailEvent, ChampionshipDetailState>
    implements ChampionshipDetailBloc {}
class MockChampionshipListBloc
    extends MockBloc<ChampionshipListEvent, ChampionshipListState>
    implements ChampionshipListBloc {}
class MockChampionshipCreationBloc
    extends MockBloc<ChampionshipCreationEvent, ChampionshipCreationState>
    implements ChampionshipCreationBloc {}
class MockAdminPanelBloc extends MockBloc<AdminPanelEvent, AdminPanelState>
    implements AdminPanelBloc {}
class MockMatchDetailBloc extends MockBloc<MatchDetailEvent, MatchDetailState>
    implements MatchDetailBloc {}

class FakeChampionshipDetailEvent extends Fake
    implements ChampionshipDetailEvent {}
class FakeChampionshipDetailState extends Fake
    implements ChampionshipDetailState {}
class FakeChampionshipCreationEvent extends Fake
    implements ChampionshipCreationEvent {}
class FakeChampionshipCreationState extends Fake
    implements ChampionshipCreationState {}
class FakeAdminPanelEvent extends Fake implements AdminPanelEvent {}
class FakeAdminPanelState extends Fake implements AdminPanelState {}
class FakeMatchDetailEvent extends Fake implements MatchDetailEvent {}
class FakeMatchDetailState extends Fake implements MatchDetailState {}
class FakeChampionshipListEvent extends Fake implements ChampionshipListEvent {}
class FakeChampionshipListState extends Fake implements ChampionshipListState {}

// ─── Fallback value registration ─────────────────────────────────────────────

/// Call once in `setUpAll()` for any test that uses Fake* classes as
/// fallback argument matchers with `any()`.
void registerFallbackValues() {
  // Navigation
  registerFallbackValue(FakeRoute());

  // Auth
  registerFallbackValue(FakeAuthenticationEvent());
  registerFallbackValue(FakeAuthenticationState());
  registerFallbackValue(FakeLoginEvent());
  registerFallbackValue(FakeLoginState());
  registerFallbackValue(FakeRegistrationEvent());
  registerFallbackValue(FakeRegistrationState());
  registerFallbackValue(FakePasswordResetEvent());
  registerFallbackValue(FakePasswordResetState());

  // Core BLoCs
  registerFallbackValue(FakeInvitationEvent());
  registerFallbackValue(FakeInvitationState());
  registerFallbackValue(FakeGroupEvent());
  registerFallbackValue(FakeGroupState());
  registerFallbackValue(FakeGroupMemberEvent());
  registerFallbackValue(FakeGroupMemberState());
  registerFallbackValue(FakeLocalePreferencesEntity());
  registerFallbackValue(FakeUserModel());

  // Friends
  registerFallbackValue(FakeFriendEvent());
  registerFallbackValue(FakeFriendState());

  // Games
  registerFallbackValue(FakeGamesListEvent());
  registerFallbackValue(FakeGamesListState());
  registerFallbackValue(FakeGameCreationEvent());
  registerFallbackValue(FakeGameCreationState());
  registerFallbackValue(FakeGameHistoryEvent());
  registerFallbackValue(FakeGameHistoryState());

  registerFallbackValue(FakeInviteeSelectionEvent());
  registerFallbackValue(FakeInviteeSelectionState());
  registerFallbackValue(FakeRecordResultsEvent());
  registerFallbackValue(FakeRecordResultsState());
  registerFallbackValue(FakeScoreEntryEvent());
  registerFallbackValue(FakeScoreEntryState());

  // Training
  registerFallbackValue(FakeTrainingSessionCreationEvent());
  registerFallbackValue(FakeTrainingSessionCreationState());
  registerFallbackValue(FakeTrainingFeedbackEvent());
  registerFallbackValue(FakeTrainingFeedbackState());

  // Championships
  registerFallbackValue(FakeChampionshipDetailEvent());
  registerFallbackValue(FakeChampionshipDetailState());
  registerFallbackValue(FakeChampionshipCreationEvent());
  registerFallbackValue(FakeChampionshipCreationState());
  registerFallbackValue(FakeAdminPanelEvent());
  registerFallbackValue(FakeAdminPanelState());
  registerFallbackValue(FakeMatchDetailEvent());
  registerFallbackValue(FakeMatchDetailState());
  registerFallbackValue(FakeChampionshipListEvent());
  registerFallbackValue(FakeChampionshipListState());
}
