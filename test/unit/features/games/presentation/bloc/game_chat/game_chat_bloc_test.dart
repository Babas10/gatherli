// Validates GameChatBloc state transitions for chat loading and sending.
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_chat/game_chat_bloc.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_chat/game_chat_event.dart';
import 'package:play_with_me/features/games/presentation/bloc/game_chat/game_chat_state.dart';

class MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  late MockMessageRepository mockMessageRepository;

  const testContextPath = 'games/game-1';

  final testMessage = ChatMessageModel(
    id: 'msg-1',
    senderId: 'user-1',
    senderDisplayName: 'Alice',
    text: 'Hello!',
    sentAt: DateTime(2025, 1, 1, 12, 0),
  );

  setUpAll(() {
    registerFallbackValue(Stream<List<ChatMessageModel>>.empty());
  });

  setUp(() {
    mockMessageRepository = MockMessageRepository();
  });

  group('GameChatBloc', () {
    group('LoadGameChat', () {
      blocTest<GameChatBloc, GameChatState>(
        'emits [loading, loaded] with messages from stream',
        build: () {
          when(
            () => mockMessageRepository.getMessages(
              contextPath: testContextPath,
            ),
          ).thenAnswer((_) => Stream.value([testMessage]));
          return GameChatBloc(messageRepository: mockMessageRepository);
        },
        act: (bloc) =>
            bloc.add(const LoadGameChat(contextPath: testContextPath)),
        expect: () => [
          const GameChatLoading(),
          GameChatLoaded(messages: [testMessage]),
        ],
      );

      blocTest<GameChatBloc, GameChatState>(
        'emits [loading, loaded with empty list] on stream error',
        build: () {
          when(
            () => mockMessageRepository.getMessages(
              contextPath: testContextPath,
            ),
          ).thenAnswer((_) => Stream.error(Exception('error')));
          return GameChatBloc(messageRepository: mockMessageRepository);
        },
        act: (bloc) =>
            bloc.add(const LoadGameChat(contextPath: testContextPath)),
        expect: () => [
          const GameChatLoading(),
          const GameChatLoaded(messages: []),
        ],
      );
    });

    group('SendChatMessage', () {
      blocTest<GameChatBloc, GameChatState>(
        'sends message and clears isSending flag',
        build: () {
          when(
            () => mockMessageRepository.getMessages(
              contextPath: testContextPath,
            ),
          ).thenAnswer((_) => Stream.value([testMessage]));
          when(
            () => mockMessageRepository.sendMessage(
              contextPath: any(named: 'contextPath'),
              senderId: any(named: 'senderId'),
              senderDisplayName: any(named: 'senderDisplayName'),
              text: any(named: 'text'),
              teamId: any(named: 'teamId'),
            ),
          ).thenAnswer((_) async {});
          return GameChatBloc(messageRepository: mockMessageRepository);
        },
        seed: () => GameChatLoaded(messages: [testMessage]),
        act: (bloc) => bloc.add(
          const SendChatMessage(
            contextPath: testContextPath,
            senderId: 'user-1',
            senderDisplayName: 'Alice',
            text: 'Hello!',
          ),
        ),
        expect: () => [
          GameChatLoaded(messages: [testMessage], isSending: true),
          GameChatLoaded(messages: [testMessage], isSending: false),
        ],
      );

      blocTest<GameChatBloc, GameChatState>(
        'does nothing when state is not loaded',
        build: () => GameChatBloc(messageRepository: mockMessageRepository),
        act: (bloc) => bloc.add(
          const SendChatMessage(
            contextPath: testContextPath,
            senderId: 'user-1',
            senderDisplayName: 'Alice',
            text: 'Hello!',
          ),
        ),
        expect: () => [],
      );
    });
  });
}
