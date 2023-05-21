import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/helpers/response/user_model.dart';
import 'package:social_network/modules/user_feed/user_feed_events.dart';
import 'package:social_network/modules/user_feed/user_feed_states.dart';

import '../../helpers/response/feed_model.dart';

class UserFeedBloc extends Bloc<UserFeedEvent, UserFeedState> {
  Repository repository;
  User user = User();
  FeedModel feed = FeedModel(posts: []);
  bool isFriend = false;

  UserFeedBloc(UserFeedInitialState initialState, this.repository) : super(initialState) {
    on<GetUserFeedPosts>(_getPost);
    on<AddOrRemoveFriend>(_addOrRemoveFriend);
  }

  void _getPost(GetUserFeedPosts event, Emitter<UserFeedState> emit) async {
    Response infoResponse = await repository.getUserInfo(event.userId);
    user = User.fromJson(infoResponse.data);
    Response response = await repository.getUserFeedPosts(event.userId);
    feed = FeedModel.fromJson({'posts': response.data});
    emit(UserFeedPostState(userInfo: user, feed: feed));
  }

  void _addOrRemoveFriend(AddOrRemoveFriend event, Emitter<UserFeedState> emit) async {
    await repository.addOrRemoveFriend(event.userId);
    Response infoResponse = await repository.getUserInfo(event.userId);
    user = User.fromJson(infoResponse.data);
    emit(UserFeedPostState(userInfo: user, feed: feed));
  }
}
