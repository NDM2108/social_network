import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_network/core/repository/repository.dart';
import 'package:social_network/core/shared_preferences/shared_preferences_repository.dart';
import 'package:social_network/helpers/response/feed_model.dart';
import 'package:social_network/modules/feed/feed_events.dart';
import 'feed_states.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  Repository repository;
  FeedModel feed = FeedModel(posts: []);
  int page = 1;

  FeedBloc(FeedInitialState initialState, this.repository) : super(initialState) {
    on<GetFeedPosts>(_getPost);
    on<LikePost>(_likePost);
    on<CommentPost>(_commentPost);
  }

  void _getPost(GetFeedPosts event, Emitter<FeedState> emit) async {
    Response response = await repository.getFeedPosts(page, 5);
    page ++;
    final newFeed = FeedModel.fromJson({'posts': response.data});
    feed.posts!.addAll(newFeed.posts!);
    emit(FeedPostState(feed: feed));
  }

  void _likePost(LikePost event, Emitter<FeedState> emit) async {
    Response response = await repository.like(
        event.postId, SharedPreferencesRepository().getUserInformation()?.user?.id ?? '');
    final newPost = Post.fromJson(response.data);
    var index = feed.posts!.indexWhere((element) => element.id == newPost.id);
    feed.posts![index] = newPost;
    emit(FeedPostState(feed: feed));
  }

  void _commentPost(CommentPost event, Emitter<FeedState> emit) async {
    Response response = await repository.comment(
        event.postId, event.content);
    final newPost = Post.fromJson(response.data);
    var index = feed.posts!.indexWhere((element) => element.id == newPost.id);
    feed.posts![index] = newPost;
    emit(FeedPostState(feed: feed));
  }
}
