// Validates MatchChatBloc state transitions for loading, receiving, and sending messages.
import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_chat/match_chat_bloc.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_chat/match_chat_event.dart';
import 'package:play_with_me/features/championships/presentation/bloc/match_chat/match_chat_state.dart';

import '../../../../../helpers/mocks.dart';

ChatMessageModel _message({
  String id = 'msg-1',
  String senderId = 'user-1',
  String senderDisplayName = 'Alice',
  String text = 'Hello!',
  String? teamId = 'team-1',
}) =>
    ChatMessageModel(
      id: id,
      senderId: senderId,
      senderDisplayName: senderDisplayName,
      text: text,
      sentAt: DateTime(2026, 8, 1, 10),
      teamId: teamId,
    );

void main() {
  late MockMessageRepository mockRepo;

  const String championshipId = 'champ-1';
  const String matchId = 'match-1';
  const String contextPath = 'championships/$championshipId/matches/$matchId';

  setUpAll(() {
    registerFallbackValues();
    registerFallbackValue(_message());
  });

  setUp(() {
    mockRepo = MockMessageRepository();
  });

  MatchChatBloc makeBloc() => MatchChatBloc(messageRepository: mockRepo);

  group('LoadMatchChat', () {
    blocTest<MatchChatBloc, MatchChatState>(
      'emits Loading then Loaded(empty) when stream emits empty list',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => Stream.value([]));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const LoadMatchChat(
          championshipId: championshipId,
          matchId: matchId,
        ),
      ),
      expect: () => [
        const MatchChatLoading(),
        const MatchChatLoaded(messages: []),
      ],
    );

    blocTest<MatchChatBloc, MatchChatState>(
      'emits Loading then Loaded with messages when stream emits messages',
      build: () {
        final msg = _message();
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => Stream.value([msg]));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const LoadMatchChat(
          championshipId: championshipId,
          matchId: matchId,
        ),
      ),
      expect: () => [
        const MatchChatLoading(),
        MatchChatLoaded(messages: [_message()]),
      ],
    );

    blocTest<MatchChatBloc, MatchChatState>(
      'emits Loaded(empty) when stream emits error',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer(
          (_) => Stream.error(Exception('stream error')),
        );
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const LoadMatchChat(
          championshipId: championshipId,
          matchId: matchId,
        ),
      ),
      expect: () => [
        const MatchChatLoading(),
        const MatchChatLoaded(messages: []),
      ],
    );

    blocTest<MatchChatBloc, MatchChatState>(
      'cancels previous subscription on reload and calls getMessages twice',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => Stream.value([]));
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(
          const LoadMatchChat(
            championshipId: championshipId,
            matchId: matchId,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const LoadMatchChat(
            championshipId: championshipId,
            matchId: matchId,
          ),
        );
      },
      verify: (_) => verify(
        () => mockRepo.getMessages(contextPath: contextPath),
      ).called(2),
      expect: () => isNotEmpty,
    );
  });

  group('SendMatchChatMessage', () {
    blocTest<MatchChatBloc, MatchChatState>(
      'sets isSending true then false on success',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => Stream.value([_message()]));
        when(
          () => mockRepo.sendMessage(
            contextPath: contextPath,
            senderId: any(named: 'senderId'),
            senderDisplayName: any(named: 'senderDisplayName'),
            text: any(named: 'text'),
            teamId: any(named: 'teamId'),
          ),
        ).thenAnswer((_) async {});
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(
          const LoadMatchChat(
            championshipId: championshipId,
            matchId: matchId,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SendMatchChatMessage(
            championshipId: championshipId,
            matchId: matchId,
            senderId: 'user-1',
            senderDisplayName: 'Alice',
            text: 'Hi',
            teamId: 'team-1',
          ),
        );
      },
      expect: () => [
        const MatchChatLoading(),
        MatchChatLoaded(messages: [_message()]),
        MatchChatLoaded(messages: [_message()], isSending: true),
        MatchChatLoaded(messages: [_message()], isSending: false),
      ],
    );

    blocTest<MatchChatBloc, MatchChatState>(
      'restores isSending false and emits addError on MessageException',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => Stream.value([_message()]));
        when(
          () => mockRepo.sendMessage(
            contextPath: contextPath,
            senderId: any(named: 'senderId'),
            senderDisplayName: any(named: 'senderDisplayName'),
            text: any(named: 'text'),
            teamId: any(named: 'teamId'),
          ),
        ).thenThrow(MessageException('send failed'));
        return makeBloc();
      },
      act: (bloc) async {
        bloc.add(
          const LoadMatchChat(
            championshipId: championshipId,
            matchId: matchId,
          ),
        );
        await Future<void>.delayed(Duration.zero);
        bloc.add(
          const SendMatchChatMessage(
            championshipId: championshipId,
            matchId: matchId,
            senderId: 'user-1',
            senderDisplayName: 'Alice',
            text: 'Hi',
          ),
        );
      },
      expect: () => [
        const MatchChatLoading(),
        MatchChatLoaded(messages: [_message()]),
        MatchChatLoaded(messages: [_message()], isSending: true),
        MatchChatLoaded(messages: [_message()], isSending: false),
      ],
      errors: () => [isA<Exception>()],
    );

    blocTest<MatchChatBloc, MatchChatState>(
      'does nothing when state is not Loaded',
      build: () {
        when(
          () => mockRepo.getMessages(contextPath: contextPath),
        ).thenAnswer((_) => const Stream.empty());
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const SendMatchChatMessage(
          championshipId: championshipId,
          matchId: matchId,
          senderId: 'user-1',
          senderDisplayName: 'Alice',
          text: 'Hi',
        ),
      ),
      expect: () => [],
    );
  });

  group('contextPath', () {
    blocTest<MatchChatBloc, MatchChatState>(
      'uses championships/championshipId/matches/matchId as context path',
      build: () {
        when(
          () => mockRepo.getMessages(
            contextPath: 'championships/champ-99/matches/match-42',
          ),
        ).thenAnswer((_) => Stream.value([]));
        return makeBloc();
      },
      act: (bloc) => bloc.add(
        const LoadMatchChat(championshipId: 'champ-99', matchId: 'match-42'),
      ),
      verify: (_) => verify(
        () => mockRepo.getMessages(
          contextPath: 'championships/champ-99/matches/match-42',
        ),
      ).called(1),
    );
  });
}
