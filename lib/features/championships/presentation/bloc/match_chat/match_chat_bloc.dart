// Manages real-time per-match coordination chat messages for championship matches.
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:play_with_me/core/presentation/bloc/base_bloc.dart';
import 'package:play_with_me/core/domain/exceptions/repository_exceptions.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'match_chat_event.dart';
import 'match_chat_state.dart';

class MatchChatBloc extends BaseBloc<MatchChatEvent, MatchChatState> {
  final MessageRepository _messageRepository;
  StreamSubscription<dynamic>? _messagesSubscription;

  MatchChatBloc({required MessageRepository messageRepository})
      : _messageRepository = messageRepository,
        super(const MatchChatInitial()) {
    on<LoadMatchChat>(_onLoadMatchChat);
    on<MatchChatMessagesUpdated>(_onMessagesUpdated);
    on<SendMatchChatMessage>(_onSendMatchChatMessage);
  }

  String _contextPath(String championshipId, String matchId) =>
      'championships/$championshipId/matches/$matchId';

  Future<void> _onLoadMatchChat(
    LoadMatchChat event,
    Emitter<MatchChatState> emit,
  ) async {
    emit(const MatchChatLoading());
    await _messagesSubscription?.cancel();
    _messagesSubscription = _messageRepository
        .getMessages(
          contextPath: _contextPath(event.championshipId, event.matchId),
        )
        .listen(
          (messages) => add(MatchChatMessagesUpdated(messages: messages)),
          onError: (_) => add(const MatchChatMessagesUpdated(messages: [])),
        );
  }

  void _onMessagesUpdated(
    MatchChatMessagesUpdated event,
    Emitter<MatchChatState> emit,
  ) {
    final isSending =
        state is MatchChatLoaded
            ? (state as MatchChatLoaded).isSending
            : false;
    emit(MatchChatLoaded(messages: event.messages, isSending: isSending));
  }

  Future<void> _onSendMatchChatMessage(
    SendMatchChatMessage event,
    Emitter<MatchChatState> emit,
  ) async {
    if (state is! MatchChatLoaded) return;
    final current = state as MatchChatLoaded;
    emit(current.copyWith(isSending: true));
    try {
      await _messageRepository.sendMessage(
        contextPath: _contextPath(event.championshipId, event.matchId),
        senderId: event.senderId,
        senderDisplayName: event.senderDisplayName,
        text: event.text,
        teamId: event.teamId,
      );
      // Use the live state — the stream may have delivered the new message
      // while sendMessage was in flight; do not revert to the pre-send snapshot.
      final latest = state;
      if (latest is MatchChatLoaded) {
        emit(latest.copyWith(isSending: false));
      }
    } on MessageException catch (e) {
      emit(current.copyWith(isSending: false));
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
