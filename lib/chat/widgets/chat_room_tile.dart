import 'package:flutter/material.dart';
import 'package:agora_chat_sdk/agora_chat_sdk.dart';

class ChatRoomTile extends StatelessWidget {
  final ChatConversation conversation;
  final VoidCallback onTap;

  const ChatRoomTile({
    Key? key,
    required this.conversation,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: conversation.latestMessage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            title: Text(conversation.id),
            subtitle: Text("Loading..."),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(conversation.id),
            subtitle: Text("Error: ${snapshot.error}"),
          );
        } else if (snapshot.hasData) {
          final chatMessage = snapshot.data!;
          final lastMessage = chatMessage.body.toJson()['content'] ?? "";
          final isGroupChat =
              conversation.type == ChatConversationType.GroupChat;

          return InkWell(
            onTap: onTap,
            child: Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  isGroupChat
                      ? Container(
                          width: 50,
                          height: 50,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 0,
                                left: 0,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/women/1.jpg'),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://randomuser.me/api/portraits/men/2.jpg'),
                                ),
                              ),
                            ],
                          ),
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/men/3.jpg'),
                        ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          conversation.id,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5),
                        Text(lastMessage),
                      ],
                    ),
                  ),
                  Text(
                    _formatDate(chatMessage.serverTime),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          );
        } else {
          return ListTile(
            title: Text(conversation.id),
            subtitle: Text("No message available"),
          );
        }
      },
    );
  }

  String _formatDate(int timestamp) {
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    final Duration difference = DateTime.now().difference(date);
    if (difference.inDays > 0) {
      return "${difference.inDays}일 전";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}시간 전";
    } else if (difference.inMinutes > 0) {
      return "${difference.inMinutes}분 전";
    } else {
      return "방금 전";
    }
  }
}
