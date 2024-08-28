class ChatRoom {
  final String id;
  final String userName;
  final String lastMessage;
  final DateTime lastMessageTime;
  final String profileImageUrl;
  final bool isPinned;

  ChatRoom({
    required this.id,
    required this.userName,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.profileImageUrl,
    required this.isPinned,
  });
}
