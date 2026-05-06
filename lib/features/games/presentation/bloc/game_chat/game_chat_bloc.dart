// Manages real-time in-game chat messages and send actions.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'game_chat_event.dart';
import 'game_chat_state.dart';

class GameChatBloc extends Bloc<GameChatEvent, GameChatState> {
  final MessageRepository _messageRepository;
  StreamSubscription<dynamic>? _messagesSubscription;

  GameChatBloc({required MessageRepository messageRepository})
      : _messageRepository = messageRepository,
        super(const GameChatInitial()) {
    on<LoadGameChat>(_onLoadGameChat);
    on<GameChatMessagesUpdated>(_onMessagesUpdated);
    on<SendChatMessage>(_onSendChatMessage);
  }

  Future<void> _onLoadGameChat(
    LoadGameChat event,
    Emitter<GameChatState> emit,
  ) async {
    emit(const GameChatLoading());
    await _messagesSubscription?.cancel();
    _messagesSubscription = _messageRepository
        .getMessages(contextPath: event.contextPath)
        .listen(
          (messages) => add(GameChatMessagesUpdated(messages: messages)),
          onError: (_) => add(const GameChatMessagesUpdated(messages: [])),
        );
  }

  void _onMessagesUpdated(
    GameChatMessagesUpdated event,
    Emitter<GameChatState> emit,
  ) {
    final isSending =
        state is GameChatLoaded ? (state as GameChatLoaded).isSending : false;
    emit(GameChatLoaded(messages: event.messages, isSending: isSending));
  }

  Future<void> _onSendChatMessage(
    SendChatMessage event,
    Emitter<GameChatState> emit,
  ) async {
    if (state is! GameChatLoaded) return;
    final current = state as GameChatLoaded;
    emit(current.copyWith(isSending: true));
    try {
      await _messageRepository.sendMessage(
        contextPath: event.contextPath,
        senderId: event.senderId,
        senderDisplayName: event.senderDisplayName,
        text: event.text,
      );
      // Use the live state — the stream may have already delivered the new
      // message while sendMessage was in flight, so we must not revert to
      // the pre-send snapshot (current). Just clear the isSending flag.
      final latest = state;
      if (latest is GameChatLoaded) {
        emit(latest.copyWith(isSending: false));
      }
    } on MessageException catch (e) {
      emit(current.copyWith(isSending: false));
      // Don't emit error — just restore state (snackbar handled in widget)
      addError(Exception(e.message));
    } catch (e) {
      emit(current.copyWith(isSending: false));
      addError(e is Exception ? e : Exception(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    return super.close();
  }
}
