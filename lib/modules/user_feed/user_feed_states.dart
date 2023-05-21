import 'package:social_network/helpers/response/feed_model.dart';
import 'package:social_network/helpers/response/user_model.dart';

abstract class UserFeedState {}

class UserFeedInitialState extends UserFeedState {}

class UserFeedPostState extends UserFeedState {
  User userInfo;
  FeedModel feed;

  UserFeedPostState({required this.userInfo, required this.feed});
}
