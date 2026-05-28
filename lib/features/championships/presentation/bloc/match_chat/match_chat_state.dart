// States for MatchChatBloc managing per-match coordination chat.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';

abstract class MatchChatState extends Equatable {
  const MatchChatState();
  @override
  List<Object?> get props => [];
}

class MatchChatInitial extends MatchChatState {
  const MatchChatInitial();
}

class MatchChatLoading extends MatchChatState {
  const MatchChatLoading();
}

class MatchChatLoaded extends MatchChatState {
  final List<ChatMessageModel> messages;
  final bool isSending;

  const MatchChatLoaded({required this.messages, this.isSending = false});

  @override
  List<Object?> get props => [messages, isSending];

  MatchChatLoaded copyWith({
    List<ChatMessageModel>? messages,
    bool? isSending,
  }) {
    return MatchChatLoaded(
      messages: messages ?? this.messages,
      isSending: isSending ?? this.isSending,
    );
  }
}

class MatchChatError extends MatchChatState {
  final String message;

  const MatchChatError({required this.message});

  @override
  List<Object?> get props => [message];
}
