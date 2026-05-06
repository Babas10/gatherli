// Tests FirestoreInvitationRepository methods with the unified invitations collection.
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/invitation_model.dart';
import 'package:play_with_me/core/data/repositories/firestore_invitation_repository.dart';

class MockFirebaseFunctions extends Mock implements FirebaseFunctions {}

class MockHttpsCallable extends Mock implements HttpsCallable {}

class MockHttpsCallableResult extends Mock implements HttpsCallableResult {}

void main() {
  group('FirestoreInvitationRepository', () {
    late FakeFirebaseFirestore fakeFirestore;
    late MockFirebaseFunctions mockFunctions;
    late MockHttpsCallable mockCallable;
    late FirestoreInvitationRepository repository;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      mockFunctions = MockFirebaseFunctions();
      mockCallable = MockHttpsCallable();

      when(() => mockFunctions.httpsCallable(any())).thenReturn(mockCallable);
      when(
        () => mockCallable.call(any()),
      ).thenAnswer((_) async => MockHttpsCallableResult());

      repository = FirestoreInvitationRepository(
        firestore: fakeFirestore,
        functions: mockFunctions,
      );
    });

    group('sendGroupInvitation', () {
      test('calls sendInvitation Cloud Function with type=group', () async {
        // Arrange
        final mockResult = MockHttpsCallableResult();
        when(() => mockResult.data)
            .thenReturn({'success': true, 'invitationId': 'invitation-789'});
        when(
          () => mockCallable.call(any()),
        ).thenAnswer((_) async => mockResult);

        // Act
        final invitationId = await repository.sendGroupInvitation(
          groupId: 'group-123',
          invitedUserId: 'user-456',
        );

        // Assert
        expect(invitationId, 'invitation-789');
        verify(() => mockFunctions.httpsCallable('sendInvitation')).called(1);
        verify(
          () => mockCallable.call({
            'type': 'group',
            'groupId': 'group-123',
            'invitedUserId': 'user-456',
          }),
        ).called(1);
      });

      test('throws InvitationException for permission-denied error', () async {
        when(() => mockCallable.call(any())).thenThrow(
          FirebaseFunctionsException(
            code: 'permission-denied',
            message: 'You can only invite friends to groups',
          ),
        );

        expect(
          () => repository.sendGroupInvitation(
            groupId: 'group-123',
            invitedUserId: 'user-456',
          ),
          throwsA(
            predicate(
              (e) =>
                  e is Exception &&
                  e.toString().contains('You can only invite friends'),
            ),
          ),
        );
      });

      test('throws InvitationException for already-exists error', () async {
        when(() => mockCallable.call(any())).thenThrow(
          FirebaseFunctionsException(
            code: 'already-exists',
            message: 'User already has a pending invitation',
          ),
        );

        expect(
          () => repository.sendGroupInvitation(
            groupId: 'group-123',
            invitedUserId: 'user-456',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('getPendingInvitations', () {
      test('returns stream of pending invitations from unified collection',
          () async {
        // Arrange — write to top-level invitations collection
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'groupId': 'group-123',
          'groupName': 'Test Group 1',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John Doe',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'groupId': 'group-789',
          'groupName': 'Test Group 2',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-111',
          'inviterName': 'Jane Smith',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        // Non-pending — should not be returned
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'groupId': 'group-999',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-222',
          'inviterName': 'Bob',
          'status': 'accepted',
          'createdAt': Timestamp.now(),
        });

        // Act
        final stream = repository.getPendingInvitations('user-456');

        // Assert
        await expectLater(
          stream,
          emits(
            predicate<List<InvitationModel>>((invitations) {
              return invitations.length == 2 &&
                  invitations.every((inv) => inv.status == InvitationStatus.pending);
            }),
          ),
        );
      });

      test('returns empty list when user has no pending invitations', () async {
        final stream = repository.getPendingInvitations('user-456');
        await expectLater(
          stream,
          emits(predicate<List<InvitationModel>>((list) => list.isEmpty)),
        );
      });
    });

    group('getInvitations', () {
      test('returns all invitations regardless of status', () async {
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-111',
          'inviterName': 'Jane',
          'status': 'accepted',
          'createdAt': Timestamp.now(),
        });

        final invitations = await repository.getInvitations('user-456');
        expect(invitations, hasLength(2));
      });

      test('returns empty list when user has no invitations', () async {
        final invitations = await repository.getInvitations('user-456');
        expect(invitations, isEmpty);
      });
    });

    group('hasPendingGroupInvitation', () {
      test('returns true when pending invitation exists for group', () async {
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'groupId': 'group-123',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        final hasPending = await repository.hasPendingGroupInvitation(
          userId: 'user-456',
          groupId: 'group-123',
        );

        expect(hasPending, true);
      });

      test('returns false when no pending invitation exists', () async {
        final hasPending = await repository.hasPendingGroupInvitation(
          userId: 'user-456',
          groupId: 'group-123',
        );
        expect(hasPending, false);
      });

      test('returns false when invitation is not pending', () async {
        await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'groupId': 'group-123',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John',
          'status': 'accepted',
          'createdAt': Timestamp.now(),
        });

        final hasPending = await repository.hasPendingGroupInvitation(
          userId: 'user-456',
          groupId: 'group-123',
        );
        expect(hasPending, false);
      });
    });

    group('acceptInvitation', () {
      test('calls acceptInvitation Cloud Function', () async {
        await repository.acceptInvitation(
          userId: 'user-456',
          invitationId: 'invitation-123',
        );

        verify(
          () => mockFunctions.httpsCallable('acceptInvitation'),
        ).called(1);
        verify(
          () => mockCallable.call({'invitationId': 'invitation-123'}),
        ).called(1);
      });

      test('throws exception when Cloud Function fails', () async {
        when(() => mockCallable.call(any())).thenThrow(
          FirebaseFunctionsException(
            code: 'not-found',
            message: 'Invitation not found',
          ),
        );

        expect(
          () => repository.acceptInvitation(
            userId: 'user-456',
            invitationId: 'non-existent-id',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('declineInvitation', () {
      test('calls declineInvitation Cloud Function', () async {
        await repository.declineInvitation(
          userId: 'user-456',
          invitationId: 'invitation-123',
        );

        verify(
          () => mockFunctions.httpsCallable('declineInvitation'),
        ).called(1);
        verify(
          () => mockCallable.call({'invitationId': 'invitation-123'}),
        ).called(1);
      });

      test('throws exception when Cloud Function fails', () async {
        when(() => mockCallable.call(any())).thenThrow(
          FirebaseFunctionsException(
            code: 'not-found',
            message: 'Invitation not found',
          ),
        );

        expect(
          () => repository.declineInvitation(
            userId: 'user-456',
            invitationId: 'non-existent-id',
          ),
          throwsA(isA<Exception>()),
        );
      });
    });

    group('deleteInvitation', () {
      test('deletes invitation from top-level collection', () async {
        final docRef = await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        await repository.deleteInvitation(
          userId: 'user-456',
          invitationId: docRef.id,
        );

        final doc = await docRef.get();
        expect(doc.exists, false);
      });
    });

    group('cancelInvitation', () {
      test('removes invitation document', () async {
        final docRef = await fakeFirestore.collection('invitations').add({
          'type': 'group',
          'invitedUserId': 'user-456',
          'invitedBy': 'user-123',
          'inviterName': 'John',
          'status': 'pending',
          'createdAt': Timestamp.now(),
        });

        await repository.cancelInvitation(
          userId: 'user-456',
          invitationId: docRef.id,
        );

        final doc = await docRef.get();
        expect(doc.exists, false);
      });
    });
  });
}
