import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/helpers/widgets/custom_text_field.dart';
import 'package:social_network/modules/chat_room/chat_room_bloc.dart';
import 'package:social_network/modules/chat_room/chat_room_events.dart';
import 'package:social_network/modules/chat_room/chat_room_states.dart';

class ChatRoom extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatRoom({Key? key, required this.userId, required this.userName}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final chatRoomBloc = ChatRoomBloc(ChatRoomInitialState(), Repository());
  final messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: BlocProvider<ChatRoomBloc>(
        create: (context) => chatRoomBloc,
        child: Column(
          children: [
            Expanded(child: Container()),
            SizedBox(
              height: 60,
              child: CustomTextField(
                hintText: 'message',
                textEditingController: messageController,
                onSubmitted: (value) {
                  chatRoomBloc.add(SendMessage(userId: widget.userId, message: value));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
      preferredSize: const Size(double.infinity, 60),
      child: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
        leading: BackButton(
          onPressed: () {
            context.pop();
          },
        ),
        title: Text(
          widget.userName,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}