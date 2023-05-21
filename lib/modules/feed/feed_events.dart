abstract class FeedEvent {}

class GetFeedPosts extends FeedEvent {}

class LikePost extends FeedEvent {
  final String postId;

  LikePost({required this.postId});
}

class CommentPost extends FeedEvent {
  final String postId;
  final String content;

  CommentPost({required this.postId, required this.content});
} 