abstract class ChatRoomEvent {}

class SendMessage extends ChatRoomEvent {
  final String userId;
  final String message;

  SendMessage({required this.userId, required this.message});
}

