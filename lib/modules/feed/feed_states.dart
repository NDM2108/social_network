import 'package:social_network/helpers/response/feed_model.dart';

abstract class FeedState {}

class FeedInitialState extends FeedState {}

class FeedPostState extends FeedState {
  FeedModel feed;

  FeedPostState({required this.feed});
}
