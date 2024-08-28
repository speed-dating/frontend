import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:agora_chat_uikit/views/chat_messages_view/chat_messages_view.dart';
import 'package:flutter/material.dart';

class MessagePage extends StatefulWidget {
  const MessagePage(this.conversation, {super.key});

  final ChatConversation conversation;

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.conversation.id)),
      body: SafeArea(
        // Message page in uikit.
        child: ChatMessagesView(
          conversation: widget.conversation,
          nicknameBuilder: (context, userId) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(userId),
            );
          },
          avatarBuilder: (context, userId) {
            return CircleAvatar();
          },
        ),
      ),
    );
  }
}
