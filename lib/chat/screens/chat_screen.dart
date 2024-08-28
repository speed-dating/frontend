import 'dart:convert';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:agora_chat_uikit/agora_chat_uikit.dart';
import 'package:agora_chat_uikit/views/chat_messages_view/chat_messages_view.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:speed_dating_front/chat/screens/message_page.dart';
import 'package:speed_dating_front/chat/service/agora_service.dart';
import 'package:speed_dating_front/chat/widgets/chat_room_tile.dart';

class ChatConfig {
  static const String appKey = "611193750#1381387";
  static const String userId = "shy";
  static String? agoraToken = null;
}

class ChatPageScreen extends StatefulWidget {
  const ChatPageScreen({super.key});

  @override
  State<ChatPageScreen> createState() => _ChatPageScreenState();
}

class _ChatPageScreenState extends State<ChatPageScreen> {
  List<ChatConversation> chatConversations = [];
  ScrollController scrollController = ScrollController();
  final List<String> _logText = [];

  @override
  void initState() {
    super.initState();
    _loadChatConversations();
  }

  Future<void> _loadChatConversations() async {
    final agoraService = Provider.of<AgoraService>(context, listen: false);

    try {
      List<ChatConversation> conversations =
          await agoraService.loadChatConversations();

      setState(() {
        chatConversations = conversations;
      });
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("채팅 불러오기를 실패했어요.")));
    }
  }

  void pushToChatPage(String userId) async {
    if (userId.isEmpty) {
      // _addLogToConsole('UserId is null');
      return;
    }
    if (ChatClient.getInstance.currentUserId == null) {
      // _addLogToConsole('user not login');
      return;
    }
    ChatConversation? conv =
        await ChatClient.getInstance.chatManager.getConversation(userId);
    Future(() {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return MessagePage(conv!);
      })).then((_) {
        _loadChatConversations();
      });
    });
  }

  String get _timeString {
    return DateTime.now().toString().split(".").first;
  }

  void _addLogToConsole(String log) {
    _logText.add(log);
    setState(() {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            // 대화 목록을 표시하는 부분
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (_, index) {
                  final conversation = chatConversations[index];

                  return FutureBuilder(
                      future: conversation.latestMessage(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          // While waiting for the future to complete, show a loading indicator
                          return ListTile(
                            title: Text(conversation
                                .id), // Show conversation ID or name
                            subtitle: Text("Loading..."), // Loading placeholder
                          );
                        } else if (snapshot.hasError) {
                          // If there's an error, display the error message
                          return ListTile(
                            title: Text(conversation.id),
                            subtitle: Text("Error: ${snapshot.error}"),
                          );
                        } else if (snapshot.hasData) {
                          // When the future completes with data, display the message content
                          final chatMessage = snapshot.data!;
                          final lastMessage =
                              chatMessage.body.toJson()['content'] ?? "";

                          final recipientId = conversation.id;

                          return ChatRoomTile(
                            conversation: conversation,
                            onTap: () => pushToChatPage(conversation.id),
                          );
                        } else {
                          // If the future completes with no data
                          // return ListTile(
                          //   title: Text(conversation.id),
                          //   subtitle: Text("No message available"),
                          // );
                          return ChatRoomTile(
                            conversation: conversation,
                            onTap: () => pushToChatPage(conversation.id),
                          );
                        }
                      });
                  // return ListTile(
                  //   title: Text(conversation.id), // 실제 사용자 이름으로 변경 필요
                  //   subtitle: Text(conversation.latestMessage.toString()),
                  // );
                },
                itemCount: chatConversations.length,
              ),
            ),
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                itemBuilder: (_, index) {
                  return Text(_logText[index]);
                },
                itemCount: _logText.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
