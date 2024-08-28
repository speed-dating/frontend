import 'dart:convert';

import 'package:agora_chat_sdk/agora_chat_sdk.dart';
import 'package:http/http.dart' as http;

class AgoraService {
  Future<void> signIn(String userId, String? token) async {
    token ??= await fetchAgoraUserToken();

    if (token == null) {
      // todo : show pop up message
    }

    try {
      await ChatClient.getInstance.loginWithAgoraToken(userId, token!);
    } on ChatError catch (e) {
      // todo : show Popup Message
    }
  }

  Future<void> signOut() async {
    try {
      await ChatClient.getInstance.logout();
    } on ChatError catch (e) {
      // todo : send log
    }
  }

  Future<List<ChatConversation>> loadChatConversations() async {
    try {
      List<ChatConversation> chatConversations =
          await ChatClient.getInstance.chatManager.loadAllConversations();

      String? cursor;
      int pageSize = 100;
      ChatCursorResult<ChatConversation> serverConversations =
          await ChatClient.getInstance.chatManager.fetchConversation(
        cursor: cursor,
        pageSize: pageSize,
      );

      return chatConversations;
    } catch (e) {
      // todo : show popup
      throw Exception("Failed to load conversations: $e");
    }
  }

  Future<String?> fetchAgoraUserToken() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/v1/chat/user/shy/token'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        if (responseBody['resultCode'] == 'SUCCESS') {
          return responseBody['data'];
        }
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
