import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/api_paths.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';
import 'package:social_network/modules/chat_room/chat_room_events.dart';
import 'package:social_network/modules/chat_room/chat_room_states.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../core/repository/repository.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  Repository repository;
  Socket socket = io(ApiPaths.socket, <String, dynamic>{
    'transports': ['websocket'],
    'autoConnect': true
  });

  ChatRoomBloc(ChatRoomInitialState initialState, this.repository) : super(initialState) {
    socket.onConnect((_) {
      print('connected');
      socket.emit('addUser', SharedPreferencesRepository().getUserInformation()?.user?.id ?? '');
    });
    socket.onError((error) {
      print(error);
    });
    socket.onDisconnect((data) {
      print(data);
    });
    socket.on('getMessage', (data) {
      print(data);
    });
    socket.on('getUsers', (data) {
      print(data);
    });

    on<SendMessage>(_sendMessage);
  }

  void _sendMessage(SendMessage event, Emitter<ChatRoomState> emit) async {
    socket.emit('sendMessage', {
      'senderId': SharedPreferencesRepository().getUserInformation()?.user?.id ?? '',
      'receiverId': event.userId,
      'text': event.message
    });
  }

  @override
  Future<void> close() {
    socket?.disconnect();
    return super.close();
  }
}
