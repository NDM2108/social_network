abstract class UserFeedEvent {}

class GetUserFeedPosts extends UserFeedEvent {
  final String userId;

  GetUserFeedPosts({required this.userId});
}

class AddOrRemoveFriend extends UserFeedEvent {
  final String userId;

  AddOrRemoveFriend({required this.userId});
}