import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/modules/conversations/conversations_events.dart';
import 'package:social_network/modules/conversations/conversations_states.dart';

import '../../core/repository/repository.dart';

class ConversationsBloc extends Bloc<ConversationsEvent, ConversationsState> {
  Repository repository;

  ConversationsBloc(ConversationsInitialStates initialState, this.repository) : super(initialState) {
    on<GetConversations>(_getConversations);
  }

  void _getConversations(GetConversations event, Emitter<ConversationsState> emit) async {
  }
}