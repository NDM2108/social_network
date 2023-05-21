import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/helpers/response/user_model.dart';
import 'package:social_network/modules/explore/explore_events.dart';
import 'package:social_network/modules/explore/explore_states.dart';

import '../../core/repository/repository.dart';

class ExploreBloc extends Bloc<ExploreEvent, ExploreState> {
  Repository repository;

  ExploreBloc(ExploreInitialState initialState, this.repository) : super(initialState) {
    on<SearchName>(_searchName);
  }

  void _searchName(SearchName event, Emitter<ExploreState> emit) async {
    final response = await repository.searchName(event.name);
    List<User> users =  List<User>.from(response.data.map((e) => User.fromJson(e)));
    emit(UsersList(users: users));
  }
}
