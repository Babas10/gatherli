// Events for MatchChatBloc managing per-match coordination chat.
import 'package:equatable/equatable.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';

abstract class MatchChatEvent extends Equatable {
  const MatchChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadMatchChat extends MatchChatEvent {
  final String championshipId;
  final String matchId;

  const LoadMatchChat({
    required this.championshipId,
    required this.matchId,
  });

  @override
  List<Object?> get props => [championshipId, matchId];
}

class MatchChatMessagesUpdated extends MatchChatEvent {
  final List<ChatMessageModel> messages;

  const MatchChatMessagesUpdated({required this.messages});

  @override
  List<Object?> get props => [messages];
}

class SendMatchChatMessage extends MatchChatEvent {
  final String championshipId;
  final String matchId;
  final String senderId;
  final String senderDisplayName;
  final String text;

  /// The team the sender belongs to (teamAId or teamBId of the match).
  final String? teamId;

  const SendMatchChatMessage({
    required this.championshipId,
    required this.matchId,
    required this.senderId,
    required this.senderDisplayName,
    required this.text,
    this.teamId,
  });

  @override
  List<Object?> get props => [
    championshipId,
    matchId,
    senderId,
    senderDisplayName,
    text,
    teamId,
  ];
}
