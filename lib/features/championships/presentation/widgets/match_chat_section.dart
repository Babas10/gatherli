// Widget displaying the per-match coordination chat for championship matches.
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:play_with_me/core/data/models/chat_message_model.dart';
import 'package:play_with_me/core/domain/repositories/message_repository.dart';
import 'package:play_with_me/core/services/service_locator.dart';
import 'package:play_with_me/core/theme/app_colors.dart';
import 'package:play_with_me/l10n/app_localizations.dart';
import '../bloc/match_chat/match_chat_bloc.dart';
import '../bloc/match_chat/match_chat_event.dart';
import '../bloc/match_chat/match_chat_state.dart';

class MatchChatSection extends StatelessWidget {
  final String championshipId;
  final String matchId;
  final String currentUserId;
  final String currentUserDisplayName;

  /// Whether the current user is a member of one of the two competing teams.
  final bool isTeamMember;

  /// The team ID the current user belongs to (used to colour their messages).
  /// Null when [isTeamMember] is false.
  final String? currentTeamId;

  final MessageRepository? messageRepository;

  const MatchChatSection({
    super.key,
    required this.championshipId,
    required this.matchId,
    required this.currentUserId,
    required this.currentUserDisplayName,
    required this.isTeamMember,
    this.currentTeamId,
    this.messageRepository,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MatchChatBloc(
        messageRepository: messageRepository ?? sl<MessageRepository>(),
      )..add(
          LoadMatchChat(
            championshipId: championshipId,
            matchId: matchId,
          ),
        ),
      child: _MatchChatView(
        championshipId: championshipId,
        matchId: matchId,
        currentUserId: currentUserId,
        currentUserDisplayName: currentUserDisplayName,
        isTeamMember: isTeamMember,
        currentTeamId: currentTeamId,
      ),
    );
  }
}

class _MatchChatView extends StatefulWidget {
  final String championshipId;
  final String matchId;
  final String currentUserId;
  final String currentUserDisplayName;
  final bool isTeamMember;
  final String? currentTeamId;

  const _MatchChatView({
    required this.championshipId,
    required this.matchId,
    required this.currentUserId,
    required this.currentUserDisplayName,
    required this.isTeamMember,
    this.currentTeamId,
  });

  @override
  State<_MatchChatView> createState() => _MatchChatViewState();
}

class _MatchChatViewState extends State<_MatchChatView> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(BuildContext context) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;
    _textController.clear();
    context.read<MatchChatBloc>().add(
      SendMatchChatMessage(
        championshipId: widget.championshipId,
        matchId: widget.matchId,
        senderId: widget.currentUserId,
        senderDisplayName: widget.currentUserDisplayName,
        text: text,
        teamId: widget.currentTeamId,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.secondary,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  l10n.matchChatTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              l10n.matchChatCoordinationHint,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
            const SizedBox(height: 12),
            if (!widget.isTeamMember)
              SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    l10n.matchChatNotMember,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.textMuted,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              )
            else
              BlocConsumer<MatchChatBloc, MatchChatState>(
                listener: (context, state) {
                  if (state is MatchChatLoaded) {
                    _scrollToBottom();
                  }
                },
                builder: (context, state) {
                  if (state is MatchChatLoading || state is MatchChatInitial) {
                    return const SizedBox(
                      height: 120,
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  final messages = state is MatchChatLoaded
                      ? state.messages
                      : <ChatMessageModel>[];
                  final isSending =
                      state is MatchChatLoaded ? state.isSending : false;

                  return Column(
                    children: [
                      SizedBox(
                        height: 240,
                        child: messages.isEmpty
                            ? Center(
                                child: Text(
                                  l10n.matchChatEmpty,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textMuted,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            : ListView.builder(
                                controller: _scrollController,
                                itemCount: messages.length,
                                itemBuilder: (context, index) =>
                                    _MatchMessageBubble(
                                      message: messages[index],
                                      isCurrentUser:
                                          messages[index].senderId ==
                                          widget.currentUserId,
                                    ),
                              ),
                      ),
                      const SizedBox(height: 8),
                      _ChatInput(
                        controller: _textController,
                        isSending: isSending,
                        onSend: () => _sendMessage(context),
                        hint: l10n.chatInputHint,
                      ),
                    ],
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}

class _MatchMessageBubble extends StatelessWidget {
  final ChatMessageModel message;
  final bool isCurrentUser;

  const _MatchMessageBubble({
    required this.message,
    required this.isCurrentUser,
  });

  @override
  Widget build(BuildContext context) {
    final timeFormat = DateFormat('HH:mm');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Align(
        alignment:
            isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isCurrentUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isCurrentUser)
              Padding(
                padding: const EdgeInsets.only(left: 8, bottom: 2),
                child: Text(
                  message.senderDisplayName,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: isCurrentUser
                  ? MainAxisAlignment.end
                  : MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (!isCurrentUser) const SizedBox(width: 4),
                Flexible(
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.65,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isCurrentUser
                          ? AppColors.secondary
                          : AppColors.divider,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isCurrentUser ? 16 : 4),
                        bottomRight: Radius.circular(isCurrentUser ? 4 : 16),
                      ),
                    ),
                    child: Text(
                      message.text,
                      style: TextStyle(
                        color: isCurrentUser
                            ? Colors.white
                            : AppColors.onSurface,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  timeFormat.format(message.sentAt),
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: AppColors.textMuted,
                    fontSize: 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatInput extends StatelessWidget {
  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;
  final String hint;

  const _ChatInput({
    required this.controller,
    required this.isSending,
    required this.onSend,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: AppColors.textMuted),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(24),
                borderSide: const BorderSide(color: AppColors.divider),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 10,
              ),
              isDense: true,
            ),
            maxLines: null,
            textInputAction: TextInputAction.send,
            onSubmitted: (_) => onSend(),
            enabled: !isSending,
          ),
        ),
        const SizedBox(width: 8),
        IconButton(
          onPressed: isSending ? null : onSend,
          icon: isSending
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.send),
          color: AppColors.secondary,
          style: IconButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: const CircleBorder(),
          ),
        ),
      ],
    );
  }
}
