// Validates PartnerPickerBloc state transitions for loading partners and single-select logic.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/domain/repositories/friend_repository.dart';
import 'package:play_with_me/features/auth/domain/entities/user_entity.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/partner_picker/partner_picker_state.dart';

class MockFriendRepository extends Mock implements FriendRepository {}

UserEntity _user(String uid, String name) => UserEntity(
      uid: uid,
      email: '$uid@test.com',
      displayName: name,
      isEmailVerified: true,
    );

void main() {
  late MockFriendRepository mockFriendRepository;

  setUp(() {
    mockFriendRepository = MockFriendRepository();
  });

  PartnerPickerBloc makeBloc() =>
      PartnerPickerBloc(friendRepository: mockFriendRepository);

  group('LoadPartners', () {
    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'emits [Loading, Loaded] with friends list on success',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any())).thenAnswer(
          (_) async => [_user('uid-a', 'Alice'), _user('uid-b', 'Bob')],
        );
      },
      act: (bloc) => bloc.add(const LoadPartners('user-123')),
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.friends.length, 'friends length', 2)
            .having((s) => s.selectedPartnerId, 'selectedPartnerId', isNull),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'emits [Loading, Loaded] with empty list when user has no friends',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any()))
            .thenAnswer((_) async => []);
      },
      act: (bloc) => bloc.add(const LoadPartners('user-123')),
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.friends, 'friends', isEmpty),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'deduplicates friends with the same uid',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any())).thenAnswer(
          (_) async => [_user('uid-a', 'Alice'), _user('uid-a', 'Alice')],
        );
      },
      act: (bloc) => bloc.add(const LoadPartners('user-123')),
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.friends.length, 'friends length', 1),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'emits [Loading, Error] on FriendshipException',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any()))
            .thenThrow(FriendshipException('Network error'));
      },
      act: (bloc) => bloc.add(const LoadPartners('user-123')),
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerError>(),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'emits [Loading, Error] on unexpected exception',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any()))
            .thenThrow(Exception('unexpected'));
      },
      act: (bloc) => bloc.add(const LoadPartners('user-123')),
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerError>(),
      ],
    );
  });

  group('SelectPartner', () {
    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'selects a partner from the loaded list',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any())).thenAnswer(
          (_) async => [_user('uid-a', 'Alice')],
        );
      },
      act: (bloc) async {
        bloc.add(const LoadPartners('user-123'));
        await Future.delayed(Duration.zero);
        bloc.add(const SelectPartner('uid-a'));
      },
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selectedPartnerId', isNull),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selectedPartnerId', 'uid-a'),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'deselects when tapping the already-selected partner',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any())).thenAnswer(
          (_) async => [_user('uid-a', 'Alice')],
        );
      },
      act: (bloc) async {
        bloc.add(const LoadPartners('user-123'));
        await Future.delayed(Duration.zero);
        bloc.add(const SelectPartner('uid-a'));
        await Future.delayed(Duration.zero);
        bloc.add(const SelectPartner('uid-a')); // tap again → deselect
      },
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', isNull),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', 'uid-a'),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', isNull),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'selecting a new partner replaces the previous selection',
      build: makeBloc,
      setUp: () {
        when(() => mockFriendRepository.getFriends(any())).thenAnswer(
          (_) async => [_user('uid-a', 'Alice'), _user('uid-b', 'Bob')],
        );
      },
      act: (bloc) async {
        bloc.add(const LoadPartners('user-123'));
        await Future.delayed(Duration.zero);
        bloc.add(const SelectPartner('uid-a'));
        await Future.delayed(Duration.zero);
        bloc.add(const SelectPartner('uid-b'));
      },
      expect: () => [
        const PartnerPickerLoading(),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', isNull),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', 'uid-a'),
        isA<PartnerPickerLoaded>()
            .having((s) => s.selectedPartnerId, 'selected', 'uid-b'),
      ],
    );

    blocTest<PartnerPickerBloc, PartnerPickerState>(
      'ignores SelectPartner when state is not loaded',
      build: makeBloc,
      act: (bloc) => bloc.add(const SelectPartner('uid-a')),
      expect: () => <PartnerPickerState>[],
    );
  });
}
