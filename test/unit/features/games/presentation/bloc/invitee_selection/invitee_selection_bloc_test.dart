// Validates InviteeSelectionBloc correctly loads users and toggles selection.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/core/domain/repositories/user_repository.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_state.dart';

class MockFriendRepository extends Mock implements FriendRepository {}

class MockUserRepository extends Mock implements UserRepository {}

UserEntity _makeUserEntity(String uid, {String? displayName}) => UserEntity(
      uid: uid,
      email: '$uid@example.com',
      displayName: displayName ?? 'User $uid',
      isEmailVerified: true,
    );

UserModel _makeUserModel(String uid, {String? displayName}) => UserModel(
      uid: uid,
      email: '$uid@example.com',
      displayName: displayName ?? 'User $uid',
    );

void main() {
  late MockFriendRepository mockFriendRepo;
  late MockUserRepository mockUserRepo;

  setUp(() {
    mockFriendRepo = MockFriendRepository();
    mockUserRepo = MockUserRepository();
  });

  InviteeSelectionBloc makeBloc() => InviteeSelectionBloc(
        friendRepository: mockFriendRepo,
        userRepository: mockUserRepo,
      );

  group('InviteeSelectionBloc', () {
    test('initial state is InviteeSelectionInitial', () {
      expect(makeBloc().state, isA<InviteeSelectionInitial>());
    });

    group('LoadInvitees', () {
      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'emits Loading then Loaded with friends list when no groupIds given',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => [
                    _makeUserEntity('friend-a', displayName: 'Alice'),
                    _makeUserEntity('friend-b', displayName: 'Bob'),
                  ]);
          return makeBloc();
        },
        act: (bloc) =>
            bloc.add(const LoadInvitees(userId: 'user-1')),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.allUsers.length, 'allUsers.length', 2)
              .having((s) => s.allUsers.first.uid, 'first uid', 'friend-a')
              .having((s) => s.selectedIds, 'selectedIds', isEmpty),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'deduplicates users — friends take priority over group members',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => [
                    _makeUserEntity('friend-a', displayName: 'Alice'),
                  ]);
          when(() => mockUserRepo.getUsersInGroup('group-1'))
              .thenAnswer((_) async => [
                    _makeUserModel('friend-a', displayName: 'Alice (group)'),
                    _makeUserModel('member-b', displayName: 'Bob'),
                  ]);
          return makeBloc();
        },
        act: (bloc) => bloc.add(
          const LoadInvitees(userId: 'user-1', groupIds: ['group-1']),
        ),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.allUsers.length, 'allUsers.length', 2)
              .having((s) => s.allUsers.first.displayName, 'first displayName',
                  'Alice')
              .having(
                (s) => s.allUsers.map((u) => u.uid).toList(),
                'uids',
                containsAll(['friend-a', 'member-b']),
              ),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'excludes the current user from group members',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => []);
          when(() => mockUserRepo.getUsersInGroup('group-1'))
              .thenAnswer((_) async => [
                    _makeUserModel('user-1'), // current user — must be excluded
                    _makeUserModel('member-b', displayName: 'Bob'),
                  ]);
          return makeBloc();
        },
        act: (bloc) => bloc.add(
          const LoadInvitees(userId: 'user-1', groupIds: ['group-1']),
        ),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.allUsers.length, 'allUsers.length', 1)
              .having((s) => s.allUsers.first.uid, 'uid', 'member-b'),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'emits InviteeSelectionError when getFriends throws',
        build: () {
          when(() => mockFriendRepo.getFriends(any()))
              .thenThrow(FriendshipException('Network error', code: 'NETWORK'));
          return makeBloc();
        },
        act: (bloc) =>
            bloc.add(const LoadInvitees(userId: 'user-1')),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionError>()
              .having((s) => s.message, 'message', 'Network error')
              .having((s) => s.errorCode, 'errorCode', 'NETWORK'),
        ],
      );
    });

    group('ToggleInvitee', () {
      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'adds uid to selectedIds when not already selected',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => [
                    _makeUserEntity('friend-a'),
                  ]);
          return makeBloc();
        },
        seed: () => InviteeSelectionLoaded(
          allUsers: [
            const InvitableUser(uid: 'friend-a', displayName: 'Alice'),
          ],
          selectedIds: const {},
        ),
        act: (bloc) =>
            bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => [
          isA<InviteeSelectionLoaded>()
              .having((s) => s.selectedIds, 'selectedIds',
                  contains('friend-a')),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'removes uid from selectedIds when already selected',
        build: () => makeBloc(),
        seed: () => InviteeSelectionLoaded(
          allUsers: [
            const InvitableUser(uid: 'friend-a', displayName: 'Alice'),
          ],
          selectedIds: const {'friend-a'},
        ),
        act: (bloc) =>
            bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => [
          isA<InviteeSelectionLoaded>()
              .having((s) => s.selectedIds, 'selectedIds',
                  isNot(contains('friend-a'))),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'does nothing when state is not InviteeSelectionLoaded',
        build: () => makeBloc(),
        act: (bloc) =>
            bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => <InviteeSelectionState>[],
      );
    });
  });
}
