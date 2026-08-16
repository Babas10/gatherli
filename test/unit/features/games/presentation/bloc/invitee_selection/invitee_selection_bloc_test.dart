// Validates InviteeSelectionBloc correctly loads users and toggles selection.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/invitable_user.dart';
import 'package:play_with_me/core/data/models/user_model.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/invitee_selection/invitee_selection_state.dart';
import '../../../../../../helpers/mocks.dart';

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
        'emits Loading then Loaded with friends list when no groups given',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => [
                    _makeUserEntity('friend-a', displayName: 'Alice'),
                    _makeUserEntity('friend-b', displayName: 'Bob'),
                  ]);
          return makeBloc();
        },
        act: (bloc) => bloc.add(const LoadInvitees(userId: 'user-1')),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.friends.length, 'friends.length', 2)
              .having((s) => s.friends.first.uid, 'first uid', 'friend-a')
              .having((s) => s.groups, 'groups', isEmpty)
              .having((s) => s.selectedIds, 'selectedIds', isEmpty),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'loads group members into InvitableGroup',
        build: () {
          when(() => mockFriendRepo.getFriends('user-1'))
              .thenAnswer((_) async => [
                    _makeUserEntity('friend-a', displayName: 'Alice'),
                  ]);
          when(() => mockUserRepo.getUsersInGroup('group-1'))
              .thenAnswer((_) async => [
                    _makeUserModel('friend-a', displayName: 'Alice'),
                    _makeUserModel('member-b', displayName: 'Bob'),
                  ]);
          return makeBloc();
        },
        act: (bloc) => bloc.add(
          const LoadInvitees(userId: 'user-1', groups: {'group-1': 'Team A'}),
        ),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.friends.length, 'friends.length', 1)
              .having((s) => s.groups.length, 'groups.length', 1)
              .having((s) => s.groups.first.name, 'group name', 'Team A')
              .having((s) => s.groups.first.members.length, 'group members', 2),
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
          const LoadInvitees(userId: 'user-1', groups: {'group-1': 'Team A'}),
        ),
        expect: () => [
          isA<InviteeSelectionLoading>(),
          isA<InviteeSelectionLoaded>()
              .having((s) => s.groups.first.members.length, 'members', 1)
              .having(
                  (s) => s.groups.first.members.first.uid, 'uid', 'member-b'),
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
        'adds uid to selectedFriendIds when not already selected',
        build: () => makeBloc(),
        seed: () => const InviteeSelectionLoaded(
          friends: [InvitableUser(uid: 'friend-a', displayName: 'Alice')],
          groups: [],
        ),
        act: (bloc) => bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => [
          isA<InviteeSelectionLoaded>().having(
              (s) => s.selectedFriendIds, 'selectedFriendIds',
              contains('friend-a')),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'removes uid from selectedFriendIds when already selected',
        build: () => makeBloc(),
        seed: () => const InviteeSelectionLoaded(
          friends: [InvitableUser(uid: 'friend-a', displayName: 'Alice')],
          groups: [],
          selectedFriendIds: {'friend-a'},
        ),
        act: (bloc) => bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => [
          isA<InviteeSelectionLoaded>().having((s) => s.selectedFriendIds,
              'selectedFriendIds', isNot(contains('friend-a'))),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'does nothing when state is not InviteeSelectionLoaded',
        build: () => makeBloc(),
        act: (bloc) => bloc.add(const ToggleInvitee(uid: 'friend-a')),
        expect: () => <InviteeSelectionState>[],
      );
    });

    group('ToggleGroup', () {
      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'adds group to selectedGroupIds and its members to selectedIds',
        build: () => makeBloc(),
        seed: () => const InviteeSelectionLoaded(
          friends: [],
          groups: [
            InvitableGroup(
              id: 'group-1',
              name: 'Team A',
              members: [InvitableUser(uid: 'member-a')],
            ),
          ],
        ),
        act: (bloc) => bloc.add(const ToggleGroup(groupId: 'group-1')),
        expect: () => [
          isA<InviteeSelectionLoaded>()
              .having((s) => s.selectedGroupIds, 'selectedGroupIds',
                  contains('group-1'))
              .having((s) => s.selectedIds, 'selectedIds',
                  contains('member-a')),
        ],
      );

      blocTest<InviteeSelectionBloc, InviteeSelectionState>(
        'removes group from selectedGroupIds when already selected',
        build: () => makeBloc(),
        seed: () => const InviteeSelectionLoaded(
          friends: [],
          groups: [
            InvitableGroup(
              id: 'group-1',
              name: 'Team A',
              members: [InvitableUser(uid: 'member-a')],
            ),
          ],
          selectedGroupIds: {'group-1'},
        ),
        act: (bloc) => bloc.add(const ToggleGroup(groupId: 'group-1')),
        expect: () => [
          isA<InviteeSelectionLoaded>()
              .having((s) => s.selectedGroupIds, 'selectedGroupIds',
                  isNot(contains('group-1')))
              .having(
                  (s) => s.selectedIds, 'selectedIds', isNot(contains('member-a'))),
        ],
      );
    });
  });
}
