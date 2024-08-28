import 'dart:convert';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatContentScreen extends StatefulWidget {
  @override
  _ChatContentScreenState createState() => _ChatContentScreenState();
}

class _ChatContentScreenState extends State<ChatContentScreen> {
  static const String appKey = "611193750#1381387";
  static const String userId = "shy";
  String token = "<Your authentication token>";

  late ChatClient agoraChatClient; // Agora Chat SDK 클라이언트
  bool isJoined = false;

  ScrollController scrollController = ScrollController();
  TextEditingController messageBoxController = TextEditingController();
  String messageContent = "", recipientId = "";
  final List<Widget> messageList = [];

  // 사용자가 메시지를 보내거나 UI에서 로그를 표시할 때 호출할 수 있는 메소드
  void showLog(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> fetchAndSetToken() async {
    try {
      final response = await http.get(
        Uri.parse('http://your_server_ip:port/chat/user/$userId/token'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['resultCode'] == 'SUCCESS') {
          setState(() {
            token = responseBody['data']; // 서버에서 받은 토큰을 설정
          });
        } else {
          showLog('Failed to get token: ${responseBody['message']}');
        }
      } else {
        showLog('Failed to get token from server');
      }
    } catch (e) {
      showLog('Error fetching token: $e');
    }
  }

  // 사용자가 채팅에 가입하거나 탈퇴할 때 호출되는 메소드
  void joinLeave() {
    // TODO: Join or leave chat functionality goes here
    setState(() {
      isJoined = !isJoined;
    });
    showLog(isJoined ? "Joined chat" : "Left chat");
  }

  // 메시지를 보내는 메소드
  void sendMessage() {
    if (messageContent.isNotEmpty && recipientId.isNotEmpty) {
      // TODO: Send message functionality using Agora SDK
      setState(() {
        messageList.add(Text("$userId: $messageContent"));
        messageBoxController.clear();
        messageContent = "";
      });
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    } else {
      showLog("Recipient ID or Message is empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: "Enter recipient's userId",
                    ),
                    onChanged: (chatUserId) => recipientId = chatUserId,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 80,
                height: 40,
                child: ElevatedButton(
                  onPressed: joinLeave,
                  child: Text(isJoined ? "Leave" : "Join"),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              itemBuilder: (_, index) {
                return messageList[index];
              },
              itemCount: messageList.length,
            ),
          ),
          Row(children: [
            Expanded(
              child: SizedBox(
                height: 40,
                child: TextField(
                  controller: messageBoxController,
                  decoration: const InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Message",
                  ),
                  onChanged: (msg) => messageContent = msg,
                ),
              ),
            ),
            const SizedBox(width: 10),
            SizedBox(
              width: 50,
              height: 40,
              child: ElevatedButton(
                onPressed: sendMessage,
                child: const Text(">>"),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
